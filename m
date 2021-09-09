Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C31405BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhIIRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhIIRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:01:25 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E755C061574;
        Thu,  9 Sep 2021 10:00:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso3339359ots.5;
        Thu, 09 Sep 2021 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xKKR6qczWnM+DVT1cLKTQGzcqdqw7UBUC6ng0ENQDdA=;
        b=jwPd6ufkJh4j6AeGl7T21bBkS8TsfPzzGcPIBzeFKtsgLb1/6oR6VFPrGX3MObNUaJ
         K3fhTBrj66zX+U5rCu1+RM+WTOpdVtwr5dgb+gfOsZEv0o1aWZI1IC8tZXPTSiTK4Vwp
         tMS7PxcmXxtQ4jDn5BvEaGRPlMAgvsqJJ7u1p9dXGxaJTrX9KFJ6AHBiRtUgtWUej1mA
         Zr7namuYp38kuT0bMzp2xXEL8HCWEk1dwBr6vSlecL3tG5R/Bofz4gLhkuddOvFBruqZ
         OS5nZcsSbv2gMq6SEcD4mRpdEqKWQX1AKBZek1DgXbtIF/ZdlyBV2/sZ8jgxIqcejO2f
         vEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=xKKR6qczWnM+DVT1cLKTQGzcqdqw7UBUC6ng0ENQDdA=;
        b=1E6QGYjmOY47ClLR9nfntDWyVA0C8sad+0DU10GIuq43gStospTGM+Sh6oj3xN+CZi
         mFvo416ZTFj+OPrl3xrv0T89p50HE6ylCzO4bcuL40Vq9TbTpvJbP+RUsKJvDUQom36d
         5AcpkHaeBSkk42ISnfGEgnku5ZZUGP6ad/KU32F7Ek84c2YnaBbuDo2COX5TBQDVkVPF
         2+SpiJDpNgG38Nxe5/1nos/vDqBrA3q099ynPssjkxVFh0M4oqNMsnf7fhL9FNW7nXdU
         kg4+kTZrJTtniKbZTUylp4ixjDF049zBIoswTP3C3P/qnqZUy+WTciGfXxMy5IROR64d
         oJ6A==
X-Gm-Message-State: AOAM53359TYFkQrZt69ZDJ/ROw3YI5eHNh17PQ+mB2RBVgHRUKzUB8CY
        FUvi+pU3CIAIK/dfFpQLaPQ=
X-Google-Smtp-Source: ABdhPJzZGNv0lfW7unX8VvwOumPKbOsrt5WuaAf989fWhTUrY0vkUucytJGNoNy3pooCtbczBJKW8Q==
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr768791otq.294.1631206815733;
        Thu, 09 Sep 2021 10:00:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v29sm526302ooe.31.2021.09.09.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 10:00:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Sep 2021 10:00:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?iso-8859-1?B?UORy?= Ekholm <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (nct6775) Support access via Asus WMI (v2)
Message-ID: <20210909170013.GC3973437@roeck-us.net>
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
 <20210908213605.9929-1-pauk.denis@gmail.com>
 <20210908213605.9929-3-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908213605.9929-3-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:36:04AM +0300, Denis Pauk wrote:
