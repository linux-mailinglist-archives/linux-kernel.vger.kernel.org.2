Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F24284E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhJKBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhJKBvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:51:42 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4764C061570;
        Sun, 10 Oct 2021 18:49:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so19696678otb.10;
        Sun, 10 Oct 2021 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mPp2IC/8XVa9FpmITYRYA6birTrJuBZb+Xd2yUO/arA=;
        b=bY17w47tT3Z4dmcvdDlUqi0T7m8Go5K5sg3FuLOFbi4CMJQHiieJ6CBNiG0sQfNbE3
         QY387jwKiaEuSNuRdbE2LkQlTwd/YSdXUt1lnwFx48mVyZYYxtlV2ucA4PGSeY7anmks
         zw46VyovJTO7LVkq/VVMiNzLu8RKAR6NzmopRrvEu85a8BEBJZkDCRhScJhaNFQYPwk4
         nHRGq7/FYdeecRDsA9QNBZJQKAWONxemWu9PvvS/NTJal/Y2F1+37vWVy/oHiHwQOF8K
         MjpmLCYP/wsKEcs8vagRvYAqzoTvnbqRd1KCPs7bDBvLRWlQxCXsc/zT5sxC7q6fDoyl
         FLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mPp2IC/8XVa9FpmITYRYA6birTrJuBZb+Xd2yUO/arA=;
        b=rit4Sz7cIcde2VlxbY3JaHh0X2ZEi4H9HKVAg8ktgs2pRU6/uBhjncJekEs/sjrCRM
         9ildP8nzCZeb3mNwlZsPDa+gwP08i3JGN9YbrQ6n9PLrnySB0K4azcCyYQaOd6TEWrWe
         cJor+r0ge/sILjdouM9o1/21aOEai7Lc2eGpWVkY+x8iAjisiGcPoVsTk59FA4EzKgM5
         GGt5qUR4oHg0DI4jR9ewPDdmlj8ekrslEFHcRhkViiFdLFQGr//9wwyUCZrgPYFoWp9x
         ttTXo33Wtyk5/qaDPpZ06S94OjQtyntZj/njYce6aF6QzDVPYH8TO4MXH5+yOhgF4RYi
         QLBw==
X-Gm-Message-State: AOAM533kdviG+kFNLtKHZFFBI/cIJ0MVLlO5u8OrIRpqN9woPQ4MIzOB
        SSedqIOSSWeB48u7rnp5vK8NDqQGSRc=
X-Google-Smtp-Source: ABdhPJw0fd3jfT7oq4wVfJ7vcebpNes7JdZdurzSgVPeljWPSIyBB0yjTb3wlDvkYAyg+f2x8cHJJA==
X-Received: by 2002:a9d:eac:: with SMTP id 41mr18859144otj.38.1633916982884;
        Sun, 10 Oct 2021 18:49:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2sm1401111oia.44.2021.10.10.18.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 18:49:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v7 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211011012212.91357-1-osk@google.com>
 <20211011012212.91357-2-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <98dcaa85-d04c-7a9c-1901-8786d361477c@roeck-us.net>
Date:   Sun, 10 Oct 2021 18:49:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011012212.91357-2-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 6:22 PM, Oskar Senft wrote:
> This change allows LTD and RTD inputs to be configured via
> device tree bindings. If the DT bindings are not present or
> invalid, the input configuration is not modified and left at
> HW defaults.
> 
> Signed-off-by: Oskar Senft <osk@google.com>

I sent a Reviewed-by: for v6 of this patch.

> ---
> Changes from PATCH v6:
> - None (resubmitted due to changes in nuvoton,nct7802.yaml).
> 

Why did you drop it if there was no change ?

Guenter

