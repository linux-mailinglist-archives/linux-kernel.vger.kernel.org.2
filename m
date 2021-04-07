Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50035711E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353778AbhDGPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347396AbhDGPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CY2aVknDkI0MztKSF9mzjfw7Bllhxi8JMxcn2J8lgDw=;
        b=HhgXMhm+OM/+JcrVDp+QwUQLvJfRb0Dvp8Iy3yEvRjvV/XfVM0VVXEIaf1IORDWefxYcno
        Mf0id+sjyR3fCmqGkYPR8xY3PIGBgreU5LqWVaebHh73dTd5zS97UJgeTtzarZYT0bq6Z1
        0dDAGNi5zRSRJhQLUpunFhrfo7lBHwc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-tf8FsMsTObaVr2H5JUMReA-1; Wed, 07 Apr 2021 11:54:19 -0400
X-MC-Unique: tf8FsMsTObaVr2H5JUMReA-1
Received: by mail-ed1-f71.google.com with SMTP id o24so12303717edt.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CY2aVknDkI0MztKSF9mzjfw7Bllhxi8JMxcn2J8lgDw=;
        b=MogLV0WmJI0OlQyNzWd5jFRUB30HXPvd980cguMC/xCHTWrWg+0Lmgtue10USyxezW
         hmVtbhVin9b3dwKlouavxxxMVQMu89gxGwSzgZ57FTCTGiUAjEn/uaowWHsbcIhJ56m8
         0GpBicI4XYrqWvOL9xxWpXTtapwzLn7wGpxRfMEdPVJ5Ubgcb9/WR8a77s4poS4h4F20
         5z3K8J3PXo69e+V8aL6gZD5VwuvB4UOARmcWxolKXG7tfvvjmsR8mRhApOI+ttqo4cAz
         6/3csJBCgYWp1dT0SRhO2EVBccogLrmSxotHecYILIZDoiJxZ4C9Z78OXC+h2FpqtJ5n
         c5YQ==
X-Gm-Message-State: AOAM531a3oO931SvZgHZPcQ61ruMHS3ArKHdnG6dSZ06aCyP2tUnArJT
        n7ca/ee/dvUNNGbw8mmLu1Ttvbe9zrkbhZ5I0EEJPtHZGX0BuWpv/so4IL/F4urDoK1m4Nw6tXM
        ubNw3pBgyREXsaC9M2JQSdpXk
X-Received: by 2002:a05:6402:518c:: with SMTP id q12mr5333026edd.11.1617810858250;
        Wed, 07 Apr 2021 08:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh3Ce5MoWSVG7wduI1XRNOe9ABqlTadtTezJdN2B5H51vorTlm7sQVSndH6UFGa1VeTeUUNw==
X-Received: by 2002:a05:6402:518c:: with SMTP id q12mr5333003edd.11.1617810857970;
        Wed, 07 Apr 2021 08:54:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f21sm2517244edq.55.2021.04.07.08.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:54:17 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
Date:   Wed, 7 Apr 2021 17:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210405204810.339763-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thank you for your new driver and thank you for the quick respin
addressing Barnabás' request to make it a WMI driver.

The code looks good, so merging this should be a no-brainer,
yet I'm not sure if I should merge this driver as-is, let me
explain.

The problem is that I assume that this is based on reverse-engineering?

We have some mixes experiences with reverse-engineered WMI drivers,
sometimes a feature is not supported yet the wmi_evaluate_method()
call happily succeeds. One example of this causing trouble is:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1797d588af15174d4a4e7159dac8c800538e4f8c

At a minimum I think your driver should check in its
probe function that

gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, ...)

actually succeeds on the machine the driver is running on chances
are that Gigabyte has been using the DEADBEEF-2001-0000-00A0-C90629100000
GUID for ages, where as the 0x125 value for GIGABYTE_WMI_TEMPERATURE_QUERY
suggests that this is a pretty new API.

It would be good if you can see if you can find some DSDT-s for older
gigabyte motherboards attached to various distro's bug-tracking systems
or forum posts and see how those respond to an unknown gigabyte_wmi_commandtype.

Another open question to make sure this driver is suitable
as a generic driver (and does not misbehave) is how to figure out
how many temperature sensors there actually are.

Perhaps the WMI interface returns an error when you query an out-of-range
temperature channel?

One option here might be to add a DMI matching table and only load on
systems on that table for now. That table could then perhaps also provide
labels for each of the temperature channels, which is something which
would be nice to have regardless of my worries about how well this driver
will work on motherboards on which it has not been tested.

You could combine this DMI matching table with a "force" module option to
continue with probing on boards which are not on the table to allow users
to test and report their results to you.

And hopefully after a while, when we're confident that the code works
well on most gigabyte boards we can drop the DMI table, or at least
only use it for the channel labels.

Please don't take this the wrong way; I think it is great that you are
working on this. And the quick turnaround of the v2 of this drivers makes
me pretty certain that we can figure something out and get this merged.

Have you tried contacting Gigabyte about this? I don't think the WMI
interface is something which they need to keep secret for competitive
reasons, so maybe they can help? Note if they want you to sign a NDA
of sorts to view docs, then make sure that it contains some language
about them allowing you to release an opensource driver for their
hardware based on the "protected" information.

Regards,

Hans









