Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A143BACA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhJZTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbhJZTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:31:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2890C061570;
        Tue, 26 Oct 2021 12:29:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q124so149012oig.3;
        Tue, 26 Oct 2021 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/DsGp68guXlSIqkqaJmSVVnWQHHvWYZ3U4rjyZZAqEU=;
        b=SA5TCGPavR5bxhLLTKmTD4lY3ylQPGGavzCWLEVGbRmSxgZZ3bZF8OW5cM8c/nDrA9
         ZSrhgAilyVDySP49S+o9mTegv+rDLnp2C3Qrp13KSoJQQ7BR9y1tDvvnd8bbuuoop+Vh
         8JesDnElLmJkyAno+vQjteObERgUgaF/ku7JnoHB8GeRe9h3g/WgcylrnAK6UwphC+md
         +8TnLfAoMt3jf14R4X+Kdj5M/F9G8Fb0t5/LDyMKmO/XaUgw8TYPV+QCnG1bKcpEC3S4
         f7wL4onsLTgnPGJHsEL7+lDXi5Yn6TCY3ufmkxLTC0iEDm62DE2GH8JPHcmB6uoPiYq9
         qmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/DsGp68guXlSIqkqaJmSVVnWQHHvWYZ3U4rjyZZAqEU=;
        b=gqAe7JYu2t2xDjuPlUqvQRqcLUB4wRmsZ3vv9FKdeThv4NeGkXsDVzj9IQSUt76CxH
         agMhIgwCZT9hyueJ4/uDtO6uEb1AHLw2h60uz1IO2EVdKt4enNARCDolOF8Hucd6dWcP
         EalinLahq56iUtRsLr9LDi3L8HtJYDPKy+2d30xZm+vwiGuIp6fN1Di1P0JXZT71J/NG
         OUeLzTuuG6zq6R7ck4bboicKxN5JI66xnNsPTLcvWBV9Gef59t1Vvck5PONOV0IzXupb
         cqRF9oYZfeTCU3sFze3y3JhJaH2Mb8IqoVQ1dlKIHGP1HuwQX9UXl6jEAjmdBArlftQe
         /VrA==
X-Gm-Message-State: AOAM533GhfDCfJbbAOvT0Qn9OO4i6+qklDbMudj6zUjUVnLdsc69PlSI
        t5u7Wj4eESDP9htv63UW54zKx1XHQTo=
X-Google-Smtp-Source: ABdhPJxMN4s+93ffEnlYkHYyyqOnevPfNwsTl5wXlqa2ukfKOM5SQkebRBTd0bL+IzhNquYIy5i2NA==
X-Received: by 2002:a05:6808:1597:: with SMTP id t23mr552562oiw.78.1635276561999;
        Tue, 26 Oct 2021 12:29:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s20sm5466777oiw.17.2021.10.26.12.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 12:29:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [RFC] hwmon: (dell-smm) Allow for specifying fan control commands
 as module params
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211026171821.25944-1-W_Armin@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c0084820-6e4b-8a76-6220-5262774a8f69@roeck-us.net>
Date:   Tue, 26 Oct 2021 12:29:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026171821.25944-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 10:18 AM, Armin Wolf wrote:
> Right now, the only way to test if setting manual/auto fan control works
> is to edit and recompile the module, which might not be possible for
> everyone. Allow for specifying the necessary SMM commands when loading
> the module, but taint the kernel if so since those commands might
> cause strange side effects. Also update kernel-parameters.txt
> accordingly.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

As far as I can see there are three logical changes in this patch:
- move parameters from i8k to dell_smm_hwmon
- add documentation for undocumented parameters
- add new parameters

"One patch per logical change", please, as documented.

Thanks,
Guenter

