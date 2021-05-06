Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0174374E32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEFEDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhEFEDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:03:38 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B6C06174A;
        Wed,  5 May 2021 21:02:36 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id h9-20020a4a94090000b02901f9d4f64172so975626ooi.5;
        Wed, 05 May 2021 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U5+6EEXuMcLvUcLHA4wlcVOVLXtB5D19/TGtJi1Zhgw=;
        b=D+aNF15OMIC3EIoDiMVtATmCyaA3aERnmcIZtxAVKGMmgLbKCZkwcrL+CASUQyPAsY
         h6lRdqXNlHAH38xIMag748b4sKvH9u03tKtjBamjKo4T63OdMoqwUuZidKmrp07VBM2R
         2ipKBnh8tsdePEngZVb6dgxOlQOxb7agapodA4QJM2p/QtpLXOE2dBC1aW0Bv+NKecQK
         K+R8Ieky5+r39PhblAaGRW1AbjIGH2QovPQMthHfvZcJC7tpMOEOhhMUys8839MkTraX
         VVaOGpbuwyJLf3KCw4ZY7rGKZ8hrfcJjAgo3nTTSbZInD6J64wchUmc6btncYuymI5gM
         xgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U5+6EEXuMcLvUcLHA4wlcVOVLXtB5D19/TGtJi1Zhgw=;
        b=hFz7DBJYdGsyVaBjVEbhnSqKrC3r9X1Ndam7GHVCzV5bFxd5w1D963yhWULoI+Hekw
         Pup01qsZajUaFI4fV1B0/o8mlSEq/HUFSaiuhHrzQzD77G7guHa8IQ1I5vxvTWCB8dFR
         7aVDzLUhc3l6N27oA4kx80sODqT+rivamS4VQeh1G4c3oFxXn4fjgzcpisH8Phy8DaMF
         woEt1wY6X9CdSDvkHoLMkVecqNAXXoMmmC+/U7Vz9Dkv7e9R9JDRVAY5cF5GVCdtiUdp
         stu7t/CkLxjmXFZmPcuMr6pOx288xxgaOCOsnVzatFBUtQ7Iu2QXPXqIgU4xNMHCsyXT
         YLYw==
X-Gm-Message-State: AOAM531cMifJel53TXw/irvpOBlLE2pX7wbFFJxZ757zdB4F8JBwiJ8X
        65O28EDp1CogedP+z8h7QR5FxaBOqpc=
X-Google-Smtp-Source: ABdhPJw96Z0Rc3rv1ZadTzkWaz32IA7fme5mtyI47bqKjnplzZPhr92X4XisTzzzRCvQxtJ76hVC0Q==
X-Received: by 2002:a4a:e886:: with SMTP id g6mr1591209ooe.49.1620273755280;
        Wed, 05 May 2021 21:02:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u24sm338659otg.73.2021.05.05.21.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 21:02:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (pmbus) Add support for additional Flex BMR
 converters to pmbus
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505183248.57082-1-erik.rosen@metormote.com>
 <20210505183248.57082-4-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f2290036-3041-3ef2-b1fe-2be029652f7d@roeck-us.net>
