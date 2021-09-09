Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06B3405BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhIIRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:02:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:32369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237081AbhIIRCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:02:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="200374834"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="200374834"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 10:01:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="504529799"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 10:01:39 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mONQe-001iIr-S4;
        Thu, 09 Sep 2021 20:01:36 +0300
Date:   Thu, 9 Sep 2021 20:01:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?iso-8859-1?B?UORy?= Ekholm <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (nct6775) Support access via Asus WMI (v2)
Message-ID: <YTo98BIZjtlHtGrH@smile.fi.intel.com>
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
 <20210908213605.9929-1-pauk.denis@gmail.com>
 <20210908213605.9929-3-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908213605.9929-3-pauk.denis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:36:04AM +0300, Denis Pauk wrote:
> Support accessing the NCT677x via Asus WMI functions.
> 
> On mainboards that support this way of accessing the chip,
> the driver will usually not work without this option since
> in these mainboards, ACPI will mark the I/O port as used.

...

> +static int asuswmi_evaluate_method(u32 method_id,
> +		u8 bank, u8 reg, u8 val, u32 *retval)

Indentation can be better.
Ditto for many lines in this change.

> +{
> +	u32 args = bank | (reg << 8) | (val << 16);
> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *obj;
> +	u32 tmp = 0;
> +
> +	status = wmi_evaluate_method(ASUSWMI_MGMT2_GUID, 0, method_id,
> +				     &input, &output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;

> +	obj = (union acpi_object *)output.pointer;

Do you need casting?

> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		tmp = (u32) obj->integer.value;

Ditto.

> +	if (retval)
> +		*retval = tmp;
> +
> +	kfree(obj);
> +
> +	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
> +		return -ENODEV;
> +	return 0;
> +}

...

> +static inline int
> +nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)

One line.

> +{
> +	u32 tmp;
> +	int ret = asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM, bank, reg, 0, &tmp);

> +	*val = tmp & 0xff;

Do you need  ' & 0xff' part?

> +	return ret;
> +}

...

> +	if (data->access == access_asuswmi) {
> +		data->bank = bank;
> +		return;
> +	}

It means you have to introduce a new callback ->set_bank() (in a separate change).

...

> +	if (data->access == access_asuswmi) {
> +		nct6775_asuswmi_read(data->bank, reg, &tmp);
> +		res = (tmp & 0xff);
> +		if (word_sized) {
> +			nct6775_asuswmi_read(data->bank,
> +					(reg & 0xff) + 1, &tmp);
> +			res = (res << 8) + (tmp & 0xff);
> +		}
> +		return res;
> +	}

Similar.

...

> +	if (data->access == access_asuswmi) {
> +		if (word_sized) {
> +			nct6775_asuswmi_write(data->bank, (reg & 0xff),
> +					(value >> 8) & 0xff);
> +			nct6775_asuswmi_write(data->bank, (reg & 0xff) + 1,
> +					value & 0xff);
> +		} else {
> +			nct6775_asuswmi_write(data->bank, (reg & 0xff),
> +					value);
> +		}
> +
> +		return 0;
> +	}

Similar.

...

> +	if (sio_data->access == access_direct) {
> +		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +		if (!res)
> +			return -EBUSY;
>  
> -	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
> -				 DRVNAME))
> -		return -EBUSY;
> +		if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
> +					 DRVNAME))
> +			return -EBUSY;
> +	}

Maybe it should be part of some kind of ->setup()?

...

> +static const char * const asus_wmi_boards[] = {
> +	"PRIME B460-PLUS",
> +	"ROG CROSSHAIR VIII IMPACT",
> +	"ROG STRIX B550-E GAMING",
> +	"ROG STRIX B550-F GAMING (WI-FI)",
> +	"ROG STRIX Z490-I GAMING",
> +	"TUF GAMING B550M-PLUS",
> +	"TUF GAMING B550M-PLUS (WI-FI)",
> +	"TUF GAMING B550-PLUS",
> +	"TUF GAMING X570-PLUS",

> +	"TUF GAMING X570-PRO (WI-FI)"

+ comma at the end.

> +};

...

> +		if (match_string(asus_wmi_boards,
> +				ARRAY_SIZE(asus_wmi_boards), board_name) != -EINVAL) {

	err = match_string(...);
	if (err < 0) {
		...
	}

> +			/* if reading chip id via WMI succeeds, use WMI */
> +			if (!nct6775_asuswmi_read(0, NCT6775_REG_CHIPID, &tmp)) {
> +				pr_info("Using Asus WMI to access chip\n");
> +				access = access_asuswmi;
> +			}
> +		}

-- 
With Best Regards,
Andy Shevchenko


