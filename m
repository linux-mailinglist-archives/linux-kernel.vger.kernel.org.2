Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D253587E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhDHPIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhDHPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:08:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A9C061761;
        Thu,  8 Apr 2021 08:08:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w70so2543185oie.0;
        Thu, 08 Apr 2021 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9kvcpM+GB+hcoF8XPjUY/KVSJ7PLNU/AOk4id5vTQvQ=;
        b=ooY50HMTV7TabpE15vdOsALr0Pmma9xENiej+cTDzEKbESHuoamXf1+3WN9uqLjhLY
         OnAbcRb47Pn3OK2n1orfWu9PnaH93pWEa/gLqLzNJzSU4EhZ+5a+d3/s7/WSjVl/eUs/
         gxfWb0iI9SPSJIfrKgFRll+45gOTt7CxzyqwGtg4FotspPIbE6bnKrhonDwFvMtLLSXX
         pXvv5ryy0GnmFxc1kZIaNFRFTKUlXBu924OCVudv/vOoX6dCNUA7JMT+mLfdaHp7RmSL
         pK5UvDQ38nlW6foST6WqF5s6YD46L2cRg60LMay+YX7WwT9KGeWPs4xBw+CCar+6PZ9r
         h4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9kvcpM+GB+hcoF8XPjUY/KVSJ7PLNU/AOk4id5vTQvQ=;
        b=r3eT46tArXNXoeSnqc7Zg12H3oNygzaOChYppNSrf/ZjxJpcu4QX0ITfR7Qp5ztrAl
         ash6p+CMhM/OCjzMOEgaWRy9+W9fw7vRNWiQBYwmxK+N/hL1WRTBWwsc9OallI1UeDsQ
         d7xGQZkETt4UBRF/CPjPoc/uz+zWguZNgdMAQX8UylHSgxTNyJ+aYywadFXUJYo+JDyG
         8uLAZjzk146gU4KptdJUw27HKSo3Glv8fh5neof/ZfAo649cJRYSJZy9hcKXsliY/PV4
         9vYRpT6qzVIg7n3zBVO2ajie/n+4C8dxeWvYXlPSclORuwgj0dNwtM+zkXDVuV1lvFjS
         WKNQ==
X-Gm-Message-State: AOAM530pWdRqVPiL+8y8xXWa/G56iir6Tn7IOLbeXyqjSRyZOlwqtWfH
        bnyZFtdlKHFgEQtUYP2BsD5cCbJ1MjY=
X-Google-Smtp-Source: ABdhPJzk3GfCuogST6cIchqVVyrMhoryYcZBPffW4itk183PKzdfBWCPeMOMZvJGnidEE0OMZMdgig==
X-Received: by 2002:aca:240b:: with SMTP id n11mr1583678oic.26.1617894503045;
        Thu, 08 Apr 2021 08:08:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1sm5019306oig.47.2021.04.08.08.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Apr 2021 08:08:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Apr 2021 08:08:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <20210408150821.GA205657@roeck-us.net>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210405204810.339763-1-linux@weissschuh.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 10:48:10PM +0200, Thomas Weißschuh wrote:
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

Originally drivers/platform was supposed to be used for platform specific
code. Not that I have control over it, but I really dislike that more and
more hwmon drivers end up there.

At least hwmon is in good company - I see drivers for various other subsystems
there as well. I just wonder if that is such a good idea. That entire directory
is bypassing subsystem maintainer reviews.

Guenter

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
> -- 
> 2.31.1
> 
