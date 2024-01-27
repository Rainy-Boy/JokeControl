extends Node2D

const PUN = 1
const OFFENSIVE = 2
const CLEVER = 3

const GOOD = 3
const MEDIUM = 2
const BAD = 1

const jokePanelStartingPositionVector = Vector2(1100, -1656)
const punchlinePanelStartingPositionVector = Vector2(1100, -1328)

var rng = RandomNumberGenerator.new()

var easyMode = true

var jokesDictionary = {
	PUN : {
		"Why is 6 afraid of 7?": {
			GOOD : [
				"Because seven ate nine"
			],
			MEDIUM: [
				"Because 7 is a registered 6 offender"
			],
			BAD: [
				"Because 7 is a prime number",
				"Because 9 8 7",
				"Because 8 7 9"
			]
		},
		"What happens when you illegally park a frog?": {
			GOOD: [
				"It gets toad away!"
			],
			MEDIUM: [
				"The police might jump to conclusions!"
			],
			BAD: [
				"You'll be left with a hopportunity to pay fines!"
			]
		},
		"What is a dogs favorite homework assignment?": {
			GOOD: [
				"A lab report"
			],
			MEDIUM: [
				"Chasing 'paw-ssibilities' in 'Bark-itecture' class!",
				"Sniffing out 'Lick-erature' for a good read!",
				"Bark-eology – it's a real tail-wagger!"
			],
			BAD: []
		}
	}
}

var listOfShittyEndings = [
	"To get to the other side",
	"She looked surprised!",
	"Sounds like my last relationship!",
	"They don't have the guts!"
]

"""
var testDictionary = {
	"test": [
		"one", "two"
	],
	"secondOne": [
		"three", "four"
	],
	"three": {
		"test": 1
	}
}
"""
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(testDictionary["secondOne"][0])
	#print(jokesDictionary[PUN].keys().pick_random())
	#var randomJoke = jokesDictionary[PUN].keys().pick_random()
	#print(jokesDictionary[PUN][randomJoke][BAD].size())
	setDefaultPositions()

	#var jokeType = rng.randi_range(1, 3)
	var jokeType = 1
	var joke = setRandomJoke(jokeType)
	setRandomPunchlines(joke, jokeType)
	
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($Camera2D, "zoom", $Camera2D.zoom + Vector2(0.2, 0.2), 5)
	tween.tween_property($Camera2D, "position", $Camera2D.position - Vector2(0, 300), 5)
	showJokePanel()
	tween.connect("finished", showThreePunchlinePanel)
	
func setDefaultPositions():
	$JokePanel.position = jokePanelStartingPositionVector
	$SixPunchlinePanel.position = punchlinePanelStartingPositionVector
	$ThreePunchlinePanel.position = punchlinePanelStartingPositionVector

func showJokePanel():
	var tween = get_tree().create_tween()
	tween.tween_property($JokePanel, "position", $JokePanel.position - Vector2(1130, 0), 2)
	
func showThreePunchlinePanel():
	var expositionTween = get_tree().create_tween()
	expositionTween.tween_property($ThreePunchlinePanel, "position", $ThreePunchlinePanel.position - Vector2(1120, 0), 2)

func setRandomJoke(jokeType):
	var jokeObject = get_node("JokePanel/Joke")
	
	var randomJoke = jokesDictionary[jokeType].keys().pick_random()
	
	jokeObject.text = randomJoke
	
	return randomJoke

func setRandomPunchlines(joke, jokeType):
	if easyMode:
		setThreePunchlines(joke, jokeType)
		
func setThreePunchlines(joke, jokeType):
	var punchlineObject1 = get_node("ThreePunchlinePanel/PunchlineButton1/PunchlineText")
	var punchlineObject2 = get_node("ThreePunchlinePanel/PunchlineButton2/PunchlineText")
	var punchlineObject3 = get_node("ThreePunchlinePanel/PunchlineButton3/PunchlineText")
	
	var punchlineObjects = [punchlineObject1, punchlineObject2, punchlineObject3]
	#print(punchlineObject3.get_child_count())
	
	var punchlineOptions = [BAD, MEDIUM, GOOD]
	
	for punchlineObject in punchlineObjects:
		var option = punchlineOptions.pick_random()
		var punchline
		
		print(jokeType)
		print(joke)
		print(option)
		
		if jokesDictionary[jokeType][joke][option].pick_random() != null:
			punchline = jokesDictionary[jokeType][joke][option].pick_random()
		else:
			punchline = listOfShittyEndings.pick_random()
		
		punchlineObject.text = punchline
		punchlineOptions.erase(option)


func _on_punchline_button_1_pressed():
	print("Uzspieda pirmo pogu")

func _on_punchline_button_2_pressed():
	print("Uzspieda otro pogu")

func _on_punchline_button_3_pressed():
	print("Uzspieda trešo pogu")