Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82FB427ADC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhJIOhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhJIOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:37:34 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF8C061570;
        Sat,  9 Oct 2021 07:35:37 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a0568302b0700b0054e40740571so9577173otv.0;
        Sat, 09 Oct 2021 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWlZarvv2JxPdrzhfRVj8fyMdevADTATJGBJxYBWoLE=;
        b=AOU8zwZItd6x4C4+kwSwuUXQr8wtrHWenJ9GWRw9PCVoTLsY+pqIHcVsmStezMl1ym
         3BpOZS/VJ58AEqUq/rk2l1uraQgs10aEYpg1viay2ZZKPKnGOXljGgN6mEYLQFFyPlzt
         KSf7LxfQyfbuD/Cbdpy/N5zQ5O6xBADjUOFCiux24o338j0BJSZUo6o+UB90YDzv73I7
         WKEpufoFN3v+1a/EthStv5u0P8qJKKEw8lq0LXa/84gexQdR1z0+ec8dMThRlQNigQJ5
         l/VDWrySjzxBemQzE8YZI49zzsC4FnIpFhutAkBpNtDPRthvfY4Mg208dtwuIpIJpGk0
         UuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWlZarvv2JxPdrzhfRVj8fyMdevADTATJGBJxYBWoLE=;
        b=S4U+csd6JlD/kn8+mGkRxUo09eiUm4oTb+q78TOrMiAjIpXQ4j9k5Ypgd2i18BEY+F
         DGoZvHz31PagMxWvswTFn5V6yNCHGq7KISEO3yXelZlaoKCW7TIWm6JxYbId+/z25i0F
         zpGbz0XLXww/L2DDZLwvNVTsF2ZRGrcEL3KEIAd2JJn25dvC9l/G43ZhdtVFfh7yGAee
         7m30XzqYynkYgByX32VuX41xI0OdSJRICO+V8v55mk8aEsAt1QUSb0zFfUsmUCzR1nOa
         MWpWEcidOZpvlhGt6m4yaGUGtwOc5iD5hIi/imDXcJyPp3K0rrGz9pFf7QAKqoh6GNK/
         Sc9w==
X-Gm-Message-State: AOAM530FpoWkR9nWkO2W0VD30/qjy33p8PpIlpVpW93MGBQT+/CTijR2
        x+Rb7ozzrIKTRlLGth3LL1qx/2a8leA=
X-Google-Smtp-Source: ABdhPJyMBkX/F0Ft4kQWEykV5BgWfFHIrG0yfYAG4ZKITh0UaSaPd6kqOgwi3b5IGtF82ORN6y+Iag==
X-Received: by 2002:a05:6830:2386:: with SMTP id l6mr10988733ots.88.1633790136445;
        Sat, 09 Oct 2021 07:35:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm561135oig.29.2021.10.09.07.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 07:35:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211009025858.3326725-1-osk@google.com>
 <20211009025858.3326725-2-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] hwmon: (nct7802) Make temperature sensors
 configurable.
