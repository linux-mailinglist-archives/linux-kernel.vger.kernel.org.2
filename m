Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384C3321382
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBVJ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:57:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhBVJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613987735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AK4yt3E8U0Og9wDcu8xib+pli0Ob9nbDlOPFgta9TBk=;
        b=a/YhzVudTv99LZ9gg4gSToBXtqJAAjPmBAU1jVcxT8+3RgOLscn2YLuC4cgS7jkzKkxtP5
        zFrUo4ncKJjyFNlLoT4aGL4C4K6oETDlBUOotdyHBzyfpkxSD5JffovHKOlDMMczxYwWv9
        XyqzA9i5ZeTKhSwCgreBnZHf0fo9BKw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-6hSaRD1YN3SucqeLaDNJbg-1; Mon, 22 Feb 2021 04:55:33 -0500
X-MC-Unique: 6hSaRD1YN3SucqeLaDNJbg-1
Received: by mail-ed1-f70.google.com with SMTP id f11so6702405edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AK4yt3E8U0Og9wDcu8xib+pli0Ob9nbDlOPFgta9TBk=;
        b=JGiI6jNaAKuiuyknEkoUcekch2S4ge5knCZXnaA2ye5eW/le6nqRA1X0RxzrGRhbW8
         ETiyYwZY7R7Mg9PVZokXMaUWP2HheSTzSLfO62+22CAYN/OHluGrK+v/FvMqkKL0IbA9
         jswhTVaLwD5ufEOB0W5pqw3A8BQnFZTg5l60XHFGrObQf70ylLEafzxCCjegT+Cz/02j
         228TxFxHhGCBIC1sWY6zhgURZZJQ277/G1v2evj5G97SNEflyT91+FLz3wikuGox0qJ0
         Q5jZgGkVS/RE5iLNnkSarouNNzgyDhUPhfvbhhgQziqFGDxGQDgVmb1Y2YhreOjTl6tq
         iYiA==
X-Gm-Message-State: AOAM530eFekcn5nx7NCPLOKCiR4W45JaVUKK/Sibb6pCuAYbYpWb8MwN
        TXMeITfuw9V+X5Phoxy09PXMJz/TRyEk/SjE8vLW8GRVGus6Dm3AfRImQ22XceUBInpLeOU/fbX
        bwzArBmfEwquvSCdbAYYhCuqUZShq/fUWNbYfLT8zBhrp9taWBfVY57f7bYEgAW5w9332K1dbNt
        Vm
X-Received: by 2002:aa7:dd4c:: with SMTP id o12mr21177518edw.180.1613987731837;
        Mon, 22 Feb 2021 01:55:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyN4gCgnQMNNOXxqIHlj1WxFZiv+ZGViW135bVl0qWLRetXzxUzwEHBtywebPf/GAlsWXhlJw==
X-Received: by 2002:aa7:dd4c:: with SMTP id o12mr21177506edw.180.1613987731628;
        Mon, 22 Feb 2021 01:55:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k27sm10306471eje.67.2021.02.22.01.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 01:55:31 -0800 (PST)
Subject: Re: [PATCH v3 2/2] platform/x86: hp-wmi: add platform profile support
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <nVb9zC39HBbC5-iweNmNol7ymCjT4iD91ydsZVuo_Upqh2_3eVKaF1X1rbYpZGva-NyrGUW_W2uJIc5RHu1KhBGy7-ejGNYZJyRttjhJT-s=@protonmail.com>
 <20210221221339.12395-1-eliadevito@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <95419d36-78de-7804-87af-39f776d9ad51@redhat.com>
Date:   Mon, 22 Feb 2021 10:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210221221339.12395-1-eliadevito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/21 11:13 PM, Elia Devito wrote:
> Implement support for cool, balanced and performance thermal profile
> 
> Signed-off-by: Elia Devito <eliadevito@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will merge this once we are out of the merge-window / once 5.12-rc1 is out.

Regards,

Hans



> ---
> the "quiet" profile will be implemented with a further patch
> 
> v2: added platform_profile_remove() missing call
> v3: apply Barnabás suggestions
> 
>  drivers/platform/x86/hp-wmi.c | 97 +++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 6d7b91b8109b..027a1467d009 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -21,6 +21,7 @@
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/acpi.h>
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
> @@ -119,6 +120,12 @@ enum hp_wireless2_bits {
>  	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
>  };
>  
> +enum hp_thermal_profile {
> +	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
> +	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
> +	HP_THERMAL_PROFILE_COOL			= 0x02
> +};
> +
>  #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
>  #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
>  
> @@ -159,6 +166,8 @@ static const struct key_entry hp_wmi_keymap[] = {
>  
>  static struct input_dev *hp_wmi_input_dev;
>  static struct platform_device *hp_wmi_platform_dev;
> +static struct platform_profile_handler platform_profile_handler;
> +static bool platform_profile_support;
>  
>  static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
> @@ -869,11 +878,74 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
>  	return err;
>  }
>  
> -static int thermal_profile_setup(struct platform_device *device)
> +static int thermal_profile_get(void)
> +{
> +	return hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
> +}
> +
> +static int thermal_profile_set(int thermal_profile)
> +{
> +	return hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &thermal_profile,
> +							   sizeof(thermal_profile), 0);
> +}
> +
> +static int platform_profile_get(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile)
> +{
> +	int tp;
> +
> +	tp = thermal_profile_get();
> +	if (tp < 0)
> +		return tp;
> +
> +	switch (tp) {
> +	case HP_THERMAL_PROFILE_PERFORMANCE:
> +		*profile =  PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case HP_THERMAL_PROFILE_DEFAULT:
> +		*profile =  PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case HP_THERMAL_PROFILE_COOL:
> +		*profile =  PLATFORM_PROFILE_COOL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int platform_profile_set(struct platform_profile_handler *pprof,
> +				enum platform_profile_option profile)
>  {
>  	int err, tp;
>  
> -	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
> +	switch (profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		tp =  HP_THERMAL_PROFILE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		tp =  HP_THERMAL_PROFILE_DEFAULT;
> +		break;
> +	case PLATFORM_PROFILE_COOL:
> +		tp =  HP_THERMAL_PROFILE_COOL;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = thermal_profile_set(tp);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_setup(void)
> +{
> +	int err, tp;
> +
> +	tp = thermal_profile_get();
>  	if (tp < 0)
>  		return tp;
>  
> @@ -881,11 +953,23 @@ static int thermal_profile_setup(struct platform_device *device)
>  	 * call thermal profile write command to ensure that the firmware correctly
>  	 * sets the OEM variables for the DPTF
>  	 */
> -	err = hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &tp,
> -							   sizeof(tp), 0);
> +	err = thermal_profile_set(tp);
>  	if (err)
>  		return err;
>  
> +	platform_profile_handler.profile_get = platform_profile_get,
> +	platform_profile_handler.profile_set = platform_profile_set,
> +
> +	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
> +
> +	err = platform_profile_register(&platform_profile_handler);
> +	if (err)
> +		return err;
> +
> +	platform_profile_support = true;
> +
>  	return 0;
>  }
>  
> @@ -900,7 +984,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  	if (hp_wmi_rfkill_setup(device))
>  		hp_wmi_rfkill2_setup(device);
>  
> -	thermal_profile_setup(device);
> +	thermal_profile_setup();
>  
>  	return 0;
>  }
> @@ -927,6 +1011,9 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
>  		rfkill_destroy(wwan_rfkill);
>  	}
>  
> +	if (platform_profile_support)
> +		platform_profile_remove();
> +
>  	return 0;
>  }
>  
> 

