Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA93765F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhEGNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhEGNTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620393483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bc6gFYtaAautPv5s36zE7t1w1DxKhv3daqqZP7w0uFc=;
        b=J0W0vWm7CEAROOpfKdQNFG+uVw9vW03IzxpDWJe7+HCjohjAHrP/hqLq6/ctkSfSWpD2SQ
        BrBMrZ/bE1BiRd89nDXVMhKNW8YojV/1YLunv8/xhH3oG/G1q8CSQBR8PiMgQENLTUJCki
        4eyeNqOakgLYAeWWE8SlYE5D8oe60YQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-1-VPGFz5O3yJ57wfH6lKVQ-1; Fri, 07 May 2021 09:18:00 -0400
X-MC-Unique: 1-VPGFz5O3yJ57wfH6lKVQ-1
Received: by mail-ed1-f70.google.com with SMTP id g7-20020aa7c5870000b02903888f809d62so4441146edq.23
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 06:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bc6gFYtaAautPv5s36zE7t1w1DxKhv3daqqZP7w0uFc=;
        b=iO0EzvzS0a+gOjS/+vSeSlSXi+4qe22ZIxZCuup747oK54NgLpsj1rvzQ059vYiw2u
         +6xuSTwCvBx8++HR2A7kahWNwYCgPoVWlXHA16HbpFI92KJLeVRSth4mV1x1rsxQE4t0
         8kKjv8dLEFkAn8yd+lt7CPK8/loRnLq6qfGiOQJKFV5Uag3nexpNmPKLejEHVZFQiiYi
         LsajROJqAtOXZhH7ye/52G5h9xL8Lz+baQ3oAWuX6TjzWnDe0m9TeLcrGXly9d04p3xG
         ogH3LJ/1qcPu+2utWvF4xyQkHj0sK7t3ddkJUzEh74yE9ywTH+hf1Ja29eVe3dkQ+EuM
         8Lxw==
X-Gm-Message-State: AOAM531a+2YjmBo2VsTwF03kkGd7eOVK8ljQtQWenRzYf2HAZF9eciX0
        nCM4u0Fq+sK8urhco+FIHm6RPowguEeXv6DhSCe9+vgcHw420f3LbD9g1DzQFLIWhDDZ6Ce7dhZ
        sm6UpEAvNsEUCaRKrpaoGjgnR
X-Received: by 2002:a17:906:cf82:: with SMTP id um2mr10056066ejb.322.1620393479002;
        Fri, 07 May 2021 06:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9RMAbnLQQM1GfifQbHqjze/BSzkOG3iRxhRcv6/Dy2qouIy+i/Xzf+Rt2n5APZnk1bnbXJg==
X-Received: by 2002:a17:906:cf82:: with SMTP id um2mr10056039ejb.322.1620393478737;
        Fri, 07 May 2021 06:17:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q16sm4278106edv.61.2021.05.07.06.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 06:17:58 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] ASoC: rt715:add micmute led state control supports
To:     Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        pierre-louis.bossart@linux.intel.com, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mario.limonciello@outlook.com,
        Dell.Client.Kernel@dell.com
References: <20210506115626.12480-1-Perry_Yuan@Dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <050c2e9d-9510-523b-5504-10397d7ec96f@redhat.com>
Date:   Fri, 7 May 2021 15:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506115626.12480-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 5/6/21 1:56 PM, Perry Yuan wrote:
> From: Perry Yuan <perry_yuan@dell.com>
> 
> Some new Dell system is going to support audio internal micphone
> privacy setting from hardware level with micmute led state changing
> When micmute hotkey pressed by user, soft mute will need to be enabled
> firstly in case of pop noise, and codec driver need to react to mic
> mute event to EC(embedded controller) notifying that SW mute is completed
> Then EC will do the hardware mute physically within the timeout reached
> 
> This patch allow codec rt715 and rt715 sdca driver to change the local micmute
> led state. Dell privacy led trigger driver will ack EC when micmute key pressed
> through this micphone led control interface like hda_generic provided
> ACPI method defined in dell-privacy micmute led trigger will be called
> for notifying the EC that software mute has been completed, then hardware
> audio circuit solution controlled by EC will switch the audio input source off/on
> 
> Signed-off-by: Perry Yuan <perry_yuan@dell.com>

NACK, as explained before we want the binding of the control to the
LED-trigger to be done from the UCM profile.

Support for this has landed kernel-side in Linux tree now (this will
be part of 5.13-rc1). Together with the latest git alsa-lib and
alsa-utils code, you can now do what this patch does from an UCM
profile file and AFAIK that is the preferred way to do this.

See here for an example UCM profile patch implementing this:

https://lore.kernel.org/alsa-devel/20210507131139.10231-3-hdegoede@redhat.com/T/#u

Note that if you test this under Fedora you will hit a selinux denial,
to workaround that you can put selinux in permissive mode. This selinux
issue is being tracked here:

https://bugzilla.redhat.com/show_bug.cgi?id=1958210

Regards,

Hans






