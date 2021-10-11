Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1892E4291C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbhJKOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbhJKOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:30:30 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D072C122764;
        Mon, 11 Oct 2021 07:05:43 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w10-20020a056830280a00b0054e4e6c85a6so12792156otu.5;
        Mon, 11 Oct 2021 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBOwSA5CWrwgHLreR7NH6QWAhTPBd3HCpS3K5+L/d9M=;
        b=EBSMxrCsSueJJCHLftFehMVA6G7wsZsnNZxFALXt2cNl/zpnTH9GG5MyaD//Lcc/Rc
         PzeSeB8nT0YcooKR0MntxDYypymZ5b3OFlsHoZcSBhSJzka9wfKJs16O72mA6sp1mn+f
         +z3Z8kyO9JeZPPbEBe4b8JYqg99+xcZg0oMqWz4gY3zTXvlwFM9hS0JmL72/KNuxfxyw
         QFDD4O/M2Gk42sYAVZoUOyJXfVWYNFHdRHBCIz+vtnuwqVhiHcSwQKM0/b9X5ET8w0Cr
         sItsyoZO6ti9lXCDWXjqDzWH67JGkMMvgsyDmHtC5FzDh/MySfzvpn9Pp6oB9WAIx4vG
         PyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBOwSA5CWrwgHLreR7NH6QWAhTPBd3HCpS3K5+L/d9M=;
        b=zjztENTFjdhIx07X0rz4ge9GnPkG4jYsJS8p4aaQwwbaUmqJkTgRuq78Hkxo/TlQnh
         V91MpXOKJMzvWeJ6CaPGND6UGGZ1p9lN3YZ66ZiXmyUZy1sqxypH1f0qPIDq/E0j8V8m
         /z/iTQkU+WUShlCYcN37xzaUiKmoW0zbCVeKOpK7LFs3sP48eS6vRJAH77F6CVOh/Hn6
         nwQ1rTunDtGkgjsKUneULDrZa+AL7FUne35OiMyZj8LjdQFFQnE4dY+zoeuGdTRxhLPf
         lWtTdTvEv+fLCag+n/By2bNIOwdRU3YrunGk2VT0fGimutYEaZtH1ioi6U6tFAqRgdTM
         WqBw==
X-Gm-Message-State: AOAM531PVdE+uNOKunMEd+TeKqtkO8uyy50VINvuFqg3TyXny1tBD6Os
        kuLqcCzTMqG2V+hKQHL9TUc0I8CgAyE=
X-Google-Smtp-Source: ABdhPJxso/VdopnfaGkiNX8DG2t2phvqHKoZZMsI+DZA7sM8kAAMtAA87/5Z0SbPD0jzla19Dho+uA==
X-Received: by 2002:a9d:4616:: with SMTP id y22mr4586551ote.165.1633961140018;
        Mon, 11 Oct 2021 07:05:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l23sm1776480otk.21.2021.10.11.07.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 07:05:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v7 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211011012212.91357-1-osk@google.com>
 <20211011012212.91357-2-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cf4cc661-7128-14b1-e198-08a485a9c12d@roeck-us.net>
Date:   Mon, 11 Oct 2021 07:05:37 -0700
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

Again, for my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from PATCH v6:
> - None (resubmitted due to changes in nuvoton,nct7802.yaml).
> 
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

