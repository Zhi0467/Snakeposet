from sage.rings.polynomial.complex_roots import complex_roots
# first we build a snake class which enables us to get lots of information of one snake poset at once.
class snake():
    def __init__(self, word_string):
        word = [char for char in word_string]
        self.dimension = 2 * len(word) + 4
        self.poset = self.buildSnake(word)
        self.poset_polytope = self.poset.order_polytope()
        self.ehrhart = self.poset_polytope.ehrhart_polynomial()
        self.comparability_graph = self.poset.comparability_graph()
        self.linear_extensions = self.poset.linear_extensions()
        self.order_polynomial = self.poset.order_polynomial()
        self.incomparability_graph = self.poset.incomparability_graph()
        self.rank_function = self.poset.rank_function()
        self.flag_f_polynomial = self.poset.flag_f_polynomial()
        self.flag_h_polynomial = self.poset.flag_h_polynomial()
        self.chain_polytope = self.poset.chain_polytope()
        self.p_hat = self.poset.with_bounds()
        self.chain_polynomial = self.poset.chain_polynomial()
    def HasseGeneration(self, word, length):
        if length == 0:
            return [(1, 0), (2, 0), (3, 1), (3, 2)]
        else:
            L = self.HasseGeneration(word[: -1], length - 1)
            lastMove = word[-1]
            secondLast = ' '
            if length > 1:
                secondLast = word[-2]
            if lastMove == 'L':
                if secondLast == 'R':
                    n = length
                    L.extend([(2*n+3, 2*n+1), (2*n + 3, 2*n+2), (2*n +2, 2*n-1)])
                elif secondLast == 'L':
                    n = length
                    L.extend([(2*n+3, 2*n+1), (2*n + 3, 2*n+2), (2*n + 2, 2*n)])
                else:
                    L.extend([(4, 1), (5, 4), (5, 3)])
            elif lastMove == 'R':
                if secondLast == 'L':
                    n = length
                    L.extend([(2*n+3, 2*n+1), (2*n + 3, 2*n+2), (2*n +2, 2*n-1)])
                elif secondLast == 'R':
                    n = length
                    L.extend([(2*n+3, 2*n+1), (2*n + 3, 2*n+2), (2*n + 2, 2*n)])
                else:
                    L.extend([(4, 2), (5, 4), (5, 3)])
            return L
    def buildSnake(self, word):
        length = len(word)
        vertices = [i for i in range(2*length+4)]
        vertices.reverse()
        relations = self.HasseGeneration(word, length)
        P = LatticePoset((vertices, relations), linear_extension = True)
        return P
    def showInfo(self):
        self.poset.hasse_diagram().show()
        self.comparability_graph.show()
        self.p_hat.hasse_diagram().show()
        print("")
        pretty_print("The Ehrhart polynomial is {}: ".format(self.ehrhart))
        print("")
        pretty_print("The Order polynomial is {}: ".format(self.order_polynomial))
        print("")
        pretty_print("The flag-f polynomial is {}: ".format(self.flag_f_polynomial))
        print("")
        pretty_print("The flag-h polynomial is {}: ".format(self.flag_h_polynomial))
        print("")
        pretty_print("The chain polynomial is {}: ".format(self.chain_polynomial))
        print("O(P):")
        print("")
        print(self.poset_polytope)
        print("")
        print("The volume of O(P): {}".format(self.poset_polytope.volume()))
        print("")
        print("These are vertices of O(P):")
        pretty_print(self.poset_polytope.vertices())
        print("")
        print("C(P):")
        print("")
        print(self.chain_polytope)
        print("")
        print("The volume of C(P): {}".format(self.chain_polytope.volume()))
        print("")
        print("")
        print("These are vertices of C(P):")
        pretty_print(self.chain_polytope.vertices())
        print("")
        print("All {} linear extensions:".format(self.linear_extensions.cardinality()))
        for element in self.linear_extensions.list():
            print("")
            print(element)
s = snake("RL")
s.showInfo()

class snake_meet_irreducible():
    def __init__(self, word):
        self.snake = snake(word)
        self.poset = self.snake.p_hat.meet_irreducibles_poset()
def generate_snake_words(n):
    if n == 0:
        return ['']
    else:
        prev_strings = generate_snake_words(n-1)
        new_strings = []
        for string in prev_strings:
            new_strings.append(string + 'R')
            new_strings.append(string + 'L')
        return new_strings
def non_isomorphic_snake_words(n):
    if n == 0:
        return ['']
    else:
        return generate_snake_words(n)[0: 2**(n-1)]

def ehrhart_of_snake_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_ehr = [(word, snake(word).ehrhart) for word in words]
    print("These are Ehrhart polynomials for n = {}:".format(n))
    for entry in snakes_ehr:
        print("{}:".format(entry[0]))
        pretty_print(entry[1])
        print("")
        pretty_print(entry[1].factor())
        print("")
def roots_of_ehrhart_of_snake_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_ehr = [(word, snake(word).ehrhart) for word in words]
    print("These are the roots of Ehrhart polynomials for n = {}:".format(n))
    for entry in snakes_ehr:
        print("{}:".format(entry[0]))
        pretty_print(complex_roots(entry[1]))
        print("")

def order_poly_of_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_rank_polynomials = [(word, snake(word).order_polynomial) for word in words]
    print("These are order polynomials for n = {}:".format(n))
    for entry in snakes_rank_polynomials:
        print("{}:".format(entry[0]))
        pretty_print(entry[1])
        print("")
        
        
def volume_of_order(n):
    words = non_isomorphic_snake_words(n)
    snakes = [(word, snake(word).poset_polytope.volume()) for word in words]
    print("These are volumes for n = {}:".format(n))
    pretty_print(snakes)
        
volume_of_order(4)
