Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20458437499
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhJVJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhJVJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634894273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lboD0bBPHVoGPW1F/xWMh4ehE1WNGBRLzYFSTLsKba8=;
        b=Ew/bhXqBxOCS8+NOODiVEb3TA6izVD1exSK8TNSnMTyPrF9JMpar2qt3khglmaKUIHi7PU
        69SsUsAs7/aFdvMQDHAvEV3x0K3R6r0BvrOH32sFeUsntyLKyZsemk/KXTjMtrNUxZOdH6
        3ynfZ6MCdVRWZ3B7LYrKGe2lvzEctAk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-QTu7WDBAMnm7kfxz7fp3Jw-1; Fri, 22 Oct 2021 05:17:51 -0400
X-MC-Unique: QTu7WDBAMnm7kfxz7fp3Jw-1
Received: by mail-ed1-f70.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so3067004edx.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lboD0bBPHVoGPW1F/xWMh4ehE1WNGBRLzYFSTLsKba8=;
        b=Mkob9sotlXwUmOVfZ6exmdYOLWRM5ZCq4t/BjE9BGTNcevhi2D06oTuMjaINLep8Cf
         5p+l+/51lo1XBYT4vyuxeCA6/+0dNADu2O/lt+HFybjJiXkl9Bh6f3xIVgqVhPnzLhw6
         Ab8Qls5Ujyodfb/XlTCFZTG5mIYVrN4/R2+i7EE6K+cePGB6teFz3AbeF+u1M0kPte4u
         7RVTrgU/bXWHPtvHCOClsbiUPRZYiml3H6QsiSh0sOintkM2QQ14NjlFtlnHO350H6fQ
         VwzzzrdJzhq0M9kXBI7ERBNfu1lvEMEEud2lT+lkXv8ogKq0etFabcfVrkPlTsXEEWP+
         YA2Q==
X-Gm-Message-State: AOAM53183ThJlWAp2Hu+H08MWujpEU232OB3incQgG6G3lppxIYfJHAk
        F3PAb1rY0PcDzBHReZt+eLRK0G/IVx6E4rsO/7OtLiDrP68uBDp8Lsf8wGNyH13Ecuy/S/iaTSr
        cHOMHfmb/5OjJpAV4DoOHnMCy
X-Received: by 2002:a17:906:fad8:: with SMTP id lu24mr14694553ejb.133.1634894270657;
        Fri, 22 Oct 2021 02:17:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfOkanZknF9lMVId7X2JviIg1DkDlFJb8unkBqxzks7Pg5r6SxaKqrzTXFMtjtw7fmCCDnwg==
X-Received: by 2002:a17:906:fad8:: with SMTP id lu24mr14694528ejb.133.1634894270395;
        Fri, 22 Oct 2021 02:17:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id 91sm4048713ede.56.2021.10.22.02.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:16:19 -0700 (PDT)
Message-ID: <22e08521-fb11-4ab5-85e7-4227dd5d743a@redhat.com>
Date:   Fri, 22 Oct 2021 11:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/x86: sony-laptop: replace snprintf in show
 functions with sysfs_emit
