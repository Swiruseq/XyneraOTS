local function wordHelper(first, rest)
   return string.format("%s%s", first:upper(), rest:lower())
end

local function upAllWords(text)
	return string.gsub(text, "(%a)([%w_']*)", wordHelper)
end

local lastOfferId = 0
function GenerateBed(bedName, price, publishedAt, headBoard, footBoard)
	local hb = ItemType(headBoard)
	local fb = ItemType(footBoard)
	local bed = {
		string.format("%s Headboard", upAllWords(hb:getName())), hb:getClientId(),
		string.format("%s Footboard", upAllWords(fb:getName())), fb:getClientId()
	}

	local productId = #StoreOffers + 1
	lastOfferId = lastOfferId + 1
	StoreOffers[productId] = {
		name = bedName,
		description = StoreDescBed,
		publishedAt = publishedAt,

		packages = {
			[1] = {
				amount = 1,
				price = price,
				currency = STORE_CURRENCY_COINS,
				offerId = lastOfferId,
				status = STORE_CATEGORY_TYPE_NORMAL,
			},
		},
	
		type = STORE_OFFER_TYPE_DEFAULT,
		image = string.format("%s.png", bedName:gsub(" ", "_")),
		bed = bed,
		
		-- for direct offer id request
		category = STORE_TAB_BEDS,
	}
	
	table.insert(StoreCategories[STORE_TAB_BEDS].offers, productId)
end

function GenerateMount(name, lookType, price, publishedAt, description)
	local tier = price > 800 and 3 or price < 750 and 1 or 2

	local productId = #StoreOffers + 1
	lastOfferId = lastOfferId + 1
	StoreOffers[productId] = {
		name = name,
		description = string.format("{character}\n{speedboost}\n\n<i>%s</i>", description),
		publishedAt = publishedAt,

		packages = {
			[1] = {
				amount = 1,
				price = price,
				currency = STORE_CURRENCY_COINS,
				offerId = lastOfferId,
				status = STORE_CATEGORY_TYPE_NORMAL,
			},
		},
	
		type = STORE_OFFER_TYPE_MOUNT,
		lookType = lookType,
		
		-- for direct offer id request
		category = STORE_TAB_MOUNTS,
		subCategory = tier
	}
	
	table.insert(StoreCategories[STORE_TAB_MOUNTS].offerTypes[tier].offers, productId)
	
	Game.setStoreMount(lookType, lastOfferId)
end

local descOutfitColor = "{character}\n{info} colours can be changed using the Outfit dialog\n"
local descOutfitAddons = "{info} includes basic outfit and 2 addons which can be selected individually\n"

function GenerateOutfit(name, lookTypeM, lookTypeF, price, publishedAt, description)
	local retro = name:lower():match("retro") and true
	local tier = retro and 4 or price > 850 and 3 or price < 730 and 1 or 2
	local productId = #StoreOffers + 1
	lastOfferId = lastOfferId + 1
	StoreOffers[productId] = {
		name = name,
		description = string.format("%s%s\n<i>%s</i>", descOutfitColor, retro and descOutfitAddons or "", description),
		publishedAt = publishedAt,

		packages = {
			[1] = {
				amount = 1,
				price = price,
				currency = STORE_CURRENCY_COINS,
				offerId = lastOfferId,
				status = STORE_CATEGORY_TYPE_NORMAL,
			},
		},
	
		type = STORE_OFFER_TYPE_OUTFIT,
		lookTypeMale = lookTypeM,
		lookTypeFemale = lookTypeF,
		
		-- for direct offer id request
		category = STORE_TAB_OUTFITS,
		subCategory = tier
	}
	
	table.insert(StoreCategories[STORE_TAB_OUTFITS].offerTypes[tier].offers, productId)
	
	Game.setStoreOutfit(lookTypeM, lastOfferId)
	Game.setStoreOutfit(lookTypeF, lastOfferId)
end

-- name, price, publishedAt, headboard, footboard
GenerateBed("Verdant Bed", 150, 1663920000, 28752, 28753)
GenerateBed("Homely Bed", 120, 1663920000, 36976, 36977)
GenerateBed("Wrought-Iron Bed", 150, 1663920000, 37862, 37863)
GenerateBed("Vengothic Bed", 180, 1663920000, 38539, 38540)
GenerateBed("Ornate Bed", 180, 1663920000, 38527, 38528)
GenerateBed("Magnificent Bed", 180, 1663920000, 38515, 38516)
GenerateBed("Grandiose Bed", 150, 1663920000, 38592, 38593)
GenerateBed("Log Bed", 150, 1663920000, 39687, 39688)
GenerateBed("Kraken Bed", 150, 1663920000, 39857, 39858)
GenerateBed("Sleeping Mat", 120, 1663920000, 40941, 40942)
GenerateBed("Knightly Bed", 180, 1663920000, 44468, 44469)
GenerateBed("Flower Bed", 150, 1663920000, 44785, 44786)

-- bone bed is from quest
-- other beds should be from shop

