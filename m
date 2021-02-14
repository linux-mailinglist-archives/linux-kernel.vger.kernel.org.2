Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52731AF7C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 07:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBNGoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 01:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhBNGoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 01:44:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9525C061756;
        Sat, 13 Feb 2021 22:43:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n4so1817951wrx.1;
        Sat, 13 Feb 2021 22:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aUQN0SZkwCC+2sHkMRBo4eVveaM2m59ClyPi/TCSgJI=;
        b=h/mDIbriPlQZGWb9Eb+iLQ2zUlvMmcy9awHJpqDHlnzTnWOsQH0vqNZO0tg7gvYlh3
         h1HoSIjmKogwHw8RFpjBJ7uocWEfbdZjB1koiQq6K76Qh8VztTJUIE0XDc3dVr3bDXvB
         Qvr8BMnXtxJCREViPxKu4XP4vecJXZaj9I0dv1Nn/mzvM8XGc91//KKyg9RTyvDAYjgj
         iqDAUkXf4jncjNS8Pqr9fGbDuFGrAssQYNlIR/K8zW7W+rL9+EEmKdg0yCPavKc30FCK
         GPt3DR3382ijOTCvAEqAyCDomOVT6W889vWolxIP2H+Saoq5w9y1TvNITlaZ/TnqXhPK
         mJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aUQN0SZkwCC+2sHkMRBo4eVveaM2m59ClyPi/TCSgJI=;
        b=hngI7kOwJYAtoS3hwBTOZLOBSr/+aB5e6WYK3okjwMWHc1aUdsUXIvAdWAmbdMutTU
         uTueMrBkTT40E4QRdquXl4oqLP+1wQ+hUsIbmiPmXAgXtumSRAw9pXi/0JI2PzpPNFY4
         nPf37jrRhQjIF2kEajW+R4FdUz/cI+gahLP0rNg7HzcKAxx3V8OUO/8ev8sbxwNCJfen
         ViaOW+60pofap6Wl0lp1fbYDp5vKmvZagHUi70xBwvoi0bmG0gG0Mwo/oYYgj+z2arwA
         DRA4I7QUwuZO5RpZNXn2tPodfw7dz+2KsWMipgtCmSfTQQ8p29NOlMdcGUXQyqJBLCeJ
         ZzgA==
X-Gm-Message-State: AOAM531B3DlI9500FGANGciOF7Wc8UU5CPkl4QoDRJUFNdAZGHnRxxAd
        rYh6xfA7DzgqDHaX9NaO/5DpMgrvfBAppOEHq+Y=
X-Google-Smtp-Source: ABdhPJzLImN7rJllYpBrWPP1f3SYUf5vt7xMMJv7VCxJ7SlRdTVlcugQRaTGfUIvH4oKVMuw12jVhg==
X-Received: by 2002:a5d:4849:: with SMTP id n9mr12536800wrs.159.1613285001726;
        Sat, 13 Feb 2021 22:43:21 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id z15sm4013712wrs.72.2021.02.13.22.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 22:43:21 -0800 (PST)
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
To:     Mark Brown <broonie@kernel.org>, Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
 <20210112175406.GF4646@sirena.org.uk>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <43507ba7-74b8-2d18-57ca-271f89a752de@gmail.com>
Date:   Sun, 14 Feb 2021 14:43:10 +0800
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

