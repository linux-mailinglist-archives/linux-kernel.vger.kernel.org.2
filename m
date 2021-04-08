Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2160358749
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhDHOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:40:10 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:41998 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhDHOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:40:05 -0400
Date:   Thu, 8 Apr 2021 16:39:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1617892789;
        bh=eawHhWnZrhj3EwvJjSXCOh9KssxWRfjXIYrC8hWM9Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nR5KXRCmNmogKrWvoW7jwDcIWxva0F0RH3oGPMuigRneVHQabY63jpFKpXtYHyvU4
         9vTp/1XQpNVAlFjaBhX9CszJznbyHvqh/7gmCaZGP7hAOA0qPD3EZ0hHD9Q40J3Ib1
         NBLnXD0r22F69ktd6qgYTQ4CntG/pPGuhrR8/2c4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <0c3ef6d2-6e95-4dd9-b9d4-41f5e70bc574@t-8ch.de>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <eAi-yoXOCIOZAGOkYXGYZrUI6OuRrL5Fn9xBzHI1tJSgURTkMRifhlz9OHPB5FUxYLLzMARFmIP0HHR5oPgQMS0LJkga6deoVol0MYQuceA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eAi-yoXOCIOZAGOkYXGYZrUI6OuRrL5Fn9xBzHI1tJSgURTkMRifhlz9OHPB5FUxYLLzMARFmIP0HHR5oPgQMS0LJkga6deoVol0MYQuceA=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mi, 2021-04-07T18:27+0000, Barnabás Pőcze wrote:
> 2021. április 5., hétfő 22:48 keltezéssel, Thomas Weißschuh írta:
> > Tested with a X570 I Aorus Pro Wifi.
> > The mainboard contains an ITE IT8688E chip for management.
> > This chips is also handled by drivers/hwmon/i87.c but as it is also used
> > by the firmware itself it needs an ACPI driver.
> 
> I gather this means you're getting the
> 
>   ACPI Warning: SystemIO range ... conflicts with ...
>   ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> 
> warning?

Exactly.

> > +struct gigabyte_wmi_args {
> > +	u32 arg1;
> > +};
> > +
> > +static int gigabyte_wmi_perform_query(enum gigabyte_wmi_commandtype command,
> > +		struct gigabyte_wmi_args *args, struct acpi_buffer *out)
> > +{
> > +	const struct acpi_buffer in = {
> > +		.length = sizeof(*args),
> > +		.pointer = args,
> > +	};
> > +
> > +	acpi_status ret = wmi_evaluate_method(GIGABYTE_WMI_GUID, 0x0, command, &in, out);
> 
> Ideally, you'd use the WMI device that was passed to the probe method to do the query
> using `wmidev_evaluate_method()`. You can pass the WMI device pointer
> to `devm_hwmon_device_register_with_info()` in the `drvdata` argument,
> then in the ->read() callback you can retrieve it:
> 
>   static int gigabyte_wmi_hwmon_read(struct device *dev, ...)
>   {
>     struct wmi_device *wdev = dev_get_drvdata(dev);
> 
> and then you can pass that to the other functions.

Done.

> > +	if (ret == AE_OK) {
> > +		return 0;
> > +	} else {
> > +		return -EIO;
> > +	};
> 
> The `;` is not needed. And please use `ACPI_FAILURE()` or `ACPI_SUCCESS()`
> to check the returned value. For example:
> 
>   acpi_status ret = ...;
>   if (ACPI_FAILURE(ret))
>     return -EIO;
> 
>   return 0;

Done.

> > +}
> > +
> > +static int gigabyte_wmi_query_integer(enum gigabyte_wmi_commandtype command,
> > +		struct gigabyte_wmi_args *args, u64 *res)
> > +{
> > +	union acpi_object *obj;
> > +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	int ret;
> > +
> > +	ret = gigabyte_wmi_perform_query(command, args, &result);
> > +	if (ret) {
> > +		goto out;
> 
> I believe if this branch is taken, no buffer is allocated (due to the failure),
> so you can just `return ret;` here and do away with the goto completely - if I'm not mistaken.

Done.

> > +static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
> > +	HWMON_CHANNEL_INFO(temp,
> > +			HWMON_T_INPUT,
> > +			HWMON_T_INPUT,
> > +			HWMON_T_INPUT,
> > +			HWMON_T_INPUT,
> > +			HWMON_T_INPUT,
> > +			HWMON_T_INPUT),
> > +	NULL,
>             ^
> Minor thing: usually commas after sentinel values are omitted.

Done.

> > +static const struct wmi_device_id gigabyte_wmi_id_table[] = {
> > +	{ GIGABYTE_WMI_GUID, NULL },
> > +	{ },
>            ^
> Same here.

Done.

> 
> > +};
> > +
> > +static struct wmi_driver gigabyte_wmi_driver = {
> > +	.driver = {
> > +		.name = "gigabyte-wmi",
> > +	},
> > +	.id_table = gigabyte_wmi_id_table,
> > +	.probe = gigabyte_wmi_probe,
> > +};
> > +module_wmi_driver(gigabyte_wmi_driver);
> > +
> > +MODULE_DEVICE_TABLE(wmi, gigabyte_wmi_id_table);
> > +MODULE_AUTHOR("Thomas Weißschuh <thomas@weissschuh.net>");
> > +MODULE_DESCRIPTION("Gigabyte Temperature WMI Driver");
> 
> It's a very minor thing, but could you please
> synchronize this description with the Kconfig?

Of course.

Thanks again for the review!

Thomas
