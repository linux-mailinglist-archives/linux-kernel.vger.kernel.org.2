Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44893BC907
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGFKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231194AbhGFKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625566023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/MVrnqb5uxllS/19PtIANIOuWif4VbTqwukGRi/dgw=;
        b=hYPNWt3iIrEC51gv9sPUiFVCJhxJfWZiyj6pYcv2ySYas3G5qqQISMhy6awyBs+ee25IWD
        3WEOLvTL2kkPDOgIYC1JimC4dRT/2782QhRsV+Xoq1AXHUx1GQGm/jBWhj/oEktqMQ39No
        qCIELcspQV7n88Dc3KDyyZlJlrU3UYE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-cXDfC1tFMzOdpqlF3_um8A-1; Tue, 06 Jul 2021 06:07:03 -0400
X-MC-Unique: cXDfC1tFMzOdpqlF3_um8A-1
Received: by mail-ed1-f72.google.com with SMTP id u13-20020aa7d88d0000b0290397eb800ae3so6537924edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2/MVrnqb5uxllS/19PtIANIOuWif4VbTqwukGRi/dgw=;
        b=ia6edzMEWGDfc1DwgiiApZXvCpc8+jRQgLNwp7WzU+0MsY7ifGKbVq5CZOG7GLGjBx
         hSqIArK0D1zkzSydP03P1wRUBlNQ9YLSrsHJkNBbnhg/hISTW6PKC4lmAW9UbAjt6Q0O
         9sAAuYkqKncp4L3lAFFmTdS0vR8C+moLP7laCzQ8OygU6S5J20EgUitkB2E6kiay/de6
         cxuZkr78TohIJKX06znJgoUuPM8nYU6fOMxCzYcLxSI6bwi34D+qMv2tolqmrgIGPC4N
         jJg9rQLgbbvH3F4fZ/bTIbf20Fi3o+I2UocrHqQz/MZ994HlF10UA5jc5vx8zLgt5ygY
         K2CA==
X-Gm-Message-State: AOAM532Am6HJhKPHt5ST30MNG1DZuK9cl6qesbLIVRDI4X4b2MBlCWnd
        UavAsc6meu9HeK1wpW3YNh1TitJswXNMTJ/JC3byOlpqp6OIiKdWBJwHNWfuScsbG4u4sdZ/vTr
        ubV82Kq8n15cutF6i33+P3T5OXBREQiV9YABGxm//J6sH6OJvKDGgXfjPMbFjysoZDgsSW/E0+f
        BV
X-Received: by 2002:a17:907:9872:: with SMTP id ko18mr17335079ejc.505.1625566021668;
        Tue, 06 Jul 2021 03:07:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzMmMXTD2fUMRWtgHoW+In5dlnYgof82wTZOCTNRRRuC0zSmS3pRqo7GRptoROxPwPdnof2w==
X-Received: by 2002:a17:907:9872:: with SMTP id ko18mr17335054ejc.505.1625566021449;
        Tue, 06 Jul 2021 03:07:01 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c28sm5426881ejc.102.2021.07.06.03.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 03:07:00 -0700 (PDT)
Subject: Re: [PATCH 1/3] asus-wmi: Add panel overdrive functionality
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210704222148.880848-1-luke@ljones.dev>
 <20210704222148.880848-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db045e4c-cac7-2984-b0e1-367e1a58cde9@redhat.com>
Date:   Tue, 6 Jul 2021 12:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704222148.880848-2-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your patches, I've added several remarks inline (below);

On 7/5/21 12:21 AM, Luke D. Jones wrote:
> Some ASUS ROG laptops have the ability to drive the display panel
> a a higher rate to eliminate or reduce ghosting.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ebaeb7bb80f5..2468076d6cd8 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -216,6 +216,9 @@ struct asus_wmi {
>  	// The RSOC controls the maximum charging percentage.
>  	bool battery_rsoc_available;
>  
> +	bool panel_overdrive_available;
> +	u8 panel_overdrive;
> +
>  	struct hotplug_slot hotplug_slot;
>  	struct mutex hotplug_lock;
>  	struct mutex wmi_lock;
> @@ -1221,6 +1224,87 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
>  	return result;
>  }
>  
> +/* Panel Overdrive ************************************************************/
> +static int panel_od_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->panel_overdrive_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_PANEL_OD, &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> +		asus->panel_overdrive_available = true;
> +		asus->panel_overdrive = result & ASUS_WMI_DSTS_STATUS_BIT;

As the kernel-test-robot pointed out this if is missing { } around the
2 statements which should only be executed if the condition is true.

> +
> +	return 0;
> +}
> +
> +static int panel_od_write(struct asus_wmi *asus)
> +{
> +	int err;
> +	u8 value;
> +	u32 retval;
> +
> +	value = asus->panel_overdrive;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, value, &retval);
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> +			"panel_od");

Please make this a single line.

> +
> +	if (err) {
> +		pr_warn("Failed to set panel overdrive: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval > 1 || retval < 0) {
> +		pr_warn("Failed to set panel overdrive (retval): 0x%x\n",
> +			retval);

Please make this a single line too.

> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t panel_od_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 mode = asus->panel_overdrive;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
> +}
> +
> +static ssize_t panel_od_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int result;
> +	u8 overdrive;
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtou8(buf, 10, &overdrive);
> +	if (result < 0)
> +		return result;
> +
> +	if (overdrive > 1 || overdrive < 0)

An u8 can never be < 0, so please drop that check
(it will likely trigger compiler warnings in some cases).

> +		return -EINVAL;
> +
> +	asus->panel_overdrive = overdrive;
> +	panel_od_write(asus);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(panel_od);
> +
>  /* Quirks *********************************************************************/
>  
>  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> @@ -2332,6 +2416,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
>  	&dev_attr_throttle_thermal_policy.attr,
> +	&dev_attr_panel_od.attr,
>  	NULL
>  };
>  
> @@ -2357,6 +2442,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
>  		ok = asus->throttle_thermal_policy_available;
> +	else if (attr == &dev_attr_panel_od.attr)
> +		ok = asus->panel_overdrive_available;
>  
>  	if (devid != -1)
>  		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> @@ -2622,6 +2709,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	else
>  		throttle_thermal_policy_set_default(asus);
>  
> +	err = panel_od_check_present(asus);
> +	if (err)
> +		goto fail_panel_od;
> +
>  	err = asus_wmi_sysfs_init(asus->platform_device);
>  	if (err)
>  		goto fail_sysfs;
> @@ -2709,6 +2800,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_throttle_thermal_policy:
>  fail_fan_boost_mode:
>  fail_platform:
> +fail_panel_od:
>  	kfree(asus);
>  	return err;
>  }
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 2f274cf52805..428aea701c7b 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -61,6 +61,7 @@
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
>  
>  /* Misc */
> +#define ASUS_WMI_DEVID_PANEL_OD		0x00050019
>  #define ASUS_WMI_DEVID_CAMERA		0x00060013
>  #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>  
> 

Otherwise this looks good to me,

Regards,

Hans