> ---
>   .../admin-guide/kernel-parameters.txt         | 45 ++++++++++++++-----
>   Documentation/hwmon/dell-smm-hwmon.rst        | 27 ++++++++---
>   drivers/hwmon/dell-smm-hwmon.c                | 22 +++++++--
>   3 files changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..7025f5bf625f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -940,6 +940,40 @@
>   			dump out devices still on the deferred probe list after
>   			retrying.
> 
> +	dell_smm_hwmon.ignore_dmi=
> +			[HW] Continue probing hardware even if DMI data
> +                        indicates that the driver is running on unsupported
> +                        hardware.
> +
> +        dell_smm_hwmon.force=
> +			[HW] Activate driver even if SMM BIOS signature does
> +			not match list of supported models or certain
> +			features are disabled.
> +
> +        dell_smm_hwmon.power_status=
> +                        [HW] Report power status in /proc/i8k
> +                        (disabled by default).
> +
> +        dell_smm_hwmon.restricted=
> +			[HW] Allow controlling fans only if SYS_ADMIN
> +                        capability is set.
> +
> +	dell_smm_hwmon.fan_mult=
> +			[HW] Factor to multiply fan speed with.
> +
> +	dell_smm_hwmon.fan_max=
> +			[HW] Maximum configurable fan speed.
> +
> +	dell_smm_hwmon.manual_fan=
> +			[HW] SMM command to disable BIOS fan control, must be
> +			set together with dell_smm_hwmon.auto_fan to work.
> +			This can be dangerous, yet let us know if a certain
> +			command combination worked.
> +
> +	dell_smm_hwmon.auto_fan=
> +			[HW] SMM command to enable BIOS fan control, see
> +			dell_smm_hwmon.manual_fan for further explaination.
> +
>   	dfltcc=		[HW,S390]
>   			Format: { on | off | def_only | inf_only | always }
>   			on:       s390 zlib hardware support for compression on
> @@ -1693,17 +1727,6 @@
> 
>   	i810=		[HW,DRM]
> 
> -	i8k.ignore_dmi	[HW] Continue probing hardware even if DMI data
> -			indicates that the driver is running on unsupported
> -			hardware.
> -	i8k.force	[HW] Activate i8k driver even if SMM BIOS signature
> -			does not match list of supported models.
> -	i8k.power_status
> -			[HW] Report power status in /proc/i8k
> -			(disabled by default)
> -	i8k.restricted	[HW] Allow controlling fans only if SYS_ADMIN
> -			capability is set.
> -
>   	i915.invert_brightness=
>   			[DRM] Invert the sense of the variable that is used to
>   			set the brightness of the panel backlight. Normally a
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index beec88491171..df12dce7b02e 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -67,13 +67,13 @@ for your hardware. It is possible that codes that work for other
>   laptops actually work for yours as well, or that you have to discover
>   new codes.
> 
> -Check the list ``i8k_whitelist_fan_control`` in file
> -``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
> -attempt you can try to add your machine and use an already-known code
> -pair. If, after recompiling the kernel, you see that ``pwm1_enable``
> -is present and works (i.e., you can manually control the fan speed),
> -then please submit your finding as a kernel patch, so that other users
> -can benefit from it. Please see
> +Check the list ``i8k_fan_control_data`` in file
> +``drivers/hwmon/dell-smm-hwmon.c`` inside the kernel tree:
> +as a first attempt you can load the module with ``manual_fan`` and
> +``auto_fan`` set to an already-known code pair. If you see that
> +``pwm1_enable`` is present and works (i.e., you can manually control
> +the fan speed), then please submit your finding as a kernel patch,
> +so that other users can benefit from it. Please see
>   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>   for information on submitting patches.
> 
> @@ -120,6 +120,19 @@ Module parameters
>                      Maximum configurable fan speed. (default:
>                      autodetect)
> 
> +* manual_fan:uint
> +                   SMM code to disable BIOS fan control, must
> +                   be set together with auto_fan to work.
> +                   Please note that this parameter is unsafe and
> +                   will taint your kernel when set, use only for
> +                   testing codes on your hardware!
> +                   (default: retrieved from whitelist)
> +
> +* auto_fan:uint
> +                   SMM command to enable BIOS fan control, see
> +                   manual_fan for further explaination.
> +                   (default: retrieved from whitelist)
> +
>   Legacy ``/proc`` interface
>   --------------------------
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index eaace478f508..4257aa297d7a 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -111,6 +111,14 @@ static uint fan_max;
>   module_param(fan_max, uint, 0);
>   MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autodetect)");
> 
> +static uint manual_fan;
> +module_param_unsafe(manual_fan, uint, 0);
> +MODULE_PARM_DESC(manual_fan, "SMM command to disable BIOS fan control (default: disabled)");
> +
> +static uint auto_fan;
> +module_param_unsafe(auto_fan, uint, 0);
> +MODULE_PARM_DESC(auto_fan, "SMM command to enable BIOS fan control (default: disabled)");
> +
>   struct smm_regs {
>   	unsigned int eax;
>   	unsigned int ebx __packed;
> @@ -700,7 +708,7 @@ static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor_types
> 
>   			break;
>   		case hwmon_pwm_enable:
> -			if (data->auto_fan)
> +			if (data->auto_fan && data->manual_fan)
>   				/*
>   				 * There is no command for retrieve the current status
>   				 * from BIOS, and userspace/firmware itself can change
> @@ -1305,12 +1313,20 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>   	data->i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>   	data->i8k_pwm_mult = DIV_ROUND_UP(255, data->i8k_fan_max);
> 
> +	/* Values specified in module parameters override values from dmi */
>   	fan_control = dmi_first_match(i8k_whitelist_fan_control);
>   	if (fan_control && fan_control->driver_data) {
>   		const struct i8k_fan_control_data *control = fan_control->driver_data;
> 
> -		data->manual_fan = control->manual_fan;
> -		data->auto_fan = control->auto_fan;
> +		if (!manual_fan)
> +			manual_fan = control->manual_fan;
> +
> +		if (!auto_fan)
> +			auto_fan = control->auto_fan;
> +	}
> +	if (manual_fan && auto_fan) {
> +		data->manual_fan = manual_fan;
> +		data->auto_fan = auto_fan;
>   		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan control\n");
>   	}
> 
> --
> 2.30.2
> 