Date:   Wed, 5 May 2021 21:02:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505183248.57082-4-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 11:32 AM, Erik Rosen wrote:
> Add support for Flex BMR310, BMR456, BMR457, BMR458, BMR480, BMR490,
> BMR491 and BMR492 to the pmbus driver
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>  Documentation/hwmon/pmbus.rst | 11 +++++++----
>  drivers/hwmon/pmbus/Kconfig   |  7 ++++---
>  drivers/hwmon/pmbus/pmbus.c   | 24 ++++++++++++++++++++++--
>  3 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/hwmon/pmbus.rst b/Documentation/hwmon/pmbus.rst
> index c44f14115413..0514c3052d4a 100644
> --- a/Documentation/hwmon/pmbus.rst
> +++ b/Documentation/hwmon/pmbus.rst
> @@ -3,15 +3,18 @@ Kernel driver pmbus
>  
>  Supported chips:
>  
> -  * Ericsson BMR453, BMR454
> +  * Flex BMR453, BMR454, BMR456, BMR457, BMR458, BMR480,
> +    BMR490, BMR491, BMR310, BMR492
>  
> -    Prefixes: 'bmr453', 'bmr454'
> +    Prefixes: 'bmr453', 'bmr454', 'bmr456', 'bmr457', 'bmr458', 'bmr480',
> +    'bmr490', 'bmr491', 'bmr310', 'bmr492'
>  
>      Addresses scanned: -
>  
> -    Datasheet:
> +    Datasheets:
> +
> + 	https://flexpowermodules.com/products
>  
> - http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146395
>  
>    * ON Semiconductor ADP4000, NCP4200, NCP4208
>  
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..59080d142bf7 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -19,9 +19,10 @@ config SENSORS_PMBUS
>  	default y
>  	help
>  	  If you say yes here you get hardware monitoring support for generic
> -	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
> -	  MAX20796, MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, TPS40400,
> -	  TPS544B20, TPS544B25, TPS544C20, TPS544C25, and UDT020.
> +	  PMBus devices, including but not limited to ADP4000, BMR310, BMR453,
> +	  BMR454, BMR456, BMR457, BMR458, BMR480, BMR490, BMR491, BMR492,
> +	  MAX20796, MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012,
> +	  TPS40400, TPS544B20, TPS544B25, TPS544C20, TPS544C25, and UDT020.
>  
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index a1b4260e75b2..688c4a3a87e0 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -173,13 +173,18 @@ static int pmbus_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	device_info = (struct pmbus_device_info *)i2c_match_id(pmbus_id, client)->driver_data;
> -	if (device_info->flags & PMBUS_SKIP_STATUS_CHECK) {
> +	if (device_info->flags & PMBUS_SKIP_STATUS_CHECK ||
> +	    device_info->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK) {

I don't think it makes sense to skip WRITE_PROTECT here.
Just make this
	if (device_info->flags) {

>  		pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
>  				     GFP_KERNEL);
>  		if (!pdata)
>  			return -ENOMEM;
>  
> -		pdata->flags = PMBUS_SKIP_STATUS_CHECK;
> +		pdata->flags = 0;
> +		if (device_info->flags & PMBUS_SKIP_STATUS_CHECK)
> +			pdata->flags |= PMBUS_SKIP_STATUS_CHECK;
> +		if (device_info->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK)
> +			pdata->flags |= PMBUS_READ_STATUS_AFTER_FAILED_CHECK;

and this
		pdata->flags = device_info->flags;

Guenter

>  	}
>  
>  	info->pages = device_info->pages;
> @@ -193,22 +198,37 @@ static const struct pmbus_device_info pmbus_info_one = {
>  	.pages = 1,
>  	.flags = 0
>  };
> +
>  static const struct pmbus_device_info pmbus_info_zero = {
>  	.pages = 0,
>  	.flags = 0
>  };
> +
>  static const struct pmbus_device_info pmbus_info_one_skip = {
>  	.pages = 1,
>  	.flags = PMBUS_SKIP_STATUS_CHECK
>  };
>  
> +static const struct pmbus_device_info pmbus_info_one_status = {
> +	.pages = 1,
> +	.flags = PMBUS_READ_STATUS_AFTER_FAILED_CHECK
> +};
> +
>  /*
>   * Use driver_data to set the number of pages supported by the chip.
>   */
>  static const struct i2c_device_id pmbus_id[] = {
>  	{"adp4000", (kernel_ulong_t)&pmbus_info_one},
> +	{"bmr310", (kernel_ulong_t)&pmbus_info_one_status},
>  	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
>  	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
> +	{"bmr456", (kernel_ulong_t)&pmbus_info_one},
> +	{"bmr457", (kernel_ulong_t)&pmbus_info_one},
> +	{"bmr458", (kernel_ulong_t)&pmbus_info_one_status},
> +	{"bmr480", (kernel_ulong_t)&pmbus_info_one_status},
> +	{"bmr490", (kernel_ulong_t)&pmbus_info_one_status},
> +	{"bmr491", (kernel_ulong_t)&pmbus_info_one_status},
> +	{"bmr492", (kernel_ulong_t)&pmbus_info_one},
>  	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
>  	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
>  	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
> 

