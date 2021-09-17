Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B44100E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbhIQVuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhIQVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:50:20 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E51C061574;
        Fri, 17 Sep 2021 14:48:57 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so3656870ooh.7;
        Fri, 17 Sep 2021 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yR73++FWh9KjrB+EvaggwZGqSh+zqgdBiGsy7CtrVzg=;
        b=OzD1UCvwfc/rIBfF5XRndeIUJdRDIbpf/xs7+hmG5uuCGMO/G6y3THoaqVKW1VV1C3
         ulfPpjiyNqY4YRJ0dtw4guhE3+XAK6qtLBvaB4mkah1/NywXn03+0dWewer0NRP0dIQ3
         ZE+Wrw6wMs51Hmrg0wliUWs/f0NIKeYIiZYTv9l+kz/PXxzwoR7a7DEfJNL/2HupDNO9
         iXF/ArgU/znlZuaXAFrF6WYn4HFglouPWCvpJH6GfpnLhQA86yXvJWjdO03w7/sR60V6
         q7WAb1rWJVJ7YjMiFbOeyFSCLkXOyZQQ7/Ijmlrq3cdaZ31AMLavKQk4ci9AlWoITbMH
         j2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yR73++FWh9KjrB+EvaggwZGqSh+zqgdBiGsy7CtrVzg=;
        b=bWArAn9xvrhpWDFy0CPlitobR3A5EYq4/aKd4sHdoArtlJ4RzYbEg2EghsV2VD3opA
         cES5q1WZjpyA7hSjIw3YvlEqRR0+TX1+SM+dwmjKGJb3gpc13vqzT1VBu9NThizV+Y08
         /Ebiaz3fbCT+wvD0Hhx1E6R0Lc1C/kLXHSpjyu+rG4ON9ZXfpMRmojFlUb6lDgdbQfXY
         +XrIUPbM+qJDpLZzBLVnAT4hZ0K6JnDqZmcogtjw0Fsam8WNu6neHf1l2+5pQRwonSJU
         MJktnc0OkN8wjL0gwPg8YqmJqSAB7wBJBtsuF5ZRjqKUbQ9ZB04KFhAQ+FViD9XBipVh
         Sgxw==
X-Gm-Message-State: AOAM531FjvyoS9FA0zFxVriKAgLG9scLZu+0whj6L3SbNNv7V9LGs7bV
        6kwg8J3mYlK7+x7YpSv8fQ76chGBiT8=
X-Google-Smtp-Source: ABdhPJyxLnpxoVqj1IFDmgyoXIpMaWHJBDHS+dB1SzAT0kpvnQhw2LiDJaoqz9zITDtUATj2+H9Jcw==
X-Received: by 2002:a05:6820:502:: with SMTP id m2mr10826243ooj.47.1631915336803;
        Fri, 17 Sep 2021 14:48:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17sm1820950otc.28.2021.09.17.14.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:48:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v8 3/3] hwmon: (nct6775) Support access via Asus WMI
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?Q?P=c3=a4r_Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210917211811.39271-1-pauk.denis@gmail.com>
 <20210917211811.39271-4-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <70781ff8-31d6-deef-ac05-f882699901f8@roeck-us.net>
