;
; ------------------------------------------------------------
;
;   Cosine - Beast Tribute - Old School Demo 2
;   Released in 2018
;
;   Code by aNdy/AL/Cosine
;   GFX by aNdy/AL/Cosine & Steven Hammond
;   Music by aNdy/AL/Cosine (original samples by David Whittaker)
;
;   Special thanks to KrazyK (DBF Forum) & Hyb1rd-1982 (DeviantArt)
;
;   www.cosine.org.uk
;
;   The source is provided as a learning tool for others and,
;   yes, some bits could be reduced in size using loops, etc.,
;   but since this is for beginners to follow also, it
;   has been coded and commented to be as readable and 
;   friendly as possible.
;
;   All of the graphics are provided in their original bitmap
;   format so you can see how they all slot together.
;
;   The music is in OGG format when loaded in the demo, but the
;   original MOD that was written especially for this demo is
;   also included in the data folder so you can see how that
;   was done too. it was written in OpenMPT, but should load
;   into any tracker that supports MOD format.
;
; ------------------------------------------------------------
;


; >>>>>>>>>> NOTE TO LINUX USERS <<<<<<<<<<

; Before compile, uncomment the 'Import C' line below and uncheck
; 'Use Compiler' in 'Compiler > Compiler Options' menu.
;
; Thanks to PureBasic Forum member 'StarBootics' for compatability
; report and suggestions.



; ImportC "-no-pie" : EndImport




;- INITIALISE ENVIRONMENT / INCLUDE DECODERS -----------------

InitKeyboard()            ; we will be testing the keyboard for an 'escape' keypress
InitSprite()              ; we will be using sprites, plus needs to be called for screen use anyway
InitSound()               ; we will be loading and using some sound
UseOGGSoundDecoder()      ; we will need to use the ogg decoder to play the ogg tune file


;- SET UP SOME VARIABLES -------------------------------------

; these variables are used in various places throughout, so are set here as 'global'
; you will see them used in various procedures so should see what they do further on!

Global demopart = 1 : subpart = 1 : opaque = 0 : vol = 100 : bgfade = 0 : bgtrans = 255 : cloudopac = 255
Global blimpx = -300 : tree1x = -400 : tree2x = -700 : tree2x = -550 : starsx = 799

Global cloud1x = 799 : cloud2x = 799 : cloud3x = 799 : cloud4x = 799: cloud5x = 799
Global grass1x = 799 : grass2x = 799 : grass3x = 799 : grass4x = 799 : grass5x = 799 : grass6x = 799
Global fence = 799 : mountainsx = 799 : owlx = 2000 : aarbronx = 900 : credscrolly = 75 :credscrolldir = 1
Global sco1=0 : tptr1=1 : sco2=0 : tptr2=1


Global Dim a_AARBRONRUN(5)                      ; array holding aarbron's animation frames
Global Dim a_GFXFONT(60)                        ; array holding the scrolling message font alphabet

Global owlanimtime=ElapsedMilliseconds()        ; this variable controls owl animation time between frames
Global aarbronanimtime=ElapsedMilliseconds()    ; this variable controls aarbron animation time between frames
Global monitoranimtime=ElapsedMilliseconds()    ; this variable controls monitor animation time between frames
Global bganimtime=ElapsedMilliseconds()    ; this variable controls monitor animation time between frames

; the following string variables contains the text to use in the scrolling messages
; it starts as t$ and then each line adds more to the t$
;
; t1$ is the main bottom scoller message, t2$ is the smaller, top greetz scoller
;
; in the messages below, the '@' symbol is drawn as the psygnosis owl face logo when displayed in the demo! 

