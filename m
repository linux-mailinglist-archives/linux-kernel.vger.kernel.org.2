Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60C3676C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhDVB2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhDVB2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:28:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C71C06174A;
        Wed, 21 Apr 2021 18:27:41 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d25so6793811oij.5;
        Wed, 21 Apr 2021 18:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fcNZfsXjWgubhkoG9HpEo4ENef1L3qrDLqtjAJX6TkA=;
        b=KajQb+SSSMbK2zN7RtNet6tfRxx/CK61h1sqSPR26UPzYfuEQBRGo5tb/TYgI/eWh5
         GevcdeycQ4sU/rURYt05kGbitsmYPtyj2QrR7wVlXtoSHCT8T7MXcLNGb7tgTakuQryt
         f5WlUdXvMV4XI4PbprbuV+P7uOsPgFN2TelvVmzL4oMFQUNbcp4aVraghH9hXT7GxVbJ
         QKR/2d6hNxQWoQEl3cW7tb3q378lqX1Om6XHBzmZ2Mbj7nMIMOA9lHBaZ6gl6JzTHDmK
         2rFVHdYlG0KiZTcxFHE4bCx7eTMZeFt1zidPTbDcV8ivzdSjJTxwbj6VyoAvYYvY8QWe
         1jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fcNZfsXjWgubhkoG9HpEo4ENef1L3qrDLqtjAJX6TkA=;
        b=Wmg/Td/Im4ZNdDtIOF/lLGgPYRFfMej1UmIVQNgUPL7k0ViZ5Vpt7Mtj/Op6fDtqu3
         Cdf0M8i6ORfRyyjvWtmL2R1H96nWcc+m4qR2U33evZsi9w9oSS8OH9HtMKfJQ14UsSdk
         K/vTrXFN+NgotmrPRjKpCt9Hfnt2NQqr1OVYVdQ4v06dQXyWfZUPgwW1gnDH+KGnwgxa
         QgHgjnQiqkK0DyjwZ3A3NwKkv0D8hKYeaCOqiHwhiC6QrrtgCZUzuj2hyYDm6UtX795j
         HW8TNPe3HSmY0oBDrh6gmSgCx8XkUDB/Q3waPP0P84+Nhk8fdgfcLhZtEA3DB+d3hbdb
         5gHA==
X-Gm-Message-State: AOAM532tWy8o2G/b4qJ6znzC8BEZ6bTT9P6b80+cLI3TxbDBmCp8hoql
        lVsThI/R3jKsJY4MK/N0onqfvzxs/xA=
X-Google-Smtp-Source: ABdhPJwGMuO27MpsGKW67BzXbP4U/jtcGm4DDI9uVLgmwDiEyM9uB02nl7pLttdx9TeYAADwYryF4g==
X-Received: by 2002:aca:a844:: with SMTP id r65mr555011oie.168.1619054860403;
        Wed, 21 Apr 2021 18:27:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm295760ooa.18.2021.04.21.18.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 18:27:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210413025948.901867-1-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
Date:   Wed, 21 Apr 2021 18:27:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210413025948.901867-1-kubernat@cesnet.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 7:59 PM, Václav Kubernát wrote:
> Converting the driver to use regmap makes it more generic. It also makes
> it a lot easier to debug through debugfs.
> 
> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  drivers/hwmon/Kconfig    |   1 +
>  drivers/hwmon/max31790.c | 254 ++++++++++++++++++++-------------------
>  2 files changed, 133 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1ecf697d8d99..9f11d036c316 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1095,6 +1095,7 @@ config SENSORS_MAX6697
>  config SENSORS_MAX31790
>  	tristate "Maxim MAX31790 sensor chip"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for 6-Channel PWM-Output
>  	  Fan RPM Controller.
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 2c6b333a28e9..e3765ce4444a 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
>  /* MAX31790 registers */
> @@ -46,92 +47,53 @@
>  
>  #define NR_CHANNEL			6
>  
> +#define MAX31790_REG_USER_BYTE_67	0x67
> +
> +#define BULK_TO_U16(msb, lsb)		(((msb) << 8) + (lsb))
> +#define U16_MSB(num)			(((num) & 0xFF00) >> 8)
> +#define U16_LSB(num)			((num) & 0x00FF)
> +
> +static const struct regmap_range max31790_ro_range = {
> +	.range_min = MAX31790_REG_TACH_COUNT(0),
> +	.range_max = MAX31790_REG_PWMOUT(0) - 1,
> +};
> +
> +static const struct regmap_access_table max31790_wr_table = {
> +	.no_ranges = &max31790_ro_range,
> +	.n_no_ranges = 1,
> +};
> +
> +static const struct regmap_range max31790_volatile_ranges[] = {
> +	regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_COUNT(12)),
> +	regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN_FAULT_STATUS1),
> +};
> +
> +static const struct regmap_access_table max31790_volatile_table = {
> +	.no_ranges = max31790_volatile_ranges,
> +	.n_no_ranges = 2,
> +	.n_yes_ranges = 0
> +};

Looks like my reply to this got lost. Other regmap code suggests that
volatile register ranges are identified with yes_ranges, not with no_ranges.
"no" seems to mean "not volatile". Please verify and confirm if the
above code does what you want it to do.

Thanks,
Guenter
