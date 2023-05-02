︠d8754f76-7fb6-44e3-a235-f86e25c2df05︠
from sage.rings.polynomial.complex_roots import complex_roots
# first we build a snake class which enables us to get lots of information of one snake poset at once.
class snake():
    def __init__(self, word_string):
        word = [char for char in word_string]
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

    def HasseGeneration(self, word, length):
        if length == 0:
            return [(0, 1), (0, 2), (1, 3), (2, 3)]
        else:
            L = self.HasseGeneration(word[: -1], length - 1)
            lastMove = word[-1]
            secondLast = ' '
            if length > 1:
                secondLast = word[-2]
            if lastMove == 'L':
                if secondLast == 'R':
                    n = length
                    L.extend([(2*n+1, 2*n+3), (2*n + 2, 2*n+3,), (2*n -1, 2*n+2)])
                elif secondLast == 'L':
                    n = length
                    L.extend([(2*n+1, 2*n+3), (2*n + 2, 2*n+3,), (2*n, 2*n+2)])
                else:
                    L.extend([(1, 4), (4, 5), (3, 5)])
            elif lastMove == 'R':
                if secondLast == 'L':
                    n = length
                    L.extend([(2*n+1, 2*n+3), (2*n + 2, 2*n+3,), (2*n -1, 2*n+2)])
                elif secondLast == 'R':
                    n = length
                    L.extend([(2*n+1, 2*n+3), (2*n + 2, 2*n+3,), (2*n, 2*n+2)])
                else:
                    L.extend([(2, 4), (4, 5), (3, 5)])
            return L
    def buildSnake(self, word):
        length = len(word)
        vertices = [i for i in range(2*length+4)]
        relations = self.HasseGeneration(word, length)
        P = LatticePoset((vertices, relations), linear_extension = True)
        return P
    def showInfo(self):
        self.poset.hasse_diagram().show()
        self.comparability_graph.show()
        self.incomparability_graph.show()
        self.p_hat.hasse_diagram().show()
        print("The Ehrhart polynomial is {}: ".format(self.ehrhart))
        print("The Order polynomial is {}: ".format(self.order_polynomial))
        print("The flag-f polynomial is {}: ".format(self.flag_f_polynomial))
        print("The flag-h polynomial is {}: ".format(self.flag_h_polynomial))
        self.poset_polytope
        print("All {} linear extensions:".format(self.linear_extensions.cardinality()))
        for element in self.linear_extensions.list():
            print(element)


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

def ehrhart_of_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_ehr = [(word, snake(word).ehrhart) for word in words]
    print("These are Ehrhart polynomials for n = {}:".format(n))
    for entry in snakes_ehr:
        print("{}:".format(entry[0]))
        lst = entry[1].coefficients()
        lst.reverse()
        pretty_print(lst)
        print("")
ehrhart_of_order(0)
ehrhart_of_order(1)
ehrhart_of_order(2)
ehrhart_of_order(3)
def roots_of_ehrhart_of_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_ehr = [(word, snake(word).ehrhart) for word in words]
    print("These are the roots of Ehrhart polynomials for n = {}:".format(n))
    for entry in snakes_ehr:
        print("{}:".format(entry[0]))
        pretty_print(complex_roots(entry[1]))
        print("")
roots_of_ehrhart_of_order(0)
roots_of_ehrhart_of_order(1)
roots_of_ehrhart_of_order(2)
roots_of_ehrhart_of_order(3)

def order_poly_of_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_rank_polynomials = [(word, snake(word).order_polynomial) for word in words]
    print("These are order polynomials for n = {}:".format(n))
    for entry in snakes_rank_polynomials:
        print("{}:".format(entry[0]))
        pretty_print(entry[1])
        print("")