t1$="                          "
t1$=t1$+"@ COSINE SYSTEMS PRESENT  @  BEAST TRIBUTE  @  A.K.A. OLD SCHOOL DEMO 2  @  PRODUCED IN RESPONSE TO OTHER "
t1$=t1$+"PSYGNOSIS DEMOS THAT HAVE APPEARED ON THE DARK BIT FACTORY AND GRAVITY PUREBASIC FORUM DURING 2018  @  "
t1$=t1$+"CODE, GRAPHICS AND MUSIC BY ANDY  @  THE MUSIC IS BRAND NEW AND WRITTEN USING THE ORIGINAL SAMPLES FROM "
t1$=t1$+"THE AMIGA VERSION OF SHADOW OF THE BEAST 1, SO CREDIT MUST BE GIVEN TO DAVID WHITTAKER FOR THOSE ORIGINAL SOUNDS  @  "
t1$=t1$+"THE PSYGNOSIS LOGO STYLE OF LETTERING USED IN THIS SCROLLING MESSAGE IS A MODIFIED VERSION OF A BITMAP FONT "
t1$=t1$+"I FOUND ON THE ENGLISH AMIGA BOARD FORUM  @  I CANNOT FIND THE ORIGINAL THREAD POSTING FROM WHERE IT WAS "
t1$=t1$+"DOWNLOADED, SO CANNOT GIVE CREDIT.  SORRY...  @   SPECIAL THANKS MUST GO TO DBF FORUM MEMBER KRAZYK FOR POINTERS "
t1$=t1$+"ON ANIMATION CONTROL AND DEVIANTART MEMBER HYB1RD-1982 FOR PERMISSION TO USE THE EXCELLENT AARBRON RENDER THAT "
t1$=t1$+"APPEARS IN GREYSCALE IN THE INTRO TO THIS DEMO  @  I WAS INSPIRED TO CODE THIS TRIBUTE DEMO AFTER SEEING "
t1$=t1$+"THE OTHER PSYGNOSIS DEMOS BY KRAZYK AND AR-S, WHICH BROUGHT BACK SO MANY AMIGA MEMORIES FROM YESTERYEAR, "
t1$=t1$+"PARTICULARLY THOSE OF SHADOW OF THE BEAST, SO THAT GAME BECAME MY MAIN FOCUS IN THIS DEMO  @   YOU MAY SPOT THE OWL FROM "
t1$=t1$+"THE AMIGA GAME AGONY FLYING ACROSS THE SCREEN AND THIS IS A MINI-TRIBUTE TO THOSE OTHER DBF DEMOS WHICH ALSO FEATURE "
t1$=t1$+"THE SAME OWL SPRITE  @  OF COURSE, HUGE RESPECT MUST BE SHOWN TO MARTIN EDMONDSON AND PAUL HOWARTH "
t1$=t1$+"OF REFLECTIONS FOR PRODUCING THE ORIGINAL LANDMARK GAME IN THE FIRST PLACE  @  EQUAL RESPECT IS DUE TO STEVEN "
t1$=t1$+"HAMMOND WHO PIXELLED THE ORIGINAL, BEAUTIFUL AMIGA GRAPHICS  @  IF YOU ARE WATCHING THIS, THEN OBVIOUSLY YOU HAVE "
t1$=t1$+"DOWNLOADED IT, THUS YOU SHOULD ALSO HAVE RECEIVED THE SOURCE CODE AND ALL THE ASSOCIATED DATA FILES IN THE "
t1$=t1$+"HOPE THAT THEY WILL PROVE USEFUL TO SOMEONE IF THEY WANT TO LEARN TO CODE IN PUREBASIC  @  ALL OF THE GRAPHICS "
t1$=t1$+"HAVE BEEN INCLUDED IN THEIR ORIGINAL FORMAT, SO YOU CAN SEE HOW THE PARALLAX COMPONENTS ALL FIT TOGETHER  @  "
t1$=t1$+"THE GRAPHICS ARE EITHER MODIFIED VERSIONS OF THE AMIGA ORIGINALS, OR ARE BRAND NEW, BUT SIMILAR, GRAPHICS PIXELLED OR "
t1$=t1$+"MODIFIED BY YOURS TRULY  @  ALTHOUGH LOADED INTO THE DEMO AS AN OGG FILE, THE MUSIC IS PROVIDED IN THE ORIGINAL "
t1$=t1$+"4 CHANNEL MOD FORMAT, SO ANYONE WANTING TO LOAD IT INTO A TRACKER TO PULL IT APART, CAN DO SO  @  THIS IS THE "
t1$=t1$+"FIRST 4 CHANNEL MOD TUNE I HAVE WRITTEN IN OVER 20 YEARS, SO PLEASE DO NOT JUDGE IT TOO HARSHLY!  @  "
t1$=t1$+"WITH THE MUSIC, I HAVE ATTEMPTED TO WRITE A TRACK THAT COULD HAVE FIT INTO ONE OF THE LATER LEVELS OF SHADOW "
t1$=t1$+"OF THE BEAST  @  HOPEFULLY I HAVE ACHIEVED THAT AIM  @   IN CASE YOU ARE WONDERING HOW THIS OLD SCHOOL DEMO 2 "
t1$=t1$+"DIFFERS TO OLD SCHOOL DEMO 1 OTHER THAN SUBJECT MATTER, THERE ARE LOADS MORE OBJECTS BEING DISPLAYED WITH "
t1$=t1$+"ANIMATION BEING THE NEWST FEATURE OF MY CODING  @  SOME SPRITES HAVING MULITPLE FRAMES BEING CONTOLLED BY A "
t1$=t1$+"TIMER  @  THIS DEMO ALSO HAS MORE THAN ONE SCREEN, WITH THE INTRO TITLES BEING DIFFERENT IN STYLE TO THE MAIN SCREEN  @  "
t1$=t1$+"I HAVE TRIED TO DO SOMETHING MORE INTERESTING WITH THE GREETINGS SCROLLER  @  NOTICE HOW IT LOOPS AROUND ONE OF "
t1$=t1$+"THE CLOUD LAYERS, GOING IN FRONT AND THEN BEHIND  @  WHAT...  YOU DID NOT NOTICE...  SHAME ON YOU!  @  SOMETHING ELSE "
t1$=t1$+"YOU MAY NOT HAVE NOTICED IS THE SUNSET BACKGROUND  @  EACH TIME THE DEMO IS RUN, IT CHOOSES FROM A SET OF 3 "
t1$=t1$+"BACKGROUNDS, SO YOU MAY HAVE A DIFFERENT PLANET IN THE SKY, HOVERING ABOVE THE ENDLESSLY RUNNING AARBRON  @  "
t1$=t1$+"IF YOU ARE LOOKING NOW AND CANNOT SEE THE SKY BACKGROUND, IT MAY HAVE FADED TO NIGHT  @  AS THE DEMO RUNS, "
t1$=t1$+"OVER A PERIOD OF ABOUT 5 MINUTES, THE SKY FADES TO NIGHT AND THEN BACK TO DAY TO SIMULATE THE PASSING OF TIME  @  "
t1$=t1$+"THANKS GO TO MOLOCH, WARLOCK AND T.M.R FOR TESTING THIS DEMONSTRATION  @  IF YOU HAVE ANY "
t1$=t1$+"SPARE TIME, PLEASE VISIT THE COSINE AND ARKANIX LABS WEBSITES...    WWW.COSINE.ORG.UK     WWW.ARKANIXLABS.COM   @  "
t1$=t1$+"UNTIL NEXT TIME, THIS IS ANDY SIGNING OFF... BYE... .. .      @       "
t1$=t1$+"                                       "

