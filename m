Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE64348D24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCYJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:38:43 -0400
Received: from mail1.perex.cz ([77.48.224.245]:49996 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhCYJiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:38:13 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E5C64A0042;
        Thu, 25 Mar 2021 10:38:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E5C64A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1616665085; bh=m40vUxZYaBCFgv5JXNt+otVXhF33b32KBeePsOXeylE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=COtQgjIf7SS1U+9r6pyVoZgOEQL5VrPbPU+Zey6x7BDrCppwysRmKEzFt8ID44Adi
         M4+g6/8BU6wmB/hQbkC6xGXiVbQFNtdgzSBPVyBlhEvHJAUpqVYdKchaXEAT31rwoX
         ei5aRoS8LcZUzo8QVn+nzwhcJWCXg5zP/hmvTyM8=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 25 Mar 2021 10:37:52 +0100 (CET)
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
To:     "Yuan, Perry" <Perry.Yuan@dell.com>,
        Mark Brown <broonie@kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
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
 <SJ0PR19MB4528A75314336D1B756CAFE784629@SJ0PR19MB4528.namprd19.prod.outlook.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <8719e146-3606-aec7-5ba1-fceba383be51@perex.cz>
Date:   Thu, 25 Mar 2021 10:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4528A75314336D1B756CAFE784629@SJ0PR19MB4528.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 25. 03. 21 v 9:19 Yuan, Perry napsal(a):
> Hi Jaroslav:
> 
>> -----Original Message-----
>> From: Jaroslav Kysela <perex@perex.cz>
>> Sent: Monday, March 22, 2021 10:38 PM
>> To: Yuan, Perry; Mark Brown; pierre-louis.bossart@linux.intel.com;
>> Limonciello, Mario; hdegoede@redhat.com
>> Cc: pobrn@protonmail.com; oder_chiou@realtek.com; tiwai@suse.com;
>> mgross@linux.intel.com; lgirdwood@gmail.com; alsa-devel@alsa-
>> project.org; linux-kernel@vger.kernel.org; platform-driver-
>> x86@vger.kernel.org
>> Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control
>> supports
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Dne 22. 03. 21 v 10:25 Yuan, Perry napsal(a):
>>> Hi Mark:
>>>
>>>> -----Original Message-----
>>>> From: Mark Brown <broonie@kernel.org>
>>>> Sent: Tuesday, March 9, 2021 1:24 AM
>>>> To: Yuan, Perry
>>>> Cc: pobrn@protonmail.com; pierre-louis.bossart@linux.intel.com;
>>>> oder_chiou@realtek.com; perex@perex.cz; tiwai@suse.com;
>>>> hdegoede@redhat.com; mgross@linux.intel.com; Limonciello, Mario;
>>>> lgirdwood@gmail.com; alsa-devel@alsa-project.org; linux-
>>>> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
>>>> Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control
>>>> supports
>>>>
>>>> On Mon, Mar 01, 2021 at 05:38:34PM +0800, Perry Yuan wrote:
>>>>
>>>>> +	/* Micmute LED state changed by muted/unmute switch */
>>>>> +	if (mc->invert) {
>>>>> +		if (ucontrol->value.integer.value[0] || ucontrol-
>>>>> value.integer.value[1]) {
>>>>> +			micmute_led = LED_OFF;
>>>>> +		} else {
>>>>> +			micmute_led = LED_ON;
>>>>> +		}
>>>>> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
>>>>> +	}
>>>>
>>>> These conditionals on inversion seem weird and counterintuitive.  If
>>>> we're going with this approach it would probably be clearer to define
>>>> a custom operation for the affected controls that wraps the standard
>>>> one and adds the LED setting rather than keying off invert like this.
>>>
>>> Currently the sof soundwire driver has no generic led control yet.
>>> This patch can handle the led control needs for MIC mute LED, definitely
>> the patch is a short term solution.
>>> There is a feature request discussion when we started to implement this
>> solution.
>>> https://github.com/thesofproject/linux/issues/2496#issuecomment-
>> 713892
>>> 620
>>>
>>> The workable way for now is that we put the LED mute control to the
>> codec driver.
>>> When there is new and full sound LED solution implemented, this part
>> will be also optimized.
>>> The Hardware privacy feature needs this patch to handle the Mic mute
>> led state change.
>>> Before that full solution ready in kernel, could we take this as short term
>> solution?
>>
>> Perry, it's about the machine detection. Your code is too much generic even
>> for the top-level LED trigger implementation. We need an extra check, if the
>> proper LED's are really controlled on the specific hardware. Other hardware
>> may use RT715 for a different purpose. Use DMI / ACPI checks to detect this
>> hardware and don't misuse the inversion flag to enable this code.
>>
>> 						Jaroslav
>>
>> --
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> 
> In the V2 patch, I have added the machine detection, but some guys thought that I should remove the detection for it is harmless to other system
> So I remove it in the following patches.
> 
> Is it Ok for you if I add below detection of Dell system which enable the privacy feature ?
>  
> Then the mute led control will be called normally and Mic mute will be successfully configured.
> There is no any impaction to other systems.
> 
> 
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY) 
> .....
> +#endif

I think that you misunderstood the request. It's about the runtime detection
not about the compile time detection. An example for DMI check is in
sound/soc/intel/boards/sof_sdw.c / sof_sdw_quirk_table .

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
