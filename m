Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370F427E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 01:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhJIXmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhJIXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 19:42:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD1C061570;
        Sat,  9 Oct 2021 16:40:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o204so10754229oih.13;
        Sat, 09 Oct 2021 16:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZ3ynlsT/dBORO2ziPHTfzp6eSWHI6Fwf/1E1+5w09M=;
        b=LYUm9VC/2S5/0Pwo190vfiNOST/L1iJ/tZvftBqx2ai1aAn4bciq5pxIDQmehvInNh
         Uiez/c4zUHy65ZUlAIm97zpiOSCFtDtIYXi0YW8ULZS1Q10LZQ7U4LelR5JKkUizFOz9
         XFn2Bv+qVcXeUkKBJIke1VAdy1Ep9fzbM6fio8uWdwwJb0nULW0ZIeMrp2SbIP49mdIi
         0/1J7Spd95w5BBK3pv0o+6L9/iHsLeHp2JwNup99AEfSj6iX7UyC5mb4nuTUHrYBkYG/
         gjhTPvdEJa7NquO55XKQ3HWmwRUF5VVDjxBA6vArvibAPFdHlOPycopmrIJXplvvEemi
         XDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ3ynlsT/dBORO2ziPHTfzp6eSWHI6Fwf/1E1+5w09M=;
        b=tcDh+OQLm6RAbuKgmY9MTG2TtSzVgfpMGGU7nLC+WXktsDZ4jkiq8etnP0y8skB27x
         xyaAeXqBpuS7R+lXqeqn9gQEmmVwJl6ay+dAOhTfiYo3WsoFSzfU+dzVKB9tsOlvpRJJ
         7t1uKmo4EsWcr3QbI968l8guam8XtXJneTzl7fwBKD7UQdPdtrwW5tB0iO/SnvuzLFbW
         hyRx2ANqik+q7o9IplRgH0FITI8lfuHaTEWWufUdEWuMCgS1wqHQLjZhju7YC4pOg+eq
         qUqDFywRjzvnsqg8eG+GHx+CGWK+W1CIJbOYZIqN3Oya7YrwpPjquxTnvPSxX+77X1Gy
         rJNw==
X-Gm-Message-State: AOAM532UenNc2UaA6mLBeiOBZmvM2j3hXJMrL23qvOu0Cn5Ll6CveeZK
        QveK50+1wcm4BgfugM1yMTyqyX78SaY=
X-Google-Smtp-Source: ABdhPJwfhEuGbfEKXC7qNOrauAlwvqjJi0fS7NjkD7Pw9u/jVjOLWbkmlXTJPupuANhw9MNrE5D1fA==
X-Received: by 2002:aca:31c9:: with SMTP id x192mr7181930oix.173.1633822808429;
        Sat, 09 Oct 2021 16:40:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm797405otl.34.2021.10.09.16.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 16:40:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211009185257.2230013-1-osk@google.com>
 <20211009185257.2230013-2-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
Message-ID: <638924f2-4323-16d8-5a8b-2afd2b1872d6@roeck-us.net>
Date:   Sat, 9 Oct 2021 16:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009185257.2230013-2-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oskar,

On 10/9/21 11:52 AM, Oskar Senft wrote:
> This change allows LTD and RTD inputs to be configured via
> device tree bindings. If the DT bindings are not present or
> invalid, the input configuration is not modified and left at
> HW defaults.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---

change log goes here (after ---), not in a separate e-mail.

>   drivers/hwmon/nct7802.c | 133 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 129 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 604af2f6103a..e28f8eaf9f0f 100644
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
> @@ -1038,7 +1055,116 @@ static const struct regmap_config nct7802_regmap_config = {
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
> +	bool found_channel_config = false;

now unused, as 0-day points out.

> +	u8 mode_mask = 0, mode_val = 0;
> +	struct device_node *node;
> +	int err;
> +
> +	/* Enable local temperature sensor by default */
> +	mode_val |= MODE_LTD_EN;
> +	mode_mask |= MODE_LTD_EN;
> +

Either make it = and drop the initialization above, or better
initialize the variables with MODE_LTD_EN right away.

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
> @@ -1047,8 +1173,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>   	if (err)
>   		return err;
>   
> -	/* Enable local temperature sensor */
> -	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
> +	err = nct7802_configure_channels(dev, data);
>   	if (err)
>   		return err;
>   
> @@ -1074,7 +1199,7 @@ static int nct7802_probe(struct i2c_client *client)
>   	mutex_init(&data->access_lock);
>   	mutex_init(&data->in_alarm_lock);
>   
> -	ret = nct7802_init_chip(data);
> +	ret = nct7802_init_chip(dev, data);
>   	if (ret < 0)
>   		return ret;
>   
> 