-- name, lookType, price, publishedAt, description
GenerateMount("Parade Horse", 1578, 870, 1661500800, "A seasoned warrior knows how to make an entry, and so does his faithful companion: Fully armored! Saddle up your impressive Jousting Horse to charge into battle in style, gallop into the arena on the back of your striking Tourney Horse, and ride your distinguished Parade Horse through the streets of Thais to show off your chivalrous qualities. With a horse in full barding, nobody will ever rain on your parade again.")
GenerateMount("Jousting Horse", 1579, 870, 1661500800, "A seasoned warrior knows how to make an entry, and so does his faithful companion: Fully armored! Saddle up your impressive Jousting Horse to charge into battle in style, gallop into the arena on the back of your striking Tourney Horse, and ride your distinguished Parade Horse through the streets of Thais to show off your chivalrous qualities. With a horse in full barding, nobody will ever rain on your parade again.")
GenerateMount("Tourney Horse", 1580, 870, 1661500800, "A seasoned warrior knows how to make an entry, and so does his faithful companion: Fully armored! Saddle up your impressive Jousting Horse to charge into battle in style, gallop into the arena on the back of your striking Tourney Horse, and ride your distinguished Parade Horse through the streets of Thais to show off your chivalrous qualities. With a horse in full barding, nobody will ever rain on your parade again.")
GenerateMount("Poppy Ibex", 1526, 750, 1653638400, "No mountain is too high, no wall too steep to climb for the agile Poppy, Mint and Cinnamon Ibex. They keep their balance on the thinnest of ledges, so you will never stumble, slip or go flying off the edges. Moreover, these sturdy fellows certainly know how to make an entrance as they dive down from the highest peaks and attack opponents with their impressive horns. And if you dare to call them a wild goat, they might kick you with their legs.")
GenerateMount("Mint Ibex", 1527, 750, 1653638400, "No mountain is too high, no wall too steep to climb for the agile Poppy, Mint and Cinnamon Ibex. They keep their balance on the thinnest of ledges, so you will never stumble, slip or go flying off the edges. Moreover, these sturdy fellows certainly know how to make an entrance as they dive down from the highest peaks and attack opponents with their impressive horns. And if you dare to call them a wild goat, they might kick you with their legs.")
GenerateMount("Cinnamon Ibex", 1528, 750, 1653638400, "No mountain is too high, no wall too steep to climb for the agile Poppy, Mint and Cinnamon Ibex. They keep their balance on the thinnest of ledges, so you will never stumble, slip or go flying off the edges. Moreover, these sturdy fellows certainly know how to make an entrance as they dive down from the highest peaks and attack opponents with their impressive horns. And if you dare to call them a wild goat, they might kick you with their legs.")
GenerateMount("Topaz Shrine", 1491, 690, 1648198800, "The famous Wandering Shrines were first raised by the nomad people of the Zaoan steppe. Their exceptional craftsmanship, combining architectonic features with living animals, is acknowledged even far beyond the continent of Zao. These spiritual companions will give you the opportunity to regain your strength during long and exciting journeys.")
GenerateMount("Jade Shrine", 1492, 690, 1648198800, "The famous Wandering Shrines were first raised by the nomad people of the Zaoan steppe. Their exceptional craftsmanship, combining architectonic features with living animals, is acknowledged even far beyond the continent of Zao. These spiritual companions will give you the opportunity to regain your strength during long and exciting journeys.")
GenerateMount("Obsidian Shrine", 1493, 690, 1648198800, "The famous Wandering Shrines were first raised by the nomad people of the Zaoan steppe. Their exceptional craftsmanship, combining architectonic features with living animals, is acknowledged even far beyond the continent of Zao. These spiritual companions will give you the opportunity to regain your strength during long and exciting journeys.")
GenerateMount("Emerald Raven", 1453, 690, 1641373200, "The origins of the Emerald Raven, Mystic Raven, and Radiant Raven are shrouded in darkness, as no written record nor tale told by even the most knowing storytellers mentions but a trace of them. Superstition surrounds them, as some see these gigantic birds as an echo of a long forgotten past, while others believe them to herald hitherto unknown events. What is clear is that they are highly intelligent beings which make great companions if they deem somebody worthy.")
GenerateMount("Mystic Raven", 1454, 690, 1641373200, "The origins of the Emerald Raven, Mystic Raven, and Radiant Raven are shrouded in darkness, as no written record nor tale told by even the most knowing storytellers mentions but a trace of them. Superstition surrounds them, as some see these gigantic birds as an echo of a long forgotten past, while others believe them to herald hitherto unknown events. What is clear is that they are highly intelligent beings which make great companions if they deem somebody worthy.")
GenerateMount("Radiant Raven", 1455, 690, 1641373200, "The origins of the Emerald Raven, Mystic Raven, and Radiant Raven are shrouded in darkness, as no written record nor tale told by even the most knowing storytellers mentions but a trace of them. Superstition surrounds them, as some see these gigantic birds as an echo of a long forgotten past, while others believe them to herald hitherto unknown events. What is clear is that they are highly intelligent beings which make great companions if they deem somebody worthy.")
GenerateMount("Rustwurm", 1446, 870, 1632470400, "The Bogwurm, Gloomwurm, and Rustwurm belong to a little known subset of the dragon family, and usually live out their lives in habitats far away from human interaction. Them being cunning hunters, and their keen sense of perception make these wurms great companions for whomever can locate and tame them.")
GenerateMount("Bogwurm", 1447, 870, 1632470400, "The Bogwurm, Gloomwurm, and Rustwurm belong to a little known subset of the dragon family, and usually live out their lives in habitats far away from human interaction. Them being cunning hunters, and their keen sense of perception make these wurms great companions for whomever can locate and tame them.")
GenerateMount("Gloomwurm", 1448, 870, 1632470400, "The Bogwurm, Gloomwurm, and Rustwurm belong to a little known subset of the dragon family, and usually live out their lives in habitats far away from human interaction. Them being cunning hunters, and their keen sense of perception make these wurms great companions for whomever can locate and tame them.")
GenerateMount("Hyacinth", 1439, 750, 1624608000, "Born from the depths of the forest, where flora and fauna intertwine in mysterious ways, the Floral Beast is a colourful creature that is sure to turn some heads. The Hyacinth, Peony, and Dandelion mount are loyal companions that will safely carry you through their natural habitat of the woods, or lands unknown to them.")
GenerateMount("Peony", 1440, 750, 1624608000, "Born from the depths of the forest, where flora and fauna intertwine in mysterious ways, the Floral Beast is a colourful creature that is sure to turn some heads. The Hyacinth, Peony, and Dandelion mount are loyal companions that will safely carry you through their natural habitat of the woods, or lands unknown to them.")
GenerateMount("Dandelion", 1441, 750, 1624608000, "Born from the depths of the forest, where flora and fauna intertwine in mysterious ways, the Floral Beast is a colourful creature that is sure to turn some heads. The Hyacinth, Peony, and Dandelion mount are loyal companions that will safely carry you through their natural habitat of the woods, or lands unknown to them.")
GenerateMount("Void Watcher", 1389, 870, 1616749200, "If you are looking for a vigilant and faithful companion, look no further! Glide through every realm and stare into the darkest abyss on the back of a Void Watcher. They already know everything about you anyway for they have been watching you from the shadows!")
GenerateMount("Rune Watcher", 1390, 870, 1616749200, "If you are looking for a vigilant and faithful companion, look no further! Glide through every realm and stare into the darkest abyss on the back of a Rune Watcher. They already know everything about you anyway for they have been watching you from the shadows!")
GenerateMount("Rift Watcher", 1391, 870, 1616749200, "If you are looking for a vigilant and faithful companion, look no further! Glide through every realm and stare into the darkest abyss on the back of a Rift Watcher. They already know everything about you anyway for they have been watching you from the shadows!")
GenerateMount("Merry Mammoth", 1379, 750, 1607677200, "The Festive Mammoth, Holiday Mammoth and Merry Mammoth are gentle giants with a massive appearance and impressive tusks, whose mission it is to deliver gifts all across the world. They are good-natured beings, spreading joy wherever they go, but you best not cross them - a mammoth never forgets.")
GenerateMount("Holiday Mammoth", 1380, 750, 1607677200, "The Festive Mammoth, Holiday Mammoth and Merry Mammoth are gentle giants with a massive appearance and impressive tusks, whose mission it is to deliver gifts all across the world. They are good-natured beings, spreading joy wherever they go, but you best not cross them - a mammoth never forgets.")
GenerateMount("Festive Mammoth", 1381, 750, 1607677200, "The Festive Mammoth, Holiday Mammoth and Merry Mammoth are gentle giants with a massive appearance and impressive tusks, whose mission it is to deliver gifts all across the world. They are good-natured beings, spreading joy wherever they go, but you best not cross them - a mammoth never forgets.")
GenerateMount("Cunning Hyaena", 1334, 750, 1595577600, "The Cunning Hyaena, Scruffy Hyaena and Voracious Hyaena are highly social animals and loyal companions to whomever is able to befriend them. Coming from sun-soaked places, they prefer a warm climate, but are able to cope in other environments as well.")
GenerateMount("Voracious Hyaena", 1333, 750, 1595577600, "The Cunning Hyaena, Scruffy Hyaena and Voracious Hyaena are highly social animals and loyal companions to whomever is able to befriend them. Coming from sun-soaked places, they prefer a warm climate, but are able to cope in other environments as well.")
GenerateMount("Scruffy Hyaena", 1335, 750, 1595577600, "The Cunning Hyaena, Scruffy Hyaena and Voracious Hyaena are highly social animals and loyal companions to whomever is able to befriend them. Coming from sun-soaked places, they prefer a warm climate, but are able to cope in other environments as well.")
GenerateMount("Eventide Nandu", 1311, 500, 1587625200, "These birds have a strong maternal instinct since their fledglings are completely dependent on their parents for protection. Do not expect them to abandon their brood only because they are carrying you around. In fact, if you were to separate them from their chick, the Savanna Ostrich, Coral Rhea and Eventide Nandu would turn into vicious beings, so don't even try it!")
GenerateMount("Coral Rhea", 1310, 500, 1587625200, "These birds have a strong maternal instinct since their fledglings are completely dependent on their parents for protection. Do not expect them to abandon their brood only because they are carrying you around. In fact, if you were to separate them from their chick, the Savanna Ostrich, Coral Rhea and Eventide Nandu would turn into vicious beings, so don't even try it!")
GenerateMount("Savanna Ostrich", 1309, 500, 1587625200, "These birds have a strong maternal instinct since their fledglings are completely dependent on their parents for protection. Do not expect them to abandon their brood only because they are carrying you around. In fact, if you were to separate them from their chick, the Savanna Ostrich, Coral Rhea and Eventide Nandu would turn into vicious beings, so don't even try it!")
GenerateMount("Snow Strider", 1284, 870, 1580461200, "A magical fire burns inside these wolves. Bred as the faithful guardians for an eccentric wizard's tower, these creatures make for loyal companions during your travels. While not originally intended for riding, their sturdy frame makes the Dawn Strayer, Dusk Pryer and Snow Strider suitable mounts.")
GenerateMount("Dusk Pryer", 1285, 870, 1580461200, "A magical fire burns inside these wolves. Bred as the faithful guardians for an eccentric wizard's tower, these creatures make for loyal companions during your travels. While not originally intended for riding, their sturdy frame makes the Dawn Strayer, Dusk Pryer and Snow Strider suitable mounts.")
GenerateMount("Dawn Strayer", 1286, 870, 1580461200, "A magical fire burns inside these wolves. Bred as the faithful guardians for an eccentric wizard's tower, these creatures make for loyal companions during your travels. While not originally intended for riding, their sturdy frame makes the Dawn Strayer, Dusk Pryer and Snow Strider suitable mounts.")
GenerateMount("Floating Augur", 1266, 870, 1572598800, "These creatures are Floating Savants whose mind has been warped and bent to focus their extraordinary mental capabilities on one single goal: to do their master's bidding. Instead of being filled with an endless pursuit of knowledge, their live is now one of continuous thralldom and serfhood. The Floating Sage, the Floating Scholar and the Floating Augur are at your disposal.")
GenerateMount("Floating Scholar", 1265, 870, 1572598800, "These creatures are Floating Savants whose mind has been warped and bent to focus their extraordinary mental capabilities on one single goal: to do their master's bidding. Instead of being filled with an endless pursuit of knowledge, their live is now one of continuous thralldom and serfhood. The Floating Sage, the Floating Scholar and the Floating Augur are at your disposal.")
GenerateMount("Floating Sage", 1264, 870, 1572598800, "These creatures are Floating Savants whose mind has been warped and bent to focus their extraordinary mental capabilities on one single goal: to do their master's bidding. Instead of being filled with an endless pursuit of knowledge, their live is now one of continuous thralldom and serfhood. The Floating Sage, the Floating Scholar and the Floating Augur are at your disposal.")
GenerateMount("Zaoan Badger", 1249, 690, 1566547200, "Badgers have been a staple of the world's fauna for a long time, and finally some daring souls have braved the challenge to tame some exceptional specimens - and succeeded! While the common badger you can encounter during your travels might seem like a rather unassuming creature, the Battle Badger, the Ether Badger, and the Zaoan Badger are fierce and mighty beasts, which are at your beck and call.")
GenerateMount("Ether Badger", 1248, 690, 1566547200, "Badgers have been a staple of the world's fauna for a long time, and finally some daring souls have braved the challenge to tame some exceptional specimens - and succeeded! While the common badger you can encounter during your travels might seem like a rather unassuming creature, the Battle Badger, the Ether Badger, and the Zaoan Badger are fierce and mighty beasts, which are at your beck and call.")
GenerateMount("Battle Badger", 1247, 690, 1566547200, "Badgers have been a staple of the world's fauna for a long time, and finally some daring souls have braved the challenge to tame some exceptional specimens - and succeeded! While the common badger you can encounter during your travels might seem like a rather unassuming creature, the Battle Badger, the Ether Badger, and the Zaoan Badger are fierce and mighty beasts, which are at your beck and call.")
GenerateMount("Nightmarish Crocovile", 1185, 750, 1558681200, "To the keen observer, the crocovile is clearly a relative of the crocodile, albeit their look suggests an even more aggressive nature. While it is true that the power of its massive and muscular body can not only crush enemies dead but also break through any gate like a battering ram, a crocovile is, above all, a steadfast companion showing unwavering loyalty to its owner.")
GenerateMount("Swamp Crocovile", 1184, 750, 1558681200, "To the keen observer, the crocovile is clearly a relative of the crocodile, albeit their look suggests an even more aggressive nature. While it is true that the power of its massive and muscular body can not only crush enemies dead but also break through any gate like a battering ram, a crocovile is, above all, a steadfast companion showing unwavering loyalty to its owner.")
GenerateMount("River Crocovile", 1183, 750, 1558681200, "To the keen observer, the crocovile is clearly a relative of the crocodile, albeit their look suggests an even more aggressive nature. While it is true that the power of its massive and muscular body can not only crush enemies dead but also break through any gate like a battering ram, a crocovile is, above all, a steadfast companion showing unwavering loyalty to its owner.")
GenerateMount("Cony Cart", 1181, 870, 1554451200, "Your lower back worsens with every trip you spend on the back of your mount and you are looking for a more comfortable alternative to travel through the lands? Say no more! The Cony Cart comes with two top-performing hares that never get tired thanks to the brand new and highly innovative propulsion technology. Just keep some back-up carrots in your pocket and you will be fine!")
GenerateMount("Bunny Dray", 1180, 870, 1554451200, "Your lower back worsens with every trip you spend on the back of your mount and you are looking for a more comfortable alternative to travel through the lands? Say no more! The Bunny Dray comes with two top-performing hares that never get tired thanks to the brand new and highly innovative propulsion technology. Just keep some back-up carrots in your pocket and you will be fine!")
GenerateMount("Rabbit Rickshaw", 1179, 870, 1554451200, "Your lower back worsens with every trip you spend on the back of your mount and you are looking for a more comfortable alternative to travel through the lands? Say no more! The Rabbit Rickshaw comes with two top-performing hares that never get tired thanks to the brand new and highly innovative propulsion technology. Just keep some back-up carrots in your pocket and you will be fine!")
GenerateMount("Festive Snowman", 1167, 900, 1546592400, "When the nights are getting longer and freezing wind brings driving snow into the land, snowmen rise and shine on every corner. Lately, a peaceful, arcane creature has found shelter in one of them and used its magical power to call the Festive Snowman into being. Wrap yourself up well and warmly and jump on the back of your new frosty companion.")
GenerateMount("Muffled Snowman", 1168, 900, 1546592400, "When the nights are getting longer and freezing wind brings driving snow into the land, snowmen rise and shine on every corner. Lately, a peaceful, arcane creature has found shelter in one of them and used its magical power to call the Muffled Snowman into being. Wrap yourself up well and warmly and jump on the back of your new frosty companion.")
GenerateMount("Caped Snowman", 1169, 900, 1546592400, "When the nights are getting longer and freezing wind brings driving snow into the land, snowmen rise and shine on every corner. Lately, a peaceful, arcane creature has found shelter in one of them and used its magical power to call the Caped Snowman into being. Wrap yourself up well and warmly and jump on the back of your new frosty companion.")
GenerateMount("Tawny Owl", 1104, 870, 1538121600, "Owls have always been a symbol of mystery, magic and wisdom in various mythologies and fairy tales. Having one of these enigmatic creatures of the night as a trustworthy companion provides you with a silent guide whose ever-watchful eyes will cut through the shadows, help you navigate the darkness and unravel great secrets.")
GenerateMount("Snowy Owl", 1105, 870, 1538121600, "Owls have always been a symbol of mystery, magic and wisdom in various mythologies and fairy tales. Having one of these enigmatic creatures of the night as a trustworthy companion provides you with a silent guide whose ever-watchful eyes will cut through the shadows, help you navigate the darkness and unravel great secrets.")
GenerateMount("Boreal Owl", 1106, 870, 1538121600, "Owls have always been a symbol of mystery, magic and wisdom in various mythologies and fairy tales. Having one of these enigmatic creatures of the night as a trustworthy companion provides you with a silent guide whose ever-watchful eyes will cut through the shadows, help you navigate the darkness and unravel great secrets.")
GenerateMount("Ebony Tiger", 1091, 750, 1529654400, "It is said that in ancient times, the sabre-tooth tiger was already used as a mount by elder warriors of Svargrond. As seafaring began to expand, this noble big cat was also transported to other regions. Influenced by the new environment and climatic changes, the fur of the Ebony Tiger has developed its extraordinary colouring over several generations.")
GenerateMount("Feral Tiger", 1092, 750, 1529654400, "It is said that in ancient times, the sabre-tooth tiger was already used as a mount by elder warriors of Svargrond. As seafaring began to expand, this noble big cat was also transported to other regions. Influenced by the new environment and climatic changes, the fur of the Feral Tiger has developed its extraordinary colouring over several generations.")
GenerateMount("Jungle Tiger", 1093, 750, 1529654400, "It is said that in ancient times, the sabre-tooth tiger was already used as a mount by elder warriors of Svargrond. As seafaring began to expand, this noble big cat was also transported to other regions. Influenced by the new environment and climatic changes, the fur of the Jungle Tiger has developed its extraordinary colouring over several generations.")
GenerateMount("Marsh Toad", 1052, 690, 1522137600, "For centuries, humans and monsters have dumped their garbage in the swamps around Venore. The combination of old, rusty weapons, stale mana and broken runes have turned some of the swamp dwellers into gigantic frogs. Benefit from those mutations and make the Marsh Toad a faithful mount for your adventures even beyond the bounds of the swamp.")
GenerateMount("Sanguine Frog", 1053, 690, 1522137600, "For centuries, humans and monsters have dumped their garbage in the swamps around Venore. The combination of old, rusty weapons, stale mana and broken runes have turned some of the swamp dwellers into gigantic frogs. Benefit from those mutations and make the Sanguine Frog a faithful mount for your adventures even beyond the bounds of the swamp.")
GenerateMount("Toxic Toad", 1054, 690, 1522137600, "For centuries, humans and monsters have dumped their garbage in the swamps around Venore. The combination of old, rusty weapons, stale mana and broken runes have turned some of the swamp dwellers into gigantic frogs. Benefit from those mutations and make the Toxic Toad a faithful mount for your adventures even beyond the bounds of the swamp.")
GenerateMount("Cranium Spider", 1025, 690, 1510650000, "It is said that the Cranium Spider was born long before Banor walked the earth. While its parents died in the war against the cruel hordes sent by Brog and Zathroth, their child survived by hiding in skulls of burned enemies. It never left its hiding spot and as it grew older, the skulls merged into its body. Now, it is fully-grown and thirsts for revenge.")
GenerateMount("Cave Tarantula", 1026, 690, 1510650000, "It is said that the Cave Tarantula was born long before Banor walked the earth. While its parents died in the war against the cruel hordes sent by Brog and Zathroth, their child survived by hiding in skulls of burned enemies. It never left its hiding spot and as it grew older, the skulls merged into its body. Now, it is fully-grown and thirsts for revenge.")
GenerateMount("Gloom Widow", 1027, 690, 1510650000, "It is said that the Gloom Widow was born long before Banor walked the earth. While its parents died in the war against the cruel hordes sent by Brog and Zathroth, their child survived by hiding in skulls of burned enemies. It never left its hiding spot and as it grew older, the skulls merged into its body. Now, it is fully-grown and thirsts for revenge.")
GenerateMount("Blazing Unicorn", 1017, 870, 1503648000, "The Blazing Unicorn lives in a deep rivalry with its cousin the Arctic Unicorn. Even though they were born in completely different areas, they somehow share the same bloodline. The eternal battle between fire and ice continues. Who will win? Crystal blue vs. tangerine! The choice is yours!")
GenerateMount("Arctic Unicorn", 1018, 870, 1503648000, "The Arctic Unicorn lives in a deep rivalry with its cousin the Blazing Unicorn. Even though they were born in completely different areas, they somehow share the same bloodline. The eternal battle between fire and ice continues. Who will win? Tangerine vs.crystal blue! The choice is yours!")
GenerateMount("Prismatic Unicorn", 1019, 870, 1503648000, "Legend has it that a mare and a stallion once reached the end of a rainbow and decided to stay there. Influenced by the mystical power of the rainbow, the mare gave birth to an exceptional foal: Not only the big, strong horn on its forehead but the unusual colouring of its hair makes the Prismatic Unicorn a unique mount in every respect.")
GenerateMount("Armoured War Horse", 426, 870, 1506672000, "The Armoured War Horse is a dangerous black beauty! When you see its threatening, blood-red eyes coming towards you, you'll know trouble is on its way. Protected by its heavy armour plates, the warhorse is the perfect partner for dangerous hunting sessions and excessive enemy slaughtering.")
GenerateMount("Shadow Draptor", 427, 870, 1506672000, "A wild, ancient creature, which had been hiding in the depths of the shadows for a very long time, has been spotted again! The almighty Shadow Draptor has returned and only the bravest adventurers can control such a beast!")
GenerateMount("Steelbeak", 522, 870, 1501228800, "Forged by only the highest skilled blacksmiths in the depths of Kazordoon's furnaces, a wild animal made out of the finest steel arose from glowing embers and blazing heat. Protected by its impenetrable armour, the Steelbeak is ready to accompany its master on every battleground.")
GenerateMount("Crimson Ray", 521, 870, 1501228800, "Have you ever dreamed of gliding through the air on the back of a winged creature? With its deep red wings, the majestic Crimson Ray is a worthy mount for courageous heroes. Feel like a king on its back as you ride into your next adventure.")
GenerateMount("Jungle Saurian", 959, 750, 1494576000, "Thousands of years ago, its ancestors ruled the world. The Jungle Saurian likes to hide in dense wood and overturned trees.")
GenerateMount("Ember Saurian", 960, 750, 1494576000, "Thousands of years ago, its ancestors ruled the world. The Ember Saurian has been spotted in a sea of flames and fire deep down in the depths of Kazordoon.")
GenerateMount("Lagoon Saurian", 961, 750, 1494576000, "Thousands of years ago, its ancestors ruled the world. The Lagoon Saurian feels most comfortable in torrential rivers and behind dangerous waterfalls.")
GenerateMount("Gold Sphinx", 950, 750, 1490346000, "Ride a Gold Sphinx on your way through ancient chambers and tombs and have a loyal friend by your side while fighting countless mummies and other creatures.")
GenerateMount("Emerald Sphinx", 951, 750, 1490346000, "Ride an Emerald Sphinx on your way through ancient chambers and tombs and have a loyal friend by your side while fighting countless mummies and other creatures.")
GenerateMount("Shadow Sphinx", 952, 750, 1490346000, "Ride a Shadow Sphinx on your way through ancient chambers and tombs and have a loyal friend by your side while fighting countless mummies and other creatures.")
GenerateMount("Jackalope", 905, 870, 1483686000, "Do you like fluffy bunnies but think they are too small? Do you admire the majesty of stags and their antlers but are afraid of their untameable wilderness? Do not worry, the mystic creature Jackalope consolidates the best qualities of both animals. Hop on its backs and enjoy the ride.")
GenerateMount("Dreadhare", 907, 870, 1483686000, "Do you like fluffy bunnies but think they are too small? Do you admire the majesty of stags and their antlers but are afraid of their untameable wilderness? Do not worry, the mystic creature Dreadhare consolidates the best qualities of both animals. Hop on its backs and enjoy the ride.")
GenerateMount("Wolpertinger", 906, 870, 1483686000, "Do you like fluffy bunnies but think they are too small? Do you admire the majesty of stags and their antlers but are afraid of their untameable wilderness? Do not worry, the mystic creature Wolpertinger consolidates the best qualities of both animals. Hop on its backs and enjoy the ride.")
GenerateMount("Ivory Fang", 901, 750, 1477036800, "Incredible strength and smartness, an irrepressible will to survive, passionately hunting in groups. If these attributes apply to your character, we have found the perfect partner for you. Have a proper look at Ivory Fang, which stands loyally by its master's side in every situation. It is time to become the leader of the wolf pack!")
GenerateMount("Shadow Claw", 902, 750, 1477036800, "Incredible strength and smartness, an irrepressible will to survive, passionately hunting in groups. If these attributes apply to your character, we have found the perfect partner for you. Have a proper look at Shadow Claw, which stands loyally by its master's side in every situation. It is time to become the leader of the wolf pack!")
GenerateMount("Snow Pelt", 903, 750, 1477036800, "Incredible strength and smartness, an irrepressible will to survive, passionately hunting in groups. If these attributes apply to your character, we have found the perfect partner for you. Have a proper look at Snow Pelt, which stands loyally by its master's side in every situation. It is time to become the leader of the wolf pack!")
GenerateMount("Swamp Snapper", 886, 690, 3190, "You are intrigued by tortoises and would love to throne on a tortoise shell when travelling the wilderness? The Swamp Snapper might become your new trustworthy companion then, which will transport you safely and even carry you during combat.")
GenerateMount("Mould Shell", 887, 690, 3204, "You are intrigued by tortoises and would love to throne on a tortoise shell when travelling the wilderness? The Mould Shell might become your new trustworthy companion then, which will transport you safely and even carry you during combat.")
GenerateMount("Reed Lurker", 888, 690, 3218, "You are intrigued by tortoises and would love to throne on a tortoise shell when travelling the wilderness? The Reed Lurker might become your new trustworthy companion then, which will transport you safely and even carry you during combat.")
GenerateMount("Bloodcurl", 869, 750, 1690, "You are fascinated by insectoid creatures and can picture yourself riding one during combat or just for travelling? The Bloodcurl will carry you through the wilderness with ease.")
GenerateMount("Leafscuttler", 870, 750, 1703, "You are fascinated by insectoid creatures and can picture yourself riding one during combat or just for travelling? The Leafscuttler will carry you through the wilderness with ease.")
GenerateMount("Mouldpincer", 868, 750, 1716, "You are fascinated by insectoid creatures and can picture yourself riding one during combat or just for travelling? The Mouldpincer will carry you through the wilderness with ease.")
GenerateMount("Nightdweller", 849, 870, 1558, "If you are more of an imp than an angel, you may prefer riding out on a Nightdweller to scare fellows on their festive strolls. Its devilish mask, claw-like hands and sharp hooves makes it the perfect companion for any daring adventurer who likes to stand out.")
GenerateMount("Frostflare", 850, 870, 1570, "If you are more of an imp than an angel, you may prefer riding out on a Frostflare to scare fellows on their festive strolls. Its devilish mask, claw-like hands and sharp hooves makes it the perfect companion for any daring adventurer who likes to stand out.")
GenerateMount("Cinderhoof", 851, 870, 1583, "If you are more of an imp than an angel, you may prefer riding out on a Cinderhoof to scare fellows on their festive strolls. Its devilish mask, claw-like hands and sharp hooves makes it the perfect companion for any daring adventurer who likes to stand out.")
GenerateMount("Slagsnare", 761, 780, 1430, "The Slagsnare has external characteristics of different breeds. It is assumed that his brain is also composed of many different species, which makes it completely unpredictable. Only few have managed to approach this creature unharmed and only the best could tame it.")
GenerateMount("Nightstinger", 762, 780, 1442, "The Nightstinger has external characteristics of different breeds. It is assumed that his brain is also composed of many different species, which makes it completely unpredictable. Only few have managed to approach this creature unharmed and only the best could tame it.")
GenerateMount("Razorcreep", 763, 780, 1454, "The Razorcreep has external characteristics of different breeds. It is assumed that his brain is also composed of many different species, which makes it completely unpredictable. Only few have managed to approach this creature unharmed and only the best could tame it.")
GenerateMount("Gorongra", 738, 720, 967, "Get yourself a mighty travelling companion with broad shoulders and a gentle heart. Gorongra is a physically imposing creature that is much more peaceful than its relatives, Tiquanda's wild kongras, and will carry you safely wherever you ask it to go.")
GenerateMount("Noctungra", 739, 720, 979, "Get yourself a mighty travelling companion with broad shoulders and a gentle heart. Noctungra is a physically imposing creature that is much more peaceful than its relatives, Tiquanda's wild kongras, and will carry you safely wherever you ask it to go.")
GenerateMount("Silverneck", 740, 720, 990, "Get yourself a mighty travelling companion with broad shoulders and a gentle heart. Silverneck is a physically imposing creature that is much more peaceful than its relatives, Tiquanda's wild kongras, and will carry you safely wherever you ask it to go.")
GenerateMount("Sea Devil", 734, 570, 348, "If the Sea Devil moves its fins, it generates enough air pressure that it can even float over land. Its numerous eyes allow it to quickly detect dangers even in confusing situations and eliminate them with one powerful bite. If you watch your fingers, you are going to be good friends.")
GenerateMount("Coralripper", 735, 570, 353, "If the Coralripper moves its fins, it generates enough air pressure that it can even float over land. Its numerous eyes allow it to quickly detect dangers even in confusing situations and eliminate them with one powerful bite. If you watch your fingers, you are going to be good friends.")
GenerateMount("Plumfish", 736, 570, 358, "If the Plumfish moves its fins, it generates enough air pressure that it can even float over land. Its numerous eyes allow it to quickly detect dangers even in confusing situations and eliminate them with one powerful bite. If you watch your fingers, you are going to be good friends.")
GenerateMount("Flitterkatzen", 726, 870, 326, "Rumour has it that many years ago elder witches had gathered to hold a magical feast high up in the mountains. They had crossbred Flitterkatzen to easily conquer rocky canyons and deep valleys. Nobody knows what happened on their way up but only the mount has been seen ever since.")
GenerateMount("Venompaw", 727, 870, 331, "Rumour has it that many years ago elder witches had gathered to hold a magical feast high up in the mountains. They had crossbred Venompaw to easily conquer rocky canyons and deep valleys. Nobody knows what happened on their way up but only the mount has been seen ever since.")
GenerateMount("Batcat", 728, 870, 336, "Rumour has it that many years ago elder witches had gathered to hold a magical feast high up in the mountains. They had crossbred Batcat to easily conquer rocky canyons and deep valleys. Nobody knows what happened on their way up but only the mount has been seen ever since.")
GenerateMount("Ringtail Waccoon", 691, 750, 303, "Waccoons are cuddly creatures that love nothing more than to be petted and snuggled! Share a hug, ruffle the fur of the Ringtail Waccoon and scratch it behind its ears to make it happy.")
GenerateMount("Night Waccoon", 692, 750, 308, "Waccoons are cuddly creatures that love nothing more than to be petted and snuggled! Share a hug, ruffle the fur of the Night Waccoon and scratch it behind its ears to make it happy.")
GenerateMount("Emerald Waccoon", 693, 750, 313, "Waccoons are cuddly creatures that love nothing more than to be petted and snuggled! Share a hug, ruffle the fur of the Emerald Waccoon and scratch it behind its ears to make it happy.")
GenerateMount("Flying Divan", 688, 900, 281, "The Flying Divan is the perfect mount for those who are too busy to take care of an animal mount or simply like to travel on a beautiful, magic hand-woven carpet.")
GenerateMount("Magic Carpet", 689, 900, 289, "The Magic Carpet is the perfect mount for those who are too busy to take care of an animal mount or simply like to travel on a beautiful, magic hand-woven carpet.")
GenerateMount("Floating Kashmir", 690, 900, 296, "The Floating Kashmir is the perfect mount for those who are too busy to take care of an animal mount or simply like to travel on a beautiful, magic hand-woven carpet.")
GenerateMount("Shadow Hart", 685, 660, 259, "Treat your character to a new travelling companion with a gentle nature and an impressive antler: The noble Shadow Hart will carry you through the deepest snow.")
GenerateMount("Black Stag", 686, 660, 266, "Treat your character to a new travelling companion with a gentle nature and an impressive antler: The noble Black Stag will carry you through the deepest snow.")
GenerateMount("Emperor Deer", 687, 660, 274, "Treat your character to a new travelling companion with a gentle nature and an impressive antler: The noble Emperor Deer will carry you through the deepest snow.")
GenerateMount("Tundra Rambler", 672, 750, 237, "With its thick, shaggy hair, the Tundra Rambler will keep you warm even in the chilly climate of the Ice Islands. Due to its calm and peaceful nature, it is not letting itself getting worked up easily.")
GenerateMount("Highland Yak", 673, 750, 244, "With its thick, shaggy hair, the Highland Yak will keep you warm even in the chilly climate of the Ice Islands. Due to its calm and peaceful nature, it is not letting itself getting worked up easily.")
GenerateMount("Glacier Vagabond", 674, 750, 252, "With its thick, shaggy hair, the Glacier Vagabond will keep you warm even in the chilly climate of the Ice Islands. Due to its calm and peaceful nature, it is not letting itself getting worked up easily.")
GenerateMount("Golden Dragonfly", 669, 600, 215, "If you are more interested in the achievements of science, you may enjoy a ride on the Golden Dragonfly, one of the new insect-like flying machines. Even if you do not move around, the wings of these unusual vehicles are always in motion.")
GenerateMount("Steel Bee", 670, 600, 222, "If you are more interested in the achievements of science, you may enjoy a ride on the Steel Bee, one of the new insect-like flying machines. Even if you do not move around, the wings of these unusual vehicles are always in motion.")
GenerateMount("Copper Fly", 671, 600, 229, "If you are more interested in the achievements of science, you may enjoy a ride on the Copper Fly, one of the new insect-like flying machines. Even if you do not move around, the wings of these unusual vehicles are always in motion.")
GenerateMount("Doombringer", 644, 780, 192, "Once captured and held captive by a mad hunter, the Doombringer is the result of sick experiments. Fed only with demon dust and concentrated demonic blood it had to endure a dreadful transformation. The demonic blood that is now running through its veins, however, provides it with incredible strength and endurance.")
GenerateMount("Woodland Prince", 647, 780, 200, "Once captured and held captive by a mad hunter, the Woodland Prince is the result of sick experiments. Fed only with demon dust and concentrated demonic blood it had to endure a dreadful transformation. The demonic blood that is now running through its veins, however, provides it with incredible strength and endurance.")
GenerateMount("Hailstorm Fury", 648, 780, 207, "Once captured and held captive by a mad hunter, the Hailstorm Fury is the result of sick experiments. Fed only with demon dust and concentrated demonic blood it had to endure a dreadful transformation. The demonic blood that is now running through its veins, however, provides it with incredible strength and endurance.")
GenerateMount("Siegebreaker", 649, 690, 154, "The Siegebreaker is out searching for the best bamboo. Its heavy armour allows it to visit even the most dangerous places. Treat it nicely with its favourite food from time to time and it will become a loyal partner.")
GenerateMount("Poisonbane", 650, 690, 161, "The Poisonbane is out searching for the best bamboo. Its heavy armour allows it to visit even the most dangerous places. Treat it nicely with its favourite food from time to time and it will become a loyal partner.")
GenerateMount("Blackpelt", 651, 690, 169, "The Blackpelt is out searching for the best bamboo. Its heavy armour allows it to visit even the most dangerous places. Treat it nicely with its favourite food from time to time and it will become a loyal partner.")
GenerateMount("Nethersteed", 629, 900, 132, "Once a majestic and proud warhorse, the Nethersteed has fallen in a horrible battle many years ago. Driven by agony and pain, its spirit once again took possession of its rotten corpse to avenge its death. Stronger than ever, it seeks a master to join the battlefield, aiming for nothing but death and destruction.")
GenerateMount("Tempest", 630, 900, 139, "Once a majestic and proud warhorse, the Tempest has fallen in a horrible battle many years ago. Driven by agony and pain, its spirit once again took possession of its rotten corpse to avenge its death. Stronger than ever, it seeks a master to join the battlefield, aiming for nothing but death and destruction.")
GenerateMount("Flamesteed", 626, 900, 147, "Once a majestic and proud warhorse, the Flamesteed has fallen in a horrible battle many years ago. Driven by agony and pain, its spirit once again took possession of its rotten corpse to avenge its death. Stronger than ever, it seeks a master to join the battlefield, aiming for nothing but death and destruction.")
GenerateMount("Tombstinger", 546, 600, 110, "The Tombstinger is a scorpion that has surpassed the natural boundaries of its own kind. Way bigger, stronger and faster than ordinary scorpions, it makes a perfect companion for fearless heroes and explorers. Just be careful of his poisonous sting when you mount it.")
GenerateMount("Death Crawler", 624, 600, 117, "The Death Crawler is a scorpion that has surpassed the natural boundaries of its own kind. Way bigger, stronger and faster than ordinary scorpions, it makes a perfect companion for fearless heroes and explorers. Just be careful of his poisonous sting when you mount it.")
GenerateMount("Jade Pincer", 628, 600, 124, "The Jade Pincer is a scorpion that has surpassed the natural boundaries of its own kind. Way bigger, stronger and faster than ordinary scorpions, it makes a perfect companion for fearless heroes and explorers. Just be careful of his poisonous sting when you mount it.")
GenerateMount("Desert King", 572, 450, 57, "Its roaring is piercing marrow and bone and can be heard over ten miles away. The Desert King is the undisputed ruler of its territory and no one messes with this animal. Show no fear and prove yourself worthy of its trust and you will get yourself a valuable companion for your adventures.")
GenerateMount("Jade Lion", 627, 450, 95, "Its roaring is piercing marrow and bone and can be heard over ten miles away. The Jade Lion is the undisputed ruler of its territory and no one messes with this animal. Show no fear and prove yourself worthy of its trust and you will get yourself a valuable companion for your adventures.")
GenerateMount("Winter King", 631, 450, 102, "Its roaring is piercing marrow and bone and can be heard over ten miles away. The Winter King is the undisputed ruler of its territory and no one messes with this animal. Show no fear and prove yourself worthy of its trust and you will get yourself a valuable companion for your adventures.")