On 4/5/21 10:48 PM, Thomas Weißschuh wrote:
> Changes since v1:
> * Incorporate feedback from Barnabás Pőcze
>   * Use a WMI driver instead of a platform driver
>   * Let the kernel manage the driver lifecycle
>   * Fix errno/ACPI error confusion
>   * Fix resource cleanup
>   * Document reason for integer casting
> 
> Thank you Barnabás for your review, it is much appreciated.
> 
> -- >8 --
> 
> Tested with a X570 I Aorus Pro Wifi.
> The mainboard contains an ITE IT8688E chip for management.
> This chips is also handled by drivers/hwmon/i87.c but as it is also used
> by the firmware itself it needs an ACPI driver.
> 
> Unfortunately not all sensor registers are handled by the firmware and even
> less are exposed via WMI.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/platform/x86/Kconfig        |  11 +++
>  drivers/platform/x86/Makefile       |   1 +
>  drivers/platform/x86/gigabyte-wmi.c | 138 ++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/platform/x86/gigabyte-wmi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ad4e630e73e2..96622a2106f7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -123,6 +123,17 @@ config XIAOMI_WMI
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called xiaomi-wmi.
>  
> +config GIGABYTE_WMI
> +	tristate "Gigabyte WMI temperature driver"
> +	depends on ACPI_WMI
> +	depends on HWMON
> +	help
> +	  Say Y here if you want to support WMI-based temperature reporting on
> +	  Gigabyte mainboards.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called gigabyte-wmi.
> +
>  config ACERHDF
>  	tristate "Acer Aspire One temperature and fan driver"
>  	depends on ACPI && THERMAL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 60d554073749..1621ebfd04fd 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
>  obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>  obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
>  obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
> +obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
>  
>  # Acer
>  obj-$(CONFIG_ACERHDF)		+= acerhdf.o
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> new file mode 100644
> index 000000000000..8618363e3ccf
> --- /dev/null
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (C) 2021 Thomas Weißschuh <thomas@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
> +
> +enum gigabyte_wmi_commandtype {
> +	GIGABYTE_WMI_BUILD_DATE_QUERY       =   0x1,
> +	GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =   0x2,
> +	GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =   0x4,
> +	GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =   0x5,
> +	GIGABYTE_WMI_TEMPERATURE_QUERY      = 0x125,
> +};
> +
> +struct gigabyte_wmi_args {
> +	u32 arg1;
> +};
> +
> +static int gigabyte_wmi_perform_query(enum gigabyte_wmi_commandtype command,
> +		struct gigabyte_wmi_args *args, struct acpi_buffer *out)
> +{
> +	const struct acpi_buffer in = {
> +		.length = sizeof(*args),
> +		.pointer = args,
> +	};
> +
> +	acpi_status ret = wmi_evaluate_method(GIGABYTE_WMI_GUID, 0x0, command, &in, out);
> +	if (ret == AE_OK) {
> +		return 0;
> +	} else {
> +		return -EIO;
> +	};
> +}
> +
> +static int gigabyte_wmi_query_integer(enum gigabyte_wmi_commandtype command,
> +		struct gigabyte_wmi_args *args, u64 *res)
> +{
> +	union acpi_object *obj;
> +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
> +	int ret;
> +
> +	ret = gigabyte_wmi_perform_query(command, args, &result);
> +	if (ret) {
> +		goto out;
> +	}
> +	obj = result.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		*res = obj->integer.value;
> +		ret = 0;
> +	} else {
> +		ret = -EIO;
> +	}
> +out:
> +	kfree(result.pointer);
> +	return ret;
> +}
> +
> +static int gigabyte_wmi_temperature(u8 sensor, long *res)
> +{
> +	struct gigabyte_wmi_args args = {
> +		.arg1 = sensor,
> +	};
> +	u64 temp;
> +	acpi_status ret;
> +
> +	ret = gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, &args, &temp);
> +	if (ret == 0)
> +		*res = (s8) temp * 1000; // value is a signed 8-bit integer
> +	return ret;
> +}
> +
> +static int gigabyte_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +		u32 attr, int channel, long *val)
> +{
> +	return gigabyte_wmi_temperature(channel, val);
> +}
> +
> +static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +		u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			HWMON_T_INPUT,
> +			HWMON_T_INPUT,
> +			HWMON_T_INPUT,
> +			HWMON_T_INPUT,
> +			HWMON_T_INPUT,
> +			HWMON_T_INPUT),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops gigabyte_wmi_hwmon_ops = {
> +	.read = gigabyte_wmi_hwmon_read,
> +	.is_visible = gigabyte_wmi_hwmon_is_visible,
> +};
> +
> +static const struct hwmon_chip_info gigabyte_wmi_hwmon_chip_info = {
> +	.ops = &gigabyte_wmi_hwmon_ops,
> +	.info = gigabyte_wmi_hwmon_info,
> +};
> +
> +static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct device *hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
> +			"gigabyte_wmi", NULL,
> +			&gigabyte_wmi_hwmon_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct wmi_device_id gigabyte_wmi_id_table[] = {
> +	{ GIGABYTE_WMI_GUID, NULL },
> +	{ },
> +};
> +
> +static struct wmi_driver gigabyte_wmi_driver = {
> +	.driver = {
> +		.name = "gigabyte-wmi",
> +	},
> +	.id_table = gigabyte_wmi_id_table,
> +	.probe = gigabyte_wmi_probe,
> +};
> +module_wmi_driver(gigabyte_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, gigabyte_wmi_id_table);
> +MODULE_AUTHOR("Thomas Weißschuh <thomas@weissschuh.net>");
> +MODULE_DESCRIPTION("Gigabyte Temperature WMI Driver");
> +MODULE_LICENSE("GPL");
> 
> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> 

