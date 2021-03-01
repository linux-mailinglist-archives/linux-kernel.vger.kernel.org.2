Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F053281B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhCAPDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:03:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:39889 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236851AbhCAPDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:03:05 -0500
IronPort-SDR: oLA0531zfjrUboNNaCIp5295ZbxgKSFm+onVHJwpJ/hZ1zqWIp22E3MBmU2EJirbn77bNcmWp4
 JDFGtXkPlbTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166365396"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="166365396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:01:17 -0800
IronPort-SDR: KF2Avy2eAS2o+2sJug2/wUSV6fRdMARwcncPBqSE1narCLlG0Cy5Zn+D7vvtgZ4/eAXWhdx5y9
 4Fo+iBBVVCFA==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="406256458"
Received: from jli125-mobl.gar.corp.intel.com (HELO [10.255.229.226]) ([10.255.229.226])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:01:16 -0800
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
To:     Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210301093834.19524-1-Perry_Yuan@Dell.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <98d8b015-c1d6-fd4c-ac94-3f9226b93436@linux.intel.com>
Date:   Mon, 1 Mar 2021 08:30:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301093834.19524-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/21 3:38 AM, Perry Yuan wrote:
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
> 
> --------
> v3 -> v4:
> * remove unused debug log
> * remove compile flag of DELL privacy
> * move the micmute_led to local from rt715_priv
> * when Jaroslav upstream his gerneric LED trigger driver,I will rebase
>    this patch,please consider merge this at first
>    https://lore.kernel.org/alsa-devel/20210211111400.1131020-1-perex@perex.cz/
> v2 -> v3:
> * simplify the patch to reuse some val value
> * add more detail to the commit info
> v1 -> v2:
> * fix some format issue
> --------
> ---
>   sound/soc/codecs/rt715-sdca.c | 12 ++++++++++++

that file is not yet in Mark Brown's tree, so that patch wouldn't apply.

>   sound/soc/codecs/rt715.c      | 12 ++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
> index b43ac8559e45..816348ae11a1 100644
> --- a/sound/soc/codecs/rt715-sdca.c
> +++ b/sound/soc/codecs/rt715-sdca.c
> @@ -12,6 +12,7 @@
>   #include <linux/version.h>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> +#include <linux/leds.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pm.h>
>   #include <linux/soundwire/sdw.h>
> @@ -269,6 +270,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>   	unsigned int reg = mc->reg;
>   	unsigned int max = mc->max;
>   	int err;
> +	bool micmute_led;
>   
>   	val = ucontrol->value.integer.value[0];
>   	if (invert)
> @@ -287,6 +289,16 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>   			return err;
>   	}
>   
> +	/* Micmute LED state changed by muted/unmute switch */
> +	if (mc->invert) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
> +			micmute_led = LED_OFF;
> +		} else {
> +			micmute_led = LED_ON;
> +		}
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
> index cdcba70146da..db2c0d2ff9d2 100644
> --- a/sound/soc/codecs/rt715.c
> +++ b/sound/soc/codecs/rt715.c
> @@ -13,6 +13,7 @@
>   #include <linux/init.h>
>   #include <linux/delay.h>
>   #include <linux/i2c.h>
> +#include <linux/leds.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pm.h>
>   #include <linux/soundwire/sdw.h>
> @@ -88,6 +89,7 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
>   		RT715_SET_GAIN_MIX_ADC2_L};
>   	unsigned int addr_h, addr_l, val_h, val_ll, val_lr;
>   	unsigned int read_ll, read_rl, i, j, loop_cnt;
> +	bool micmute_led;
>   
>   	if (strstr(ucontrol->id.name, "Main Capture Switch") ||
>   		strstr(ucontrol->id.name, "Main Capture Volume"))
> @@ -95,6 +97,16 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
>   	else
>   		loop_cnt = 1;
>   
> +	/* Micmute LED state changed by muted/unmute switch */
> +	if (mc->invert) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
> +			micmute_led = LED_OFF;
> +		} else {
> +			micmute_led = LED_ON;
> +		}
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
> +	}
> +
>   	for (j = 0; j < loop_cnt; j++) {
>   		/* Can't use update bit function, so read the original value first */
>   		if (loop_cnt == 1) {
> 