-- to do: set product id to outfits/mounts, show them in outfit/podium/tryon windows
-- to do: add buyfrom field, send with golden/pumpkin outfits

GenerateOutfit("Full Fencer Outfit", 1575, 1576, 750, 1658476800, "They are skilled, they are disciplined, they wield their weapon with deadly precision as a form of art. Fencers are true masters of the blade who can cut through anything and anyone in the blink of an eye. While being feared for their lethal attacks, they are also admired for their elegant and fierce style, their dashing looks. Do not be on the fence, be a fencer, or at least dress like one with this fashionable, cutting-edge outfit.")
GenerateOutfit("Full Nordic Chieftain Outfit", 1500, 1501, 750, 1650614400, "Where others not dare to tread due to the biting cold and freezing winds, the Nordic Chieftain feels right at home. Braving the harsh conditions is possible due to a protective layer of warm clothing, as well as suitable armament to fend off any hostile wildlife. The helmet's massive horns are a tad heavy and unwieldy, but show the chieftain's status.")
GenerateOutfit("Full Ghost Blade Outfit", 1489, 1490, 600, 1643965200, "Being a Ghost Blade means having mastered the way of the warrior. No matter the circumstances, these fighters retain full control over their body and mind, with the sole focus of vanquishing their foe. So great is their ability that they not only control the weapons in their hands perfectly, but two floating blades following them as well.")
GenerateOutfit("Full Arbalester Outfit", 1449, 1450, 600, 1634889600, "Armed with a powerful crossbow, and gifted with steady hands as well as a sharp eye, the Arbalester is not one to be trifled with. Requiring both skill and strength to properly wield, the arbalest is a mighty tool in the hands of an able marksman, shooting deadly bolts across great distance.")
GenerateOutfit("Full Dragon Knight Outfit", 1444, 1445, 870, 1627027200, "A Dragon Knight is ready for everything, channeling the primordial might of the winged, ancient beasts into weapons and armour. Their imposing demeanour and impressive appearance are often enough to quell any animosity towards them, and those who still dare oppose them are not long for this world.")
GenerateOutfit("Full Forest Warden Outfit", 1415, 1416, 750, 1622188800, "The Forest Warden watches over all living things in the woods, be they plants or beasts. They have a special connection to the earth they tread on, the air they breathe, and the wind which whispers around them. Naturally, the suit that they don is not made out of dead vegetation, but is a living being itself.")
GenerateOutfit("Full Rune Master Outfit", 1384, 1385, 870, 1614330000, "A Rune Master has dedicated their whole life to the study and mastery of runes. They are intrigued by the ancient symbols, shrouded in mystery, and how their magic works. Rune Masters have a deep understanding of the awesome power they are wielding and can make use of the full potential of runes.")
GenerateOutfit("Full Merry Garb Outfit", 1382, 1383, 600, 1609837200, "Are you ready for the festive season? Or feeling festive regardless of the time of year? Then the Merry Garb is perfect for you. Donning the outfit not only puts you in a mirthful mood, but spreads blitheness on your travels throughout the lands.")
GenerateOutfit("Full Moth Cape Outfit", 1338, 1339, 600, 1601020800, "If you are fascinated by this particular group of insects and want to show your deep appreciation of these critters, the Moth Cape is for you. The wing-shaped coat and the antennae provide you with the feeling of being a moth without experiencing the downside of inevitably being drawn to light.")
GenerateOutfit("Full Jouster Outfit", 1331, 1332, 750, 1593158400, "The Jouster is all geared up for a tournament, ready to partake in festive activities involving friendly competition to prove their chivalry. However, being well-armoured, they are also a force to be reckoned with on the battlefield, especially with a trusty steed at their service.")
GenerateOutfit("Full Trailblazer Outfit", 1292, 1293, 600, 1585299600, "The Trailblazer is on a mission of enlightenment and carries the flame of wisdom near and far. The everlasting shine brightens the hearts and minds of all creatures its rays touch, bringing light even to the darkest corners of the world as a beacon of insight and knowledge.")
GenerateOutfit("Full Herder Outfit", 1279, 1280, 750, 1576227600, "The Herder is one with nature, being outside all day, watching carefully over his flock. If you like to spend time on picturesque meadows and are always looking for greener pastures, then this outfit is for you.")
GenerateOutfit("Full Breezy Garb Outfit", 1245, 1246, 600, 1564128000, "Even the most eager adventurers and toughest warriors need some time to rest and recharge. Enjoy tranquility and peace as you picnic in good company at one of your favourite places. Put on your Breezy Garb outfit, grab your walking stick, a basket filled with tasty snacks and then head out into nature!")
GenerateOutfit("Full Guidon Bearer Outfit", 1186, 1187, 870, 1556262000, "Carrying the guidon of a unit, always marching in front, is not only an honour but also comes with great responsibility. Guidon bearers wield great power, they lead where others follow and keep the spirits of the troops up as they wave their flag against the golden suns.")
GenerateOutfit("Full Owl Keeper Outfit", 1173, 1174, 600, 1550566800, "Owl Keepers are often referred to as spirits walking through the forest at night, mere shadows during the day. They are also said to be shamans, protecting the flora and fauna. You often see them wearing a stag's antlers on their head and in the company of an owl, for they are as wise and mysterious as these intriguing creatures.")
GenerateOutfit("Full Pumpkin Mummy Outfit", 1127, 1128, 870, 1541149200, "If you cannot decide whether to wrap yourself up as a mummy or flaunt an enormous pumpkin head for your next hunting party, why not combine both? The Pumpkin Mummy outfit is the perfect costume for scary nights and spooky days.")
GenerateOutfit("Full Sinister Archer Outfit", 1102, 1103, 600, 1532678400, "From an early age, the Sinister Archer has been fascinated by people's dark machinations and perversions. Sinister Archers claim that they advocate the good and that they only use their arrows to pierce the hearts of those who have committed many crimes and misdeeds. However, they are still viewed by the public with much suspicion due to their dubious appearance. To keep their identity secret, they often hide themselves behind a skull-like face guard that can easily withstand even axe and club blows.")
GenerateOutfit("Full Mercenary Outfit", 1056, 1057, 870, 1524812400, "The Mercenary carries a powerful, razor-sharp axe on his shoulders that effortlessly cuts through any armour and bone. You should better tell your friends to keep a safe distance, since heads will roll over the blood-soaked battleground after a powerful swing of yours.\nConsidering the sheer size of this axe, it might even be possible to chop onions without shedding a tear.")
GenerateOutfit("Full Siege Master Outfit", 1050, 1051, 600, 1519981200, "Neither thick stone walls nor heavily armoured gates can stop the Siege Master, who brings down hostile fortifications in the blink of an eye. Whenever he tenses his muscular arms to lift the powerful battering ram, his enemies' knees begin to buckle. It is the perfect outfit for those who also stand for brute strength and immense destruction.")
GenerateOutfit("Full Sun Priest Outfit", 1023, 1024, 750, 1515229200, "Do you worship warm temperatures and are opposed to the thought of long and dark winter nights? Do you refuse to spend countless evenings in front of your chimney while ice-cold wind whistles through the cracks and niches of your house? It is time to stop freezing and to become an honourable Sun Priest! With this stylish outfit, you can finally show the world your unconditional dedication and commitment to the sun!")
GenerateOutfit("Full Herbalist Outfit", 1021, 1020, 750, 1509091200, "The Herbalist outfit is the perfect outfit for all herbs collectors. Those of you who are aware that you do not necessarily have to reach into the mouth of a hydra to get a hydra tongue and those who know exactly where to get blood- and shadow-herbs will find a matching outfit for their daily hobby. Show the world your affinity for herbs and impress your friends with your knowledge of medicine and potions.")
GenerateOutfit("Full Entrepreneur Outfit", 472, 471, 750, 1501228800, "Slaughter through hordes of monsters during your early morning hunt and kiss the hand of Queen Eloise later on at the evening reception in her historical residence. With the Entrepreneur outfit you will cut a fine figure on every occasion.")
GenerateOutfit("Full Trophy Hunter Outfit", 957, 958, 870, 1498204800, "You spend hours in the woods in search of wild and rare animals? Countless stuffed skulls of deer, wolves and other creatures are decorating your walls? Now you have the chance to present your trophies in public. Become a Trophy Hunter and cover your shoulders with the finest bear skulls!")
GenerateOutfit("Retro Noble(wo)man Outfit", 966, 967, 870, 1496995200, "The king has invited you to a summer ball and you have nothing to wear for this special event? Do not worry, the Retro Noble(wo)man outfit makes you a real eye catcher on every festive occasion.")
GenerateOutfit("Retro Summoner Outfit", 964, 965, 870, 1496995200, "While the Retro Mage usually throws runes and mighty spells directly at the enemies, the Retro Summoner outfit might be the better choice for adventurers that prefer to send mighty summons to the battlefield to keep their enemies at distance.")
GenerateOutfit("Retro Warrior Outfit", 962, 963, 870, 1496995200, "You are fearless and strong as a behemoth but have problems finding the right outfit for your adventures? The Retro Warrior outfit is a must-have for all fashion-conscious old-school adventurers out there.")
GenerateOutfit("Retro Knight Outfit", 970, 971, 870, 1495785600, "Who needs a fancy looking sword with bling-bling and ornaments? Back in the days, we survived without such unnecessary accessories! Time to show those younkers what a Retro Knight is made of.")
GenerateOutfit("Retro Hunter Outfit", 972, 973, 870, 1495785600, "Whenever you pick up your bow and spears, you walk down memory lane and think of your early days? Treat yourself with the fashionable Retro Hunter outfit and hunt some good old monsters from your childhood.")
GenerateOutfit("Retro Mage Outfit", 968, 969, 870, 1495785600, "Dress up as a Retro Mage and you will always cut a fine figure on the battleground while eliminating your enemies with your magical powers the old-fashioned way.")
GenerateOutfit("Retro Citizen Outfit", 974, 975, 870, 1495785600, "Do you still remember your first stroll through the streets of Thais? For old times' sake, walk the paths of Nostalgia as a Retro Citizen!")
GenerateOutfit("Full Pharaoh Outfit", 955, 956, 750, 1488531600, "You know how to read hieroglyphs? You admire the exceptional architectural abilities and the unsolved mysteries of an ancient high culture? Next time you pay a visit to your friends, tell them to prepare a bathtub full of milk and honey for you because a Pharaoh is now walking through the streets of Ankrahmun!")
GenerateOutfit("Full Grove Keeper Outfit", 908, 909, 870, 1480662000, "Feeling the springy grass under your feet and inhaling the spicy air of the forest is pure satisfaction for your soul? Every animal is your friend and you caringly look after trees and plants all the time? Then it is time to become one with nature: Become a Grove Keeper!")
GenerateOutfit("Full Lupine Warden Outfit", 899, 900, 840, 1475222400, "Do you feel the adrenaline rushing through your veins when the sun goes down and a full moon lightens the night? Do you have the urge to hunt down your target no matter what? Unleash the beast inside of you and lead your friends to battle with the Lupine Warden outfit!")
GenerateOutfit("Full Arena Champion Outfit", 884, 885, 870, 1475222399, "Fight your bloody battles in the arena and become a darling of the crowd. Once you have made it to the top and everyone is cheering your name, the fashionable outfit of an Arena Champion will show the world what you are made of.")
GenerateOutfit("Full Philosopher Outfit", 873, 874, 750, 1475222398, "Do you feel the urge to tell people what is really going on in the world? Do you know all answers to the important questions of life? Are you a true philosopher? Then dress like one to showcase the latest fashion for all wise theorists.")
GenerateOutfit("Full Winter Warden Outfit", 853, 852, 870, 1475222397, "The warm and cosy cloak of the Winter Warden outfit will keep you warm in every situation. Best thing, it is not only comfortable but fashionable as well. You will be the envy of any snow queen or king, guaranteed!")
GenerateOutfit("Full Royal Pumpkin Outfit", 760, 759, 840, 1475222396, "The mutated pumpkin is too weak for your mighty weapons? Time to show that evil vegetable how to scare the living daylight out of people! Put on a scary looking pumpkin on your head and spread terror and fear amongst the population.")
GenerateOutfit("Full Sea Dog Outfit", 750, 749,  600, 1475222395, "Ahoy mateys! Flaunt the swashbuckling Sea Dog outfit and strike a pose with your hook to impress both landlubbers and fellow pirates. Board your next ship in style!")
GenerateOutfit("Full Champion Outfit", 633, 632, 570, 1475222385, "Protect your body with heavy armour plates and spiky bones to teach your enemies the meaning of fear! The Champion outfit perfectly suits battle-hardened warriors who rely on their trusty sword and shield.")
GenerateOutfit("Full Conjurer Outfit", 634, 635, 720, 1475222386, "You recently graduated from the Magic Academy and want to bring your knowledge to good use? Congratulations, you are now an honourable disciple of magic! Open up a bottle of well-aged mana and treat yourself with the fashionable Conjurer outfit.")
GenerateOutfit("Full Beastmaster Outfit", 637, 636, 870, 1475222384, "Do you have enough authority to make wild animals subservient to you? Become a Beastmaster and surround yourself with fearsome companions. When your beasts bare their teeth, your enemies will turn tails and run.")
GenerateOutfit("Full Chaos Acolyte Outfit", 665, 664, 900, 1475222387, "You have always felt like the cat among the pigeons and have a fable for dark magic? The Chaos Acolyte outfit is a perfect way to express your inner nature. Show your commitment for the higher cause and wreak havoc on your enemies in this unique outfit.")
GenerateOutfit("Full Death Herald Outfit", 667, 666, 600, 1475222388, "Death and decay are your ever-present companions? Your enemies are dropping like flies and your path is covered with their bodies? However, as decency demands, you want to at least give them a proper funeral? Then the Death Herald is just the right outfit for you.")
GenerateOutfit("Full Ranger Outfit", 684, 683, 750, 1475222389, "Most of the day, the Ranger is looking over his forest. He is taking care of all animals and plants and tries to keep everything in balance. Intruders are greeted by a warning shot from his deadly longbow. It is the perfect outfit for Paladins who live in close touch with nature.")
GenerateOutfit("Full Ceremonial Garb Outfit", 695, 694, 750, 1475222390, "If you want to make a great entrance at a costume party, the Ceremonial Garb is certainly a good choice. With a drum over your shoulder and adorned with feathers you are perfectly dressed to lead a carnival parade through the streets of Thais.")
GenerateOutfit("Full Puppeteer Outfit", 697, 696, 870, 1475222391, "Are you a fan of puppetry? You like to travel the world together with one or two little acting fellows? Or are you simply the one who likes to pull the strings? Then the Puppeteer outfit is the right choice for you.")
GenerateOutfit("Full Spirit Caller Outfit", 699, 698, 600, 1475222392, "You are in love with the deep soul of Mother Earth and prefer to walk in the shadows of her wooden children? Choose the Spirit Caller outfit to live in harmony with nature.")
GenerateOutfit("Full Evoker Outfit", 725, 724, 840, 1475222393, "Dance around flickering fires in the Evoker outfit while singing unholy chants to praise witchcraft and wizardry. Your faithful bat will always be by your side.")
GenerateOutfit("Full Seaweaver Outfit", 733, 732, 570, 1475222394, "The Seaweaver outfit is the perfect choice if you want to show the world that you are indeed a son or a daughter of the submarine kingdom. You can almost feel the salty taste and the rough wind of the sea when wearing it.")

-- autogenerate helpers for store indexing
CategoryToIdMap = {}
for index, categoryData in pairs(StoreCategories) do
	-- index category
	CategoryToIdMap[categoryData.name] = index
	
	-- cache offer count
	local offerCount = 0
	if categoryData.offers then
		offerCount = offerCount + #categoryData.offers
	end
	
	local offerTypeCount = 0
	if categoryData.offerTypes and #categoryData.offerTypes > 0 then
		for tabId = 1, #categoryData.offerTypes do
			offerCount = offerCount + #categoryData.offerTypes[tabId].offers
			offerTypeCount = offerTypeCount + 1
		end
	end
	
	StoreCategories[index].offerCount = offerCount
	StoreCategories[index].offerTypeCount = offerTypeCount
end