Content-Language: en-US
To:     cgel.zte@gmail.com, malattia@linux.it
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211022090851.1065538-1-ye.guojin@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211022090851.1065538-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/22/21 11:08, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>

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
>  drivers/platform/x86/sony-laptop.c | 46 ++++++++++++------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index 704813374922..d8d0c0bed5e9 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -964,7 +964,7 @@ static ssize_t sony_nc_sysfs_show(struct device *dev, struct device_attribute *a
>  	if (item->validate)
>  		value = item->validate(SNC_VALIDATE_OUT, value);
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
> +	return sysfs_emit(buffer, "%d\n", value);
>  }
>  
>  static ssize_t sony_nc_sysfs_store(struct device *dev,
> @@ -1811,9 +1811,7 @@ static ssize_t sony_nc_kbd_backlight_mode_store(struct device *dev,
>  static ssize_t sony_nc_kbd_backlight_mode_show(struct device *dev,
>  		struct device_attribute *attr, char *buffer)
>  {
> -	ssize_t count = 0;
> -	count = snprintf(buffer, PAGE_SIZE, "%d\n", kbdbl_ctl->mode);
> -	return count;
> +	return sysfs_emit(buffer, "%d\n", kbdbl_ctl->mode);
>  }
>  
>  static int __sony_nc_kbd_backlight_timeout_set(u8 value)
> @@ -1855,9 +1853,7 @@ static ssize_t sony_nc_kbd_backlight_timeout_store(struct device *dev,
>  static ssize_t sony_nc_kbd_backlight_timeout_show(struct device *dev,
>  		struct device_attribute *attr, char *buffer)
>  {
> -	ssize_t count = 0;
> -	count = snprintf(buffer, PAGE_SIZE, "%d\n", kbdbl_ctl->timeout);
> -	return count;
> +	return sysfs_emit(buffer, "%d\n", kbdbl_ctl->timeout);
>  }
>  
>  static int sony_nc_kbd_backlight_setup(struct platform_device *pd,
> @@ -2051,21 +2047,18 @@ static ssize_t sony_nc_battery_care_limit_show(struct device *dev,
>  		break;
>  	}
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", status);
>  }
>  
>  static ssize_t sony_nc_battery_care_health_show(struct device *dev,
>  		struct device_attribute *attr, char *buffer)
>  {
> -	ssize_t count = 0;
>  	unsigned int health;
>  
>  	if (sony_call_snc_handle(bcare_ctl->handle, 0x0200, &health))
>  		return -EIO;
>  
> -	count = snprintf(buffer, PAGE_SIZE, "%d\n", health & 0xff);
> -
> -	return count;
> +	return sysfs_emit(buffer, "%d\n", health & 0xff);
>  }
>  
>  static int sony_nc_battery_care_setup(struct platform_device *pd,
> @@ -2215,15 +2208,12 @@ static ssize_t sony_nc_thermal_mode_store(struct device *dev,
>  static ssize_t sony_nc_thermal_mode_show(struct device *dev,
>  		struct device_attribute *attr, char *buffer)
>  {
> -	ssize_t count = 0;
>  	int mode = sony_nc_thermal_mode_get();
>  
>  	if (mode < 0)
>  		return mode;
>  
> -	count = snprintf(buffer, PAGE_SIZE, "%s\n", snc_thermal_profiles[mode]);
> -
> -	return count;
> +	return sysfs_emit(buffer, "%s\n", snc_thermal_profiles[mode]);
>  }
>  
>  static int sony_nc_thermal_setup(struct platform_device *pd)
> @@ -2361,7 +2351,7 @@ static ssize_t sony_nc_lid_resume_show(struct device *dev,
>  
>  	while (pos < LID_RESUME_MAX) {
>  		if (&lid_ctl->attrs[pos].attr == &attr->attr)
> -			return snprintf(buffer, PAGE_SIZE, "%d\n",
> +			return sysfs_emit(buffer, "%d\n",
>  					(lid_ctl->status >> pos) & 0x01);
>  		pos++;
>  	}
> @@ -2493,7 +2483,7 @@ static ssize_t sony_nc_gfx_switch_status_show(struct device *dev,
>  	if (pos < 0)
>  		return pos;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  					pos == SPEED ? "speed" :
>  					pos == STAMINA ? "stamina" :
>  					pos == AUTO ? "auto" : "unknown");
> @@ -2568,7 +2558,7 @@ static ssize_t sony_nc_highspeed_charging_show(struct device *dev,
>  	if (sony_call_snc_handle(0x0131, 0x0100, &result))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0x01);
> +	return sysfs_emit(buffer, "%d\n", result & 0x01);
>  }
>  
>  static int sony_nc_highspeed_charging_setup(struct platform_device *pd)
> @@ -2642,7 +2632,7 @@ static ssize_t sony_nc_lowbatt_show(struct device *dev,
>  	if (sony_call_snc_handle(0x0121, 0x0200, &result))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 1);
> +	return sysfs_emit(buffer, "%d\n", result & 1);
>  }
>  
>  static int sony_nc_lowbatt_setup(struct platform_device *pd)
> @@ -2708,7 +2698,7 @@ static ssize_t sony_nc_hsfan_show(struct device *dev,
>  	if (sony_call_snc_handle(0x0149, 0x0100, &result))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0x01);
> +	return sysfs_emit(buffer, "%d\n", result & 0x01);
>  }
>  
>  static ssize_t sony_nc_fanspeed_show(struct device *dev,
> @@ -2719,7 +2709,7 @@ static ssize_t sony_nc_fanspeed_show(struct device *dev,
>  	if (sony_call_snc_handle(0x0149, 0x0300, &result))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0xff);
> +	return sysfs_emit(buffer, "%d\n", result & 0xff);
>  }
>  
>  static int sony_nc_fanspeed_setup(struct platform_device *pd)
> @@ -2815,7 +2805,7 @@ static ssize_t sony_nc_usb_charge_show(struct device *dev,
>  	if (sony_call_snc_handle(0x0155, 0x0000, &result))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0x01);
> +	return sysfs_emit(buffer, "%d\n", result & 0x01);
>  }
>  
>  static int sony_nc_usb_charge_setup(struct platform_device *pd)
> @@ -2870,7 +2860,7 @@ static ssize_t sony_nc_panelid_show(struct device *dev,
>  	if (sony_call_snc_handle(0x011D, 0x0000, &result))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", result);
> +	return sysfs_emit(buffer, "%d\n", result);
>  }
>  
>  static int sony_nc_panelid_setup(struct platform_device *pd)
> @@ -2998,7 +2988,7 @@ static ssize_t sony_nc_touchpad_show(struct device *dev,
>  	if (sony_call_snc_handle(tp_ctl->handle, 0x000, &result))
>  		return -EINVAL;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", !(result & 0x01));
> +	return sysfs_emit(buffer, "%d\n", !(result & 0x01));
>  }
>  
>  static int sony_nc_touchpad_setup(struct platform_device *pd,
> @@ -3915,7 +3905,7 @@ static ssize_t sony_pic_wwanpower_show(struct device *dev,
>  {
>  	ssize_t count;
>  	mutex_lock(&spic_dev.lock);
> -	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.wwan_power);
> +	count = sysfs_emit(buffer, "%d\n", spic_dev.wwan_power);
>  	mutex_unlock(&spic_dev.lock);
>  	return count;
>  }
> @@ -3954,7 +3944,7 @@ static ssize_t sony_pic_bluetoothpower_show(struct device *dev,
>  {
>  	ssize_t count = 0;
>  	mutex_lock(&spic_dev.lock);
> -	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.bluetooth_power);
> +	count = sysfs_emit(buffer, "%d\n", spic_dev.bluetooth_power);
>  	mutex_unlock(&spic_dev.lock);
>  	return count;
>  }
> @@ -3996,7 +3986,7 @@ static ssize_t sony_pic_fanspeed_show(struct device *dev,
>  	if (sony_pic_get_fanspeed(&value))
>  		return -EIO;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
> +	return sysfs_emit(buffer, "%d\n", value);
>  }
>  
>  #define SPIC_ATTR(_name, _mode)					\
> 

