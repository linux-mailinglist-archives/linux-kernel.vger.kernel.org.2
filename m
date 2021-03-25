Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354403494EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhCYPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhCYPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616684844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdW+h3VAQThOQw07Y6OKhgA+HyJmyOTTSfSPPcXsFkY=;
        b=X9/PomG8yFZQk/32HmrbwMgp/AMeW4EF//uRfVn58AfG2vVpqdCNbyl/mChHJ9ooww1wpD
        1CPvKlhfhX6AQoovgmgh6p1SkGhLAZEBG4zAXy3VC0CB2wni0C90VE8b3zWpIF9wfNkenT
        ymJA/5tuodIt43XojPZrncvtaoWShCY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-sNkj-PMCMHqNzjmwOQZRSQ-1; Thu, 25 Mar 2021 11:07:17 -0400
X-MC-Unique: sNkj-PMCMHqNzjmwOQZRSQ-1
Received: by mail-ed1-f69.google.com with SMTP id m8so2828762edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sdW+h3VAQThOQw07Y6OKhgA+HyJmyOTTSfSPPcXsFkY=;
        b=hZ36+od5u7dN2sb3+lnuEmcfnxRBMW0eTpk6TtScNEC5iaaB+2Z0aQsVcmZv0qJ3xu
         qXS2cChBIqmqtY+74c9vPzoVcVnEbeJpaJfM9U4n1lem1yJ0yFE6LDJcQ50zqDBv7vY6
         nQ369USw0a+uMgnIh56NNw5F3SNMyJIm/Wy6ma4dniBqksoVy9VEp0kQ4+sLW9yRY6nB
         3Dmnq1hWVw2OtLpqFbrobdPIzQdI6ToP5dDKTYCw+2aN19QxxaCpiDRYjGdVut3IKgka
         UcAU9ds6ptdbeEofMOVSssaIsRQQDlYZj7OaxJVW2r68tldVknj85ypX7GI8gK2pY25F
         qSVw==
X-Gm-Message-State: AOAM5308bJqG2gfX0spHaus6NxWoBuhD3UywHuuIJD5ojHJms5Q6bxZF
        n6LnJsgkhkIaWa3pJvieVGLAGxvkOx2EmS60ClagJ3/Kjp/DMZ2D7YfrBiBZEzsBpeO0UJzB6/u
        lxiR2JzOI5tv5gtmnUAqn2g1E
X-Received: by 2002:aa7:cb97:: with SMTP id r23mr9506799edt.106.1616684835557;
        Thu, 25 Mar 2021 08:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydmbo8ZKmhunzAF9C+bbWnixIH0gXNfgg9UZR6Jx+UkTqtnCZVem1uAMv94NPAhu43ZR44SA==
X-Received: by 2002:aa7:cb97:: with SMTP id r23mr9506770edt.106.1616684835320;
        Thu, 25 Mar 2021 08:07:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id oy8sm2537376ejb.58.2021.03.25.08.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 08:07:14 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
To:     "Yuan, Perry" <Perry.Yuan@dell.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "pobrn@protonmail.com" <pobrn@protonmail.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210301093834.19524-1-Perry_Yuan@Dell.com>
 <20210308172409.GF4656@sirena.org.uk>
 <SJ0PR19MB4528847687FEEE4A4DED8E3F84659@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <604693cc-08c7-2b5f-632a-58ed537c54a0@perex.cz>
 <5cad3045-7948-3282-c999-926095818d5f@redhat.com>
 <SJ0PR19MB452851406C9B48DE688F1C1384629@SJ0PR19MB4528.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <11d7916c-5e8a-f3a2-5906-ed007ed146a3@redhat.com>