t2$="                                                            "
t2$=t2$+"PSYGNOSIS STYLE COSINE GREETINGS ARE SENT OUT TO...        ABSENCE    @    "
t2$=t2$+"ABYSS CONNECTION    @    ARKANIX LABS    @    ARTSTATE    @    ATE BIT    @    ATLANTIS    @    BOOZE DESIGN    @    "
t2$=t2$+"CAMELOT    @    CENSOR DESIGN    @    CHORUS    @    CHROME    @    CNCD    @    CPU    @    CRESCENT    @    "
t2$=t2$+"COVERT BITOPS    @    DEFENCE FORCE    @    DEKADENCE    @    DESIRE    @    DAC    @    DMAGIC    @    DUALCREW    @    "
t2$=t2$+"EXCLUSIVE ON    @    FAIRLIGHT    @    F4CG    @    FIRE    @    FLAT 3    @    FOCUS    @    FRENCH TOUCH    @    "
t2$=t2$+"GENESIS PROJECT    @    GHEYMAID INC.    @    HITMEN    @    HOKUTO FORCE    @    LEGION OF DOOM    @    "
t2$=t2$+"LEVEL64    @    MANIACS OF NOISE    @    MAYDAY    @    MEANTEAM    @    METALVOLTE   @     NONAME    @    "
t2$=t2$+"NOSTALGIA    @    NUANCE    @    OFFENCE    @    ONSLAUGHT    @    ORB    @    OXYRON   @     PADUA    @    "
t2$=t2$+"PERFORMERS    @    PLUSH    @    PROFESSIONAL PROTECTION CRACKING SERVICE    @    PSYTRONIK    @    "
t2$=t2$+"REPTILIA    @    RESOURCE    @    RGCD    @    SECURE    @    SHAPE    @    SIDE B    @    SINGULAR    @    "
t2$=t2$+"SLASH    @    SLIPSTREAM    @    SUCCESS AND TRC    @    STYLE    @    SUICYCO INDUSTRIES    @    "
t2$=t2$+"TAQUART    @    TEMPEST    @    TEK    @    TRIAD    @    TRSI    @    VIRUZ    @    VISION   @     WOW    @    "
t2$=t2$+"WRATH    @    XENON...              AND GREETINGS TO INDIVIDUALS...          MOLOCH    @    WARLOCK    @    FUZZ    @    "
t2$=t2$+"REDBACK    @    T.M.R    @    ODIE        ...AND ALL OTHER BEASTS, ER, MEMBERS IN BOTH COSINE AND ARKANIX LABS...     "
t2$=t2$+"                                                             "


;- PROCEDURES ------------------------------------------------

; here are various procedures that loads images/sounds and draws/animates various parts of the screen

