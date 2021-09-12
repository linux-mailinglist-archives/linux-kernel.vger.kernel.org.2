Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BF6408209
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhILWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 18:22:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF421C061574;
        Sun, 12 Sep 2021 15:20:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w144so11578696oie.13;
        Sun, 12 Sep 2021 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=S6QydbH+nLhh9VI1dxzK/7xA5Ru/z0ga0LXOzck6vFk=;
        b=MX14xm6JWW9JRApxKAR64/UN5+8bNL3cIsQnrKiJiYU+sqWDT+rGsHuRXfzTLGmeD/
         HYDdzrUrAAuchj7yhJPO08pSXpaM0hO+/LRxR+9DwlYSM1UTokG1PtdjlvVab7nxAxlm
         njr7l288MwZP5NPSd9MPCmvHhdrk3Hj1o830Bsz93OeinQIqrwG8AutrxiAKXc6sF/EE
         PKOlUpxu4vy07xW9lQdHEbjklwcDQ540rFiS3pZv1QptCtFpEHlxDbpc7aLQaJPuZhwW
         OC4P1Y/Db5M09elYMk3m/iUA/SFoCf3lPZmHQF91NuL+Teo4zJU00gUB5r79H1YbNgkl
         aMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=S6QydbH+nLhh9VI1dxzK/7xA5Ru/z0ga0LXOzck6vFk=;
        b=yhSreLz6F1K6OK0HkKfhsbzVwuXZIza7MDWvSNUsg1592LMvAGBR+lP1e998GL/uXe
         R7mV3balqd8LK/mMXUEcOsPOCA7+1CC94nvUAA/iQh0+EX9JDRUa0lZxQnGmjv0HnQ64
         lQMfS3AT1vaG1HqAqmxajnF323YGTAn/IeYDW7Qa1GJKBzvYQO30JdRafc5CorRFa78B
         dSVA6AN45RKdbbWsPE2/reFyxN8gUXH9AJlPT2uWRBB6UxnTG27H1hsHQL2TahFm1b0d
         cb914I2/MfN9yJ7Ui4Qt9Ing8vXl/+XdG12NHA3ExBuq+fPxAb6RvnB3APc9e1pOGl9X
         E7ug==
X-Gm-Message-State: AOAM530Sh3mW5NiWcCnN/SfInYwIH9R5o4AVXGgcL0ocpsfC6P2ajm7E
        JXmGkqScCYW6wQNjj/BekL4=
X-Google-Smtp-Source: ABdhPJwcDvJ5kOIlpJUPpVuA3++dO9ZFGeT5xs9O6H02BAzgB5WlsWbJqYsZEpl77/4DOwtWalPGxQ==
X-Received: by 2002:aca:1b0d:: with SMTP id b13mr5475465oib.162.1631485253060;
        Sun, 12 Sep 2021 15:20:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1sm1414598ott.21.2021.09.12.15.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 15:20:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Sep 2021 15:20:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?iso-8859-1?B?UORy?= Ekholm <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] hwmon: (nct6775) Support access via Asus WMI
Message-ID: <20210912222051.GA2363493@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:25:37AM +0300, Denis Pauk wrote:
> Support accessing the NCT677x via Asus WMI functions.
> 
> On mainboards that support this way of accessing the chip, the driver will
> usually not work without this option since in these mainboards, ACPI will
> mark the I/O port as used.
> 
> Code uses ACPI firmware interface to commucate with sensors with ASUS
> motherboards:
> * PRIME B460-PLUS,
> * ROG CROSSHAIR VIII IMPACT,
> * ROG STRIX B550-E GAMING,
> * ROG STRIX B550-F GAMING,
> * ROG STRIX B550-F GAMING (WI-FI),
> * ROG STRIX Z490-I GAMING,
> * TUF GAMING B550M-PLUS,
> * TUF GAMING B550M-PLUS (WI-FI),
> * TUF GAMING B550-PLUS,
> * TUF GAMING X570-PLUS,
> * TUF GAMING X570-PRO (WI-FI).
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
> Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> Tested-by: Pär Ekholm <pehlm@pekholm.org>
> Tested-by: <to.eivind@gmail.com>
> Tested-by: Artem S. Tashkinov <aros@gmx.com>
> Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
> Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> 
> ---
> Changes in v5:
>   - Use IS_ENABLED(CONFIG_ACPI_WMI) instead defined(CONFIG_ACPI_WMI)