Date:   Thu, 25 Mar 2021 16:07:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB452851406C9B48DE688F1C1384629@SJ0PR19MB4528.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/25/21 3:11 PM, Yuan, Perry wrote:
> Hi Hans
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Monday, March 22, 2021 11:02 PM
>> To: Jaroslav Kysela; Yuan, Perry; Mark Brown; pierre-
>> louis.bossart@linux.intel.com; Limonciello, Mario
>> Cc: pobrn@protonmail.com; oder_chiou@realtek.com; tiwai@suse.com;
>> mgross@linux.intel.com; lgirdwood@gmail.com; alsa-devel@alsa-project.org;
>> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
>> Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control
>> supports
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Hi,
>>
>> On 3/22/21 3:37 PM, Jaroslav Kysela wrote:
>>> Dne 22. 03. 21 v 10:25 Yuan, Perry napsal(a):
>>>> Hi Mark:
>>>>
>>>>> -----Original Message-----
>>>>> From: Mark Brown <broonie@kernel.org>
>>>>> Sent: Tuesday, March 9, 2021 1:24 AM
>>>>> To: Yuan, Perry
>>>>> Cc: pobrn@protonmail.com; pierre-louis.bossart@linux.intel.com;
>>>>> oder_chiou@realtek.com; perex@perex.cz; tiwai@suse.com;
>>>>> hdegoede@redhat.com; mgross@linux.intel.com; Limonciello, Mario;
>>>>> lgirdwood@gmail.com; alsa-devel@alsa-project.org; linux-
>>>>> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
>>>>> Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state
>>>>> control supports
>>>>>
>>>>> On Mon, Mar 01, 2021 at 05:38:34PM +0800, Perry Yuan wrote:
>>>>>
>>>>>> +	/* Micmute LED state changed by muted/unmute switch */
>>>>>> +	if (mc->invert) {
>>>>>> +		if (ucontrol->value.integer.value[0] || ucontrol-
>>>>>> value.integer.value[1]) {
>>>>>> +			micmute_led = LED_OFF;
>>>>>> +		} else {
>>>>>> +			micmute_led = LED_ON;
>>>>>> +		}
>>>>>> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
>>>>>> +	}
>>>>>
>>>>> These conditionals on inversion seem weird and counterintuitive.  If
>>>>> we're going with this approach it would probably be clearer to
>>>>> define a custom operation for the affected controls that wraps the
>>>>> standard one and adds the LED setting rather than keying off invert like
>> this.
>>>>
>>>> Currently the sof soundwire driver has no generic led control yet.
>>>> This patch can handle the led control needs for MIC mute LED, definitely
>> the patch is a short term solution.
>>>> There is a feature request discussion when we started to implement this
>> solution.
>>>> https://github.com/thesofproject/linux/issues/2496#issuecomment-
>> 71389
>>>> 2620
>>>>
>>>> The workable way for now is that we put the LED mute control to the
>> codec driver.
>>>> When there is new and full sound LED solution implemented, this part will
>> be also optimized.
>>>> The Hardware privacy feature needs this patch to handle the Mic mute led
>> state change.
>>>> Before that full solution ready in kernel, could we take this as short term
>> solution?
>>>
>>> Perry, it's about the machine detection. Your code is too much generic
>>> even for the top-level LED trigger implementation. We need an extra
>>> check, if the proper LED's are really controlled on the specific
>>> hardware. Other hardware may use RT715 for a different purpose. Use
>>> DMI / ACPI checks to detect this hardware and don't misuse the inversion
>> flag to enable this code.
>>
>> I think this would be a goo candidate for the new generic LED handling:
>>
>> https://lore.kernel.org/alsa-devel/20210317172945.842280-1-
>> perex@perex.cz/
>>
>> And then use a udev-rule + hwdb and/or UCM profiles to configure the LED
>> trigger for specific models from userspace ?
>>
>> Regards,
>>
>> Hans
>>
>>
>>
> Because the SOF SDW design has no mic mute led control yet.
> So I add one short term solution to make Dell privacy working for now 
> Definitely , that is new solution I can add my patch on that to test as one user case .
> We really need to take the short term solution work for some system which support new SOF soundwire hardware which have  dependence on the MIC mute feature
> Meanwhile we can continue working on the new  "udev-rule + hwdb and/or UCM profiles" solution as to replace this one.
> If we agree that, I will submit another V6 addressing new feedback. 

The triggering of the LED trigger and the code registering the led_classdev
are in 2 separate subsystems; and should be merged separately.

If you post a new version of patch 1/2 addressing my review remarks then
I can merge that.

For merging the sound side of this you need to talk to the sound folks
(Jaroslav Kysela, Takashi Iwai, Mark Brown for files under sound/soc).

Regards,

Hans

