% Parsa Khodabandehlou
% pkhodab@ncsu.edu
% 2/18/2026
% PA4_KHODABANDEHLOU.m
%
% Plays the music the user selects.

clear
clc
close all

%% Declarations
rate = 32768; % sampling rate
logo = ["   88             88                  88                                  "
"   ""             88                  88                                  "
"                  88                  88                                  "
"   88 88       88 88   ,d8  ,adPPYba, 88,dPPYba,   ,adPPYba, 8b,     ,d8  "
"   88 88       88 88 ,a8""  a8P_____88 88P'    ""8a a8""     ""8a `Y8, ,8P'   "
"   88 88       88 8888[    8PP"""""""" 88       d8 8b       d8   )888(     "
"   88 ""8a,   ,a88 88`""Yba, ""8b,   ,aa 88b,   ,a8"" ""8a,   ,a8"" ,d8"" ""8b,   "
"   88  `""YbbdP'Y8 88   `Y8a `""Ybbd8""' 8Y""Ybbd8""'   `""YbbdP""' 8P'     `Y8  "
"  ,88                                                                     "
"888P""                                                                     "];
fprintf("%s\n", logo)
fprintf("\n")

options = ["Dies Irae";
    "Merry Go Round of Life";
    "Megalovania";
    "Gravity Falls!";
    "He's a Pirate";
    "Passacaglia";
    "BOTW";
    "Never Gonna";
    "A Mother's Love";
 ];
randomC = "A random choice.";

randomDisp = "-----------(10) A random choice.-----------------";
optionsDisp = [
    "-----------(1)Dies Irae-------------------------";
    "-----------(2) Merry Go Round of Life-----------";
    "-----------(3) Megalovania----------------------";
    "-----------(4) Gravity Falls!-------------------";
    "-----------(5) He's a Pirate--------------------";
    "-----------(6) Passacaglia----------------------";
    "-----------(7) BOTW-----------------------------";
    "-----------(8) Never Gonna----------------------";
    "-----------(9) A Mother's Love------------------";
    "-----------(0) QUIT-----------------------------";
 ];


numOptions = length(options);
%% Jukebox Code
quit = false;
while ~quit

    %%% Opening menu. Give list of options
    fprintf("%s\n", [optionsDisp; randomDisp])
    fprintf("")

    %%% Prompt user for selection, and check validity of choice
    selected = false;
    while ~selected

        fprintf("Pick a song\n")
        s = input("", "s");

        switch s
            case "0"
                quit = true;
                selected = true;
                fprintf("Exiting the box!\n")

            case "1"
                song = options(1);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "2"
                song = options(2);
                selected = true;
                fprintf("User picked, %s\n", song);


            case "3"
                song = options(3);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "4"
                song = options(4);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "5"
                song = options(5);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "6"
                song = options(6);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "7"
                song = options(7);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "8"
                song = options(8);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "9"
                song = options(9);
                selected = true;
                fprintf("User picked, %s\n", song);

            case "10"
                song = options(randi(numOptions));
                selected = true;
                fprintf("Fate has chosen, %s\n", song);

            otherwise
                fprintf("Invalid.\n")
        end

    end
    

    if ~quit
    %%% Saves the user-defined song into the variable 'song' by calling the
    %%% proper function.


    %%% Asks user how much to change volume, and then change it
    volume = input("How much do you want to change the volume? --> ");

    %%% Asks user whether they want to play the song backwards, and then do
    %%% it backwards
    back = input("Do you want to play the song backwords (1 for yes 0 for no) --> ");

    %%% Asks whether user wants to add a fade over last two seconds, and then
    %%% do it
    fade = input("Do you want to add a fade at the end? (1 for yes 0 for no) --> ");

    %%% Ask if the user wants it old school
    old = input("Would you like to be old school? (1 for yes 0 for no) -->");

    %%% Ask if the user wants two part round
    tpr = input("Two part round? (1 for less 0 for no) -->");


    %%% Play the song using the function 'sound' with all the modifications
    %sound(song,rate)
    switch song
        case options(1)

            % DiesIrae
            songData = DiesIrae(0, 0, rate);

        case options(2)

            % Merry go round of life
            songData = MerryGoRoundOfLife(0, 0, rate);

        case options(3)

            % Toby fox song
            songData = MegalovaniaLong(0, 0, rate);


        case options(4)

            % Gravity falls!
            songData = GravityFalls(0,0, rate);

        case options(5)

            % Hes a pirate!
            songData = HesAPirate(0, 0, rate);

        case options(6)

            % Passac
            songData = Passacaglia(0, 0, rate);

        case options(7)

            % BOTW
            songData = BOTW(0, 0, rate);

        case options(8)

            % Never gonna
            songData = NeverGonna(0, 0, rate);

        case options(9)

            % A mothers
            songData = AMothersLove(0, 0, rate);
    end


    volume = volume + 1; % since 0 is default

    % Lit just invert the sin.
    if back
        songData = songData(end:-1:1);
    end

    if old
        % Gotta add oldy audio effects

        % Hiss/ grimy sound over old stuff:
        randomNoise = randn([1, length(songData)]);
        songData = songData + 0.01*randomNoise;

    end

    % two part round?
    if tpr
        delay = rate;

        actual = songData;
        
        % Holy moly this took WAYYYY too long
        % the arrays kept being off
        part1 = [actual, zeros(1, delay)];
        part2 = [zeros(1, delay), actual];
        
        % volume gets NUKED if you dont /2, since sin waves
        songData = (part1 + part2)/2;
    end


    if fade

        idxLastTS = length(songData) - 2*rate + 1;
        timeDecay = linspace(1, 0, (length(songData) - idxLastTS + 1));
        t = 1;
        for k = idxLastTS:length(songData)

            songData(k) = songData(k)*timeDecay(t);

            t = t + 1;
        end

        songData(end) = 0;
    end


    % at the end because I think the want the WHOLE song to be louder.
    songData = songData.*volume;

    sound(songData, rate)

    %%% Wait until the song is completed before proceeding. Use the
    %%% function 'pause(time)', where time is the longest dimension of the
    %%% song array. Since the sampling frequency is 32768 per second, you
    %%% should wait (dimension)/rate seconds.
    timeTot = length(songData)/rate;

    pause(timeTot)

    clear sound
    
    end

end
%%% Goodbye message

fprintf("Epic Tunes out!\n")