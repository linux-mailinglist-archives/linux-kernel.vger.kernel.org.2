Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE448406F91
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhIJQXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIJQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:23:09 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F50C061574;
        Fri, 10 Sep 2021 09:21:58 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso778166oon.1;
        Fri, 10 Sep 2021 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xFUVEBjVmeH2++HI+vSEGD3LOKdv48i99nhwshFp4JU=;
        b=enWr2cKogDwCYzoeIVTK1ql3AxmmUWnoByk2bfWhbbh1kBTnjj/W7L3cZ/mi7/VMIP
         9H0EVdV1I/dshz7qOvaxaFmsgXS3Ght/ZZ4Akadh9G5DTyyidk8KOojUY513A4k0v9v/
         n4pR+iBQFd1sPsTPexkqy4S5TRtgPctCD5/UxoK4LooOq8iNCzqv1yix0PzDFWsYXsgL
         HGIFc0nweVPy8qv2sLlzW+5nUYziiU3G0VlywwOhvjy+YFo216KClup5bPVdpjOtX+hO
         MBTgDaPzHMxCnpo3Gn6JUkkzrkUhT9ZwIwlg3qDksd24MTRqTHJ4qkjZ/X6il003/jju
         Gngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xFUVEBjVmeH2++HI+vSEGD3LOKdv48i99nhwshFp4JU=;
        b=h7Dh0TnYu0On8/sbUz9B20RZxljhDhOGoGnVy1Uqj3j7kiEg2vJkaKMpr0zHXapty6
         LAwvZ5mgXgvraqmGFWSE4KQbVpSiakIM6maoBFGaJo/KTBwZbaMoWFeEpKyg4RuA6IDQ
         hx1URfatkTmuG/R07AP/VZmdsMfqX5nWBnV5SJ310JX6ibupWsVtIjWz3vSJ5U5fseSF
         +J7pHFK5IAyLhi0Obce0mJbmcAImloO7RJx21TPf8LPmYonHuV28yRVr1v7NL8vv1bMO
         MF4zFiycZl4Ksuzaq4aIRbbqSS6oKtkv4XPpwhhM1gPN9jpl7psGaOqA2iuFXw5Q/bzT
         nfjw==
X-Gm-Message-State: AOAM530QJb6oXzKktgD9CZ149iJ5WcobnLYXaxveTZtOjvBTWgbX0DZi
        OaaJ1SWgBrgbvpwPoV5nLGMba+/4FNA=
X-Google-Smtp-Source: ABdhPJzP9+ooQu0x2qyA+a8SBGbOJ8CaQhUKGvuUJgwvQUq4qi8EkzmmCmU7vpUSeAnRbtqNp8Y4Ew==
X-Received: by 2002:a05:6820:235:: with SMTP id j21mr5064390oob.75.1631290917533;
        Fri, 10 Sep 2021 09:21:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm1305828otq.13.2021.09.10.09.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:21:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>
References: <20210910130755.2027995-1-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (nct7802) Make RTD modes configurable.
Message-ID: <99a84071-f737-9a8b-73fa-bcc3e0ff6a3f@roeck-us.net>
Date:   Fri, 10 Sep 2021 09:21:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210910130755.2027995-1-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 6:07 AM, Oskar Senft wrote:
> This change allows the RTD modes to be configurable via device tree
> bindings. When the setting is not present via device tree, the driver
> still defaults to the previous behavior where the RTD modes are left
> alone.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>   drivers/hwmon/nct7802.c | 94 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 604af2f6103a..6a6ab529bdd3 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -51,6 +51,24 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
>   #define REG_CHIP_ID		0xfe
>   #define REG_VERSION_ID		0xff
>   
> +/*
> + * Sensor modes according to 7.2.32 Mode Selection Register
> + */
> +#define RTD_MODE_CLOSED		0x0
> +#define RTD_MODE_CURRENT	0x1
> +#define RTD_MODE_THERMISTOR	0x2
> +#define RTD_MODE_VOLTAGE	0x3
> +#define RTD_MODE_UNDEFINED	0xf
> +
> +#define MODE_BITS_MASK		0x3
> +
> +/*
> + * Bit offsets for sensors modes in REG_MODE
> + */
> +#define MODE_OFFSET_RTD1	0
> +#define MODE_OFFSET_RTD2	2
> +#define MODE_OFFSET_RTD3	4
> +

I think the access can be defined in a macro, with the index as parameter.
to be able to use it in the temp_type_{read,store} functions.