Message-ID: <0674a2d0-f0a2-d6bc-33e3-483614602bae@roeck-us.net>
Date:   Sat, 9 Oct 2021 07:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009025858.3326725-2-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 7:58 PM, Oskar Senft wrote:
> This change allows LTD and RTD inputs to be configured via
> device tree bindings. If the DT bindings are not present,
> the input configuration is not modified and left at HW
> defaults.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>   drivers/hwmon/nct7802.c | 158 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 144 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 604af2f6103a..5a7e38e8a188 100644
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
> @@ -74,7 +91,9 @@ static ssize_t temp_type_show(struct device *dev,
>   	if (ret < 0)
>   		return ret;
>   
> -	return sprintf(buf, "%u\n", (mode >> (2 * sattr->index) & 3) + 2);
> +	return sprintf(buf, "%u\n",
> +			((mode >> MODE_BIT_OFFSET_RTD(sattr->index)) &
> +				MODE_RTD_MASK) + 2);

Please split into two patches to simplify review. The changes from
constant to define are logically separate and should thus be in a
separate patch.

>   }
>   
>   static ssize_t temp_type_store(struct device *dev,
> @@ -94,7 +113,8 @@ static ssize_t temp_type_store(struct device *dev,
>   	if (type < 3 || type > 4)
>   		return -EINVAL;
>   	err = regmap_update_bits(data->regmap, REG_MODE,
> -			3 << 2 * sattr->index, (type - 2) << 2 * sattr->index);
> +			MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(sattr->index),
> +			(type - 2) << MODE_BIT_OFFSET_RTD(sattr->index));
>   	return err ? : count;
>   }
>   
> @@ -682,24 +702,24 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct nct7802_data *data = dev_get_drvdata(dev);
>   	unsigned int reg;
> +	unsigned int rtd_mode;
>   	int err;
>   
>   	err = regmap_read(data->regmap, REG_MODE, &reg);
>   	if (err < 0)
>   		return 0;
>   
> -	if (index < 10 &&
> -	    (reg & 03) != 0x01 && (reg & 0x03) != 0x02)		/* RD1 */
> +	rtd_mode = (reg >> MODE_BIT_OFFSET_RTD(index / 10)) & MODE_RTD_MASK;
> +	if (index >= 0 && index < 20 &&				/* RD1, RD 2*/
> +	    rtd_mode != 0x01 && rtd_mode != 0x02)
>   		return 0;
>   
> -	if (index >= 10 && index < 20 &&
> -	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
> -		return 0;
> -	if (index >= 20 && index < 30 && (reg & 0x30) != 0x20)	/* RD3 */
> +	if (index >= 20 && index < 30 && rtd_mode != 0x02)	/* RD3 */
>   		return 0;
>   
> -	if (index >= 30 && index < 38)				/* local */
> -		return attr->mode;
> +	if (index >= 30 && index < 38 &&			/* local */
> +	    (reg & MODE_LTD_EN) != MODE_LTD_EN)

This is just a single bit, so "!(reg & MODE_LTD_EN)" is sufficient.

> +		return 0;
>   
>   	err = regmap_read(data->regmap, REG_PECI_ENABLE, &reg);
>   	if (err < 0)
> @@ -1038,7 +1058,118 @@ static const struct regmap_config nct7802_regmap_config = {
>   	.volatile_reg = nct7802_regmap_is_volatile,
>   };
>   
> -static int nct7802_init_chip(struct nct7802_data *data)
> +static bool nct7802_get_input_config(struct device *dev,
> +	struct device_node *input, u8 *mode_mask, u8 *mode_val)

Please align continuation lines with "(".
The function should return an error code.

> +{
> +	u32 reg;
> +	const char *type_str, *md_str;
> +	u8 md;
> +
> +	if (!input->name || of_node_cmp(input->name, "input"))
> +		return false;
> +
> +	if (of_property_read_u32(input, "reg", &reg)) {
> +		dev_err(dev, "Could not read reg value for '%s'\n",
> +			input->full_name);
> +		return false;
> +	}
> +
> +	if (reg > 3) {
> +		dev_err(dev,
> +			"Invalid reg (%u) in '%s'\n", reg, input->full_name);
> +		return false;
> +	}
> +
> +	if (reg == 0) {
> +		if (!of_device_is_available(input))
> +			*mode_val &= ~MODE_LTD_EN;
> +		else
> +			*mode_val |= MODE_LTD_EN;
> +		*mode_mask |= MODE_LTD_EN;
> +		return true;
> +	}
> +
> +	if (reg >= 1 && reg <= 3 && !of_device_is_available(input)) {

reg will always be >=1 and <=3 here.

> +		*mode_val &= ~(MODE_RTD_MASK
> +			<< MODE_BIT_OFFSET_RTD(reg-1));

space around '-'

> +		*mode_mask |= MODE_RTD_MASK
> +			<< MODE_BIT_OFFSET_RTD(reg-1);

Unnecessary continuation lines. There are several more of those;
I won't comment on it further. Please only use continuation lines if
the resulting line length is otherwise > 100 columns.

> +		return true;
> +	}
> +
> +	if (of_property_read_string(input, "sensor-type", &type_str)) {
> +		dev_err(dev, "No type for '%s'\n", input->full_name);
> +		return false;
> +	}
> +
> +	if (!strcmp(type_str, "voltage")) {
> +		*mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
> +			<< MODE_BIT_OFFSET_RTD(reg-1);
> +		*mode_mask |= MODE_RTD_MASK
> +			<< MODE_BIT_OFFSET_RTD(reg-1);
> +		return true;
> +	}
> +
> +	if (strcmp(type_str, "temperature")) {
> +		dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
> +			input->full_name);
> +		return false;
> +	}
> +
> +	if (reg == 3) {
> +		/* RTD3 only supports thermistor mode */
> +		md = RTD_MODE_THERMISTOR;
> +	} else {
> +		if (of_property_read_string(input, "temperature-mode",
> +								&md_str)) {
> +			dev_err(dev, "No mode for '%s'\n", input->full_name);
> +			return false;
> +		}
> +
> +		if (!strcmp(md_str, "thermal-diode"))
> +			md = RTD_MODE_CURRENT;
> +		else if (!strcmp(md_str, "thermistor"))
> +			md = RTD_MODE_THERMISTOR;
> +		else {
> +			dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
> +				input->full_name);
> +			return false;
> +		}
> +	}
> +
> +	*mode_val |= (md & MODE_RTD_MASK)
> +		<< MODE_BIT_OFFSET_RTD(reg-1);

space before and after '-'

> +	*mode_mask |= MODE_RTD_MASK
> +		<< MODE_BIT_OFFSET_RTD(reg-1);
> +
> +	return true;
> +}
> +
> +static int nct7802_configure_inputs(struct device *dev,
> +	struct nct7802_data *data)
> +{
> +	bool found_input_config = false;
> +	u8 mode_mask = 0, mode_val = 0;
> +	struct device_node *input;
> +
> +	if (dev->of_node) {
> +		for_each_child_of_node(dev->of_node, input) {
> +			if (nct7802_get_input_config(dev, input, &mode_mask,
> +					&mode_val))
> +				found_input_config = true;

This is mixing errors with "dt configuration does not exist".
nct7802_get_input_config() should return an actual error if the
DT configuration is bad, and return that error to the calling code
if that is the case.

> +		}
> +	}
> +
> +	if (!found_input_config) {
> +		/* Enable local temperature sensor by default */
> +		mode_val |= MODE_LTD_EN;
> +		mode_mask |= MODE_LTD_EN;
> +	}

This can be set by default since nct7802_get_input_config()
removes it if the channel is disabled, meaning found_input_config
is really unnecessary.

> +
> +	return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
> +}
> +
> +static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
>   {
>   	int err;
>   
> @@ -1047,8 +1178,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>   	if (err)
>   		return err;
>   
> -	/* Enable local temperature sensor */
> -	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
> +	err = nct7802_configure_inputs(dev, data);
>   	if (err)
>   		return err;
>   
> @@ -1074,7 +1204,7 @@ static int nct7802_probe(struct i2c_client *client)
>   	mutex_init(&data->access_lock);
>   	mutex_init(&data->in_alarm_lock);
>   
> -	ret = nct7802_init_chip(data);
> +	ret = nct7802_init_chip(dev, data);
>   	if (ret < 0)
>   		return ret;
>   
> 

