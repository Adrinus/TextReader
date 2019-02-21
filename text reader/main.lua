function love.load()
	love.window.setTitle( "TextReader" )
   med1 = love.graphics.newFont("fonts/Playball.ttf",24)
   med2 = love.graphics.newFont("fonts/Blackwood Castle.ttf",24)
   med3 = love.graphics.newFont("fonts/TitilliumWeb-Regular.ttf",25)
   med4 = love.graphics.newFont("fonts/carbon.ttf",16)
   med5 = love.graphics.newFont("fonts/computer_7.ttf",24)
   med6 = love.graphics.newFont("fonts/BadScript-Regular.ttf",26)
   med7 = love.graphics.newFont("fonts/SpecialElite.ttf",20)
   med8 = love.graphics.newFont("fonts/Silent Reaction.ttf",20)
   med9 = love.graphics.newFont("fonts/Olde English Regular.ttf",28)
   med10 = love.graphics.newFont("fonts/HomemadeApple.ttf",20)
   med11 = love.graphics.newFont("fonts/heav.ttf",22)
   med12 = love.graphics.newFont("fonts/last draft.ttf",30)
   med13 = love.graphics.newFont("fonts/AlexBrush-Regular.ttf",26)
   allFonts={med1,med2,med3,med4,med5,med6,med7,med8,med9,med10,med11,med12,med13}
   scroll = love.graphics.newImage("bg/scroll.png")
   computer = love.graphics.newImage("bg/computer.png")
   oldbook = love.graphics.newImage("bg/oldbook.png")
   glare = love.graphics.newImage("monitorglare.png")
   typewriter = love.graphics.newImage("bg/typewriter.png")
   love.window.setMode( 1000, 800, {resizable=true, vsync=false, minwidth=600, minheight=480} )
   background = scroll
   filename="Welcome.txt"
   story={}
   for line in love.filesystem.lines(filename) do
	table.insert(story, line)
	end
   page=1
   pages=1
   font=1
   love.graphics.setFont(allFonts[font])
   scale = 1
   originalWidth=1000
   originalHeight=800
end

function love.filedropped( file )
	fileDir= file:getFilename( )
	story = {}
	page = 1
	pages = 1
	for line in file:lines( ) do
		table.insert(story, line)
	end
end

function love.update(dt)
   
end

function love.resize(w, h)
  local scalex = w/originalWidth
  local scaley = h/originalHeight
  scale = scalex
  if scaley < scalex then
	scale = scaley
	end
end

function love.draw()
love.graphics.setFont(allFonts[font])
love.graphics.draw(background,0,0,0,scale,scale)
if background ~= computer then
	love.graphics.setColor(0,0,0)
else
	love.graphics.setColor(0,255,0)
end
pagelength=math.floor((500*scale)/30)
pages = math.ceil(#story/pagelength)
	if (pages-page) < 1 then
		for j=1, #story-((pages-1)*pagelength) do
		love.graphics.print(story[j+((page-1)*pagelength)], 110*scale, (130*scale)+(30*j),0,scale,scale )
		end
	else
		for j=1, pagelength do
			love.graphics.print(story[j+((page-1)*pagelength)], 110*scale, (130*scale)+(30*j),0,scale,scale )
		end
	end
if background == computer then
	love.graphics.setColor(255,255,255)
	love.graphics.draw(glare,0,0,0,scale,scale)
end
	
love.graphics.setColor(255,255,255)
love.graphics.print("Font: " ..font .." Page: " ..page .."/" ..pages,10,10)
end

function love.keypressed(key)
   if key == 'p' or key == 'right' then
	if page <= math.floor(pages)-1 then
	page=page+1
	end
   elseif key == 'o' or key == 'left' then
	if page >= 2 then
		page = page-1
	end
    elseif key == 'd' then
	if font <= #allFonts-1 then
		font = font+1
	end
   elseif key == 'a' then
   if font >= 2 then
	font = font -1
   end
   elseif key == 's' then
	if background == computer then
		background = scroll
	elseif background == scroll then
		background = typewriter
	elseif background == typewriter then
		background = oldbook
	elseif background == oldbook then
		background = computer
	end
	elseif key == 'w' then
	if background == computer then
		background = oldbook
	elseif background == scroll then
		background = computer
	elseif background == typewriter then
		background = scroll
	elseif background == oldbook then
		background = typewriter
	end
   end
end

function love.quit()
  print("Thanks for playing! Come back soon!")
end