> Support accessing the NCT677x via Asus WMI functions.
> 
> On mainboards that support this way of accessing the chip,
> the driver will usually not work without this option since
> in these mainboards, ACPI will mark the I/O port as used.
> 
> v2: split changes to separate patches
>     limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: Pär Ekholm <pehlm@pekholm.org>
> Tested-by: <to.eivind@gmail.com>
> Tested-by: Artem S. Tashkinov <aros@gmx.com>
> Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
> ---
>  drivers/hwmon/nct6775.c | 219 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 198 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 908521ce2ee8..ae0344811821 100644
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
>  	void (*outb)(struct nct6775_sio_data *sio_data, int reg, int val);
>  	int (*inb)(struct nct6775_sio_data *sio_data, int reg);
>  	void (*select)(struct nct6775_sio_data *sio_data, int ld);
> @@ -143,6 +147,92 @@ struct nct6775_sio_data {
>  	void (*exit)(struct nct6775_sio_data *sio_data);
>  };
>  
> +#define ASUSWMI_MGMT2_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_RSIO		0x5253494F
> +#define ASUSWMI_METHODID_WSIO		0x5753494F
> +#define ASUSWMI_METHODID_RHWM		0x5248574D
> +#define ASUSWMI_METHODID_WHWM		0x5748574D
> +#define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
> +
> +static int asuswmi_evaluate_method(u32 method_id,
> +		u8 bank, u8 reg, u8 val, u32 *retval)
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
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		tmp = (u32) obj->integer.value;
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
> +static inline int
> +nct6775_asuswmi_write(u8 bank, u8 reg, u8 val)
> +{
> +	return asuswmi_evaluate_method(ASUSWMI_METHODID_WHWM, bank, reg, val, 0);
> +}
> +
> +static inline int
> +nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)
> +{
> +	u32 tmp;
> +	int ret = asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM, bank, reg, 0, &tmp);
> +	*val = tmp & 0xff;
> +	return ret;
> +}
> +
> +static int
> +superio_wmi_inb(struct nct6775_sio_data *sio_data, int reg)
> +{
> +	int tmp;
> +
> +	asuswmi_evaluate_method(ASUSWMI_METHODID_RSIO,
> +			sio_data->ld, reg, 0, &tmp);
> +	return tmp;
> +}
> +
> +static void
> +superio_wmi_outb(struct nct6775_sio_data *sio_data, int reg, int val)
> +{
> +	asuswmi_evaluate_method(ASUSWMI_METHODID_WSIO,
> +			sio_data->ld, reg, val, 0);
> +}
> +
> +static void
> +superio_wmi_select(struct nct6775_sio_data *sio_data, int ld)
> +{
> +	sio_data->ld = ld;
> +}
> +
> +static int
> +superio_wmi_enter(struct nct6775_sio_data *sio_data)
> +{
> +	return 0;
> +}
> +
> +static void
> +superio_wmi_exit(struct nct6775_sio_data *sio_data)
> +{
> +}
> +
>  static void
>  superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
>  {
> @@ -1090,6 +1180,7 @@ struct nct6775_data {
>  	int addr;	/* IO base of hw monitor block */
>  	int sioreg;	/* SIO register address */
>  	enum kinds kind;
> +	enum sensor_access access;
>  	const char *name;
>  
>  	const struct attribute_group *groups[6];
> @@ -1432,6 +1523,11 @@ static inline void nct6775_set_bank(struct nct6775_data *data, u16 reg)
>  {
>  	u8 bank = reg >> 8;
>  
> +	if (data->access == access_asuswmi) {
> +		data->bank = bank;
> +		return;
> +	}
> +

All that preparation, and then this is still needed. The accessor functions
(nct6775_set_bank, nct6775_read_value, nct6775_write_value) should be
implemented as pointers instead.

Guenter

>  	if (data->bank != bank) {
>  		outb_p(NCT6775_REG_BANK, data->addr + ADDR_REG_OFFSET);
>  		outb_p(bank, data->addr + DATA_REG_OFFSET);
> @@ -1442,8 +1538,21 @@ static inline void nct6775_set_bank(struct nct6775_data *data, u16 reg)
>  static u16 nct6775_read_value(struct nct6775_data *data, u16 reg)
>  {
>  	int res, word_sized = is_word_sized(data, reg);
> +	u8 tmp;
>  
>  	nct6775_set_bank(data, reg);
> +
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
> +
>  	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
>  	res = inb_p(data->addr + DATA_REG_OFFSET);
>  	if (word_sized) {
> @@ -1459,6 +1568,21 @@ static int nct6775_write_value(struct nct6775_data *data, u16 reg, u16 value)
>  	int word_sized = is_word_sized(data, reg);
>  
>  	nct6775_set_bank(data, reg);
> +
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
> +
>  	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
>  	if (word_sized) {
>  		outb_p(value >> 8, data->addr + DATA_REG_OFFSET);
> @@ -3821,13 +3945,15 @@ static int nct6775_probe(struct platform_device *pdev)
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
> @@ -3836,7 +3962,11 @@ static int nct6775_probe(struct platform_device *pdev)
>  
>  	data->kind = sio_data->kind;
>  	data->sioreg = sio_data->sioreg;
> -	data->addr = res->start;
> +	data->access = sio_data->access;
> +	if (sio_data->access == access_direct)
> +		data->addr = res->start;
> +	else
> +		data->addr = 0;
>  	mutex_init(&data->update_lock);
>  	data->name = nct6775_device_names[data->kind];
>  	data->bank = 0xff;		/* Force initial bank selection */
> @@ -4747,6 +4877,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>  	int err;
>  	int addr;
>  
> +	sio_data->access = access_direct;
>  	sio_data->sioreg = sioaddr;
>  
>  	err = sio_data->enter(sio_data);
> @@ -4841,6 +4972,21 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>   */
>  static struct platform_device *pdev[2];
>  
> +#define NCT6775_REG_CHIPID 0x58
> +
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
> +};
> +
>  static int __init sensors_nct6775_init(void)
>  {
>  	int i, err;
> @@ -4849,11 +4995,29 @@ static int __init sensors_nct6775_init(void)
>  	struct resource res;
>  	struct nct6775_sio_data sio_data;
>  	int sioaddr[2] = { 0x2e, 0x4e };
> +	const char *board_vendor, *board_name;
> +	enum sensor_access access = access_direct;
> +	u8 tmp;
>  
>  	err = platform_driver_register(&nct6775_driver);
>  	if (err)
>  		return err;
>  
> +	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (board_name && board_vendor &&
> +	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> +		if (match_string(asus_wmi_boards,
> +				ARRAY_SIZE(asus_wmi_boards), board_name) != -EINVAL) {
> +			/* if reading chip id via WMI succeeds, use WMI */
> +			if (!nct6775_asuswmi_read(0, NCT6775_REG_CHIPID, &tmp)) {
> +				pr_info("Using Asus WMI to access chip\n");
> +				access = access_asuswmi;
> +			}
> +		}
> +	}
> +
>  	/*
>  	 * initialize sio_data->kind and sio_data->sioreg.
>  	 *
> @@ -4874,6 +5038,17 @@ static int __init sensors_nct6775_init(void)
>  
>  		found = true;
>  
> +		/* Update access method */
> +		sio_data.access = access;
> +
> +		if (access == access_asuswmi) {
> +			sio_data.outb = superio_wmi_outb;
> +			sio_data.inb = superio_wmi_inb;
> +			sio_data.select = superio_wmi_select;
> +			sio_data.enter = superio_wmi_enter;
> +			sio_data.exit = superio_wmi_exit;
> +		}
> +
>  		pdev[i] = platform_device_alloc(DRVNAME, address);
>  		if (!pdev[i]) {
>  			err = -ENOMEM;
> @@ -4885,23 +5060,25 @@ static int __init sensors_nct6775_init(void)
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