> Changes from PATCH v5:
> - Removed unused "found_channel_config" variable.
> - Initialize mode_mask and mode_val to defaults.
> ---
>   drivers/hwmon/nct7802.c | 129 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 125 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 604af2f6103a..d56f78327619 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -51,6 +51,23 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
>   #define REG_CHIP_ID		0xfe
>   #define REG_VERSION_ID		0xff
>   
> +/*
> + * Resistance temperature detector (RTD) modes according to 7.2.32 Mode
> + * Selection Register
> + */
> +#define RTD_MODE_CURRENT	0x1
> +#define RTD_MODE_THERMISTOR	0x2
> +#define RTD_MODE_VOLTAGE	0x3
> +
> +#define MODE_RTD_MASK		0x3
> +#define MODE_LTD_EN		0x40
> +
> +/*
> + * Bit offset for sensors modes in REG_MODE.
> + * Valid for index 0..2, indicating RTD1..3.
> + */
> +#define MODE_BIT_OFFSET_RTD(index) ((index) * 2)
> +
>   /*
>    * Data structures and manipulation thereof
>    */
> @@ -1038,7 +1055,112 @@ static const struct regmap_config nct7802_regmap_config = {
>   	.volatile_reg = nct7802_regmap_is_volatile,
>   };
>   
> -static int nct7802_init_chip(struct nct7802_data *data)
> +static int nct7802_get_channel_config(struct device *dev,
> +				      struct device_node *node, u8 *mode_mask,
> +				      u8 *mode_val)
> +{
> +	u32 reg;
> +	const char *type_str, *md_str;
> +	u8 md;
> +
> +	if (!node->name || of_node_cmp(node->name, "channel"))
> +		return 0;
> +
> +	if (of_property_read_u32(node, "reg", &reg)) {
> +		dev_err(dev, "Could not read reg value for '%s'\n",
> +			node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (reg > 3) {
> +		dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
> +			node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (reg == 0) {
> +		if (!of_device_is_available(node))
> +			*mode_val &= ~MODE_LTD_EN;
> +		else
> +			*mode_val |= MODE_LTD_EN;
> +		*mode_mask |= MODE_LTD_EN;
> +		return 0;
> +	}
> +
> +	/* At this point we have reg >= 1 && reg <= 3 */
> +
> +	if (!of_device_is_available(node)) {
> +		*mode_val &= ~(MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1));
> +		*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +		return 0;
> +	}
> +
> +	if (of_property_read_string(node, "sensor-type", &type_str)) {
> +		dev_err(dev, "No type for '%s'\n", node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (!strcmp(type_str, "voltage")) {
> +		*mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
> +			     << MODE_BIT_OFFSET_RTD(reg - 1);
> +		*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +		return 0;
> +	}
> +
> +	if (strcmp(type_str, "temperature")) {
> +		dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
> +			node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (reg == 3) {
> +		/* RTD3 only supports thermistor mode */
> +		md = RTD_MODE_THERMISTOR;
> +	} else {
> +		if (of_property_read_string(node, "temperature-mode",
> +					    &md_str)) {
> +			dev_err(dev, "No mode for '%s'\n", node->full_name);
> +			return -EINVAL;
> +		}
> +
> +		if (!strcmp(md_str, "thermal-diode"))
> +			md = RTD_MODE_CURRENT;
> +		else if (!strcmp(md_str, "thermistor"))
> +			md = RTD_MODE_THERMISTOR;
> +		else {
> +			dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
> +				node->full_name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*mode_val |= (md & MODE_RTD_MASK) << MODE_BIT_OFFSET_RTD(reg - 1);
> +	*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +
> +	return 0;
> +}
> +
> +static int nct7802_configure_channels(struct device *dev,
> +				      struct nct7802_data *data)
> +{
> +	/* Enable local temperature sensor by default */
> +	u8 mode_mask = MODE_LTD_EN, mode_val = MODE_LTD_EN;
> +	struct device_node *node;
> +	int err;
> +
> +	if (dev->of_node) {
> +		for_each_child_of_node(dev->of_node, node) {
> +			err = nct7802_get_channel_config(dev, node, &mode_mask,
> +							 &mode_val);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
> +}
> +
> +static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
>   {
>   	int err;
>   
> @@ -1047,8 +1169,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>   	if (err)
>   		return err;
>   
> -	/* Enable local temperature sensor */
> -	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
> +	err = nct7802_configure_channels(dev, data);
>   	if (err)
>   		return err;
>   
> @@ -1074,7 +1195,7 @@ static int nct7802_probe(struct i2c_client *client)
>   	mutex_init(&data->access_lock);
>   	mutex_init(&data->in_alarm_lock);
>   
> -	ret = nct7802_init_chip(data);
> +	ret = nct7802_init_chip(dev, data);
>   	if (ret < 0)
>   		return ret;
>   
> 

