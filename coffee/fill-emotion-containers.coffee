fillAllEmotionContainers = ->
    fillInvididualEmotionContainers()
    fillCommunityEmotionContainers()

fillInvididualEmotionContainers = ->
    emotionContainerHTML = 
        "<div class='oneEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/frustrated.jpg' alt='frustated' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/unchallenged.jpg' alt='unchallenged' class='secondEmotion' />
            </div>
            <select class='emotionSelect'>
              <option value='extremely frustrated'>Extremely Frustrated</option>
              <option value='very frustrated'>Very Frustrated</option>
              <option value='frustrated'>Frustrated</option>
              <option value='quite frustrated'>Quite Frustrated</option>
              <option value='slightly frustrated'>Slightly Frustrated</option>
              <option value='neutral' selected='selected'>Neutral</option>
              <option value='slightly unchallenged'>Slightly Unchallenged</option>
              <option value='quite unchallenged' >Quite Unchallenged</option>
              <option value='unchallenged'>Unchallenged</option>
              <option value='very unchallenged'>Very Unchallenged</option>
              <option value='extremely unchallenged'>Extremely Unchallenged</option>
            </select>
        </div>
        <div class='oneEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/bored.jpg' alt='bored' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/excited.jpg' alt='excited' class='secondEmotion' />
            </div>
            
            <select class='emotionSelect'>
              <option value='extremely bored'>Extremely Bored</option>
              <option value='very bored'>Very Bored</option>
              <option value='bored'>Bored</option>
              <option value='quite bored'>Quite Bored</option>
              <option value='slightly bored'>Slightly Bored</option>
              <option value='neutral' selected='selected'>Neutral</option>
              <option value='slightly excited'>Slightly Excited</option>
              <option value='quite excited' >Quite Excited</option>
              <option value='excited'>Excited</option>
              <option value='very excited'>Very Excited</option>
              <option value='extremely excited'>Extremely Excited</option>
            </select>
        </div>
        "
    $('.emotionContainer').html(emotionContainerHTML)

fillCommunityEmotionContainers = ->
    emotionContainerHTML = 
        "<div class='communityEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/frustrated.jpg' alt='frustated' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/unchallenged.jpg' alt='unchallenged' class='secondEmotion' />
            </div>
        </div>
        <div class='communityEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/bored.jpg' alt='bored' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/excited.jpg' alt='excited' class='secondEmotion' />
            </div>
        </div>
        "
    $('.communityEmotionContainer').html(emotionContainerHTML)

addSlidersToEmotionContainers = ->
    selectForms = $('select.emotionSelect')
    for selectForm in selectForms
        $(selectForm).selectToUISlider({labels: 0}).hide()

setupSlidersToChangePicturesOnChange = ->
    $(".ui-slider").on( "slide slidechange", (event, ui) ->
        emotionPictures = getTwoCorrespondingPicturesOfSlider(ui.handle)
        setSizeOfEmotionPictures(emotionPictures, ui.value)
    )
    $('.ui-slider').slider("option", "value", 5);

getTwoCorrespondingPicturesOfSlider = (sliderElement) ->
    return $(sliderElement).parent().parent().find('.emotionPictures img')

setSizeOfEmotionPictures = (emotionPictures, sliderValue) ->
    firstOpacity = 1 - (sliderValue / 10)
    secondOpacity = sliderValue / 10
    $(emotionPictures).filter('.firstEmotion').css('opacity', firstOpacity)
    $(emotionPictures).filter('.secondEmotion').css('opacity', secondOpacity)

sendEmotionsOnSubmitButtonClick = ->
    $('#submitFeelings').click(sendEmotions)

sendEmotions = ->
    emotionStateArray = getEmotionStateArray()
    sendEmotionStateArray(emotionStateArray)

getEmotionStateArray = ->
    emotionPictures = $('.oneEmotion .emotionPictures img.firstEmotion')
    opacityArray = []
    for emotionPicture in emotionPictures
        opacityArray.push(parseFloat($(emotionPicture).css('opacity')))
    return opacityArray

sendEmotionStateArray = (emotionStateArray) ->
    $.ajax ({
            url: 'http://zukunfts-management.de/emotional-social-learning/php/submitEmotionState.php'
            data: {
                emotionState: JSON.stringify(emotionStateArray)
            }
            dataType: "jsonp"
        }
    # jsonp resposne will call emotion state updated with emotion state array :)
    )

window.emotionStateUpdated = (newEmotionState) ->
    window.showEmotionState(newEmotionState)

getEmotionStateOfEverybodyAndShowIt = ->
    $.ajax ({
            url: 'http://zukunfts-management.de/emotional-social-learning/php/getEmotionState.php'
            dataType: "jsonp"
        }
    ) 
    # jsonp resposne will call showEmotionState with emotion state array :) 
    
window.showEmotionState = (emotionStateObject) ->
    emotionStateArray = emotionStateObject.emotionStateArray
    numberOfSubmissions = emotionStateObject.numberOfSubmissions
    emotionPictures = $('.communityEmotion img')
    emotionPictures.each( (index, element) ->
        firstEmotionOpacity = (emotionStateArray[Math.floor(index / 2)] / numberOfSubmissions)
        if ($(element).is('.firstEmotion'))
            opacity = firstEmotionOpacity
        else 
            opacity = 1 - firstEmotionOpacity
        $(element).css('opacity', opacity)
    )

fillAllEmotionContainers()
addSlidersToEmotionContainers()
setupSlidersToChangePicturesOnChange()
sendEmotionsOnSubmitButtonClick()
getEmotionStateOfEverybodyAndShowIt()