> 
> --------
> v7 -> v8:
> * N/A
> v6 -> v7:
> * addresed review comments from Jaroslav
> * use device id in the quirk list
> v5 -> v6:
> * add quirks for micmute led control as short term solution to control
>   micmute led state change
> * add comments for the invert checking
> v4 -> v5:
> * rebase to latest 5.12 rc4 upstream kernel
> v3 -> v4:
> * remove unused debug log
> * remove compile flag of DELL privacy
> * move the micmute_led to local from rt715_priv
> * when Jaroslav upstream his gerneric LED trigger driver,I will rebase
>   this patch,please consider merge this at first
>   https://lore.kernel.org/alsa-devel/20210211111400.1131020-1-perex@perex.cz/
> v2 -> v3:
> * simplify the patch to reuse some val value
> * add more detail to the commit info
> v1 -> v2:
> * fix some format issue
> --------
> ---
>  sound/soc/codecs/rt715-sdca.c | 42 +++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/rt715.c      | 42 +++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
> index 936e3061ca1e..de46514e0207 100644
> --- a/sound/soc/codecs/rt715-sdca.c
> +++ b/sound/soc/codecs/rt715-sdca.c
> @@ -11,12 +11,14 @@
>  #include <linux/moduleparam.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/leds.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> +#include <linux/dmi.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -344,6 +346,32 @@ static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
>  	return 0;
>  }
>  
> +static bool micmute_led_set;
> +static int  dmi_matched(const struct dmi_system_id *dmi)
> +{
> +	micmute_led_set = 1;
> +	return 1;
> +}
> +
> +/* Some systems will need to use this to trigger mic mute LED state changed */
> +static const struct dmi_system_id micmute_led_dmi_table[] = {
> +	{
> +		.callback = dmi_matched,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "0A32"),
> +		},
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "0A3E"),
> +		},
> +	},
> +	{},
> +};
> +
>  static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>  	struct snd_ctl_elem_value *ucontrol)
>  {
> @@ -358,6 +386,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>  	unsigned int mask = (1 << fls(max)) - 1;
>  	unsigned int invert = p->invert;
>  	int err;
> +	bool micmute_led;
>  
>  	for (i = 0; i < 4; i++) {
>  		if (ucontrol->value.integer.value[i] != rt715->kctl_switch_orig[i]) {
> @@ -394,6 +423,18 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>  			return err;
>  	}
>  
> +	/* Micmute LED state changed by muted/unmute switch
> +	 * to keep syncing with actual hardware mic mute led state
> +	 * invert will be checked to change the state switch
> +	 */
> +	if (invert && micmute_led_set) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1])
> +			micmute_led = LED_OFF;
> +		else
> +			micmute_led = LED_ON;
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
> +	}
> +
>  	return k_changed;
>  }
>  
> @@ -1069,6 +1110,7 @@ int rt715_sdca_io_init(struct device *dev, struct sdw_slave *slave)
>  
>  	pm_runtime_mark_last_busy(&slave->dev);
>  	pm_runtime_put_autosuspend(&slave->dev);
> +	dmi_check_system(micmute_led_dmi_table);
>  
>  	return 0;
>  }
> diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
> index 1352869cc086..4dbd870009b8 100644
> --- a/sound/soc/codecs/rt715.c
> +++ b/sound/soc/codecs/rt715.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/leds.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm.h>
>  #include <linux/soundwire/sdw.h>
> @@ -25,6 +26,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_device.h>
> +#include <linux/dmi.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -70,6 +72,32 @@ static void rt715_get_gain(struct rt715_priv *rt715, unsigned int addr_h,
>  		pr_err("Failed to get L channel gain.\n");
>  }
>  
> +static bool micmute_led_set;
> +static int  dmi_matched(const struct dmi_system_id *dmi)
> +{
> +	micmute_led_set = 1;
> +	return 1;
> +}
> +
> +/* Some systems will need to use this to trigger mic mute LED state changed */
> +static const struct dmi_system_id micmute_led_dmi_table[] = {
> +	{
> +		.callback = dmi_matched,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "0A32"),
> +		},
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "0A3E"),
> +		},
> +	},
> +	{},
> +};
> +
>  /* For Verb-Set Amplifier Gain (Verb ID = 3h) */
>  static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
>  					struct snd_ctl_elem_value *ucontrol)
> @@ -83,6 +111,7 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
>  	unsigned int addr_h, addr_l, val_h, val_ll, val_lr;
>  	unsigned int read_ll, read_rl, i;
>  	unsigned int k_vol_changed = 0;
> +	bool micmute_led;
>  
>  	for (i = 0; i < 2; i++) {
>  		if (ucontrol->value.integer.value[i] != rt715->kctl_2ch_vol_ori[i]) {
> @@ -155,6 +184,18 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
>  			break;
>  	}
>  
> +	/* Micmute LED state changed by muted/unmute switch
> +	 * to keep syncing with actual hardware mic mute led state
> +	 * invert will be checked to change the state switch
> +	 */
> +	if (micmute_led_set) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1])
> +			micmute_led = LED_OFF;
> +		else
> +			micmute_led = LED_ON;
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
> +	}
> +
>  	/* D0:power on state, D3: power saving mode */
>  	if (dapm->bias_level <= SND_SOC_BIAS_STANDBY)
>  		regmap_write(rt715->regmap,
> @@ -1088,6 +1129,7 @@ int rt715_io_init(struct device *dev, struct sdw_slave *slave)
>  
>  	pm_runtime_mark_last_busy(&slave->dev);
>  	pm_runtime_put_autosuspend(&slave->dev);
> +	dmi_check_system(micmute_led_dmi_table);
>  
>  	return 0;
>  }
> 

