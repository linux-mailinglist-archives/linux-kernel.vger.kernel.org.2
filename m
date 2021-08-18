Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2123F0418
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhHRNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234949AbhHRNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629291697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lw6BXWdtuS4hR/ac6qIxxX0UDFX1YMj9fYYRu49Z6rk=;
        b=VTmhdThxavvxgqTPGQFj6CqDJmK5G+Fd2IgPNSoIgjDLOSCCXNVAQ3YiqZ1xj/vE/1phtT
        gjGJQttbieVzOkVdobKcboqmK7OLlL4YRRNVdMo8DWNmSNzzGNr4xIBDqbsFQqsfuXEOJM
        yn1Q4bcw8sI5mOd0sN9UnlRSsXu6dhQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-pHnb9BzxPEOk3eD688CmaQ-1; Wed, 18 Aug 2021 09:01:36 -0400
X-MC-Unique: pHnb9BzxPEOk3eD688CmaQ-1
Received: by mail-ed1-f72.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso993590edh.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lw6BXWdtuS4hR/ac6qIxxX0UDFX1YMj9fYYRu49Z6rk=;
        b=GA5COxcWtMVrQgKqROT6TiB4jjiZyHBCxgGSOS7WhtIuPtvTImqW3HL2NUq9815Rxi
         bqZ1LyAuPq3J97s1h6jk7+UQKltvD0o5q6PFRYO69gmz+VW8i5l5WqNaYU4K8OjEgtxF
         QNqx7j7Rc/iCDyYn9t+zBAGZFgjN4PTLuDHTqUOks6FGzqSwFbR286BRwxResiO85rQD
         1Uk/7F+SYaBbCFlnPWrVWsgV2gdL6CTXo8ETyxV088CRqJ/DrlXONjnWKWiIsCAXhaF5
         MSYeDwrJ+exAxlCF/0eQ0/nTZ1q8lwG8Q/asLGnJfrL1OA3ZKRetNzejTRl9MXAEF3z+
         v7vg==
X-Gm-Message-State: AOAM532av0hqwOyvSH6Nx6gtFcl6c86udY1dEpc9WwZn5swYgb5PvzH1
        x7TQ1SAiv9EK/rpRIQl+C5i96aAnUgb95S6K+93Xijw7periTiAE9nZdf1pdV8flx+5/E8ASNA1
        l83bW2imukOxM0WcQgJYU01NR
X-Received: by 2002:a17:907:2110:: with SMTP id qn16mr9500912ejb.170.1629291694391;
        Wed, 18 Aug 2021 06:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMQ5q7lg+bckGnfhfZIACI90q7iAC77DlnLtWEPMWFzbcep4gBx4v2mQdgXxkDRPHZOA2DUA==
X-Received: by 2002:a17:907:2110:: with SMTP id qn16mr9500896ejb.170.1629291694137;
        Wed, 18 Aug 2021 06:01:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ee29sm2675718edb.63.2021.08.18.06.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:01:33 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for platform_profile
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     hadess@hadess.net, platform-driver-x86@vger.kernel.org
References: <20210815230558.5860-1-luke@ljones.dev>
 <20210815230558.5860-2-luke@ljones.dev>
 <01f2f52e-e41f-4fce-480e-ab5fcd6c7b40@redhat.com>
Message-ID: <65dad655-9aef-fadf-ca53-d227f1cb9cca@redhat.com>
Date:   Wed, 18 Aug 2021 15:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <01f2f52e-e41f-4fce-480e-ab5fcd6c7b40@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/16/21 10:32 AM, Hans de Goede wrote:
> Hi Luke,
> 
> I have a couple of small remarks once those are resolved in v5
> then this should be ready for merging.

I'm trying to get the pdx86 in order for the upcoming merge-window
and it would be good if we can get this patch included.

Since my suggested changes come down to just dropping 2 unnecessary
"if (!asus->throttle_thermal_policy_available) {...}"
checks, a v5 is not really necessary. I can also just merge v4 and
drop these lines myself when merging, then you don't need to do a v5.

Are you ok with me dropping these extra/unnecessary checks and merging
v4 with that change?

Regards,

Hans




