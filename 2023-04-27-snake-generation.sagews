︠22869a49-a5f6-425c-97a2-c1af9bf11ddb︠

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
ehrhart_of_order(3)

def order_poly_of_order(n):
    words = non_isomorphic_snake_words(n)
    snakes_rank_polynomials = [(word, snake(word).order_polynomial) for word in words]
    print("These are order polynomials for n = {}:".format(n))
    for entry in snakes_rank_polynomials:
        print("{}:".format(entry[0]))
        pretty_print(entry[1])
        print("")
order_poly_of_order(3)
︡e9319f25-5cda-4cda-9027-7271b7581872︡{"stdout":"['RRRRR', 'RRRRL', 'RRRLR', 'RRRLL', 'RRLRR', 'RRLRL', 'RRLLR', 'RRLLL', 'RLRRR', 'RLRRL', 'RLRLR', 'RLRLL', 'RLLRR', 'RLLRL', 'RLLLR', 'RLLLL']\n"}︡{"stdout":"These are Ehrhart polynomials for n = 3:"}︡{"stdout":"\nRRR:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{1}{86400}$, $\\displaystyle \\frac{7}{17280}$, $\\displaystyle \\frac{1}{160}$, $\\displaystyle \\frac{161}{2880}$, $\\displaystyle \\frac{3077}{9600}$, $\\displaystyle \\frac{2359}{1920}$, $\\displaystyle \\frac{27491}{8640}$, $\\displaystyle \\frac{23681}{4320}$, $\\displaystyle \\frac{21569}{3600}$, $\\displaystyle \\frac{56}{15}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRRL:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{11}{1209600}$, $\\displaystyle \\frac{11}{34560}$, $\\displaystyle \\frac{199}{40320}$, $\\displaystyle \\frac{257}{5760}$, $\\displaystyle \\frac{14983}{57600}$, $\\displaystyle \\frac{11753}{11520}$, $\\displaystyle \\frac{20563}{7560}$, $\\displaystyle \\frac{41917}{8640}$, $\\displaystyle \\frac{138977}{25200}$, $\\displaystyle \\frac{43}{12}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRLR:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{29}{3628800}$, $\\displaystyle \\frac{29}{103680}$, $\\displaystyle \\frac{263}{60480}$, $\\displaystyle \\frac{683}{17280}$, $\\displaystyle \\frac{40157}{172800}$, $\\displaystyle \\frac{31871}{34560}$, $\\displaystyle \\frac{905767}{362880}$, $\\displaystyle \\frac{117553}{25920}$, $\\displaystyle \\frac{88489}{16800}$, $\\displaystyle \\frac{1261}{360}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\nRLL:\n"}︡{"html":"<div align='center'>[$\\displaystyle \\frac{11}{1209600}$, $\\displaystyle \\frac{11}{34560}$, $\\displaystyle \\frac{199}{40320}$, $\\displaystyle \\frac{257}{5760}$, $\\displaystyle \\frac{14983}{57600}$, $\\displaystyle \\frac{11753}{11520}$, $\\displaystyle \\frac{20563}{7560}$, $\\displaystyle \\frac{41917}{8640}$, $\\displaystyle \\frac{138977}{25200}$, $\\displaystyle \\frac{43}{12}$, $\\displaystyle 1$]</div>"}︡{"stdout":"\n"}︡{"stdout":"These are order polynomials for n = 3:"}︡{"stdout":"\nRRR:\n"}︡{"html":"<div align='center'>$\\displaystyle \\frac{1}{86400} q^{10} + \\frac{1}{3456} q^{9} + \\frac{1}{320} q^{8} + \\frac{11}{576} q^{7} + \\frac{697}{9600} q^{6} + \\frac{341}{1920} q^{5} + \\frac{301}{1080} q^{4} + \\frac{233}{864} q^{3} + \\frac{131}{900} q^{2} + \\frac{1}{30} q$</div>"}︡{"stdout":"\nRRL:\n"}︡{"html":"<div align='center'>$\\displaystyle \\frac{11}{1209600} q^{10} + \\frac{11}{48384} q^{9} + \\frac{5}{2016} q^{8} + \\frac{125}{8064} q^{7} + \\frac{3523}{57600} q^{6} + \\frac{1819}{11520} q^{5} + \\frac{6443}{24192} q^{4} + \\frac{3415}{12096} q^{3} + \\frac{8569}{50400} q^{2} + \\frac{37}{840} q$</div>"}︡{"stdout":"\nRLR:\n"}︡{"html":"<div align='center'>$\\displaystyle \\frac{29}{3628800} q^{10} + \\frac{29}{145152} q^{9} + \\frac{53}{24192} q^{8} + \\frac{335}{24192} q^{7} + \\frac{9617}{172800} q^{6} + \\frac{5101}{34560} q^{5} + \\frac{293}{1134} q^{4} + \\frac{10435}{36288} q^{3} + \\frac{4631}{25200} q^{2} + \\frac{16}{315} q$</div>"}︡{"stdout":"\nRLL:\n"}︡{"html":"<div align='center'>$\\displaystyle \\frac{11}{1209600} q^{10} + \\frac{11}{48384} q^{9} + \\frac{5}{2016} q^{8} + \\frac{125}{8064} q^{7} + \\frac{3523}{57600} q^{6} + \\frac{1819}{11520} q^{5} + \\frac{6443}{24192} q^{4} + \\frac{3415}{12096} q^{3} + \\frac{8569}{50400} q^{2} + \\frac{37}{840} q$</div>"}︡{"stdout":"\n"}︡{"done":true}
︠cbdd835f-9391-4652-8a50-779f4cea7f99︠