Procedure OpenMainWindow()
  
  ; the main display window is opened and a windowed screen applied to it so
  ; we can draw images and sprites on it smoothly
  ;
  ; the window will be centered on the desktop, have a small titlebar, have no
  ; taskbar entry and will be hidden until later on when a command is given to unhide the screen!
  
  OpenWindow(0, 0, 0, 800, 600, "Cosine - Beast Tribute - Old School Demo 2 - 'ESC' to Exit", #PB_Window_ScreenCentered | #PB_Window_Tool | #PB_Window_Invisible)
  OpenWindowedScreen(WindowID(0), 0, 0, 800, 600)
  
  ; since the demo runs in a windowed screen, the screen is synced to the desktop screen, usually 60Hz, 
  ; therefore the below code probably isn't necessary, but just being thorough!
  
  ExamineDesktops()
  refreshrate = DesktopFrequency(0)
  framerate = refreshrate
  SetFrameRate(framerate)
  
EndProcedure

Procedure LoadAssets()
  
  ; here, we load the various images for the demo.  the images are loaded as sprites so we
  ; can make them move around and display nice and quickly on the screen.  by using
  ; sprites, we can also display them using the transparent function to make use of
  ; the transparent and intensity functions.
  
  ; to explain my naming convention below... i use the prefix 'i' at the front of the variable
  ; to indicate an image, so 'i_PSYPRES' is a variable that holds the image (sprite) of the
  ; title card 'in 1989 psygnosis presented'.
  
  Global i_PSYPRES = LoadSprite(#PB_Any, "data/psypres.bmp")          ; load the psygnosis title card
  Global i_REFPROD = LoadSprite(#PB_Any, "data/reflect-prod.bmp")     ; load the reflections title card
  Global i_COSPRES = LoadSprite(#PB_Any, "data/cos-pres.bmp")         ; load the cosine title card
  Global i_BEASTTRI = LoadSprite(#PB_Any, "data/beast-tri.bmp")       ; load the beast tribute title card
  Global i_AARGREY = LoadSprite(#PB_Any, "data/aarbron-grey.bmp")     ; load the greyscale aarbron image
  Global i_MONITOR = LoadSprite(#PB_Any, "data/monitor.bmp")          ; load the heartbeat monitor image
  Global i_TUBES = LoadSprite(#PB_Any, "data/testtubes.bmp")          ; load the testtube image
  Global i_BEASTLOGO = LoadSprite(#PB_Any, "data/beast-logo.bmp")     ; load the beast logo image  
  
  bg = Random(2)                                                       ; generate a random number between 0 and 2!
  If bg = 0                                                             
    Global i_SUNSET = LoadSprite(#PB_Any, "data/sunset1.bmp")         ; depending on the random number, 1 of 3
  ElseIf bg = 1                                                       ; background images is loaded, so each time
    Global i_SUNSET = LoadSprite(#PB_Any, "data/sunset2.bmp")         ; the demo is run, the background image may
  ElseIf bg = 2                                                       ; be different.  whichever is picked, it is
    Global i_SUNSET = LoadSprite(#PB_Any, "data/sunset3.bmp")         ; loaded into the variable 'i_SUNSET'
  EndIf
   
  Global i_BLIMP = LoadSprite(#PB_Any, "data/blimp.bmp")              ; load the cosine blimp image
  Global i_OWL = LoadSprite(#PB_Any, "data/owl.bmp")                  ; load the agony owl image
  Global i_CLOUDS1 = LoadSprite(#PB_Any, "data/clouds1.bmp")          ; load the various cloud images
  Global i_CLOUDS2 = LoadSprite(#PB_Any, "data/clouds2.bmp")
  Global i_CLOUDS3 = LoadSprite(#PB_Any, "data/clouds3.bmp")
  Global i_CLOUDS4 = LoadSprite(#PB_Any, "data/clouds4.bmp")
  Global i_CLOUDS5 = LoadSprite(#PB_Any, "data/clouds5.bmp")
  Global i_MOUNTAINS = LoadSprite(#PB_Any, "data/mountains.bmp")      ; load some mountains
  Global i_TREE1 = LoadSprite(#PB_Any, "data/tree1.bmp")              ; load the various tree images
  Global i_TREE2 = LoadSprite(#PB_Any, "data/tree2.bmp")
  Global i_TREE3 = LoadSprite(#PB_Any, "data/tree3.bmp")
  Global i_GRASS1 = LoadSprite(#PB_Any, "data/grass1.bmp")            ; load the various grass images
  Global i_GRASS2 = LoadSprite(#PB_Any, "data/grass2.bmp")
  Global i_GRASS3 = LoadSprite(#PB_Any, "data/grass3.bmp") 
  Global i_GRASS4 = LoadSprite(#PB_Any, "data/grass4.bmp") 
  Global i_GRASS5 = LoadSprite(#PB_Any, "data/grass5.bmp")
  Global i_FENCE = LoadSprite(#PB_Any, "data/fence.bmp")              ; load the fence image
  
  a_AARBRONRUN(0) = LoadSprite(#PB_Any, "data/aarbronrun0.bmp")        ; load aarbrons animation frames
  a_AARBRONRUN(1) = LoadSprite(#PB_Any, "data/aarbronrun1.bmp")        ; into diffrent parts of the array
  a_AARBRONRUN(2) = LoadSprite(#PB_Any, "data/aarbronrun2.bmp")        ; that was dimensioned earlier
  a_AARBRONRUN(3) = LoadSprite(#PB_Any, "data/aarbronrun3.bmp") 
  a_AARBRONRUN(4) = LoadSprite(#PB_Any, "data/aarbronrun4.bmp") 
  a_AARBRONRUN(5) = LoadSprite(#PB_Any, "data/aarbronrun5.bmp")
  
  
  Global i_FONT = LoadImage (#PB_Any, "data/psy-font.bmp")             ; load the image containing all the
                                                                        ; letters and numbers for the scroller  
  
  StartDrawing (ScreenOutput())                                         ; draw the above letter/number image
  DrawImage (ImageID(i_FONT),0,0)                                       ; onto the screen - you can't see it
  StopDrawing()                                                         ; because the screen is hidden!
  
  xp=0
  yp=0
  
  For loop = 1 To 60                                                    ; this loop 'cuts' the large letter/number
    a_GFXFONT(loop) = GrabSprite(#PB_Any,xp,yp,31,31)                    ; image into individual letters/numbers
    xp=xp+32                                                             ; stores them into the GFXFONT array that
    If xp>=320                                                           ; was dimensioned earlier.  each letter and
      yp=yp+33                                                           ; is 32 pixels high and 32 pixels wide.
      xp=0
    EndIf
  Next
  
  
  Global i_DISK = LoadSprite(#PB_Any, "data/disk.bmp")                  ; load the disk image for the end
  
  Global m_BEASTTRI = LoadSound(#PB_Any, "data/beasttri.ogg")           ; finally, load the music!
   
  
EndProcedure  

Procedure CreateSprites()
  
  ; here, we will create a window sized (800x600) sprite that we are going to use to fade
  ; the main part of the demo in.  the sprite has alpha blending applied so we will be able
  ; to change the opacity of it.
  ;
  ; once created, the sprite is drawn to the hidden screen and then is completly filled
  ; in with black. this should make it easy to fade from a black screen to reveal the
  ; parallax scrolling main demo part underneath, using purebasic commands.
  
  Global i_FADESPRITE = CreateSprite(#PB_Any, 800, 600, #PB_Sprite_AlphaBlending)
  
  StartDrawing(SpriteOutput(i_FADESPRITE))
  FillArea(0, 0, -1, RGB(0, 0 ,0))
  StopDrawing()
  
  ; now, create a simple random starfield that will be drawn behind the normal
  ; sunset backdrop so that when the sunset fades, stars are revealed.
    
  Global i_STARFIELD = CreateSprite(#PB_Any, 800, 400)
  
  StartDrawing(SpriteOutput(i_STARFIELD))
  For n=0 To 99
    Plot(Random(799), Random(399), RGB(150, 150, 150))
  Next
  
  For n=0 To 399
    Plot(Random(799), Random(399), RGB(50, 50, 50))
  Next  
  StopDrawing() 

EndProcedure

Procedure FadeToBlack()
  
  ; make the hidden window created in the 'OpenMainWindow' procedure above
  ; actually visible so we can see what is happening!  i've added a
  ; clear screen command here just in case there are any left overs from
  ; creating the font sprites from earlier.  the clear screen wipes the
  ; window completely white.
  
  ClearScreen(RGB(255,255,255))                   ; clears screen to white
  HideWindow(0, #False)                           ; makes the window visible
  FlipBuffers()                                   ; shows the white screen
  StickyWindow(0, #True)                          ; keeps our demo window on top of all other windows
  FlipBuffers()                                   ; swap to the buffer screen to make visible what we've drawn!
  Delay(120)
  
  fadelog=250
  
  For fade = 250 To 0 Step -25                   ; a little loop that changes the white screen from just above
                                                  ; through shades of grey until black is reached.
    ClearScreen(RGB(fadelog,fadelog,fadelog))     ; all this looks like a screen flash when running!
    
    FlipBuffers()                                 ; swap to the buffer screen to make visible what we've drawn!
    
    fadelog - 25
    
  Next fade  
  
EndProcedure 

Procedure FadeLogosIn()
  
  ; this little loop changes the variable that 
  ; controls the opacity of a displayed sprite from
  ; totally transparent (255) to totally solid (0)
  
  Shared opaque
  
  If opaque < 255
    opaque = opaque + 1
  EndIf
  
EndProcedure

Procedure FadeLogosOut()
  
  ; this little loop changes the variable that 
  ; controls the opacity of a displayed sprite from
  ; totally solid (0) to totally transparent (255)
  
  Shared opaque
  
  If opaque > 0
    opaque = opaque - 4
  EndIf
  
EndProcedure 

Procedure ScrollClouds()
  
  Shared cloud1x, cloud2x, cloud3x, cloud4x, cloud5x, cloudopac
  
  
  ; first draw the very top cloud layer, layer 1. the for-next loop controls the wrap
  ; around of the 800 pixel wide sprite - once it reaches the end, it wraps around
  ; seamlessly.
  ;
  ; just underneath the for-next loop, the cloud1x-6 part controls the cloud scroll
  ; speed.  make 6 smaller to scroll slower, or bigger to scroll quicker!
  ;
  ; this code repeats down the procedure for the different cloud layrers!
  
  
  For cloud1anim = 0 To 2
    DisplayTransparentSprite(i_CLOUDS1, 800 * cloud1anim - cloud1x, 0, cloudopac)
  Next
  
  cloud1x - 6 : If cloud1x < 1 : cloud1x = 799 : EndIf
  
  
  
  ; >>>> you may notice that cloud layer 2 is missing here.  this is because cloud layer 2
  ; interacts with the credits scrolling message at the top of the screen.  look in the
  ; procedure called 'UpdateCreditsScroller' because that procedure controls cloud layer
  ; 2 so that the scrolling message can pass behind and in front of the clouds.
  
  
  
  ; here is the code for cloud layer 3
  
  For cloud3anim = 0 To 2
    DisplayTransparentSprite(i_CLOUDS3, 800 * cloud3anim - cloud3x, 185, cloudopac)
  Next
  
  cloud3x - 4 : If cloud3x < 1 : cloud3x = 799 : EndIf
  
  
  ; here is the code for cloud layer 4
    
  For cloud4anim = 0 To 2
    DisplayTransparentSprite(i_CLOUDS4, 800 * cloud4anim - cloud4x, 265, cloudopac)
  Next
  
  cloud4x - 2 : If cloud4x < 1 : cloud4x = 799 : EndIf
  
  
  ; here is the code for cloud layer 5
    
  For cloud5anim = 0 To 2
    DisplayTransparentSprite(i_CLOUDS5, 800 * cloud5anim - cloud5x, 320, cloudopac)
  Next
  
  cloud5x - 1 : If cloud5x < 1 : cloud5x = 799 : EndIf   
  
  
EndProcedure  

Procedure ScrollStars()
  
  Shared starsx  ; starsx is a variable controlling the 'x' position of the starfield
  
  
  ; draw the starfield. the for-next loop controls the wrap
  ; around of the 800 pixel wide sprite - once it reaches the end, it wraps around
  ; seamlessly.
  ;
  ; just underneath the for-next loop, the starx-1 part controls the stars scroll
  ; speed.  make 1 bigger to scroll quicker!
  
  
  For starsanim = 0 To 2
    DisplayTransparentSprite(i_STARFIELD, 800 * starsanim - starsx, 0)
  Next
  
  starsx - 1 : If starsx < 1 : starsx = 799 : EndIf 
  
  
  
  
EndProcedure 

Procedure ScrollMountains()
  
  Shared mountainsx  ; mountainsx is a variable controlling the 'x' position of the mountains
  
  
  ; draw the mountains. the for-next loop controls the wrap
  ; around of the 800 pixel wide mountain sprite - once it reaches the end, it wraps around
  ; seamlessly.
  ;
  ; just underneath the for-next loop, the mountainsx-6 part controls the mountains scroll
  ; speed.  make 3 smaller to scroll slower, or bigger to scroll quicker!
  
  
  For mountanim = 0 To 2
    DisplayTransparentSprite(i_MOUNTAINS, 800 * mountanim - mountainsx, 244)
  Next
  
  mountainsx - 3 : If mountainsx < 1 : mountainsx = 799 : EndIf
  
    
EndProcedure  

Procedure ScrollTrees()
  
  Shared tree1x, tree2x, tree3x ; variables controlling the x position of the 3 trees
  
  ; each time this routine is called, the x position of each tree increases by 1,
  ; which moves them across the screen.  each tree has a different start position
  ; off screen on the left (the negative number) and a different end position off
  ; screen to the right.  this makes each tree appear in different places in relation
  ; to each other. sometimes they are seperate, sometimes they overlap. this is
  ; just a real simple way to make the trees look like they appear randomly.

  DisplayTransparentSprite(i_TREE1, tree1x, 110)
  tree1x + 4 : If tree1x > 900 : tree1x = -400 :  EndIf
  
  DisplayTransparentSprite(i_TREE2, tree2x, 160)
  tree2x + 4 : If tree2x > 1000 : tree2x = -700 :  EndIf
  
  DisplayTransparentSprite(i_TREE3, tree3x, 120)
  tree3x + 4 : If tree3x > 950 : tree3x = -550 :  EndIf  
    
EndProcedure  

Procedure ScrollGrass()
  
  ; the grass is drawn in the same way as the clouds, using different images
  ; and speeds.  see the 'ScrollClouds' procedure above for a description!
  
  
  Shared grass1x, grass2x, grass3x, grass4x, grass5x
  
  For grass1anim = 0 To 2
    DisplayTransparentSprite(i_GRASS1, 800 * grass1anim - grass1x, 427)
  Next
  grass1x - 4 : If grass1x < 1 : grass1x = 799 : EndIf
  
  For grass2anim = 0 To 2
    DisplayTransparentSprite(i_GRASS2, 800 * grass2anim - grass2x, 452)
  Next
  grass2x - 5 : If grass2x < 1 : grass2x = 799 : EndIf
  
  For grass3anim = 0 To 2
    DisplayTransparentSprite(i_GRASS3, 800 * grass3anim - grass3x, 482)
  Next
  grass3x - 6 : If grass3x < 1 : grass3x = 799 : EndIf
  
  For grass4anim = 0 To 2
    DisplayTransparentSprite(i_GRASS4, 800 * grass4anim - grass4x, 512)
  Next
  grass4x - 7 : If grass4x < 1 : grass4x = 799 : EndIf
  
  For grass5anim = 0 To 2
    DisplayTransparentSprite(i_GRASS5, 800 * grass5anim - grass5x, 552)
  Next
  grass5x - 8 : If grass5x < 1 : grass5x = 799 : EndIf   
  
EndProcedure  

Procedure ScrollFence()
  
  Shared fencex ; variable controlling the x position of the fence image
  
  ; the fence is scrolled in the same way as the mountains, so see the
  ; 'ScrollMountains()' procedure for an explanation!

  For fenceanim = 0 To 2
    DisplayTransparentSprite(i_FENCE, 800 * fenceanim - fencex, 547)
  Next
  
  fencex - 10 : If fencex < 1 : fencex = 799 : EndIf  
    
EndProcedure 

Procedure ScrollBlimp()
  
  ; the blimp is moved across the screen just like the trees.  see the
  ; 'ScrollTrees()' procedure for an explanation!
  
  Shared blimpx
  
  DisplayTransparentSprite(i_BLIMP, blimpx, 50)
  blimpx + 1 : If blimpx > 1200 : blimpx = -300 :  EndIf
  
EndProcedure  

Procedure ScrollOwl()
  
  Shared owlx ; variable controlling the x position of the owl
  
  Static owlframe ; variable controlling the animation frame number we are using
    
  ; look at the owl bitmap image in the data folder.  it contains all the frames to animate the owl.
  ; basically, to animate the owl, the relevant part of the image is displayed when needed.
  
  ; first, clip (cut) the image based on the frame number multiplied by the width of the
  ; owl sprite, which in this case is 32 pixels, to leave just the part of the image we need.
  
  ClipSprite(i_OWL, owlframe * 32, 0, 32, 89)
  
  ; now show the animation frame that is already clipped above!
  
  DisplayTransparentSprite(i_OWL, owlx, 225)
  
  ; now we check the timer to see if it's time to show the next frame in the animation.
  ; if so, the frame number is increased and the timer restarted.
  
  If ElapsedMilliseconds() - owlanimtime > 60 / 2       ; check if half a second has past
    owlanimtime = ElapsedMilliseconds()                 ; if so, restart the timer
    owlframe + 1                                        ; increase the frame number
    If owlframe=16 : owlframe=0 : EndIf                ; check to see if the last frame has been
  EndIf                                                ; reached, if so, reset to start frame!
  
  owlx - 4 : If owlx < -1000 : owlx = 2000 :  EndIf     ; change the owl sprite x position on screen

EndProcedure

Procedure AnimateAarbron()
  
  Static aarbronframe ; variable controlling the animation frame number we are using
  
  Shared aarbronx ; variable controlling the x position of the owl

  
  ; this first bit of code moves aarbron from the right of the screen to the left hand
  ; side.  his xposition at the start is 900 pixels so he starts off screen to the right.
  ; when this procedure is called, his x position is decreased by 4 pixels until it
  ; reaches 75 pixels, where he then stays.
  
  If aarbronx > 75
    aarbronx - 4
  EndIf
  
  ; now we need to animate aarbron, because he would look a bit silly if he slides on the screen.
  ; look at the aarbron bitmap images in the data folder.  this is done differently to the owl,
  ; just to show that another method can be used to animate. in this case, the different frames
  ; of animation for aarbron are stored in an array, defined at the start of the code.
  ; just like the owl, there is a timer to control when to display the next frame, but this
  ; time each frame is retreived from the array instead of being cut from one large image.
  ; by the way, before being displayed, the aarbron sprite is zoomed slightly to make him bigger.
  ; when he lived on the amiga, he was smaller in size, but with today's computers and their
  ; bigger screen sizes, he needs to be a littler bigger!
  
  ZoomSprite(a_AARBRONRUN(aarbronframe), 130, 170)
  DisplayTransparentSprite(a_AARBRONRUN(aarbronframe), aarbronx, 340)
  
  If ElapsedMilliseconds() - aarbronanimtime > 100		        
    aarbronanimtime  = ElapsedMilliseconds()		             
    aarbronframe + 1                                       
    If aarbronframe = 6 : aarbronframe = 0 :EndIf  
  EndIf

EndProcedure  

Procedure UpdateMainScroller()
  
  ; the main scrolling message is controlled and updated here.
  ; try adjusting the various variables to see the effect on the scroller!

  Shared cco1, cc1, t1$, tptr1, sco1, m1
  
  cco1=200 ; where scroll disappears from screen
  For cc1=0 To 25 ; where scroll appears on screen
    letter=(Asc(Mid(t1$,tptr1+cc1,1))-31) ; detect the next letter in the scroll message
    ZoomSprite(a_gfxfont(letter), 64, 64) ; assign the letter a sprite from the array and zoom to correct size
    DisplayTransparentSprite(a_gfxfont(letter),(sco1+cco1),390+10*Sin((cc1+cco1+sco1+m1)/70)) ; display sprite!
    cco1=cco1+70
  Next
  m1=m1-5
  sco1=sco1-7 ; scroll speed
  If sco1<-70
    tptr1=tptr1+1 ; scroll smoothness
    sco1=sco1+70
  EndIf
  If tptr1>(Len(t1$)-30 )
    tptr1=1
  EndIf
  
EndProcedure 

Procedure UpdateCreditsScroller()
  
  ; the smaller size credits scrolling message is controlled and updated here.
  ; try adjusting the various variables to see the effect on the scroller!
  
  Shared cco2, cc2, t2$, tptr2, sco2, m2, credscrolly, credscrolldir, cloud2x, cloudopac
  
  
  ; here we decide how to draw the message on cloud layer 2. if the varible credscrolldir
  ; is equal to 1, then the scroller is moving down and is drawn on top of the clouds.
  ; if the varible credscrolldir is 0, then the scroller is moving up and the clouds are
  ; drawn on top of the message.  this is a simple effect that make it look like the
  ; scroller looping around and interacting with the second cloud layer.
   
  If credscrolldir = 1
    
    For cloud2anim = 0 To 2
      DisplayTransparentSprite(i_CLOUDS2, 800 * cloud2anim - cloud2x, 70,cloudopac)
    Next
    
    cco2=1 ; where scroll disappears from screen
    For cc2=0 To 25 ; where scroll appears on screen
      letter=(Asc(Mid(t2$,tptr2+cc2,1))-31)
      ZoomSprite(a_gfxfont(letter), 32, 32)
      DisplayTransparentSprite(a_gfxfont(letter),(sco2+cco2),credscrolly) 
      cco2=cco2+35
    Next
    
  EndIf
  
  
  If credscrolldir = 0
    
    cco2=1 ; where scroll disappears from screen
    For cc2=0 To 25 ; where scroll appears on screen
      letter=(Asc(Mid(t2$,tptr2+cc2,1))-31)
      ZoomSprite(a_gfxfont(letter), 32, 32)
      DisplayTransparentSprite(a_gfxfont(letter),(sco2+cco2),credscrolly) 
      cco2=cco2+35
    Next
    
    For cloud2anim = 0 To 2
      DisplayTransparentSprite(i_CLOUDS2, 800 * cloud2anim - cloud2x, 70, cloudopac)
    Next
    
  EndIf
  
  ; now complete the rest of the scroller, altering variables as necessary
  
  m2=m2-3
  
  sco2=sco2-4 ; scroll speed
  
  If sco2<-35
    tptr2=tptr2+1 ; scroll smoothness
    sco2=sco2+35
  EndIf
  If tptr2>(Len(t2$)-31 )
    tptr2=1
  EndIf
  
  ; now do some simple checks to see what y position the scroller is at on the screen.
  ; if it's y position has reached the bottom limit of 180, change the direction to
  ; up and when the the top limit of 15 is reached, change the y direction to down!
  
  If credscrolldir = 1
    credscrolly + 3
    If credscrolly => 180
      credscrolldir = 0
    EndIf
  EndIf
  
  If credscrolldir = 0
    credscrolly - 3
    If credscrolly =< 15
      credscrolldir = 1
    EndIf
  EndIf  
  
  ; move the cloud layer 2 across the screen. check out the scroll clouds procedure
  ; more a more in depth explantion.
  
  cloud2x - 5 : If cloud2x < 1 : cloud2x = 799 : EndIf 
  
EndProcedure  

Procedure AnimateMonitor()
  
  ; the small heartbeat monitor is animated in the same way as the owl, by
  ; clipping the necessary frame from a larger image.  the difference here is
  ; that the monitor stays in the same place on the screen,  unlike the owl.
  ; check the 'ScrollOwl' procedure for an explantion of how the animation
  ; is acheived.
  
  Static monitorframe
  
  ClipSprite(i_MONITOR, monitorframe * 46, 0, 46, 40)
  
  DisplayTransparentSprite(i_MONITOR, 2, 2)
  
  If ElapsedMilliseconds() - monitoranimtime > 90
    monitoranimtime = ElapsedMilliseconds()
    monitorframe + 1
    If monitorframe = 10 : monitorframe = 0 : EndIf
  EndIf
  
EndProcedure  


;- INITIALISE DEMO --------------------------------------------------       
;
; here's where everything actually starts!
;
; we call the various procedures above to set everything up and then
; start the actual demo playing in the main loop below...

OpenMainWindow()                            ; open the window on the user's desktop
LoadAssets()                                ; load the images and music
CreateSprites()                             ; create some sprites on the fly
FadeToBlack()                               ; run the 'fadetoblack' procedure to flash the screen
PlaySound(m_BEASTTRI, #PB_Sound_Loop, vol)  ; start playing the music
Delay(1000)                                 ; a little delay before anything else is displayed

;- MAIN LOOP --------------------------------------------------------  

; now call the various procedures above in a repeat loop, drawing the
; various parts of the screen
;
; the loop 'Repeats' 'Until' the the 'escape' key is pressed
;
; the loop below is divided into various parts and subparts.  each 'demopart'
; displays on the screen the part we are on, whether it be part of the intro
; title cards, or the main demo screen. after each part is displayed, the
; demopart variable is increased by 1 so the next part will be displayed.
; some demoparts also have sub-parts, which are simply fading the screen
; in and out by increasing and decreasing the opacity of the image.

Repeat
  
  Delay(0)                        ; allow some time for the multitasking environment
  
  WaitWindowEvent(0)              ; wait for an event in our window ('escape' keypress)
  
  ClearScreen(0)                  ; clear the screen to black to redraw/update everything
  
  
  If demopart = 1                 ; display 'psy presented' title card
    
    If subpart = 1                ; fade the title card in
      DisplayTransparentSprite(i_PSYPRES, 150, 113, opaque)
      FadeLogosIn()
      If opaque = 255
        subpart = 2
      EndIf
    EndIf
    
    If subpart = 2                ; fade the title card out
      DisplayTransparentSprite(i_PSYPRES, 150, 113, opaque)
      FadeLogosOut()
      If opaque < 0               ; check progress of the fade and increase the
        opaque  = 0               ; demopart variable by 1
        demopart = 2
        subpart = 1
        ClearScreen(0)
        FlipBuffers()
        Delay(800)
      EndIf
    EndIf  
    
  EndIf
  
  
  If demopart = 2                 ; display 'reflect prod' title card
    
    If subpart = 1
      DisplayTransparentSprite(i_REFPROD, 150, 113, opaque)
      FadeLogosIn()
      If opaque = 255
        subpart = 2
      EndIf
    EndIf
    
    If subpart = 2
      DisplayTransparentSprite(i_REFPROD, 150, 113, opaque)
      FadeLogosOut()      
      If opaque < 0
        opaque  = 0
        subpart = 1
        demopart = 3
        ClearScreen(0)
        FlipBuffers()
        Delay(800)
      EndIf
    EndIf  
    
  EndIf  

  
  If demopart = 3                 ; display 'cosine prod' title card
    
    If subpart = 1
      DisplayTransparentSprite(i_COSPRES, 150, 113, opaque)
      FadeLogosIn()
      If opaque = 255
        subpart = 2
      EndIf
    EndIf
    
    If subpart = 2
      DisplayTransparentSprite(i_COSPRES, 150, 113, opaque)
      FadeLogosOut()      
      If opaque < 0
        opaque  = 0
        subpart = 1
        demopart = 4
        ClearScreen(0)
        FlipBuffers()        
        Delay(800)
      EndIf
    EndIf  
    
  EndIf   
  
  
  If demopart = 4                 ; display 'beast tribute' title card
    
    If subpart = 1
      DisplayTransparentSprite(i_BEASTTRI, 150, 113, opaque)
      FadeLogosIn()
      If opaque = 255
        opaque  = 0
        subpart = 1
        demopart = 5
      EndIf
    EndIf
    
  EndIf    
  
  
  If demopart = 5                 ; display 'beast tribute' title card with grey aarbron
    
    If subpart = 1
      DisplayTransparentSprite(i_AARGREY, 165, 70, opaque)
      FadeLogosIn()
      If opaque = 255
        subpart = 2
      EndIf
      DisplayTransparentSprite(i_BEASTTRI, 150, 113)
    EndIf
    
    If subpart = 2
      
      DisplayTransparentSprite(i_AARGREY, 165, 70, opaque)
      DisplayTransparentSprite(i_BEASTTRI, 150, 113, opaque)
      FadeLogosOut()      
      If opaque < 0
        opaque  = 255
        subpart = 1
        demopart = 6
      EndIf
    EndIf  
    
  EndIf   
  
  
  ; now the main screen is displayed when the demopart varible reaches 6.
  ; the various procedures are drawn on the screen to build the display.
  ; they are drawn in the order to produce the parallax and overlapping
  ; effects.
  ;
  ; if you change the order of the procedure calls below, the
  ; screen will be built in a different order and may look a bit strange.
  ; for example, if you call the trees before the mountains, the trees
  ; will appear behind the mountains, which will look odd because the
  ; size of the trees suggest they should be closer to you than the
  ; mountains.
  ;
  ; at the end of the procedure call, some images of the test tubes and
  ; the beast logo are drawn in their positions.
  
  If demopart = 6                 
    
    ScrollStars()
    
    DisplayTransparentSprite(i_SUNSET, 0, 0, bgtrans)
    
    ScrollBlimp()
    
    ScrollClouds()
    
    ScrollMountains()
    
    ScrollGrass()
    
    ScrollOwl()
    
    UpdateCreditsScroller()
    
    ScrollTrees()
    
    ScrollFence()
    
    UpdateMainScroller()
    
    AnimateAarbron()
    
    AnimateMonitor()
    
    DisplayTransparentSprite(i_TUBES, 738, 2)
    
    DisplayTransparentSprite(i_BEASTLOGO, 614, 519)    
    
    
    ; once the screen is built above, this part checks to see if we are
    ; at the start of the main demo screen, in which case we cover up
    ; all our hard work with a black image that is gradually decreased
    ; in opacity until the main screen is revealed underneath. this has
    ; the effect of fading in the main demo screen insted of it suddenly
    ; appearing.  there is now need to actually do this, but it just 
    ; looks a bit nicer i think?  what do you mean no???!!1
    
    If opaque > 0
      DisplayTransparentSprite(i_FADESPRITE, 0, 0, opaque)
      opaque = opaque - 2
    EndIf
    
    
    ; this next section of the main loop contains the code that slowly fades
    ; the sunset background image to reveal the starfield underneath.  it also
    ; reduces the opacity of the clouds a little so they are darker at night    
    
    If ElapsedMilliseconds() - bganimtime > 1000
      bganimtime = ElapsedMilliseconds()
      If bgfade = 0
        bgtrans - 1
        cloudopac - 1
        If cloudopac < 100
          cloudopac = 100
        EndIf
        If bgtrans = 0 : bgfade = 1 : EndIf
      EndIf
      If bgfade = 1
        bgtrans + 1
        cloudopac + 1
        If cloudopac > 255
          cloudopac = 255
        EndIf
        If bgtrans = 255 : bgfade = 0 : EndIf
      EndIf 
    EndIf
    
    
  EndIf  
  
   
  ExamineKeyboard()                       ; has the user pressed a key yet? 
  FlipBuffers()                           ; while displaying the already drawn screen, flip to
                                          ; the spare screen to begin the drawing again
  
Until KeyboardPushed(#PB_Key_Escape)      ; when escape is pressed, exit the repeat loop
                                           ; and run the rest of the program below... 

;- EXIT INTRO -------------------------------------------------------     

; exit the intro gracefully!
;
; first, call our FadeToBlack procedure to flash the screen white and
; fade to black!  no reason to do this other than it looks a little
; nicer than just suddenly blanking the screen!
;
; then display the final disk image advertising the cosine website,
; we need the flipbuffers to show the disk and there is a little delay
; to make sure the disk is visible for a couple of seconds

FadeToBlack()

DisplayTransparentSprite(i_DISK, 173, 69)

FlipBuffers()

Delay(2000)

; the website is being advetised on disk to the person watching, so
; now lets set a while/wend loop to turn the volume down from 100%
; to 0%   again, don't have to do this, just sounds like a nicer
; ending than suddenly stopping the music
;
; the slight delay inside the loop is so you hear the fade,
; otherwise it may happen so fast it sounds like a sudden stop

While vol > 0
  SoundVolume(m_BEASTTRI, vol)
  vol = vol - 1
  Delay(10)
Wend

; another quick screen flash to clear the screen and signal the end

FadeToBlack()

; the screen is blank, the sound volume at '0', so lets be polite and
; clear out all the sounds, images, sprites and windows we've used
;
; the 'End' command at the, er, end does this automatically, we're
; just being very extra unnecessarily thorough here!

FreeSound(m_BEASTTRI)             ; erase the music and free the memory
FreeSprite(#PB_All)               ; erase all sprites and free the memory
FreeImage(#PB_All)                ; erase any images and free the memory
CloseWindow(#PB_All)              ; close the window and free the memory


End                              ; shut everything down and exit leaving no trace!





; IDE Options = PureBasic 5.60 (Windows - x64)
; CursorPosition = 38
; FirstLine = 21
; Folding = AAA-
; EnableThread
; EnableXP
; UseIcon = gfx\cos.ico
; Executable = sotb-tribute.exe
; Compiler = PureBasic 5.60 (Windows - x86)