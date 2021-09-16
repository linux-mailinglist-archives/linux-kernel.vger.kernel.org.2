Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD740EC72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhIPV0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhIPV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:26:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B14DC061574;
        Thu, 16 Sep 2021 14:24:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c21so21685946edj.0;
        Thu, 16 Sep 2021 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zSZUXpkg7rRdoKx/7ALOO/8/ze2ohJR8bBFu6JohYs=;
        b=kL3dh5eTSHXtnyoFxUjKxQEyK+5FSjdl29RSMPFeDKxZm13GHbSYPDZq8F172trWWi
         Pnu7lSfEavvfWN+r/jPsKPTIr+mkz8EU3UoFI2LCibJa1KZOgg0XpqWVRYD5MnAOhkQa
         kesxpwPPVy4+Oh3Agl/y/It775CyFE9JtHO+f/IKhaKKvKasLZ+L0JCq/mHmj/5Q2M3E
         AAVYywZIdEFBZMbtdekpLYzBAmLU0cs5CH3GfUFL189nEflzK5oG9jMt2G49urxjjm5I
         wlWGH4D8wbDA2H1mJMu38Kzys44nER5SrYMzPX6GbQ0jeERqp5RRZoguhXLqSlWmvfI2
         dvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zSZUXpkg7rRdoKx/7ALOO/8/ze2ohJR8bBFu6JohYs=;
        b=Iv0NFEDehpOfBOfHNhNcmvHAJsNpXKk5FPd6g3SpM0NJZvWB33FrGuyWMu0wVZdRHz
         ftDmfHnc/OqiYH4iB3MNn5JwN5qhDHZ0JE8kdG1HO6b34UMkjIPkVZuX7eR6abm5wbT+
         ySibMPrM1poga2vRJHg8PIDarHIJN2B2+WTfLoQS0lx5SDbKSuv1ltOPmRSbo0Hjb6oL
         RI6KztePR0gLHoj/c60rjT9zxVz39Pu2GtypucqdlMeOfc57R0yAtwK44Bqr40MBo/Bb
         CM2q5JKUd01PKa3C3L9yA1AJRRgn+SyuMXgt38TiQX+u1cuOcLGL30dJDxU4oqj9FSFT
         8E2w==
X-Gm-Message-State: AOAM533lI+iU5j18HP8nqT963iWJh+5bFpjN6eO9jZ3gyWMTYqGyWdMz
        p5j6EiFe96AbXgInJ8U5BZEW80nUjMCEsA==
X-Google-Smtp-Source: ABdhPJyL5IUNBbrQeDbk+4Ke1zj7Lfn8SPTDba/ureKYG4JQ+7ccDsKqhEHM+TkAGLNQuBcUb9NoXg==
X-Received: by 2002:a17:906:eca7:: with SMTP id qh7mr8561576ejb.45.1631827479532;
        Thu, 16 Sep 2021 14:24:39 -0700 (PDT)
Received: from penguin.lxd (32-46-179-94.pool.ukrtel.net. [94.179.46.32])
        by smtp.gmail.com with ESMTPSA id cb10sm1824501edb.18.2021.09.16.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:24:39 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:24:33 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?B?UMOkcg==?= Ekholm <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] hwmon: (nct6775) Support access via Asus WMI
Message-ID: <20210917002433.27226146@penguin.lxd>
In-Reply-To: <78a08749-5094-b7a6-1672-6087f33c62e3@roeck-us.net>
References: <20210916202233.40334-1-pauk.denis@gmail.com>
        <20210916202233.40334-5-pauk.denis@gmail.com>
        <78a08749-5094-b7a6-1672-6087f33c62e3@roeck-us.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 14:10:49 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/16/21 1:22 PM, Denis Pauk wrote:
> > Support accessing the NCT677x via Asus WMI functions.
> >=20
> > On mainboards that support this way of accessing the chip, the
> > driver will usually not work without this option since in these
> > mainboards, ACPI will mark the I/O port as used.
> >=20
> > Code uses ACPI firmware interface to communicate with sensors with
> > ASUS motherboards:
> > * PRIME B460-PLUS,
> > * ROG CROSSHAIR VIII IMPACT,
> > * ROG STRIX B550-E GAMING,
> > * ROG STRIX B550-F GAMING,
> > * ROG STRIX B550-F GAMING (WI-FI),
> > * ROG STRIX Z490-I GAMING,
> > * TUF GAMING B550M-PLUS,
> > * TUF GAMING B550M-PLUS (WI-FI),
> > * TUF GAMING B550-PLUS,
> > * TUF GAMING X570-PLUS,
> > * TUF GAMING X570-PRO (WI-FI).
> >=20
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D204807
> > Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> > Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
> > Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> > Tested-by: P=C3=A4r Ekholm <pehlm@pekholm.org>
> > Tested-by: <to.eivind@gmail.com>
> > Tested-by: Artem S. Tashkinov <aros@gmx.com>
> > Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
> > Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> >=20
> > ---
> > Changes in v7:
> >    - Remove unrequred & 0xff with int8 variables.
> >    - Make ASUSWMI_UNSUPPORTED_METHOD as default value for WMI
> > responce, before run wmi_evaluate_method().
> >    - Rename ASUSWMI_MGMT2_GUID to ASUSWMI_MONITORING_GUID.
> >    - Replace checks of 'err !=3D -EINVAL' with 'err >=3D 0' for
> > match_string result.
> >=20
> > Changes in v6:
> >    - Minimaze codes inside code inside defined(CONFIG_ACPI_WMI).
> >=20
> > Changes in v5:
> >    - Use IS_ENABLED(CONFIG_ACPI_WMI) instead
> > defined(CONFIG_ACPI_WMI)
> >=20
> > Changes in v4:
> >    - Fix build without ACPI WMI.
> >=20
> > Changes in v3:
> >    - Remove unrequired type conversions.
> >    - Save result of match_string before check.
> >=20
> > Changes in v2:
> >    - Split changes to separate patches.
> >    - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
> > ---
> >   drivers/hwmon/Kconfig   |   1 +
> >   drivers/hwmon/nct6775.c | 230
> > ++++++++++++++++++++++++++++++++++++---- 2 files changed, 210
> > insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index e3675377bc5d..9eefb1014b53 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1423,6 +1423,7 @@ config SENSORS_NCT6683
> >   config SENSORS_NCT6775
> >   	tristate "Nuvoton NCT6775F and compatibles"
> >   	depends on !PPC
> > +	depends on ACPI_WMI || ACPI_WMI=3Dn
> >   	select HWMON_VID
> >   	help
> >   	  If you say yes here you get support for the hardware
> > monitoring diff --git a/drivers/hwmon/nct6775.c
> > b/drivers/hwmon/nct6775.c index 4253eed7f5b0..46262d9d3bd9 100644
> > --- a/drivers/hwmon/nct6775.c
> > +++ b/drivers/hwmon/nct6775.c
> > @@ -55,6 +55,7 @@
> >   #include <linux/dmi.h>
> >   #include <linux/io.h>
> >   #include <linux/nospec.h>
> > +#include <linux/wmi.h>
> >   #include "lm75.h"
> >  =20
> >   #define USE_ALTERNATE
> > @@ -132,10 +133,13 @@ MODULE_PARM_DESC(fan_debounce, "Enable
> > debouncing for fan RPM signal"); #define SIO_ID_MASK
> > 0xFFF8=20
> >   enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3,
> > sf4 }; +enum sensor_access { access_direct, access_asuswmi };
> >  =20
> >   struct nct6775_sio_data {
> >   	int sioreg;
> > +	int ld;
> >   	enum kinds kind;
> > +	enum sensor_access access;
> >  =20
> >   	/* superio_() callbacks  */
> >   	void (*sio_outb)(struct nct6775_sio_data *sio_data, int
> > reg, int val); @@ -145,6 +149,90 @@ struct nct6775_sio_data {
> >   	void (*sio_exit)(struct nct6775_sio_data *sio_data);
> >   };
> >  =20
> > +#define ASUSWMI_MONITORING_GUID
> > "466747A0-70EC-11DE-8A39-0800200C9A66" +#define
> > ASUSWMI_METHODID_RSIO		0x5253494F +#define
> > ASUSWMI_METHODID_WSIO		0x5753494F +#define
> > ASUSWMI_METHODID_RHWM		0x5248574D +#define
> > ASUSWMI_METHODID_WHWM		0x5748574D +#define
> > ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE +
> > +static int asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg,
> > u8 val, u32 *retval) +{
What do you thin about rename asuswmi_evaluate_method() to
asuswmi_monitoring_method()? I have found that kernel already have
asus_wmi_evaluate_method() that has used different method GUID, so
looks as make sense to use different function name. It uses different
constants with different names/values and does not intersect with this
one.
> > +#if IS_ENABLED(CONFIG_ACPI_WMI)
> > +	u32 args =3D bank | (reg << 8) | (val << 16);
> > +	struct acpi_buffer input =3D { (acpi_size) sizeof(args),
> > &args };
> > +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > +	acpi_status status;
> > +	union acpi_object *obj;
> > +	u32 tmp =3D ASUSWMI_UNSUPPORTED_METHOD;
> > +
> > +	status =3D wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0,
> > +				     method_id, &input, &output);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	obj =3D output.pointer;
> > +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
> > +		tmp =3D obj->integer.value;
> > +
> > +	if (retval)
> > +		*retval =3D tmp;
> > +
> > +	kfree(obj);
> > +
> > +	if (tmp =3D=3D ASUSWMI_UNSUPPORTED_METHOD)
> > +		return -ENODEV;
> > +	return 0;
> > +#else
> > +	return -EOPNOTSUPP;
> > +#endif
> > +}
> > +
> > +static inline int nct6775_asuswmi_write(u8 bank, u8 reg, u8 val)
> > +{
> > +	return asuswmi_evaluate_method(ASUSWMI_METHODID_WHWM, bank,
> > +							      reg,
> > val, NULL); +}
> > +
> > +static inline int nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)
> > +{
> > +	u32 tmp =3D 0;
> > +	int ret =3D asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM,
> > bank,
> > +				     reg, 0, &tmp);
> > +	*val =3D tmp;
> > +	return ret;
> > +}
> > +
> > +static int superio_wmi_inb(struct nct6775_sio_data *sio_data, int
> > reg) +{
> > +	int tmp;
> > +
> > +	asuswmi_evaluate_method(ASUSWMI_METHODID_RSIO,
> > sio_data->ld,
> > +				reg, 0, &tmp);
> > +	return tmp;
> > +}
> > +
> > +static void superio_wmi_outb(struct nct6775_sio_data *sio_data,
> > int reg, int val) +{
> > +	asuswmi_evaluate_method(ASUSWMI_METHODID_WSIO,
> > sio_data->ld,
> > +				reg, val, NULL);
> > +}
> > +
> > +static void superio_wmi_select(struct nct6775_sio_data *sio_data,
> > int ld) +{
> > +	sio_data->ld =3D ld;
> > +}
> > +
> > +static int superio_wmi_enter(struct nct6775_sio_data *sio_data)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void superio_wmi_exit(struct nct6775_sio_data *sio_data)
> > +{
> > +}
> > +
> >   static void superio_outb(struct nct6775_sio_data *sio_data, int
> > reg, int val) {
> >   	int ioreg =3D sio_data->sioreg;
> > @@ -207,6 +295,7 @@ static void superio_exit(struct
> > nct6775_sio_data *sio_data)=20
> >   #define NCT6775_REG_BANK	0x4E
> >   #define NCT6775_REG_CONFIG	0x40
> > +#define NCT6775_PORT_CHIPID	0x58
> >  =20
> >   /*
> >    * Not currently used:
> > @@ -1423,6 +1512,45 @@ static bool is_word_sized(struct
> > nct6775_data *data, u16 reg) return false;
> >   }
> >  =20
> > +static inline void nct6775_wmi_set_bank(struct nct6775_data *data,
> > u16 reg) +{
> > +	u8 bank =3D reg >> 8;
> > +
> > +	data->bank =3D bank;
> > +}
> > +
> > +static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16
> > reg) +{
> > +	int res, word_sized =3D is_word_sized(data, reg);
> > +	u8 tmp;
> > +
> > +	nct6775_wmi_set_bank(data, reg);
> > +
> > +	nct6775_asuswmi_read(data->bank, reg, &tmp);
> > +	res =3D tmp;
> > +	if (word_sized) {
> > +		nct6775_asuswmi_read(data->bank, (reg & 0xff) + 1,
> > &tmp); =20
>=20
> I just realized that all error returns from the wmi access methods
> are ignored. Why ?


Good question, I will check and add checks for all cases. Thank you.

>=20
> > +		res =3D (res << 8) + tmp;
> > +	}
> > +	return res;
> > +}
> > +
> > +static int nct6775_wmi_write_value(struct nct6775_data *data, u16
> > reg, u16 value) +{
> > +	int word_sized =3D is_word_sized(data, reg);
> > +
> > +	nct6775_wmi_set_bank(data, reg);
> > +
> > +	if (word_sized) {
> > +		nct6775_asuswmi_write(data->bank, reg & 0xff,
> > value >> 8);
> > +		nct6775_asuswmi_write(data->bank, (reg & 0xff) +
> > 1, value);
> > +	} else {
> > +		nct6775_asuswmi_write(data->bank, reg & 0xff,
> > value);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   /*
> >    * On older chips, only registers 0x50-0x5f are banked.
> >    * On more recent chips, all registers are banked.
> > @@ -3818,10 +3946,12 @@ static int nct6775_probe(struct
> > platform_device *pdev) struct device *hwmon_dev;
> >   	int num_attr_groups =3D 0;
> >  =20
> > -	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
> > -	if (!devm_request_region(&pdev->dev, res->start,
> > IOREGION_LENGTH,
> > -				 DRVNAME))
> > -		return -EBUSY;
> > +	if (sio_data->access =3D=3D access_direct) {
> > +		res =3D platform_get_resource(pdev, IORESOURCE_IO,
> > 0);
> > +		if (!devm_request_region(&pdev->dev, res->start,
> > IOREGION_LENGTH,
> > +					 DRVNAME))
> > +			return -EBUSY;
> > +	}
> >  =20
> >   	data =3D devm_kzalloc(&pdev->dev, sizeof(struct
> > nct6775_data), GFP_KERNEL);
> > @@ -3830,9 +3960,16 @@ static int nct6775_probe(struct
> > platform_device *pdev)=20
> >   	data->kind =3D sio_data->kind;
> >   	data->sioreg =3D sio_data->sioreg;
> > -	data->addr =3D res->start;
> > -	data->read_value =3D nct6775_read_value;
> > -	data->write_value =3D nct6775_write_value;
> > +
> > +	if (sio_data->access =3D=3D access_direct) {
> > +		data->addr =3D res->start;
> > +		data->read_value =3D nct6775_read_value;
> > +		data->write_value =3D nct6775_write_value;
> > +	} else {
> > +		data->read_value =3D nct6775_wmi_read_value;
> > +		data->write_value =3D nct6775_wmi_write_value;
> > +	}
> > +
> >   	mutex_init(&data->update_lock);
> >   	data->name =3D nct6775_device_names[data->kind];
> >   	data->bank =3D 0xff;		/* Force initial bank
> > selection */ @@ -4743,6 +4880,7 @@ static int __init
> > nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data) int
> > err; int addr;
> >  =20
> > +	sio_data->access =3D access_direct;
> >   	sio_data->sioreg =3D sioaddr;
> >  =20
> >   	err =3D sio_data->sio_enter(sio_data);
> > @@ -4837,6 +4975,23 @@ static int __init nct6775_find(int sioaddr,
> > struct nct6775_sio_data *sio_data) */
> >   static struct platform_device *pdev[2];
> >  =20
> > +static const char * const asus_wmi_boards[] =3D {
> > +	"PRIME B460-PLUS",
> > +	"ROG CROSSHAIR VIII DARK HERO",
> > +	"ROG CROSSHAIR VIII HERO",
> > +	"ROG CROSSHAIR VIII IMPACT",
> > +	"ROG STRIX B550-E GAMING",
> > +	"ROG STRIX B550-F GAMING",
> > +	"ROG STRIX B550-F GAMING (WI-FI)",
> > +	"ROG STRIX Z490-I GAMING",
> > +	"TUF GAMING B550M-PLUS",
> > +	"TUF GAMING B550M-PLUS (WI-FI)",
> > +	"TUF GAMING B550-PLUS",
> > +	"TUF GAMING X570-PLUS",
> > +	"TUF GAMING X570-PLUS (WI-FI)",
> > +	"TUF GAMING X570-PRO (WI-FI)",
> > +};
> > +
> >   static int __init sensors_nct6775_init(void)
> >   {
> >   	int i, err;
> > @@ -4845,11 +5000,32 @@ static int __init sensors_nct6775_init(void)
> >   	struct resource res;
> >   	struct nct6775_sio_data sio_data;
> >   	int sioaddr[2] =3D { 0x2e, 0x4e };
> > +	enum sensor_access access =3D access_direct;
> > +	const char *board_vendor, *board_name;
> > +	u8 tmp;
> >  =20
> >   	err =3D platform_driver_register(&nct6775_driver);
> >   	if (err)
> >   		return err;
> >  =20
> > +	board_vendor =3D dmi_get_system_info(DMI_BOARD_VENDOR);
> > +	board_name =3D dmi_get_system_info(DMI_BOARD_NAME);
> > +
> > +	if (board_name && board_vendor &&
> > +	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> > +		err =3D match_string(asus_wmi_boards,
> > ARRAY_SIZE(asus_wmi_boards),
> > +				   board_name);
> > +		if (err >=3D 0) {
> > +			/* if reading chip id via WMI succeeds,
> > use WMI */
> > +			if (!nct6775_asuswmi_read(0,
> > NCT6775_PORT_CHIPID, &tmp)) {
> > +				pr_info("Using Asus WMI to access
> > %#x chip.\n", tmp);
> > +				access =3D access_asuswmi;
> > +			} else {
> > +				pr_err("Can't read ChipID by Asus
> > WMI.\n");
> > +			}
> > +		}
> > +	}
> > +
> >   	/*
> >   	 * initialize sio_data->kind and sio_data->sioreg.
> >   	 *
> > @@ -4870,6 +5046,16 @@ static int __init sensors_nct6775_init(void)
> >  =20
> >   		found =3D true;
> >  =20
> > +		sio_data.access =3D access;
> > +
> > +		if (access =3D=3D access_asuswmi) {
> > +			sio_data.sio_outb =3D superio_wmi_outb;
> > +			sio_data.sio_inb =3D superio_wmi_inb;
> > +			sio_data.sio_select =3D superio_wmi_select;
> > +			sio_data.sio_enter =3D superio_wmi_enter;
> > +			sio_data.sio_exit =3D superio_wmi_exit;
> > +		}
> > +
> >   		pdev[i] =3D platform_device_alloc(DRVNAME, address);
> >   		if (!pdev[i]) {
> >   			err =3D -ENOMEM;
> > @@ -4881,23 +5067,25 @@ static int __init sensors_nct6775_init(void)
> >   		if (err)
> >   			goto exit_device_put;
> >  =20
> > -		memset(&res, 0, sizeof(res));
> > -		res.name =3D DRVNAME;
> > -		res.start =3D address + IOREGION_OFFSET;
> > -		res.end =3D address + IOREGION_OFFSET +
> > IOREGION_LENGTH - 1;
> > -		res.flags =3D IORESOURCE_IO;
> > +		if (sio_data.access =3D=3D access_direct) {
> > +			memset(&res, 0, sizeof(res));
> > +			res.name =3D DRVNAME;
> > +			res.start =3D address + IOREGION_OFFSET;
> > +			res.end =3D address + IOREGION_OFFSET +
> > IOREGION_LENGTH - 1;
> > +			res.flags =3D IORESOURCE_IO;
> > +
> > +			err =3D acpi_check_resource_conflict(&res);
> > +			if (err) {
> > +				platform_device_put(pdev[i]);
> > +				pdev[i] =3D NULL;
> > +				continue;
> > +			}
> >  =20
> > -		err =3D acpi_check_resource_conflict(&res);
> > -		if (err) {
> > -			platform_device_put(pdev[i]);
> > -			pdev[i] =3D NULL;
> > -			continue;
> > +			err =3D
> > platform_device_add_resources(pdev[i], &res, 1);
> > +			if (err)
> > +				goto exit_device_put;
> >   		}
> >  =20
> > -		err =3D platform_device_add_resources(pdev[i], &res,
> > 1);
> > -		if (err)
> > -			goto exit_device_put;
> > -
> >   		/* platform_device_add calls probe() */
> >   		err =3D platform_device_add(pdev[i]);
> >   		if (err)
> >  =20
>=20

