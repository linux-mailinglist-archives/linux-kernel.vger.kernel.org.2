Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4E4282E5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhJJSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 14:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhJJSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 14:15:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD7C061570;
        Sun, 10 Oct 2021 11:13:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n64so21528563oih.2;
        Sun, 10 Oct 2021 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+3Mv1qDXu2U/dFNa/+jh5WfgDQiPOTHDMUH8W5iEIA=;
        b=LtEwZzR0qscPnx7tmbfCtDiCEzJpNBNzDzLgF2rc/HqvekPrOnYhEbNleqqoWtVxrr
         NpFLVKkbYrS5iUjl0dBjBjfpdiirf+0ChXYvl/sFZpWK7dIStTZPU1dhWBGLvlvo7se1
         QdOYLy9C47x9jiXvwkUk8yKlFyXSwYs5Hef8gdiokMG4C2naqRnnDa1Zji+FJJKai+Zq
         wFx+5IY4E8mNn4erd/SX+d0eTuBmBgJc1WLHlZK0a5d2RngJgFRexl4Qim7XlASvWHIe
         ydRSNblNikVDfI6HLBonq7ePwhv3t5adwnBSXhcHJT/ONkPGU6+T2GiBQOAbQUvTumrR
         MnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+3Mv1qDXu2U/dFNa/+jh5WfgDQiPOTHDMUH8W5iEIA=;
        b=vbTA0NxgpQD3fcqbdwdMLJ1eFKAbqJC/DwGKaAFuu7ih6/tKkFNaGy3vCZ0z5pYQSb
         3YwRIFSJcRc5gwt3wCK5P6FSGFx9A5mt+DUWXEpiAjO7QYVOe7k6ifKDHyUz1th/OOl1
         kqa7T8zAl5WeRbq7GF+EfqmPrMmRFDzZNiJdW+Btm8R6DZAhBBYgRmPcyXWCG6/soTDP
         0/8F6S3zncDnp4gO0YMV90UplXIikGDOzTotxylW1Jj6FlCEOxYMUu1fJryjDNi20yFT
         +dQb4tq1FFPimJaUdA2gZsSMpf3pO1nCA2Eqoz6PZJKLjKCzmfzH4lTaPIqWY+lxjR8T
         PHBA==
X-Gm-Message-State: AOAM530gXHj8liTakV3DxmeZytYLConCDjASMn6j/U55BdFWhyWoPaW0
        w7UgU3MKQl8kNABRf6DujJMrFOMQN8Q=
X-Google-Smtp-Source: ABdhPJz4vLg+ZghpL4Sfh74yVFR8UNRGv9ZDTM6w2UwUjCIxoA7hI6F8ew+XCu1PvybZijsOTeTgvQ==
X-Received: by 2002:aca:32c5:: with SMTP id y188mr22999632oiy.163.1633889626538;
        Sun, 10 Oct 2021 11:13:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12sm1243228otu.11.2021.10.10.11.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 11:13:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211010033112.3621816-1-osk@google.com>
 <20211010033112.3621816-2-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
Message-ID: <d1846fdb-8264-ebb2-f5f1-01780ea384cf@roeck-us.net>
Date:   Sun, 10 Oct 2021 11:13:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211010033112.3621816-2-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 8:31 PM, Oskar Senft wrote:
> This change allows LTD and RTD inputs to be configured via
> device tree bindings. If the DT bindings are not present or
> invalid, the input configuration is not modified and left at
> HW defaults.
> 
> Signed-off-by: Oskar Senft <osk@google.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
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