Date:   Fri, 17 Sep 2021 14:48:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917211811.39271-4-pauk.denis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 2:18 PM, Denis Pauk wrote:
> Support accessing the NCT677x via Asus WMI functions.
> 
> On mainboards that support this way of accessing the chip, the driver will
> usually not work without this option since in these mainboards, ACPI will
> mark the I/O port as used.
> 
> Code uses ACPI firmware interface to communicate with sensors with ASUS
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
> Changes in v8:
>    - Rename asuswmi_evaluate_method() to nct6775_asuswmi_evaluate_method().
>    - Add out error message if WMI method is failed.
>    - Stop futher read/write if first operation is failed.
> 
> Changes in v7:
>    - Remove unrequred & 0xff with int8 variables.
>    - Make ASUSWMI_UNSUPPORTED_METHOD as default value for WMI responce,
>      before run wmi_evaluate_method().
>    - Rename ASUSWMI_MGMT2_GUID to ASUSWMI_MONITORING_GUID.
>    - Replace checks of 'err != -EINVAL' with 'err >= 0' for match_string result.
> 
> Changes in v6:
>    - Minimaze codes inside code inside defined(CONFIG_ACPI_WMI).
> 
> Changes in v5:
>    - Use IS_ENABLED(CONFIG_ACPI_WMI) instead defined(CONFIG_ACPI_WMI)
> 
> Changes in v4:
>    - Fix build without ACPI WMI.
> 
> Changes in v3:
>    - Remove unrequired type conversions.
>    - Save result of match_string before check.
> 
> Changes in v2:
>    - Split changes to separate patches.
>    - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
> ---
>   drivers/hwmon/Kconfig   |   1 +
>   drivers/hwmon/nct6775.c | 256 ++++++++++++++++++++++++++++++++++++----
>   2 files changed, 236 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e3675377bc5d..9eefb1014b53 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1423,6 +1423,7 @@ config SENSORS_NCT6683
>   config SENSORS_NCT6775
>   	tristate "Nuvoton NCT6775F and compatibles"
>   	depends on !PPC
> +	depends on ACPI_WMI || ACPI_WMI=n
>   	select HWMON_VID
>   	help
>   	  If you say yes here you get support for the hardware monitoring
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 4253eed7f5b0..1f79546730e4 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -55,6 +55,7 @@
>   #include <linux/dmi.h>
>   #include <linux/io.h>
>   #include <linux/nospec.h>
> +#include <linux/wmi.h>
>   #include "lm75.h"
>   
>   #define USE_ALTERNATE
> @@ -132,10 +133,13 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
>   #define SIO_ID_MASK		0xFFF8
>   
>   enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
> +enum sensor_access { access_direct, access_asuswmi };
>   
>   struct nct6775_sio_data {
>   	int sioreg;
> +	int ld;
>   	enum kinds kind;
> +	enum sensor_access access;
>   
>   	/* superio_() callbacks  */
>   	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
> @@ -145,6 +149,107 @@ struct nct6775_sio_data {
>   	void (*sio_exit)(struct nct6775_sio_data *sio_data);
>   };
>   
> +#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_RSIO		0x5253494F
> +#define ASUSWMI_METHODID_WSIO		0x5753494F
> +#define ASUSWMI_METHODID_RHWM		0x5248574D
> +#define ASUSWMI_METHODID_WHWM		0x5748574D
> +#define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
> +
> +static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
> +{
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +	u32 args = bank | (reg << 8) | (val << 16);
> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *obj;
> +	u32 tmp = ASUSWMI_UNSUPPORTED_METHOD;
> +
> +	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0,
> +				     method_id, &input, &output);
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
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static inline int nct6775_asuswmi_write(u8 bank, u8 reg, u8 val)
> +{
> +	int err;
> +
> +	err = nct6775_asuswmi_evaluate_method(ASUSWMI_METHODID_WHWM, bank,
> +					      reg, val, NULL);
> +	if (err)
> +		pr_err("Failed to write %#x:%#x\n", bank, reg);
> +

Please avoid error message noise. Just return the error.

Thanks,
Guenter

> +	return err;
> +}
> +
> +static inline int nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)
> +{
> +	u32 ret, tmp = 0;
> +
> +	ret = nct6775_asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM, bank,
> +					      reg, 0, &tmp);
> +	if (ret)
> +		pr_err("Failed to read %#x:%#x\n", bank, reg);
> +
> +	*val = tmp;
> +	return ret;
> +}
> +
> +static int superio_wmi_inb(struct nct6775_sio_data *sio_data, int reg)
> +{
> +	int ret, tmp = 0;
> +
> +	ret = nct6775_asuswmi_evaluate_method(ASUSWMI_METHODID_RSIO, sio_data->ld,
> +					      reg, 0, &tmp);
> +	if (ret)
> +		pr_err("Failed to inb %#x:%#x\n", sio_data->ld, reg);
> +
> +	return tmp;
> +}
> +
> +static void superio_wmi_outb(struct nct6775_sio_data *sio_data, int reg, int val)
> +{
> +	int ret;
> +
> +	ret = nct6775_asuswmi_evaluate_method(ASUSWMI_METHODID_WSIO, sio_data->ld,
> +					      reg, val, NULL);
> +	if (ret)
> +		pr_err("Failed to outb %#x:%#x\n", sio_data->ld, reg);
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
> +
>   static void superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
>   {
>   	int ioreg = sio_data->sioreg;
> @@ -207,6 +312,7 @@ static void superio_exit(struct nct6775_sio_data *sio_data)
>   
>   #define NCT6775_REG_BANK	0x4E
>   #define NCT6775_REG_CONFIG	0x40
> +#define NCT6775_PORT_CHIPID	0x58
>   
>   /*
>    * Not currently used:
> @@ -1423,6 +1529,54 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
>   	return false;
>   }
>   
> +static inline void nct6775_wmi_set_bank(struct nct6775_data *data, u16 reg)
> +{
> +	u8 bank = reg >> 8;
> +
> +	data->bank = bank;
> +}
> +
> +static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
> +{
> +	int res, err, word_sized = is_word_sized(data, reg);
> +	u8 tmp = 0;
> +
> +	nct6775_wmi_set_bank(data, reg);
> +
> +	err = nct6775_asuswmi_read(data->bank, reg, &tmp);
> +	if (err)
> +		return 0;
> +
> +	res = tmp;
> +	if (word_sized) {
> +		err = nct6775_asuswmi_read(data->bank, (reg & 0xff) + 1, &tmp);
> +		if (err)
> +			return 0;
> +
> +		res = (res << 8) + tmp;
> +	}
> +	return res;
> +}
> +
> +static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value)
> +{
> +	int res, word_sized = is_word_sized(data, reg);
> +
> +	nct6775_wmi_set_bank(data, reg);
> +
> +	if (word_sized) {
> +		res = nct6775_asuswmi_write(data->bank, reg & 0xff, value >> 8);
> +		if (res)
> +			return res;
> +
> +		res = nct6775_asuswmi_write(data->bank, (reg & 0xff) + 1, value);
> +	} else {
> +		res = nct6775_asuswmi_write(data->bank, reg & 0xff, value);
> +	}
> +
> +	return res;
> +}
> +
>   /*
>    * On older chips, only registers 0x50-0x5f are banked.
>    * On more recent chips, all registers are banked.
> @@ -3818,10 +3972,12 @@ static int nct6775_probe(struct platform_device *pdev)
>   	struct device *hwmon_dev;
>   	int num_attr_groups = 0;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
> -				 DRVNAME))
> -		return -EBUSY;
> +	if (sio_data->access == access_direct) {
> +		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +		if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
> +					 DRVNAME))
> +			return -EBUSY;
> +	}
>   
>   	data = devm_kzalloc(&pdev->dev, sizeof(struct nct6775_data),
>   			    GFP_KERNEL);
> @@ -3830,9 +3986,16 @@ static int nct6775_probe(struct platform_device *pdev)
>   
>   	data->kind = sio_data->kind;
>   	data->sioreg = sio_data->sioreg;
> -	data->addr = res->start;
> -	data->read_value = nct6775_read_value;
> -	data->write_value = nct6775_write_value;
> +
> +	if (sio_data->access == access_direct) {
> +		data->addr = res->start;
> +		data->read_value = nct6775_read_value;
> +		data->write_value = nct6775_write_value;
> +	} else {
> +		data->read_value = nct6775_wmi_read_value;
> +		data->write_value = nct6775_wmi_write_value;
> +	}
> +
>   	mutex_init(&data->update_lock);
>   	data->name = nct6775_device_names[data->kind];
>   	data->bank = 0xff;		/* Force initial bank selection */
> @@ -4743,6 +4906,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>   	int err;
>   	int addr;
>   
> +	sio_data->access = access_direct;
>   	sio_data->sioreg = sioaddr;
>   
>   	err = sio_data->sio_enter(sio_data);
> @@ -4837,6 +5001,23 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>    */
>   static struct platform_device *pdev[2];
>   
> +static const char * const asus_wmi_boards[] = {
> +	"PRIME B460-PLUS",
> +	"ROG CROSSHAIR VIII DARK HERO",
> +	"ROG CROSSHAIR VIII HERO",
> +	"ROG CROSSHAIR VIII IMPACT",
> +	"ROG STRIX B550-E GAMING",
> +	"ROG STRIX B550-F GAMING",
> +	"ROG STRIX B550-F GAMING (WI-FI)",
> +	"ROG STRIX Z490-I GAMING",
> +	"TUF GAMING B550M-PLUS",
> +	"TUF GAMING B550M-PLUS (WI-FI)",
> +	"TUF GAMING B550-PLUS",
> +	"TUF GAMING X570-PLUS",
> +	"TUF GAMING X570-PLUS (WI-FI)",
> +	"TUF GAMING X570-PRO (WI-FI)",
> +};
> +
>   static int __init sensors_nct6775_init(void)
>   {
>   	int i, err;
> @@ -4845,11 +5026,32 @@ static int __init sensors_nct6775_init(void)
>   	struct resource res;
>   	struct nct6775_sio_data sio_data;
>   	int sioaddr[2] = { 0x2e, 0x4e };
> +	enum sensor_access access = access_direct;
> +	const char *board_vendor, *board_name;
> +	u8 tmp;
>   
>   	err = platform_driver_register(&nct6775_driver);
>   	if (err)
>   		return err;
>   
> +	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (board_name && board_vendor &&
> +	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> +		err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
> +				   board_name);
> +		if (err >= 0) {
> +			/* if reading chip id via WMI succeeds, use WMI */
> +			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
> +				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
> +				access = access_asuswmi;
> +			} else {
> +				pr_err("Can't read ChipID by Asus WMI.\n");
> +			}
> +		}
> +	}
> +
>   	/*
>   	 * initialize sio_data->kind and sio_data->sioreg.
>   	 *
> @@ -4870,6 +5072,16 @@ static int __init sensors_nct6775_init(void)
>   
>   		found = true;
>   
> +		sio_data.access = access;
> +
> +		if (access == access_asuswmi) {
> +			sio_data.sio_outb = superio_wmi_outb;
> +			sio_data.sio_inb = superio_wmi_inb;
> +			sio_data.sio_select = superio_wmi_select;
> +			sio_data.sio_enter = superio_wmi_enter;
> +			sio_data.sio_exit = superio_wmi_exit;
> +		}
> +
>   		pdev[i] = platform_device_alloc(DRVNAME, address);
>   		if (!pdev[i]) {
>   			err = -ENOMEM;
> @@ -4881,23 +5093,25 @@ static int __init sensors_nct6775_init(void)
>   		if (err)
>   			goto exit_device_put;
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
>   		}
>   
> -		err = platform_device_add_resources(pdev[i], &res, 1);
> -		if (err)
> -			goto exit_device_put;
> -
>   		/* platform_device_add calls probe() */
>   		err = platform_device_add(pdev[i]);
>   		if (err)
> 