>> +		return -ENODATA;
> 
> On 8/16/21 1:05 AM, Luke D. Jones wrote:
>> Add initial support for platform_profile where the support is
>> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>>
>> Because throttle_thermal_policy is used by platform_profile and is
>> writeable separately to platform_profile any userspace changes to
>> throttle_thermal_policy need to notify platform_profile.
>>
>> In future throttle_thermal_policy sysfs should be removed so that
>> only one method controls the laptop power profile.
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/Kconfig    |   1 +
>>  drivers/platform/x86/asus-wmi.c | 138 +++++++++++++++++++++++++++++++-
>>  2 files changed, 135 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index d12db6c316ea..46dec48a36c1 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -281,6 +281,7 @@ config ASUS_WMI
>>  	select INPUT_SPARSEKMAP
>>  	select LEDS_CLASS
>>  	select NEW_LEDS
>> +	select ACPI_PLATFORM_PROFILE
>>  	help
>>  	  Say Y here if you have a WMI aware Asus laptop (like Eee PCs or new
>>  	  Asus Notebooks).
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 90a6a0d00deb..c11ce06073d1 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -11,6 +11,7 @@
>>   * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
>>   */
>>  
>> +#include <asm-generic/errno.h>
> 
> This is a weird place to add an include, also please use
> linux/errno.h. But this is not necessary at all, because the
> 2 if-s using -ENODATA which need this can be dropped
> (see below) so please just drop this all together.
> 
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>  
>>  #include <linux/kernel.h>
>> @@ -26,6 +27,7 @@
>>  #include <linux/rfkill.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci_hotplug.h>
>> +#include <linux/platform_profile.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/hwmon.h>
>>  #include <linux/hwmon-sysfs.h>
>> @@ -219,6 +221,9 @@ struct asus_wmi {
>>  	bool throttle_thermal_policy_available;
>>  	u8 throttle_thermal_policy_mode;
>>  
>> +	struct platform_profile_handler platform_profile_handler;
>> +	bool platform_profile_support;
>> +
>>  	// The RSOC controls the maximum charging percentage.
>>  	bool battery_rsoc_available;
>>  
>> @@ -2103,12 +2108,23 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>>  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>>  {
>>  	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>> +	int err;
>>  
>>  	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>  		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>  
>>  	asus->throttle_thermal_policy_mode = new_mode;
>> -	return throttle_thermal_policy_write(asus);
>> +	err = throttle_thermal_policy_write(asus);
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * Ensure that platform_profile updates userspace with the change to ensure
>> +	 * that platform_profile and throttle_thermal_policy_mode are in sync.
>> +	 */
>> +	platform_profile_notify();
>> +
>> +	return 0;
>>  }
>>  
>>  static ssize_t throttle_thermal_policy_show(struct device *dev,
>> @@ -2124,9 +2140,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>>  				    struct device_attribute *attr,
>>  				    const char *buf, size_t count)
>>  {
>> -	int result;
>> -	u8 new_mode;
>>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	u8 new_mode;
>> +	int result;
>> +	int err;
>>  
>>  	result = kstrtou8(buf, 10, &new_mode);
>>  	if (result < 0)
>> @@ -2136,7 +2153,15 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>>  		return -EINVAL;
>>  
>>  	asus->throttle_thermal_policy_mode = new_mode;
>> -	throttle_thermal_policy_write(asus);
>> +	err = throttle_thermal_policy_write(asus);
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * Ensure that platform_profile updates userspace with the change to ensure
>> +	 * that platform_profile and throttle_thermal_policy_mode are in sync.
>> +	 */
>> +	platform_profile_notify();
>>  
>>  	return count;
>>  }
>> @@ -2144,6 +2169,101 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>>  // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>>  static DEVICE_ATTR_RW(throttle_thermal_policy);
>>  
>> +/* Platform profile ***********************************************************/
>> +static int platform_profile_get(struct platform_profile_handler *pprof,
>> +				enum platform_profile_option *profile)
>> +{
>> +	struct asus_wmi *asus;
>> +	int tp;
>> +
>> +	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>> +
>> +	if (!asus->throttle_thermal_policy_available) {
>> +		return -ENODATA;
>> +	}
> 
> Please don't use {} for an if before a single statement.
> 
> Also platform_profile_get() only gets used if platform_profile_setup()
> proceeds beyond the same check which never happens, so this entire check is
> not necessary, please just drop the entire check.
> 
>> +	tp = asus->throttle_thermal_policy_mode;
>> +
>> +	if (tp < 0)
>> +		return tp;
>> +
>> +	switch (tp) {
>> +	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>> +		*profile = PLATFORM_PROFILE_BALANCED;
>> +		break;
>> +	case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
>> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
>> +		break;
>> +	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>> +		*profile = PLATFORM_PROFILE_QUIET;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int platform_profile_set(struct platform_profile_handler *pprof,
>> +				enum platform_profile_option profile)
>> +{
>> +	struct asus_wmi *asus;
>> +	int tp;
>> +
>> +	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>> +
>> +	/* All possible toggles like throttle_thermal_policy here */
> 
> This comment seems to be a left-over from when you considered also adding
> fan-boost-mode, please drop.
> 
>> +	if (!asus->throttle_thermal_policy_available) {
>> +		return -ENODATA;
>> +	}
> 
> As above, please drop.
> 
>> +
>> +	switch (profile) {
>> +	case PLATFORM_PROFILE_PERFORMANCE:
>> +		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>> +		break;
>> +	case PLATFORM_PROFILE_BALANCED:
>> +		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>> +		break;
>> +	case PLATFORM_PROFILE_QUIET:
>> +		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	asus->throttle_thermal_policy_mode = tp;
>> +	return throttle_thermal_policy_write(asus);
>> +}
>> +
>> +static int platform_profile_setup(struct asus_wmi *asus)
>> +{
>> +	int err;
>> +
>> +	if (!asus->throttle_thermal_policy_available) {
>> +		/*
>> +		 * Not an error if a component platform_profile relies on is unavailable
>> +		 * so early return, skipping the setup of platform_profile.
>> +		*/
>> +		return 0;
>> +	}
>> +	dev_info("Using throttle_thermal_policy for platform_profile support\n");
>> +
>> +	asus->platform_profile_handler.profile_get = platform_profile_get;
>> +	asus->platform_profile_handler.profile_set = platform_profile_set;
>> +
>> +	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
>> +	set_bit(PLATFORM_PROFILE_BALANCED,
>> +		asus->platform_profile_handler.choices);
>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE,
>> +		asus->platform_profile_handler.choices);
>> +
>> +	err = platform_profile_register(&asus->platform_profile_handler);
>> +	if (err)
>> +		return err;
>> +
>> +	asus->platform_profile_support = true;
>> +	return 0;
>> +}
>> +
>>  /* Backlight ******************************************************************/
>>  
>>  static int read_backlight_power(struct asus_wmi *asus)
>> @@ -2904,6 +3024,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>  	else
>>  		throttle_thermal_policy_set_default(asus);
>>  
>> +	err = platform_profile_setup(asus);
>> +	if (err)
>> +		goto fail_platform_profile_setup;
>> +
>>  	err = panel_od_check_present(asus);
>>  	if (err)
>>  		goto fail_panel_od;
> 
> 
> 
>> @@ -2993,6 +3117,9 @@ static int asus_wmi_add(struct platform_device *pdev)
>>  	asus_wmi_sysfs_exit(asus->platform_device);
>>  fail_sysfs:
>>  fail_throttle_thermal_policy:
>> +fail_platform_profile_setup:
>> +	if (asus->platform_profile_support)
>> +		platform_profile_remove();
>>  fail_fan_boost_mode:
>>  fail_egpu_enable:
>>  fail_dgpu_disable:
>> @@ -3017,6 +3144,9 @@ static int asus_wmi_remove(struct platform_device *device)
>>  	asus_fan_set_auto(asus);
>>  	asus_wmi_battery_exit(asus);
>>  
>> +	if (asus->platform_profile_support)
>> +		platform_profile_remove();
>> +
>>  	kfree(asus);
>>  	return 0;
>>  }
>>
> 
> 
> Regards,
> 
> Hans
> 