︡a00c0b14-acaa-4b56-bb25-714339fd40b9︡{"stdout":"These are Ehrhart polynomials for n = 0:\n:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{1}{12}$, $\\displaystyle \\frac{2}{3}$, $\\displaystyle \\frac{23}{12}$, $\\displaystyle \\frac{7}{3}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are Ehrhart polynomials for n = 1:\nR:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{1}{144}$, $\\displaystyle \\frac{5}{48}$, $\\displaystyle \\frac{91}{144}$, $\\displaystyle \\frac{95}{48}$, $\\displaystyle \\frac{121}{36}$, $\\displaystyle \\frac{35}{12}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are Ehrhart polynomials for n = 2:"}︡{"stdout":"\nRR:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{1}{2880}$, $\\displaystyle \\frac{1}{120}$, $\\displaystyle \\frac{41}{480}$, $\\displaystyle \\frac{39}{80}$, $\\displaystyle \\frac{541}{320}$, $\\displaystyle \\frac{291}{80}$, $\\displaystyle \\frac{3401}{720}$, $\\displaystyle \\frac{101}{30}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRL:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{1}{3360}$, $\\displaystyle \\frac{1}{140}$, $\\displaystyle \\frac{53}{720}$, $\\displaystyle \\frac{17}{40}$, $\\displaystyle \\frac{2161}{1440}$, $\\displaystyle \\frac{397}{120}$, $\\displaystyle \\frac{1394}{315}$, $\\displaystyle \\frac{1369}{420}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are Ehrhart polynomials for n = 3:"}︡{"stdout":"\nRRR:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{1}{86400}$, $\\displaystyle \\frac{7}{17280}$, $\\displaystyle \\frac{1}{160}$, $\\displaystyle \\frac{161}{2880}$, $\\displaystyle \\frac{3077}{9600}$, $\\displaystyle \\frac{2359}{1920}$, $\\displaystyle \\frac{27491}{8640}$, $\\displaystyle \\frac{23681}{4320}$, $\\displaystyle \\frac{21569}{3600}$, $\\displaystyle \\frac{56}{15}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRRL:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{11}{1209600}$, $\\displaystyle \\frac{11}{34560}$, $\\displaystyle \\frac{199}{40320}$, $\\displaystyle \\frac{257}{5760}$, $\\displaystyle \\frac{14983}{57600}$, $\\displaystyle \\frac{11753}{11520}$, $\\displaystyle \\frac{20563}{7560}$, $\\displaystyle \\frac{41917}{8640}$, $\\displaystyle \\frac{138977}{25200}$, $\\displaystyle \\frac{43}{12}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRLR:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{29}{3628800}$, $\\displaystyle \\frac{29}{103680}$, $\\displaystyle \\frac{263}{60480}$, $\\displaystyle \\frac{683}{17280}$, $\\displaystyle \\frac{40157}{172800}$, $\\displaystyle \\frac{31871}{34560}$, $\\displaystyle \\frac{905767}{362880}$, $\\displaystyle \\frac{117553}{25920}$, $\\displaystyle \\frac{88489}{16800}$, $\\displaystyle \\frac{1261}{360}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRLL:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{11}{1209600}$, $\\displaystyle \\frac{11}{34560}$, $\\displaystyle \\frac{199}{40320}$, $\\displaystyle \\frac{257}{5760}$, $\\displaystyle \\frac{14983}{57600}$, $\\displaystyle \\frac{11753}{11520}$, $\\displaystyle \\frac{20563}{7560}$, $\\displaystyle \\frac{41917}{8640}$, $\\displaystyle \\frac{138977}{25200}$, $\\displaystyle \\frac{43}{12}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are the roots of Ehrhart polynomials for n = 0:\n:\n"}︡{"html":"<div align='center'>[($\\displaystyle -3.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -2$, $\\displaystyle 2$), ($\\displaystyle -1.000000000000000?$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are the roots of Ehrhart polynomials for n = 1:\nR:\n"}︡{"html":"<div align='center'>[($\\displaystyle -4.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -3$, $\\displaystyle 2$), ($\\displaystyle -2$, $\\displaystyle 2$), ($\\displaystyle -1.000000000000000?$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are the roots of Ehrhart polynomials for n = 2:"}︡{"stdout":"\nRR:\n"}︡{"html":"<div align='center'>[($\\displaystyle -5.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -4$, $\\displaystyle 2$), ($\\displaystyle -3$, $\\displaystyle 2$), ($\\displaystyle -2$, $\\displaystyle 2$), ($\\displaystyle -1.000000000000000?$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\nRL:\n"}︡{"html":"<div align='center'>[($\\displaystyle -5.000000000000?$, $\\displaystyle 1$), ($\\displaystyle -4.00000000000?$, $\\displaystyle 1$), ($\\displaystyle -3$, $\\displaystyle 2$), ($\\displaystyle -2.000000000000?$, $\\displaystyle 1$), ($\\displaystyle -1.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -3.000000000000? - 0.57735026919?i$, $\\displaystyle 1$), ($\\displaystyle -3.000000000000? + 0.57735026919?i$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are the roots of Ehrhart polynomials for n = 3:"}︡{"stdout":"\nRRR:\n"}︡{"html":"<div align='center'>[($\\displaystyle -6.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -5$, $\\displaystyle 2$), ($\\displaystyle -4$, $\\displaystyle 2$), ($\\displaystyle -3$, $\\displaystyle 2$), ($\\displaystyle -2$, $\\displaystyle 2$), ($\\displaystyle -1.000000000000000?$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\nRRL:\n"}︡{"html":"<div align='center'>[($\\displaystyle -6.000000000000?$, $\\displaystyle 1$), ($\\displaystyle -5.00000000000?$, $\\displaystyle 1$), ($\\displaystyle -4$, $\\displaystyle 2$), ($\\displaystyle -3$, $\\displaystyle 2$), ($\\displaystyle -2.0000000000000?$, $\\displaystyle 1$), ($\\displaystyle -1.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -3.500000000000? - 0.69084927971?i$, $\\displaystyle 1$), ($\\displaystyle -3.500000000000? + 0.69084927971?i$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\nRLR:\n"}︡{"html":"<div align='center'>[($\\displaystyle -6.000000000?$, $\\displaystyle 1$), ($\\displaystyle -4.00000000?$, $\\displaystyle 1$), ($\\displaystyle -3.000000000?$, $\\displaystyle 1$), ($\\displaystyle -2.00000000000?$, $\\displaystyle 1$), ($\\displaystyle -1.0000000000000?$, $\\displaystyle 1$), ($\\displaystyle -5.000000000? + 0.? \\times 10^{-11}i$, $\\displaystyle 1$), ($\\displaystyle -4.240169273? - 1.16910910?i$, $\\displaystyle 1$), ($\\displaystyle -4.240169273? + 1.16910910?i$, $\\displaystyle 1$), ($\\displaystyle -2.759830727? - 1.169109093?i$, $\\displaystyle 1$), ($\\displaystyle -2.759830727? + 1.169109093?i$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\nRLL:\n"}︡{"html":"<div align='center'>[($\\displaystyle -6.000000000000?$, $\\displaystyle 1$), ($\\displaystyle -5.00000000000?$, $\\displaystyle 1$), ($\\displaystyle -4$, $\\displaystyle 2$), ($\\displaystyle -3$, $\\displaystyle 2$), ($\\displaystyle -2.0000000000000?$, $\\displaystyle 1$), ($\\displaystyle -1.00000000000000?$, $\\displaystyle 1$), ($\\displaystyle -3.500000000000? - 0.69084927971?i$, $\\displaystyle 1$), ($\\displaystyle -3.500000000000? + 0.69084927971?i$, $\\displaystyle 1$)]</div>"}︡{"stdout":"\n"}︡{"done":true}
︠cbdd835f-9391-4652-8a50-779f4cea7f99︠










