Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74C3EB10B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhHMHDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238877AbhHMHDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628838189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbsnEAAVomKHuT54XXBl4+pNRa21HznbUqANHkTznJ4=;
        b=E2KbIxbrj30w6QKw7ycLRuWqScJYanQq/vbaIKO+UcXF0q5XjPxsnSGP/HGiAzGQ/Kt3Y7
        x/MauRP2AEoCNVCd7nJBLLaOAIrN+hSlcYN6QlY5j9uHvC1/0UFvJbk1/Bi7I/VZ2ReJNP
        b38gq51/1KJXd6UGY51bG9fDwaocdjs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-QCSPYvjWMGe4tWfqZd7dRg-1; Fri, 13 Aug 2021 03:03:07 -0400
X-MC-Unique: QCSPYvjWMGe4tWfqZd7dRg-1
Received: by mail-ej1-f71.google.com with SMTP id a19-20020a1709063e93b0290551ea218ea2so2615663ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DbsnEAAVomKHuT54XXBl4+pNRa21HznbUqANHkTznJ4=;
        b=bC3sUoEEokTTCKWmVP2cB2HhdjYOkuVfYKF4766px1hQsOeusDVuhSoZ5XpujXLKYa
         iwtLDooq4spbE/RGEbrFIKdccy+n70mTiS8ieGnwTx0kDyeUqOQ1MmFIbYUbhf23zJ/j
         GEOO0CnSya7y8rzhtZNBQrOB1G4f+IHKSvFRjCMeO0u/nFNttCbbH9Z8XTpwFxylYn13
         c/zJ9RGsucFV2qLaaKHnDd8IQRWJ1lvHy+usmWXRQCbg0NCpGRUmWJu1uijNVsZJ31gu
         oeysr6wfKUEupLkQTuujK1Q3X4WF+epWMhzPmL1i0BqZpo3CmzJAQ6a1oZ+kPDBCAUwC
         tnSQ==
X-Gm-Message-State: AOAM5309DCru1pTfNpFsnW7OHZCusa4A4KtyvTJryDichumaalMIGp/J
        Ce0UGmZySDYbydl3NtEyjukQ9v3RA5pnhA6wx72xDjeCWHrxK6N37xv9P8+F6/Qu0AY8M7yBQR7
        llPM/HwESPKaQ6/r1QwoRKGru
X-Received: by 2002:a17:906:138f:: with SMTP id f15mr1052937ejc.233.1628838186025;
        Fri, 13 Aug 2021 00:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5LEtFA9bIu++3txHAUecCZLgiWCY0SfeWDWBbtQid7CdEoLpm3ZID0WxnSX0FNp5HjQuE9w==
X-Received: by 2002:a17:906:138f:: with SMTP id f15mr1052918ejc.233.1628838185762;
        Fri, 13 Aug 2021 00:03:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t11sm225737ejr.89.2021.08.13.00.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:03:05 -0700 (PDT)
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     hadess@hadess.net, platform-driver-x86@vger.kernel.org
References: <20210813024201.9518-1-luke@ljones.dev>
 <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
Date:   Fri, 13 Aug 2021 09:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/21 7:27 AM, Luke Jones wrote:
> I'm unsure of how to update the existing code for fn+f5 (next thermal profile) used by laptops like the TUF series that have keyboard over i2c. I was thinking of the following:
> 
> static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> {
> struct platform_profile_handler *handler = &asus->platform_profile_handler; // added
> u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> 
> if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>  new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> 
> // asus->throttle_thermal_policy_mode = new_mode;
> // return throttle_thermal_policy_write(asus);
> return handler->profile_set(&asus->platform_profile_handler, new_mode); // added
> }
> 
> * two lines added, two commented

I was going to say it is best to just send a key-press event to userspace
(we can define a new EV_KEY_.... code for this) and then let userspace
handle things. But I see that this is currently already handled by the kernel,
so that is not really an option.

> I'm not able to test this though, and there are very few active people in my discord with TUF/i2c laptops to ask for testing also.
> 
> My concern here is to get the platform_profile correctly updated. Simply updating asus->throttle_thermal_policy_mode isn't going to achieve what we'll want.

Right, there is no need to go through handler->profile_set() you have defined
profile_set yourself after all and it does not do anything different then the
old code you are replacing here.

The trick is to call platform_profile_notify() after throttle_thermal_policy_write()
this will let userspace, e.g. power-profiles-daemon know that the profile has
been changed and it will re-read it then, resulting in a call to
handler->profile_get()

So the new throttle_thermal_policy_switch_next() would look like this:

static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
{
        u8 new_mode = asus->throttle_thermal_policy_mode + 1;
	int err; // new

        if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
                new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;

        asus->throttle_thermal_policy_mode = new_mode;

        err = throttle_thermal_policy_write(asus); // changed
	if (err == 0)                              // new
		platform_profile_notify();         // new

	return err;                                // new
}

As you can see the only new thing here is the
platform_profile_notify() call on a successful write,
which is such a small change that I'm not overly worried about
not being able to test this.

I hope this helps.

Regards,

Hans


