Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01393BC91C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhGFKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhGFKN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625566248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wARO+JtkPU4FsWOT7PxcsZnPDD+Ad8zrK/OhxkHqibs=;
        b=LEaBXBv/KAU2Xmco2OdwgBC04PSXSwm2iAEEoN7Pzc4G8vVg9Z4GyqXrV9PHQETRf5DMhF
        T2KnQC/7AR1IX1ejRfmSt/4xfrXew8h3ByKldKu3wlLYd6cf0euFiS7rO6h+luzg6IwxZf
        lex04PK5iWpaK3LiEdOEBt1G7Vh/Jj8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-ajzAOzcKPqimVH1OK763sQ-1; Tue, 06 Jul 2021 06:10:47 -0400
X-MC-Unique: ajzAOzcKPqimVH1OK763sQ-1
Received: by mail-ej1-f69.google.com with SMTP id hy7-20020a1709068a67b02904cdf8737a75so4792169ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wARO+JtkPU4FsWOT7PxcsZnPDD+Ad8zrK/OhxkHqibs=;
        b=Fp06WqMxLvdqm0b23GvH1naMZ2y09mPIe+QpM/S9s2LBNsnqEjslv82AO2IGBcJVzK
         MuS0e2faIvVjO7hBFAifiMiJedSDd7kOvKrQBeOUgBbaKG3yEz84LpX292WMgw4iJ8D1
         bPt5mtNtN2TUIOrSw3rIMlJRwXckw+KoLhWnplvnbG3THfN4UlJeX3UB1ekUxi2shEBq
         tY4Qpssi0Of2Ap/7pDW7cFYbCX151uFuB+eD2F3aWpaghTLD6rzkKyII/NfJOekOo6hN
         vCQfnk0hmqdomNu8gtevKinTVdZUiI9NWTyEkx662Zt/Tor13r8LqCfVTsik5vO2OrvB
         /DHQ==
X-Gm-Message-State: AOAM5320rpJjtQsr1hxr2HtGHaSZEtjcUjjk2agWdnez3dvgk5mdPI8g
        jNW3VUKaK7oAJZlPeggI/mBVx++xYA5mH4m6M5qMxroF9J4+uaidng/8PG52owABtf+AsaeP/sT
        P7fUy5eY9ZLUW9itskuN4pLMJp049+SV0fzdVa9OdiURyZ4QOyVPokHfoihA53tyc3fRTrhxiGF
        up
X-Received: by 2002:a17:907:7213:: with SMTP id dr19mr17516418ejc.107.1625566246129;
        Tue, 06 Jul 2021 03:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC+r6N+9/mXFbu7ObuiUxW9+TdSFS109tjWi+HMkfAeP2zrIv9twqAQl2fUJdx3D/5aemJ2w==
X-Received: by 2002:a17:907:7213:: with SMTP id dr19mr17516394ejc.107.1625566245913;
        Tue, 06 Jul 2021 03:10:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id br4sm5351256ejb.110.2021.07.06.03.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 03:10:45 -0700 (PDT)
Subject: Re: [PATCH 2/3] asus-wmi: Add dgpu disable method
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210704222148.880848-1-luke@ljones.dev>
 <20210704222148.880848-3-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fa826d11-6cc6-be22-2a8b-b8a76248a5d4@redhat.com>
Date:   Tue, 6 Jul 2021 12:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704222148.880848-3-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some review remarks inline (mostly just echo-ing what Barnabás already said):

On 7/5/21 12:21 AM, Luke D. Jones wrote:
> In Windows the ASUS Armory Crate progrm can enable or disable the
> dGPU via a WMI call. This functions much the same as various Linux
> methods in software where the dGPU is removed from the device tree.
> 
> However the WMI call saves the state of dGPU enabled or not and this
> then changes the dGPU visibility in Linux with no way for Linux
> users to re-enable it. We expose the WMI method so users can see
> and change the dGPU ACPI state.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 98 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>  2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2468076d6cd8..8dc3f7ed021f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -210,6 +210,9 @@ struct asus_wmi {
>  	u8 fan_boost_mode_mask;
>  	u8 fan_boost_mode;
>  
> +	bool dgpu_disable_available;
> +	u8 dgpu_disable_mode;
> +
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
>  
> @@ -427,6 +430,93 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>  	}
>  }
>  
> +/* dGPU ********************************************************************/
> +static int dgpu_disable_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->dgpu_disable_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> +		asus->dgpu_disable_available = true;
> +		asus->dgpu_disable_mode = result & ASUS_WMI_DSTS_STATUS_BIT;

Missing {}

> +
> +	return 0;
> +}
> +
> +static int dgpu_disable_write(struct asus_wmi *asus)
> +{
> +	int err;
> +	u8 value;
> +	u32 retval;
> +
> +	value = asus->dgpu_disable_mode;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> +			"dgpu_disable");

Make this one line please.

> +
> +	if (err) {
> +		pr_warn("Failed to set dgpu disable: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval > 1 || retval < 0) {
> +		pr_warn("Failed to set dgpu disable (retval): 0x%x\n",
> +			retval);

Make this one line please.

> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t dgpu_disable_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 mode = asus->dgpu_disable_mode;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);

sysfs_emit() please.

> +}
> +
> +static ssize_t dgpu_disable_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int result;
> +	u8 disable;
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtou8(buf, 10, &disable);
> +	if (result < 0)
> +		return result;
> +
> +	if (disable > 1 || disable < 0)
> +		return -EINVAL;

Drop the "disable < 0" check please.

> +
> +	asus->dgpu_disable_mode = disable;
> +	/*
> +	 * The ACPI call used does not save the mode unless the call is run twice.
> +	 * Once to disable, then once to check status and save - this is two code
> +	 * paths in the method in the ACPI dumps.
> +	*/
> +	dgpu_disable_write(asus);
> +	dgpu_disable_write(asus);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(dgpu_disable);
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -2412,6 +2502,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_camera.attr,
>  	&dev_attr_cardr.attr,
>  	&dev_attr_touchpad.attr,
> +	&dev_attr_dgpu_disable.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> @@ -2438,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_LID_RESUME;
>  	else if (attr == &dev_attr_als_enable.attr)
>  		devid = ASUS_WMI_DEVID_ALS_ENABLE;
> +	else if (attr == &dev_attr_dgpu_disable.attr)
> +		ok = asus->dgpu_disable_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> @@ -2699,6 +2792,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	if (err)
>  		goto fail_platform;
>  
> +	err = dgpu_disable_check_present(asus);
> +	if (err)
> +		goto fail_dgpu_disable;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> @@ -2799,6 +2896,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_sysfs:
>  fail_throttle_thermal_policy:
>  fail_fan_boost_mode:
> +fail_dgpu_disable:
>  fail_platform:
>  fail_panel_od:
>  	kfree(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 428aea701c7b..a528f9d0e4b7 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -90,6 +90,9 @@
>  /* Keyboard dock */
>  #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
>  
> +/* dgpu on/off */
> +#define ASUS_WMI_DEVID_DGPU		0x00090020
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
> 

Otherwise this looks good to me.

Regards,

Hans

