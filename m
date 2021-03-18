Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653043410A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhCRXFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhCRXEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:04:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A6AC06174A;
        Thu, 18 Mar 2021 16:04:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so6759017otf.12;
        Thu, 18 Mar 2021 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=93DAaK1WBygoRy8FrglW6XTd3DeQYW94sly5P5C0w0U=;
        b=Ngy2gcK/Zbi13ys5rvzlUMgUYZsTtlhFwntyWXMsJqnM0f+Zu7BL8uGPWqtnh+IJ23
         FkL+a7wHF9kN8GgeqwOSSXIEaiUSHRkyfGETGu58Mtcdbz+3s9VHD6yDbBzyxkDZ7xmk
         Fusr64Pt7cEAE5ms4bk8MIwLouzPgTYmjAszetH9mTrpPtchrv27d77sQPmmXApq/mpM
         oz5iq0KQJRPurovqa94HrhJrdpM2Dx8GUW8JH97rj1gBk612Pp7hNRw2AoPP1U2mrUFS
         bFBTtmNcif5J8o0wynkQnlTS5w9yzDb/XHzLwTpsJdl7344g7ETDuc5DYUjuS89oH8zv
         L6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=93DAaK1WBygoRy8FrglW6XTd3DeQYW94sly5P5C0w0U=;
        b=mvFsCG4BNmIiD0GOQm2C9Q/RV8o5S9TMBX62S81mM70cTMBUwg7hjr0/2RvxYDPmUg
         jp/DRH/fSnKCO/savJy0jMF2p6iGm5ptWiD6abfIlQ3yCAmh2VnbghoW3L63r0OXnHeD
         2heiJE7bPuTuzghZ17HBjdt/FG283cGAPMxSafscnb0GrbqmtlQW+8mhowMl9u+Fi2I7
         bafYOtbA0RfAst7m8YVBgWSWL46jH52MDRlsHQwe/dFTRyshbxf+BHJ/6xT2w+cKPpPb
         eU3mB7DDhc/43/72B6Ib5xB8EubBw3D1fwgoTbrwz5Z8QX5xCDYlWDIc/tXVMiHpXjbO
         CX1Q==
X-Gm-Message-State: AOAM531w7i8JDdx0oPf6RC997NKBr+UW+zsEoYOJmVo7gDzpXPhO9HOx
        VMp0SLVR+ZMQxbZhdKc3ftckMzM268w=
X-Google-Smtp-Source: ABdhPJyTB8E+CYL7HRsFq8+W39a4B8OkIndhvBWSSFAg4T8ARjmSIK2r2hFFmDYOOvRmaWjs0qpxDg==
X-Received: by 2002:a9d:6e09:: with SMTP id e9mr9207923otr.195.1616108684176;
        Thu, 18 Mar 2021 16:04:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9sm860850oid.17.2021.03.18.16.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 16:04:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/tps53679) Add support for TPS53676
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210318212441.69050-1-erik.rosen@metormote.com>
 <20210318212441.69050-3-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <bd7acdcd-2bbc-70f5-d7a6-76a269e8f6a7@roeck-us.net>
Date:   Thu, 18 Mar 2021 16:04:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318212441.69050-3-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 2:24 PM, Erik Rosen wrote:
> Add support for TI TPS53676 controller to the tps53679 pmbus driver
> 
> The driver uses the USER_DATA_03 register to figure out how many phases are
> enabled and to which channel they are assigned, and sets the number of pages

checkpatch complains about the line length here. Picky, but just move pages
to the next line.