>   /*
>    * Data structures and manipulation thereof
>    */
> @@ -1038,7 +1056,9 @@ static const struct regmap_config nct7802_regmap_config = {
>   	.volatile_reg = nct7802_regmap_is_volatile,
>   };
>   
> -static int nct7802_init_chip(struct nct7802_data *data)
> +static int nct7802_init_chip(struct nct7802_data *data,
> +	unsigned char rtd1_mode, unsigned char rtd2_mode,
> +	unsigned char rtd3_mode)
>   {
>   	int err;
>   
> @@ -1052,15 +1072,57 @@ static int nct7802_init_chip(struct nct7802_data *data)
>   	if (err)
>   		return err;
>   
> +	/* Configure sensor modes */
> +	if ((rtd1_mode & MODE_BITS_MASK) == rtd1_mode) {

This is an odd way of checking if the mode is set. Why not just
"if (rtd1_mode != RTD_MODE_UNDEFINED)" ?

> +		err = regmap_update_bits(data->regmap, REG_MODE,
> +			MODE_BITS_MASK << MODE_OFFSET_RTD1,
> +			rtd1_mode << MODE_OFFSET_RTD1);
> +		if (err)
> +			return err;
> +	}
> +	if ((rtd2_mode & MODE_BITS_MASK) == rtd2_mode) {
> +		err = regmap_update_bits(data->regmap, REG_MODE,
> +			MODE_BITS_MASK << MODE_OFFSET_RTD2,
> +			rtd2_mode << MODE_OFFSET_RTD2);
> +		if (err)
> +			return err;
> +	}
> +	if ((rtd3_mode & MODE_BITS_MASK) == rtd3_mode) {
> +		err = regmap_update_bits(data->regmap, REG_MODE,
> +			MODE_BITS_MASK << MODE_OFFSET_RTD3,
> +			rtd3_mode << MODE_OFFSET_RTD3);
> +		if (err)
> +			return err;
> +	}

This should all be handled in a single register update. Read the mode register,
do all the bit updates, then write it back as complete register if it changed.

> +
>   	/* Enable Vcore and VCC voltage monitoring */
>   	return regmap_update_bits(data->regmap, REG_VMON_ENABLE, 0x03, 0x03);
>   }
>   
> +static unsigned char rtd_mode_from_string(const char *value)
> +{
> +	if (!strcmp(value, "closed"))
> +		return RTD_MODE_CLOSED;
> +	if (!strcmp(value, "current"))
> +		return RTD_MODE_CURRENT;
> +	if (!strcmp(value, "thermistor"))
> +		return RTD_MODE_THERMISTOR;
> +	if (!strcmp(value, "voltage"))
> +		return RTD_MODE_VOLTAGE;
> +
> +	return RTD_MODE_UNDEFINED;
> +}
> +
>   static int nct7802_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
>   	struct nct7802_data *data;
>   	struct device *hwmon_dev;
> +	int rtd_mode_count;
> +	unsigned char rtd1_mode = RTD_MODE_UNDEFINED;
> +	unsigned char rtd2_mode = RTD_MODE_UNDEFINED;
> +	unsigned char rtd3_mode = RTD_MODE_UNDEFINED;
> +	const char *prop_value;
>   	int ret;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> @@ -1074,7 +1136,25 @@ static int nct7802_probe(struct i2c_client *client)
>   	mutex_init(&data->access_lock);
>   	mutex_init(&data->in_alarm_lock);
>   
> -	ret = nct7802_init_chip(data);
> +	if (dev->of_node) {
> +		rtd_mode_count = of_property_count_strings(dev->of_node,
> +			"nuvoton,rtd-modes");
> +
> +		if (rtd_mode_count > 0)
> +			if (!of_property_read_string_index(dev->of_node,
> +				"nuvoton,rtd-modes", 0, &prop_value))
> +				rtd1_mode = rtd_mode_from_string(prop_value);
> +		if (rtd_mode_count > 1)
> +			if (!of_property_read_string_index(dev->of_node,
> +				"nuvoton,rtd-modes", 1, &prop_value))
> +				rtd2_mode = rtd_mode_from_string(prop_value);
> +		if (rtd_mode_count > 2)
> +			if (!of_property_read_string_index(dev->of_node,
> +				"nuvoton,rtd-modes", 2, &prop_value))
> +				rtd3_mode = rtd_mode_from_string(prop_value);
> +	}
> +

Better do this in nct7802_init_chip(), and pass dev as parameter.

> +	ret = nct7802_init_chip(data, rtd1_mode, rtd2_mode, rtd3_mode); >   	if (ret < 0)
>   		return ret;
>   
> @@ -1094,10 +1174,20 @@ static const struct i2c_device_id nct7802_idtable[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, nct7802_idtable);
>   
> +static const struct of_device_id __maybe_unused nct7802_of_match[] = {
> +	{
> +		.compatible = "nuvoton,nct7802",
> +		.data = 0

Unnecessary.

> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, nct7802_of_match);
> +
>   static struct i2c_driver nct7802_driver = {
>   	.class = I2C_CLASS_HWMON,
>   	.driver = {
>   		.name = DRVNAME,
> +		.of_match_table = of_match_ptr(nct7802_of_match),
>   	},
>   	.detect = nct7802_detect,
>   	.probe_new = nct7802_probe,
> 

