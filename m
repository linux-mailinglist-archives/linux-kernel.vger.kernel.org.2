Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050E63F1494
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhHSHzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhHSHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629359663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5SDL7OozCqdtwWb+wvgn1RUit4wFHPUx1XT4h9y6C4=;
        b=ik4SIzlA5FhRIFeUPyZIfE149mO77G+ncSAqxNMT4MISaRcy0JUzVclKB7ezLBt10AYvwP
        7U3xewBIN+YsdLtUG8Apr42Du2tsngYXXkKNfTsULCfKLDW6HOdqMSKaV6vC/7PVc0HXux
        rEOjcaq/qLuDKWBqMpLThohXSxtSERM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-_F67-NAQM9OyZ3AYHvVDcQ-1; Thu, 19 Aug 2021 03:54:21 -0400
X-MC-Unique: _F67-NAQM9OyZ3AYHvVDcQ-1
Received: by mail-ed1-f71.google.com with SMTP id n4-20020aa7c6840000b02903be94ce771fso2418072edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h5SDL7OozCqdtwWb+wvgn1RUit4wFHPUx1XT4h9y6C4=;
        b=RU/J0yKiF55DK3MNRuXNdxCaklTB1i9dK6H2twlXPsC2X92v6wQSqmVvhYlYLL5PKg
         YGha4dntcPATmBIs4HuwLf+XNKk24N0xKmKG4K3EVMDV2aLS+r2VeBOmsHsUMSHu/D34
         IuQPJYQugYyBPCrH5fN1Dmj8kEIhLDYvwSIWV9+bFbPZwaQuHMzhurBijHR5r70ASIZk
         7Eel6zWzqgPdxTxuS6em4TQiDF8cz087YaiYFns4NtbEnsaReXCBvke5JYFDkQv8z29Q
         3vrmpz3HJtNRhyAUzCUm8vOZ9/Zb2dXzvRNc41xMLTP4T8tdDCnBfUbo7K0WwUqs73ce
         P5iw==
X-Gm-Message-State: AOAM532mMCcPCQuAGM1b/gR5gRzs+QOcdLt1TcdjVTOQa5Zwg7drHNfg
        xIEVi070jPilp15/y3tRKR1mwOMb/ImvPmuWqimBgYaIBo0Xq474Vw8IxCHLeFgmQGH9OqV1SDc
        B+KF1kDJPehKefEEGg4+SkA15
X-Received: by 2002:a05:6402:c9:: with SMTP id i9mr14841231edu.76.1629359660868;
        Thu, 19 Aug 2021 00:54:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7dmoGW9StS8XnqtbPbYj1yvlAaJFU4rJUk97gIvUfBsIfI5E1x68C3Zjf0ecUv2FNx2nQHg==
X-Received: by 2002:a05:6402:c9:: with SMTP id i9mr14841225edu.76.1629359660743;
        Thu, 19 Aug 2021 00:54:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j13sm1283572edr.89.2021.08.19.00.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 00:54:20 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] asus-wmi: Add support for platform_profile
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     hadess@hadess.net, platform-driver-x86@vger.kernel.org
References: <20210818190731.19170-1-luke@ljones.dev>
 <20210818190731.19170-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <26907b9a-8ff0-8aa0-c4ac-77b9c2f319b6@redhat.com>
Date:   Thu, 19 Aug 2021 09:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818190731.19170-2-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/21 9:07 PM, Luke D. Jones wrote:
> Add initial support for platform_profile where the support is
> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
> 
> Because throttle_thermal_policy is used by platform_profile and is
> writeable separately to platform_profile any userspace changes to
> throttle_thermal_policy need to notify platform_profile.
> 
> In future throttle_thermal_policy sysfs should be removed so that
> only one method controls the laptop power profile.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

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



