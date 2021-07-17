Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7A3CC455
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhGQQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhGQQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626537721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQN///39LYTf5bs3PAw2N5VQye+x4FsEFMtGYeBQPAM=;
        b=R+VArQ4pzX59FN9TAZtsZmPTAebKfj8C1o25ch7cgvqZ9K9Qx7djETHsktn9lafc3CRNRY
        Fh/B9x4Pt6g/t6jjKDkUigW04z2DTlsACxnYIZvIfjLjqCbCj8sgqPEpvU1TFyESjPwVNs
        T1IjuutMnJAGDmRUjW46isB/sas6PhM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-QrSVV0_8OUS5ORxn_cgIlQ-1; Sat, 17 Jul 2021 12:00:57 -0400
X-MC-Unique: QrSVV0_8OUS5ORxn_cgIlQ-1
Received: by mail-ed1-f69.google.com with SMTP id e1-20020a0564021481b02903a66550f6f4so6433891edv.21
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQN///39LYTf5bs3PAw2N5VQye+x4FsEFMtGYeBQPAM=;
        b=LwFhogUjits+YkWeCa8sMkON3XspWPmKIY7HqVx2/WKHvymsQX+Cyvn0EZ9fHohVLc
         CcGK6IUbujfIO+gf5hxvpoEVIUS1wuiFF7BHOFmygUX0oxwsupHwiEWHvLMBXbKn5T0m
         qMk1GBBEIsDXdrWk1RKEiy9jpTxtkmNLry16WdL3Cr91DAe0cM2v5sTHJ4VHSYmNToQu
         nY36jqKv+8Dg5PIbMfxndbKHu3P8TgW5AT4obCnp8KNrgAOF7xmTFCTQ87ojEvv+PLaU
         OfiSdymRbYjLbOhWvSJWt1lfS3FHQnwBAcNDXTQOBJSh9jb/FYcMT0P05OzSXVsrUL6l
         1wCQ==
X-Gm-Message-State: AOAM530lbE+lHzdP0RbfwwbOK1L1q0AWYZTf9wubg2VBxJKa54t7IppZ
        9Z2unKt3233nbkoXaxrXTDFUKh0kZYjIZpMwf9Ed+ofkIA2wZwGw5GC03hO2zGx9qbsU/dGtB8N
        XySIHK4Zr3bqf3WJxBEgarlMB
X-Received: by 2002:a05:6402:51:: with SMTP id f17mr22595206edu.359.1626537644909;
        Sat, 17 Jul 2021 09:00:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXd8pufIgnk6zakX532QqMqLp5oShzTfmfwvdDqKrgNQJxemHmnl2nYrBvPjzVHwGuOqffew==
X-Received: by 2002:a05:6402:51:: with SMTP id f17mr22595185edu.359.1626537644712;
        Sat, 17 Jul 2021 09:00:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ot18sm3981595ejb.109.2021.07.17.09.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 09:00:44 -0700 (PDT)
Subject: Re: [PATCH 1/4] asus-wmi: Add panel overdrive functionality
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
References: <20210717081323.7925-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce38b30b-5305-f22f-1d14-e8ea00e05a21@redhat.com>
Date:   Sat, 17 Jul 2021 18:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717081323.7925-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/17/21 10:13 AM, Luke D. Jones wrote:
> Some ASUS ROG laptops have the ability to drive the display panel
> a higher rate to eliminate or reduce ghosting.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Looks good, almost there some small remarks inline.


> ---
>  drivers/platform/x86/asus-wmi.c            | 91 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ebaeb7bb80f5..cd881443bc2f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -216,6 +216,9 @@ struct asus_wmi {
>  	// The RSOC controls the maximum charging percentage.
>  	bool battery_rsoc_available;
>  
> +	bool panel_overdrive_available;
> +	bool panel_overdrive;
> +
>  	struct hotplug_slot hotplug_slot;
>  	struct mutex hotplug_lock;
>  	struct mutex wmi_lock;
> @@ -1221,6 +1224,86 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
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
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
> +		asus->panel_overdrive_available = true;
> +		asus->panel_overdrive = result & ASUS_WMI_DSTS_STATUS_BIT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int panel_od_write(struct asus_wmi *asus)
> +{
> +	int err;
> +	u8 value;
> +	u32 retval;

nitpick: Please use upside-down-christmastree style for variable-declarations,
what that means is put the longest line first, so in this case:

	u32 retval;
	u8 value;
	int err;

> +
> +	value = asus->panel_overdrive;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, value, &retval);
> +
> +	if (err) {
> +		pr_warn("Failed to set panel overdrive: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval > 1 || retval < 0) {
> +		pr_warn("Failed to set panel overdrive (retval): 0x%x\n", retval);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "panel_od");
> +
> +	return 0;
> +}
> +
> +static ssize_t panel_od_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	bool mode = asus->panel_overdrive;
> +
> +	return sysfs_emit(buf, "%d\n", mode);
> +}
> +
> +static ssize_t panel_od_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int result;
> +	bool overdrive;
> +	struct asus_wmi *asus = dev_get_drvdata(dev);

Nitpick again, please make this:

	struct asus_wmi *asus = dev_get_drvdata(dev);
	bool overdrive;
	int result;

> +
> +	result = kstrtobool(buf, &overdrive);
> +	if (result == -EINVAL)

Any return from kstrtobool() other then 0 is an error,
for v3 please just make this:

	if (result)
		return result;


> +		return result;
> +
> +	asus->panel_overdrive = overdrive;
> +	result = panel_od_write(asus);
> +
> +	if (result != 0)
> +		return result;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(panel_od);
> +
>  /* Quirks *********************************************************************/
>  
>  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> @@ -2332,6 +2415,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
>  	&dev_attr_throttle_thermal_policy.attr,
> +	&dev_attr_panel_od.attr,
>  	NULL
>  };
>  
> @@ -2357,6 +2441,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
>  		ok = asus->throttle_thermal_policy_available;
> +	else if (attr == &dev_attr_panel_od.attr)
> +		ok = asus->panel_overdrive_available;
>  
>  	if (devid != -1)
>  		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> @@ -2622,6 +2708,10 @@ static int asus_wmi_add(struct platform_device *pdev)
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
> @@ -2709,6 +2799,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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

Regards,

Hans

