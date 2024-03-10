import turtle

turtle.bgcolor('red') # couleur du background

star = turtle.Turtle()
star.color("green") # couleur de l'étoile
star.width(15) # Epaisseur du trait
star.right(75)
star.forward(250)  # longueur des segments

for i in range(4):
    star.right(144)
    star.forward(250)

turtle.done()
