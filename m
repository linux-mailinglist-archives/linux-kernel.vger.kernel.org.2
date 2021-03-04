Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC5632D428
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbhCDN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241276AbhCDN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614864401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2kgzCDzJBnOwlfEuzuqiVgYC23L9oOT+TkY8j2SMrQ=;
        b=b91NivBuQizBl91dIqvcIS+NDQ60hvkzOgJt3vYINtKGBK9G4Bag4wXSxHvgMWsXCl9bhN
        9k+oXs4eV8glGINnPowJKq5Orq8cn0dXTWoN0H/N7JEHp8rXRQTChtjpD9wJ7n+sHPVgfL
        5soTE82QblDjmgUT7jXbQje8OoHQN04=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-CyFMg5ZxOemUbKSSB6XxCA-1; Thu, 04 Mar 2021 08:26:35 -0500
X-MC-Unique: CyFMg5ZxOemUbKSSB6XxCA-1
Received: by mail-ej1-f69.google.com with SMTP id p8so5941151ejl.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:26:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2kgzCDzJBnOwlfEuzuqiVgYC23L9oOT+TkY8j2SMrQ=;
        b=j9Y6Pe75bAz1qHy/TeBoJhUaDejfsJlPiJmZ6T0MOblc1G4IhXMLIqON+8e9rSegWt
         c8/LzVydVCsQlYfNcTxVYIegvrFSGA2jkVWJ/q0OJOmOlfEwytyTrUNKh0E5RJOaoJM7
         1FrN/v7EpBdU6lvDDtjpYEKhQ+gIeDRc6LlI4Uon5FStpmyjk/TYQ7o0Kzs4bdU/y939
         9s2TFS1RnCfFdOHjMhx9B1ZzElwC7e0W8vC7Y8LGmo+oP7sk18gUlst/T2HbTKFOaUhL
         0fZNRmkA3zopONWIn+PIIbXEQtWpMAeGOpV9CR4bSoTxLqRmEf+yrBvcd0oNqPKRZ248
         9f/w==
X-Gm-Message-State: AOAM530++zmTyALH7uzYwza9AmDuKWPbRqwfrRvEO0vCtpiiecgNRdiH
        dpcaSFsF/9aYR1lVA+L2nl2i/rLdeXQ4XsvpCJcV8cbCH0QVyL3qBTzzGTTpmXKAs56UP2cthuT
        dPjXsiwg0pi3C0rOFgdFcfkaTL1ZFLjYIMWJ0PkxaoUpx9nz5niVqJ3hrAz67ykcWCGRG3N4AjV
        lB
X-Received: by 2002:a17:906:8408:: with SMTP id n8mr4107755ejx.152.1614864393628;
        Thu, 04 Mar 2021 05:26:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvcBUb2v3ZTdyfJlSiDJ+vJVf3ql5spX5kk+5B7sPZ0l6gbyFxTAVvccE+Jcbzo6Tsye0TPg==
X-Received: by 2002:a17:906:8408:: with SMTP id n8mr4107728ejx.152.1614864393344;
        Thu, 04 Mar 2021 05:26:33 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v9sm26368005edj.89.2021.03.04.05.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:26:32 -0800 (PST)
Subject: Re: [PATCH v3 2/2] platform/x86: hp-wmi: add platform profile support
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <nVb9zC39HBbC5-iweNmNol7ymCjT4iD91ydsZVuo_Upqh2_3eVKaF1X1rbYpZGva-NyrGUW_W2uJIc5RHu1KhBGy7-ejGNYZJyRttjhJT-s=@protonmail.com>
 <20210221221339.12395-1-eliadevito@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <21dc7fd4-9075-6b76-bc74-57a7d3b3b126@redhat.com>
Date:   Thu, 4 Mar 2021 14:26:32 +0100
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
> ---
> the "quiet" profile will be implemented with a further patch
> 
> v2: added platform_profile_remove() missing call
> v3: apply Barnabás suggestions

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



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