> On Fri, Aug 13 2021 at 14:42:01 +1200, Luke D. Jones <luke@ljones.dev> wrote:
>> Add initial support for platform_profile where the support is
>> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/asus-wmi.c | 112 ++++++++++++++++++++++++++++++++
>>  1 file changed, 112 insertions(+)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 90a6a0d00deb..62260043c15c 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/rfkill.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci_hotplug.h>
>> +#include <linux/platform_profile.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/hwmon.h>
>>  #include <linux/hwmon-sysfs.h>
>> @@ -219,6 +220,9 @@ struct asus_wmi {
>>      bool throttle_thermal_policy_available;
>>      u8 throttle_thermal_policy_mode;
>>
>> +    struct platform_profile_handler platform_profile_handler;
>> +    bool platform_profile_support;
>> +
>>      // The RSOC controls the maximum charging percentage.
>>      bool battery_rsoc_available;
>>
>> @@ -2144,6 +2148,106 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>>  // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>>  static DEVICE_ATTR_RW(throttle_thermal_policy);
>>
>> +/* Platform profile ***********************************************************/
>> +static int platform_profile_get(struct platform_profile_handler *pprof,
>> +                enum platform_profile_option *profile)
>> +{
>> +    struct asus_wmi *asus;
>> +    int tp;
>> +
>> +    asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>> +
>> +    /* All possible toggles like throttle_thermal_policy here */
>> +    if (asus->throttle_thermal_policy_available) {
>> +        tp = asus->throttle_thermal_policy_mode;
>> +    } else {
>> +        return -1;
>> +    }
>> +
>> +    if (tp < 0)
>> +        return tp;
>> +
>> +    switch (tp) {
>> +    case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>> +        *profile = PLATFORM_PROFILE_BALANCED;
>> +        break;
>> +    case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
>> +        *profile = PLATFORM_PROFILE_PERFORMANCE;
>> +        break;
>> +    case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>> +        *profile = PLATFORM_PROFILE_QUIET;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int platform_profile_set(struct platform_profile_handler *pprof,
>> +                enum platform_profile_option profile)
>> +{
>> +    struct asus_wmi *asus;
>> +    int tp;
>> +
>> +    asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>> +
>> +    /* All possible toggles like throttle_thermal_policy here */
>> +    if (!asus->throttle_thermal_policy_available) {
>> +        return -1;
>> +    }
>> +
>> +    switch (profile) {
>> +    case PLATFORM_PROFILE_PERFORMANCE:
>> +        tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>> +        break;
>> +    case PLATFORM_PROFILE_BALANCED:
>> +        tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>> +        break;
>> +    case PLATFORM_PROFILE_QUIET:
>> +        tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>> +        break;
>> +    default:
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (asus->throttle_thermal_policy_available) {
>> +        asus->throttle_thermal_policy_mode = tp;
>> +        return throttle_thermal_policy_write(asus);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int platform_profile_setup(struct asus_wmi *asus)
>> +{
>> +    int err;
>> +
>> +    if (asus->throttle_thermal_policy_available) {
>> +        pr_info("Using throttle_thermal_policy for platform_profile support\n");
>> +    } else {
>> +        /*
>> +         * Not an error if a component platform_profile relies on is unavailable
>> +         * so early return, skipping the setup of platform_profile.
>> +        */
>> +        return 0;
>> +    }
>> +    asus->platform_profile_handler.profile_get = platform_profile_get;
>> +    asus->platform_profile_handler.profile_set = platform_profile_set;
>> +
>> +    set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
>> +    set_bit(PLATFORM_PROFILE_BALANCED,
>> +        asus->platform_profile_handler.choices);
>> +    set_bit(PLATFORM_PROFILE_PERFORMANCE,
>> +        asus->platform_profile_handler.choices);
>> +
>> +    err = platform_profile_register(&asus->platform_profile_handler);
>> +    if (err)
>> +        return err;
>> +
>> +    asus->platform_profile_support = true;
>> +    return 0;
>> +}
>> +
>>  /* Backlight ******************************************************************/
>>
>>  static int read_backlight_power(struct asus_wmi *asus)
>> @@ -2904,6 +3008,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>      else
>>          throttle_thermal_policy_set_default(asus);
>>
>> +    err = platform_profile_setup(asus);
>> +    if (err)
>> +        goto fail_platform_profile_setup;
>> +
>>      err = panel_od_check_present(asus);
>>      if (err)
>>          goto fail_panel_od;
>> @@ -2993,6 +3101,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>      asus_wmi_sysfs_exit(asus->platform_device);
>>  fail_sysfs:
>>  fail_throttle_thermal_policy:
>> +fail_platform_profile_setup:
>>  fail_fan_boost_mode:
>>  fail_egpu_enable:
>>  fail_dgpu_disable:
>> @@ -3017,6 +3126,9 @@ static int asus_wmi_remove(struct platform_device *device)
>>      asus_fan_set_auto(asus);
>>      asus_wmi_battery_exit(asus);
>>
>> +    if (asus->platform_profile_support)
>> +        platform_profile_remove();
>> +
>>      kfree(asus);
>>      return 0;
>>  }
>> -- 
>> 2.31.1
>>
> 
> 

