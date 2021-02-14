Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51AD31AF7A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 07:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBNGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 01:43:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03438C061574;
        Sat, 13 Feb 2021 22:43:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so4844319wmq.4;
        Sat, 13 Feb 2021 22:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aUQN0SZkwCC+2sHkMRBo4eVveaM2m59ClyPi/TCSgJI=;
        b=lONEfYJPUrLz5RDAOZS2qSR+fbN2nlHvin68WfMaf3E1IJ6M+G1Z555jS9N+iasaNg
         /Tb06GEyFyOySORkE3gJcvZDr8Bjg8W5Yf3uklS7Sz5MTc9uMjsn6a/TBwzoCLs7eDEu
         7K+gkflquhfbVj3SMqZxT5V895G8rCuSZU0O7jgJHeT/pukTeFrsVARPWOytTUpVjcAa
         YlTmMFNqpJrihrpuUbyq3n2Cs5DB2Xs4235iMQJVkezstXUe1ikd612BSYn+32wgzF31
         9Zc4dLs6ITH8eqBVO8m8Ng7mNvNTog73Codg88VC3xA4dq0E69wbLBjJ5NfgJEWwIFPj
         zG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aUQN0SZkwCC+2sHkMRBo4eVveaM2m59ClyPi/TCSgJI=;
        b=KjRwA1NgOP3i0iQkjvvT5BaT/0z2+h1AYmElsntGhnL94inpT20dnU0IkC5/+0R9BX
         6wZn9tUSiRYy+s5Fl8ukyKz/O6t3g5cUzR5wASVgixxDNb3KuJu0hGIK09pNny/O0VBc
         Yg6rf44YEc67sHsfT8BPXlSlstEPzhxWU9lCe+G9FoMhPhGI6OVwzey4n3WkuOOhZofZ
         Vsyh6T9PJAETZTKt5GW66iXudFZKHYoZhDXYoZ20Zc4Xzs+UM+o16M+9jOMSYrOq6AyN
         QK41t680eOESVIbMOzRsZZfmS9YaOO/Vm5tf7y6nWauJfNV/6v4pBBrKhbmZ3PSFMrXA
         Y+rw==
X-Gm-Message-State: AOAM533KHvf3C0ZVqHN7uimlm9fpIJjUtVDN9wNj3pYEAOnkrbHPcNvW
        kqCGAUh+gHo6TTYNEg6+uQ0=
X-Google-Smtp-Source: ABdhPJxUwqq6xODqw/+vkq1hdQjPuAD84Fy0EPAcABxWLmYvuBqPgDfL8/4lq97lUQETtqDhXSwU8g==
X-Received: by 2002:a7b:c355:: with SMTP id l21mr9283477wmj.61.1613284982503;
        Sat, 13 Feb 2021 22:43:02 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id f14sm20469280wmc.32.2021.02.13.22.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 22:43:02 -0800 (PST)
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
To:     Mark Brown <broonie@kernel.org>, Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
 <20210112175406.GF4646@sirena.org.uk>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <6d705d1e-9fe2-86fa-4c6a-270bf6039a3f@gmail.com>
Date:   Sun, 14 Feb 2021 14:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210112175406.GF4646@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark:
Thanks for your review.

On 2021/1/13 1:54, Mark Brown wrote:
> On Wed, Jan 13, 2021 at 01:18:14AM +0800, Perry Yuan wrote:
> 
>> Some new Dell system is going to support audio internal micphone
>> privacy setting from hardware level with micmute led state changing
>> When micmute hotkey pressed by user, soft mute will need to be enabled
>> firstly in case of pop noise, and codec driver need to react to mic
>> mute event to EC(embedded controller) notifying that SW mute is completed
>> Then EC will do the hardware mute physically within the timeout reached
> 
>> This patch allow codec rt715 driver to ack EC when micmute key pressed
>> through this micphone led control interface like hda_generic provided
>> ACPI method defined in dell-privacy micmute led trigger will be called
>> for notifying the EC that software mute has been completed
> 
> It feels like there's an abstraction problem here with this being hard
> coded in a specific CODEC driver.
> 
>>   #include <linux/soundwire/sdw.h>
>> @@ -244,6 +245,7 @@ static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
>>   	unsigned int max = mc->max;
>>   	int val;
>>   
>> +	pr_err("++++++rt715_sdca_get_volsw++\n");
>>   	val = snd_soc_component_read(component, mc->reg);
>>   	if (val < 0)
>>   		return -EINVAL;
> 
> This shouldn't be in the patch.
Removed in V4, I forget to clear this debug code
> 
>> @@ -287,6 +291,18 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>>   			return err;
>>   	}
>>   
>> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
>> +	/* dell privacy LED trigger state changed by muted/unmute switch */
>> +	if (mc->invert) {
>> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
>> +			rt715->micmute_led = LED_OFF;
>> +		} else {
>> +			rt715->micmute_led = LED_ON;
>> +		}
>> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led);
>> +	}
>> +#endif
>> +
> 
> This doesn't look good.  There's nothing Dell specific here, and nothing
> about this is conditional on any sort of runtime detection of Dell
> systems, it's not obvious why this is conditional on DELL_PRIVACY or why
> we only report the state if the control is inverted.
> 
I will remove the CONFIG_DELL_PRIVACY from V4 patch and allow it to run 
if CONFIG_DELL_PRIVACY is not set, the result will be a no-op.
> I'm also not convinced that it's a good idea to set the mute LED if only
> one channel in a stereo microphone is muted, that seems likely to lead
> to surprising behaviour for users.
> 
https://github.com/thesofproject/linux/pull/2660#discussion_r555480210
There is a discussion for the channel mute changing behavior.
If the anyone of value[0] or value[1] is 1, it means mic is NOT muted
The muted state will be LED_ON state need to set.

> TBH I don't understand why this isn't being done in generic code.
> 
>> +	bool micmute_led;
> 
> What is this for, it never seems to be read except for in the function
> where it's set?
> 

I have moved this part code to the local definition of 
rt715_set_amp_gain_put and removed from rt715_priv.
new code will be like this in V4.

@@ -88,6 +89,7 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol 
*kcontrol,
                 RT715_SET_GAIN_MIX_ADC2_L};
         unsigned int addr_h, addr_l, val_h, val_ll, val_lr;
         unsigned int read_ll, read_rl, i, j, loop_cnt;
+       bool micmute_led;