> ---
>  drivers/platform/x86/Kconfig    |   1 +
>  drivers/platform/x86/asus-wmi.c | 130 +++++++++++++++++++++++++++++++-
>  2 files changed, 127 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index d12db6c316ea..46dec48a36c1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -281,6 +281,7 @@ config ASUS_WMI
>  	select INPUT_SPARSEKMAP
>  	select LEDS_CLASS
>  	select NEW_LEDS
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	  Say Y here if you have a WMI aware Asus laptop (like Eee PCs or new
>  	  Asus Notebooks).
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 90a6a0d00deb..cc5811844012 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -26,6 +26,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/platform_profile.h>
>  #include <linux/power_supply.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> @@ -219,6 +220,9 @@ struct asus_wmi {
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
>  
> +	struct platform_profile_handler platform_profile_handler;
> +	bool platform_profile_support;
> +
>  	// The RSOC controls the maximum charging percentage.
>  	bool battery_rsoc_available;
>  
> @@ -2103,12 +2107,23 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>  {
>  	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> +	int err;
>  
>  	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>  		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>  
>  	asus->throttle_thermal_policy_mode = new_mode;
> -	return throttle_thermal_policy_write(asus);
> +	err = throttle_thermal_policy_write(asus);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Ensure that platform_profile updates userspace with the change to ensure
> +	 * that platform_profile and throttle_thermal_policy_mode are in sync.
> +	 */
> +	platform_profile_notify();
> +
> +	return 0;
>  }
>  
>  static ssize_t throttle_thermal_policy_show(struct device *dev,
> @@ -2124,9 +2139,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t count)
>  {
> -	int result;
> -	u8 new_mode;
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 new_mode;
> +	int result;
> +	int err;
>  
>  	result = kstrtou8(buf, 10, &new_mode);
>  	if (result < 0)
> @@ -2136,7 +2152,15 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  		return -EINVAL;
>  
>  	asus->throttle_thermal_policy_mode = new_mode;
> -	throttle_thermal_policy_write(asus);
> +	err = throttle_thermal_policy_write(asus);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Ensure that platform_profile updates userspace with the change to ensure
> +	 * that platform_profile and throttle_thermal_policy_mode are in sync.
> +	 */
> +	platform_profile_notify();
>  
>  	return count;
>  }
> @@ -2144,6 +2168,94 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>  static DEVICE_ATTR_RW(throttle_thermal_policy);
>  
> +/* Platform profile ***********************************************************/
> +static int platform_profile_get(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile)
> +{
> +	struct asus_wmi *asus;
> +	int tp;
> +
> +	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> +
> +	tp = asus->throttle_thermal_policy_mode;
> +
> +	if (tp < 0)
> +		return tp;
> +
> +	switch (tp) {
> +	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> +		*profile = PLATFORM_PROFILE_QUIET;
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
> +{
> +	struct asus_wmi *asus;
> +	int tp;
> +
> +	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	asus->throttle_thermal_policy_mode = tp;
> +	return throttle_thermal_policy_write(asus);
> +}
> +
> +static int platform_profile_setup(struct asus_wmi *asus)
> +{
> +	struct device *dev = &asus->platform_device->dev;
> +	int err;
> +
> +	/*
> +	 * Not an error if a component platform_profile relies on is unavailable
> +	 * so early return, skipping the setup of platform_profile.
> +	 */
> +	if (!asus->throttle_thermal_policy_available)
> +		return 0;
> +
> +	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> +
> +	asus->platform_profile_handler.profile_get = platform_profile_get;
> +	asus->platform_profile_handler.profile_set = platform_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED,
> +		asus->platform_profile_handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> +		asus->platform_profile_handler.choices);
> +
> +	err = platform_profile_register(&asus->platform_profile_handler);
> +	if (err)
> +		return err;
> +
> +	asus->platform_profile_support = true;
> +	return 0;
> +}
> +
>  /* Backlight ******************************************************************/
>  
>  static int read_backlight_power(struct asus_wmi *asus)
> @@ -2904,6 +3016,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	else
>  		throttle_thermal_policy_set_default(asus);
>  
> +	err = platform_profile_setup(asus);
> +	if (err)
> +		goto fail_platform_profile_setup;
> +
>  	err = panel_od_check_present(asus);
>  	if (err)
>  		goto fail_panel_od;
> @@ -2993,6 +3109,9 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus_wmi_sysfs_exit(asus->platform_device);
>  fail_sysfs:
>  fail_throttle_thermal_policy:
> +fail_platform_profile_setup:
> +	if (asus->platform_profile_support)
> +		platform_profile_remove();
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> @@ -3017,6 +3136,9 @@ static int asus_wmi_remove(struct platform_device *device)
>  	asus_fan_set_auto(asus);
>  	asus_wmi_battery_exit(asus);
>  
> +	if (asus->platform_profile_support)
> +		platform_profile_remove();
> +
>  	kfree(asus);
>  	return 0;
>  }
> 

