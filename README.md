Made with love by Onorine - Jom Gabbar (previously Mutanus and Grobbulus)

<unlimited breadsticks>

# Summary

OnorineAutoCandy is an addon to assist in automating the process of farming
for boxes of chocolates in WoW Classic.

This addon has two modes, a Perfume Giver mode, which is activated if your
character has >= 50 copper, and a chocolate miner mode, which is activated if you
have less than 50 copper.

# PRs

I'm sure there's things that could be done to improve this process. Let me
know via an issue or a PR if you have a bugfix or an improvement.

# Installing

You can use the following link to download the ZIP from GitHub

https://github.com/gamozolabs/OnorineAutoCandy/archive/refs/heads/main.zip

Simply download the zip, extract it, and rename `OnorineAutoCandy-main` to
`OnorineAutoCandy` and place it into `Interface/Addons`

If you use something like WoWUp, you should be able to directly import from
GitHub.

# Safety

Obviously, as with any addon, you shouldn't trust it. Luckily, the entire code
for this project is ~150 lines of code, feel free to read it yourself. It's
pretty straightforward.

I've really only tested this in Ironforge. Ultimately, if you have >=50c on
your character this addon will do absolutely nothing other than automatially
put a single perfume or cologne in the trade window. Just remove or disable
this addon when you no longer want this functionality.

# Perfume Giver (>= 50 copper on character)

In perfume giver mode, anyone who trades with you will automatically cause
you to post a single perfume or cologne into the trade window. Trading itself
cannot be automated legally, thus you still have to accept the trade.

This is the only feature of the perfume giver mode.

# Chocolate Miner (< 50 copper on character)

In chocolate miner mode it is expected that you trade a character who is
a perfume giver to receive a single perfume or cologne. You then need to use
one charge of this perfume or cologne to apply the Cologne or Perfume buff.

Your character needs nothing except for a single perfume or cologne. Zero
copper is needed on your chocolate character.

Once this buff is applied, simply right click an innkeeper, the addon will
find the correct gossip option that says "Let me browse your goods.", it will
then sell the perfume or cologne (thus giving you copper), and automatically
buy a love token and close the merchant window.

Then, you can click on an NPC and it will automatically turn in the love token.
If your love token is accepted successfully and you recieve a gift of adoration
the addon will automatically open it, and loot every item except for
a box of chocolates. This will leave a gift that only contains a box of
chocolates in it.

If you are lucky and successfully get a box of chocolates, trade with another
character again and the addon will automatically place the gift into the
trade window.

# TL;DR:

- Make a level 1 character
- Trade your main/bank and receive a single perfume or cologne
- Use the perfume/cologne
- Right click an innkeeper to automatically sell the cologne and receive a love
  token
- Right click an NPC to turn in the token and receieve a gift, which will
  automatically be mined for chocolates
- Trade with your main/bank to have the addon automatically place the gift
  into the trade window.

Repeat forever. Use mage portals or warlock summons to speed up the process
of making alts and getting them to a major city innkeeper.