This either needs to be IS_REACHABLE, or better the driver dependencies
need to be changed to

	depends on ACPI_WMI || ACPI_WMI=n

> 
> Changes in v4:
>   - Fix build without ACPI WMI.
> 
> Changes in v3:
>   - Remove unrequired type conversions.
>   - Save result of match_string before check.
> 
> Changes in v2:
>   - Split changes to separate patches.
>   - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
> ---
>  drivers/hwmon/nct6775.c | 244 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 221 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index d813a7478f59..bb1f2039d087 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -55,6 +55,7 @@
>  #include <linux/dmi.h>
>  #include <linux/io.h>
>  #include <linux/nospec.h>
> +#include <linux/wmi.h>
>  #include "lm75.h"
>  
>  #define USE_ALTERNATE
> @@ -132,10 +133,13 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
>  #define SIO_ID_MASK		0xFFF8
>  
>  enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
> +enum sensor_access { access_direct, access_asuswmi };
>  
>  struct nct6775_sio_data {
>  	int sioreg;
> +	int ld;
>  	enum kinds kind;
> +	enum sensor_access access;
>  
>  	/* superio_() callbacks  */
>  	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
> @@ -145,6 +149,86 @@ struct nct6775_sio_data {
>  	void (*sio_exit)(struct nct6775_sio_data *sio_data);
>  };
>  
> +#if IS_ENABLED(CONFIG_ACPI_WMI)

Overall I'd prefer to have most of those #ifdefs dropped and replaced with
an ifdef around asuswmi_evaluate_method() which returns, say, -EOPNOTSUPP
if ACPI_WMI is not enabled.

In practice, CONFIG_ACPI_WMI will pretty much always be enabled,
and the many #ifdefs just make the code more difficult to read
and understand.

> +#define ASUSWMI_MGMT2_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_RSIO		0x5253494F
> +#define ASUSWMI_METHODID_WSIO		0x5753494F
> +#define ASUSWMI_METHODID_RHWM		0x5248574D
> +#define ASUSWMI_METHODID_WHWM		0x5748574D
> +#define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
> +
> +static int asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
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
> +
> +	obj = output.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		tmp = obj->integer.value;
> +
> +	if (retval)
> +		*retval = tmp;
> +
> +	kfree(obj);
> +
> +	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +static inline int nct6775_asuswmi_write(u8 bank, u8 reg, u8 val)
> +{
> +	return asuswmi_evaluate_method(ASUSWMI_METHODID_WHWM, bank, reg, val, 0);
> +}
> +
> +static inline int nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)
> +{
> +	u32 tmp;
> +	int ret = asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM, bank, reg, 0, &tmp);
> +	*val = tmp;
> +	return ret;
> +}
> +
> +static int superio_wmi_inb(struct nct6775_sio_data *sio_data, int reg)
> +{
> +	int tmp;
> +
> +	asuswmi_evaluate_method(ASUSWMI_METHODID_RSIO,
> +			sio_data->ld, reg, 0, &tmp);

Unaligned continuation line, and it is unnecessary to start with.

> +	return tmp;
> +}
> +
> +static void superio_wmi_outb(struct nct6775_sio_data *sio_data, int reg, int val)
> +{
> +	asuswmi_evaluate_method(ASUSWMI_METHODID_WSIO,
> +			sio_data->ld, reg, val, 0);
> +}
> +
> +static void superio_wmi_select(struct nct6775_sio_data *sio_data, int ld)
> +{
> +	sio_data->ld = ld;
> +}
> +
> +static int superio_wmi_enter(struct nct6775_sio_data *sio_data)
> +{
> +	return 0;
> +}
> +
> +static void superio_wmi_exit(struct nct6775_sio_data *sio_data)
> +{
> +}
> +#endif
> +
>  static void superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
>  {
>  	int ioreg = sio_data->sioreg;
> @@ -1423,6 +1507,51 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
>  	return false;
>  }
>  
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +static inline void nct6775_wmi_set_bank(struct nct6775_data *data, u16 reg)
> +{
> +	u8 bank = reg >> 8;
> +
> +	data->bank = bank;
> +}
> +
> +static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
> +{
> +	int res, word_sized = is_word_sized(data, reg);
> +	u8 tmp;
> +
> +	nct6775_wmi_set_bank(data, reg);
> +
> +	nct6775_asuswmi_read(data->bank, reg, &tmp);
> +	res = (tmp & 0xff);
> +	if (word_sized) {
> +		nct6775_asuswmi_read(data->bank,
> +				(reg & 0xff) + 1, &tmp);

<ore unaligned and unnecessary continuation lines.

> +		res = (res << 8) + (tmp & 0xff);
> +	}
> +	return res;
> +}
> +
> +static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value)
> +{
> +	int word_sized = is_word_sized(data, reg);
> +
> +	nct6775_wmi_set_bank(data, reg);
> +
> +	if (word_sized) {
> +		nct6775_asuswmi_write(data->bank, (reg & 0xff),
> +				(value >> 8) & 0xff);
> +		nct6775_asuswmi_write(data->bank, (reg & 0xff) + 1,
> +				value & 0xff);
> +	} else {
> +		nct6775_asuswmi_write(data->bank, (reg & 0xff),
> +				value);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +

Unless I am missing something it should be possible to move this conditional
block together with the first conditional block.

>  /*
>   * On older chips, only registers 0x50-0x5f are banked.
>   * On more recent chips, all registers are banked.
> @@ -3822,13 +3951,15 @@ static int nct6775_probe(struct platform_device *pdev)
>  	struct device *hwmon_dev;
>  	int num_attr_groups = 0;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (!res)
> -		return -EBUSY;
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
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(struct nct6775_data),
>  			    GFP_KERNEL);
> @@ -3837,9 +3968,19 @@ static int nct6775_probe(struct platform_device *pdev)
>  
>  	data->kind = sio_data->kind;
>  	data->sioreg = sio_data->sioreg;
> -	data->addr = res->start;
> -	data->read_value = nct6775_read_value;
> -	data->write_value = nct6775_write_value;
> +
> +	if (sio_data->access == access_direct) {
> +		data->addr = res->start;
> +		data->read_value = nct6775_read_value;
> +		data->write_value = nct6775_write_value;
> +	} else {
> +		data->addr = 0;

Seems unnecessary since it is already 0.

> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +		data->read_value = nct6775_wmi_read_value;
> +		data->write_value = nct6775_wmi_write_value;
> +#endif

This seems just wrong. At the very least there would have to be an #else
case resulting in an abort, but most likely the entire } else { part should
be in #ifdef.

See comment above though about reducing #ifdefs.

> +	}
> +
>  	mutex_init(&data->update_lock);
>  	data->name = nct6775_device_names[data->kind];
>  	data->bank = 0xff;		/* Force initial bank selection */
> @@ -4750,6 +4891,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>  	int err;
>  	int addr;
>  
> +	sio_data->access = access_direct;
>  	sio_data->sioreg = sioaddr;
>  
>  	err = sio_data->sio_enter(sio_data);
> @@ -4844,6 +4986,24 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>   */
>  static struct platform_device *pdev[2];
>  
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +#define NCT6775_REG_CHIPID 0x58

tab after NCT6775_REG_CHIPID please, and that define can be together with
all other register defines.

However, what is the purpose of reading NCT6775_REG_CHIPID and not some
other register that is already defined ?

I don't mind using it if there is a reason, but then at the very least
the comment at the beginning of the file (where it says that the register
is not currently used) should be removed, and the register should be
defined there.

> +
> +static const char * const asus_wmi_boards[] = {
> +	"PRIME B460-PLUS",
> +	"ROG CROSSHAIR VIII IMPACT",
> +	"ROG STRIX B550-E GAMING",
> +	"ROG STRIX B550-F GAMING",
> +	"ROG STRIX B550-F GAMING (WI-FI)",
> +	"ROG STRIX Z490-I GAMING",
> +	"TUF GAMING B550M-PLUS",
> +	"TUF GAMING B550M-PLUS (WI-FI)",
> +	"TUF GAMING B550-PLUS",
> +	"TUF GAMING X570-PLUS",
> +	"TUF GAMING X570-PRO (WI-FI)",
> +};
> +#endif
> +
>  static int __init sensors_nct6775_init(void)
>  {
>  	int i, err;
> @@ -4852,11 +5012,34 @@ static int __init sensors_nct6775_init(void)
>  	struct resource res;
>  	struct nct6775_sio_data sio_data;
>  	int sioaddr[2] = { 0x2e, 0x4e };
> +	enum sensor_access access = access_direct;
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +	const char *board_vendor, *board_name;
> +	u8 tmp;
> +#endif
>  
>  	err = platform_driver_register(&nct6775_driver);
>  	if (err)
>  		return err;
>  
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (board_name && board_vendor &&
> +	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> +		err = match_string(asus_wmi_boards,
> +					ARRAY_SIZE(asus_wmi_boards), board_name);
> +		if (err != -EINVAL) {

		if (err >= 0) {

> +			/* if reading chip id via WMI succeeds, use WMI */
> +			if (!nct6775_asuswmi_read(0, NCT6775_REG_CHIPID, &tmp)) {
> +				pr_info("Using Asus WMI to access chip\n");
> +				access = access_asuswmi;
> +			}
> +		}
> +	}
> +#endif
> +
>  	/*
>  	 * initialize sio_data->kind and sio_data->sioreg.
>  	 *
> @@ -4877,6 +5060,19 @@ static int __init sensors_nct6775_init(void)
>  
>  		found = true;
>  
> +		/* Update access method */

Pointless comment.

> +		sio_data.access = access;
> +
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +		if (access == access_asuswmi) {
> +			sio_data.sio_outb = superio_wmi_outb;
> +			sio_data.sio_inb = superio_wmi_inb;
> +			sio_data.sio_select = superio_wmi_select;
> +			sio_data.sio_enter = superio_wmi_enter;
> +			sio_data.sio_exit = superio_wmi_exit;
> +		}
> +#endif
> +
>  		pdev[i] = platform_device_alloc(DRVNAME, address);
>  		if (!pdev[i]) {
>  			err = -ENOMEM;
> @@ -4888,23 +5084,25 @@ static int __init sensors_nct6775_init(void)
>  		if (err)
>  			goto exit_device_put;
>  
> -		memset(&res, 0, sizeof(res));
> -		res.name = DRVNAME;
> -		res.start = address + IOREGION_OFFSET;
> -		res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
> -		res.flags = IORESOURCE_IO;
> +		if (sio_data.access == access_direct) {
> +			memset(&res, 0, sizeof(res));
> +			res.name = DRVNAME;
> +			res.start = address + IOREGION_OFFSET;
> +			res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
> +			res.flags = IORESOURCE_IO;
> +
> +			err = acpi_check_resource_conflict(&res);
> +			if (err) {
> +				platform_device_put(pdev[i]);
> +				pdev[i] = NULL;
> +				continue;
> +			}
>  
> -		err = acpi_check_resource_conflict(&res);
> -		if (err) {
> -			platform_device_put(pdev[i]);
> -			pdev[i] = NULL;
> -			continue;
> +			err = platform_device_add_resources(pdev[i], &res, 1);
> +			if (err)
> +				goto exit_device_put;
>  		}
>  
> -		err = platform_device_add_resources(pdev[i], &res, 1);
> -		if (err)
> -			goto exit_device_put;
> -
>  		/* platform_device_add calls probe() */
>  		err = platform_device_add(pdev[i]);
>  		if (err)
> -- 
> 2.33.0
> 