> and phases accordingly.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>  Documentation/hwmon/tps53679.rst | 13 +++++++--
>  drivers/hwmon/pmbus/Kconfig      |  4 +--
>  drivers/hwmon/pmbus/tps53679.c   | 49 +++++++++++++++++++++++++++++++-
>  3 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/hwmon/tps53679.rst b/Documentation/hwmon/tps53679.rst
> index c7c589e49789..3b9561648c24 100644
> --- a/Documentation/hwmon/tps53679.rst
> +++ b/Documentation/hwmon/tps53679.rst
> @@ -19,6 +19,14 @@ Supported chips:
>  
>      Datasheet: https://www.ti.com/lit/gpn/TPS53667
>  
> +  * Texas Instruments TPS53676
> +
> +    Prefix: 'tps53676'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.ti.com/lit/gpn/TPS53676
> +
>    * Texas Instruments TPS53679
>  
>      Prefix: 'tps53679'
> @@ -136,7 +144,7 @@ power1_input		Measured input power.
>  power[N]_label		"pout[1-2]".
>  
>  			- TPS53647, TPS53667: N=2
> -			- TPS53679, TPS53681, TPS53588: N=2,3
> +			- TPS53676, TPS53679, TPS53681, TPS53588: N=2,3
>  
>  power[N]_input		Measured output power.
>  
> @@ -156,10 +164,11 @@ curr[N]_label		"iout[1-2]" or "iout1.[0-5]".
>  
>  			The first digit is the output channel, the second
>  			digit is the phase within the channel. Per-phase
> -			telemetry supported on TPS53681 only.
> +			telemetry supported on TPS53676 and TPS53681 only.
>  
>  			- TPS53647, TPS53667: N=2
>  			- TPS53679, TPS53588: N=2,3
> +			- TPS53676: N=2-8
>  			- TPS53681: N=2-9
>  
>  curr[N]_input		Measured output current.
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..35956a9227d8 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -257,10 +257,10 @@ config SENSORS_TPS40422
>  	  be called tps40422.
>  
>  config SENSORS_TPS53679
> -	tristate "TI TPS53647, TPS53667, TPS53679, TPS53681, TPS53688"
> +	tristate "TI TPS53647, TPS53667, TPS53676, TPS53679, TPS53681, TPS53688"
>  	help
>  	  If you say yes here you get hardware monitoring support for TI
> -	  TPS53647, TPS53667, TPS53679, TPS53681, and TPS53688.
> +	  TPS53647, TPS53667, TPS53676, TPS53679, TPS53681, and TPS53688.
>  
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tps53679.
> diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
> index ba838fa311c3..d8e5f71ff162 100644
> --- a/drivers/hwmon/pmbus/tps53679.c
> +++ b/drivers/hwmon/pmbus/tps53679.c
> @@ -16,11 +16,14 @@
>  #include "pmbus.h"
>  
>  enum chips {
> -	tps53647, tps53667, tps53679, tps53681, tps53688
> +	tps53647, tps53667, tps53676, tps53679, tps53681, tps53688
>  };
>  
>  #define TPS53647_PAGE_NUM		1
>  
> +#define TPS53676_USER_DATA_03		0xb3
> +#define TPS53676_MAX_PHASES		7
> +
>  #define TPS53679_PROT_VR12_5MV		0x01 /* VR12.0 mode, 5-mV DAC */
>  #define TPS53679_PROT_VR12_5_10MV	0x02 /* VR12.5 mode, 10-mV DAC */
>  #define TPS53679_PROT_VR13_10MV		0x04 /* VR13.0 mode, 10-mV DAC */
> @@ -143,6 +146,43 @@ static int tps53681_identify(struct i2c_client *client,
>  					    TPS53681_DEVICE_ID);
>  }
>  
> +static int tps53676_identify(struct i2c_client *client,
> +			     struct pmbus_driver_info *info)
> +{
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +	int phases_a = 0, phases_b = 0;
> +	int i, ret;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
> +	if (ret < 0)
> +		return ret;
> +	if (strncmp("TI\x53\x67\x60", buf, 5)) {

Someone should have a serious talk with the chip designer.

> +		dev_err(&client->dev, "Unexpected device ID: %s\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	ret = i2c_smbus_read_block_data(client, TPS53676_USER_DATA_03, buf);
> +	if (ret < 0)
> +		return ret;

You'll probably want to add a check to ensure that ret >= TPS53676_MAX_PHASES * 2 + 1
or maybe == 24.

> +	for (i = 0; i < 2 * TPS53676_MAX_PHASES; i += 2) {
> +		if (buf[i + 1] & 0x80) {
> +			if (buf[i] & 0x08)
> +				phases_b++;
> +			else
> +				phases_a++;
> +		}
> +	}
> +
> +	info->format[PSC_VOLTAGE_OUT] = linear;
> +	info->pages = 1;
> +	info->phases[0] = phases_a;
> +	if (phases_b > 0) {
> +		info->pages = 2;
> +		info->phases[1] = phases_b;
> +	}
> +	return 0;
> +}
> +
>  static int tps53681_read_word_data(struct i2c_client *client, int page,
>  				   int phase, int reg)
>  {
> @@ -183,6 +223,7 @@ static struct pmbus_driver_info tps53679_info = {
>  	.pfunc[3] = PMBUS_HAVE_IOUT,
>  	.pfunc[4] = PMBUS_HAVE_IOUT,
>  	.pfunc[5] = PMBUS_HAVE_IOUT,
> +	.pfunc[6] = PMBUS_HAVE_IOUT,
>  };
>  
>  static int tps53679_probe(struct i2c_client *client)
> @@ -206,6 +247,9 @@ static int tps53679_probe(struct i2c_client *client)
>  		info->pages = TPS53647_PAGE_NUM;
>  		info->identify = tps53679_identify;
>  		break;
> +	case tps53676:
> +		info->identify = tps53676_identify;
> +		break;
>  	case tps53679:
>  	case tps53688:
>  		info->pages = TPS53679_PAGE_NUM;
> @@ -227,9 +271,11 @@ static int tps53679_probe(struct i2c_client *client)
>  static const struct i2c_device_id tps53679_id[] = {
>  	{"tps53647", tps53647},
>  	{"tps53667", tps53667},
> +	{"tps53676", tps53676},
>  	{"tps53679", tps53679},
>  	{"tps53681", tps53681},
>  	{"tps53688", tps53688},
> +	{"bmr474", tps53676},

Please move to the top for alphabetic order.

>  	{}
>  };
>  
> @@ -238,6 +284,7 @@ MODULE_DEVICE_TABLE(i2c, tps53679_id);
>  static const struct of_device_id __maybe_unused tps53679_of_match[] = {
>  	{.compatible = "ti,tps53647", .data = (void *)tps53647},
>  	{.compatible = "ti,tps53667", .data = (void *)tps53667},
> +	{.compatible = "ti,tps53676", .data = (void *)tps53676},
>  	{.compatible = "ti,tps53679", .data = (void *)tps53679},
>  	{.compatible = "ti,tps53681", .data = (void *)tps53681},
>  	{.compatible = "ti,tps53688", .data = (void *)tps53688},
> 

