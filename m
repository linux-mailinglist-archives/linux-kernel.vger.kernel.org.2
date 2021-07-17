Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00A23CC459
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGQQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhGQQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626537907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXP3RY02VHdTggn/ihL9/I09EOA1IcHfzsvlNx9p8JQ=;
        b=WKz261S06sfe5kMe5HoPGVtS8dsuui2kIg0Ky59T6s3qb+eOeIBeUmF6WpbNF3Wm6apLGo
        TnrR1g4DEKynpO/4NtZ8vvH8ZAiWjckBrTdwIotjZwovqbompjcIcJc6n0uDgG6JRo3h1g
        qmMsm2WXVr8h8RbfQqXi0sb0/a+9peg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-Ls93z7YQNDOax4WeBYEhcg-1; Sat, 17 Jul 2021 12:05:05 -0400
X-MC-Unique: Ls93z7YQNDOax4WeBYEhcg-1
Received: by mail-ed1-f70.google.com with SMTP id j25-20020aa7ca590000b029039c88110440so6480606edt.15
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wXP3RY02VHdTggn/ihL9/I09EOA1IcHfzsvlNx9p8JQ=;
        b=VSW1CWpwqF9+S/+EIGgoSyc8FdNBfxNy5CnBI6vCDWH0WNX14V8V9H95VPf2aZ3dJo
         oSiWCXhJbpKdCKuOagybD0Tm2ShNxuGwMROPllZJp5R1Gibu8J/wGcIM0PgM0NbTFdkK
         DoUcC1oK20wzQMWYWL9HfKqsZuyFIXU0g2xXpiEiqi4EIxBE7afBj1FPBJ6omK7jMBVN
         UIU3Hs6q1SX5voFyugutdsoccgtmItNdzkuRQk6T2DScJaWsYH7dEvNNQcA15RtUfOx2
         7Agr1d4x90JGMdJT4YEtryaEy0dODa2khqQ9PO0nXO21ri1heHrJ0lduew5I8wjGdVdp
         jUrw==
X-Gm-Message-State: AOAM532dna2eAehukfbmSf+QSbYH2IeYt0Kstz0QSIGAYfDg/U0Ce77y
        G+kpqjci6rYcgx9mPYxbZn6xpIx1gUcUjk1JclFoL6z0WeopHIUPX1DgCGY0xnYgazbsv3UYRF6
        MrTUUTcFe7XVDZMTYPnZ3OW8k
X-Received: by 2002:a17:906:2dc9:: with SMTP id h9mr18431591eji.345.1626537904343;
        Sat, 17 Jul 2021 09:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx2ulyoT1xas2H/0733y/dAI/IYXCLug5GaUc6/nrplVy2zU+Pt56VMKFkKinJEi9X4AwW9A==
X-Received: by 2002:a17:906:2dc9:: with SMTP id h9mr18431578eji.345.1626537904178;
        Sat, 17 Jul 2021 09:05:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ch27sm5272195edb.57.2021.07.17.09.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 09:05:03 -0700 (PDT)
Subject: Re: [PATCH 2/4] asus-wmi: Add dgpu disable method
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
References: <20210717081323.7925-1-luke@ljones.dev>
 <20210717081323.7925-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eed70640-6252-45f8-848f-bc5890f7807b@redhat.com>
Date:   Sat, 17 Jul 2021 18:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717081323.7925-2-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/17/21 10:13 AM, Luke D. Jones wrote:
> In Windows the ASUS Armory Crate program can enable or disable the
> dGPU via a WMI call. This functions much the same as various Linux
> methods in software where the dGPU is removed from the device tree.
> 
> However the WMI call saves the state of dGPU (enabled or not) and
> this then changes the dGPU visibility in Linux with no way for
> Linux users to re-enable it. We expose the WMI method so users can
> see and change the dGPU ACPI state.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 99 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>  2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index cd881443bc2f..02762a60d27a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -210,6 +210,9 @@ struct asus_wmi {
>  	u8 fan_boost_mode_mask;
>  	u8 fan_boost_mode;
>  
> +	bool dgpu_disable_available;
> +	bool dgpu_disable;
> +
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
>  
> @@ -427,6 +430,94 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
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
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
> +		asus->dgpu_disable_available = true;
> +		asus->dgpu_disable = result & ASUS_WMI_DSTS_STATUS_BIT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dgpu_disable_write(struct asus_wmi *asus)
> +{
> +	int err;
> +	u8 value;
> +	u32 retval;

Upside-down-christmastree declaration order please.

> +
> +	value = asus->dgpu_disable;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
> +
> +	if (err) {
> +		pr_warn("Failed to set dgpu disable: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval > 1 || retval < 0) {
> +		pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_disable");
> +
> +	return 0;
> +}
> +
> +static ssize_t dgpu_disable_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	bool mode = asus->dgpu_disable;

This bool local variable is not really necessary, instead you can just do:

	return sysfs_emit(buf, "%d\n", asus->dgpu_disable);

The same applies to patch 1/3 btw.

> +
> +	return sysfs_emit(buf, "%d\n", mode);
> +}
> +
> +static ssize_t dgpu_disable_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int result;
> +	bool disable;
> +	struct asus_wmi *asus = dev_get_drvdata(dev);

Upside-down-christmastree declaration order please.

> +
> +	result = kstrtobool(buf, &disable);
> +	if (result == -EINVAL)
> +		return result;

Just "if (result) ..." please.

> +
> +	asus->dgpu_disable = disable;
> +	/*
> +	 * The ACPI call used does not save the mode unless the call is run twice.
> +	 * Once to disable, then once to check status and save - this is two code
> +	 * paths in the method in the ACPI dumps.
> +	*/
> +	result = dgpu_disable_write(asus);
> +	if (result != 0)
> +		return result;
> +
> +	result = dgpu_disable_write(asus);
> +	if (result != 0)
> +		return result;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(dgpu_disable);
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -2411,6 +2502,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_camera.attr,
>  	&dev_attr_cardr.attr,
>  	&dev_attr_touchpad.attr,
> +	&dev_attr_dgpu_disable.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> @@ -2437,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_LID_RESUME;
>  	else if (attr == &dev_attr_als_enable.attr)
>  		devid = ASUS_WMI_DEVID_ALS_ENABLE;
> +	else if (attr == &dev_attr_dgpu_disable.attr)
> +		ok = asus->dgpu_disable_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> @@ -2698,6 +2792,10 @@ static int asus_wmi_add(struct platform_device *pdev)
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
> @@ -2798,6 +2896,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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

Regards,

Hans

