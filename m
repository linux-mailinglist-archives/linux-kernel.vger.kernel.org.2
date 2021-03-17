Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7405E33F4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhCQQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhCQQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:03:54 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194FBC06174A;
        Wed, 17 Mar 2021 09:03:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u198so37326747oia.4;
        Wed, 17 Mar 2021 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9rSVcTM5isWMqxzJGKW90POrieuFYpdnGZbWZFQ/27Q=;
        b=BlQicdSnstLUof9A7VLmjmNwqaH5goGeIBSxaLlGTOyFat4cne9TTbmz6EHM0LrNoN
         yVWoNo5n8qIjelyCMninZNF9ISxyD0eJ46TwCQMK0gKVfuBEFYWTPgIGIbfTTva7hXrk
         qhshrOeGbeN5EzISYc5xCsNVGUB4MCOymXoPRjDT+AGO69tvdxntnMElE0jj8+H6Z8Y9
         PI06mWM9n4FeRh+p8rIG3u5MNvBJRqwqP21EL09A7PjdjFhtgM3GZjjVM96tsRnkuzJU
         D+GBqpPmfXAqyOSmc4DRGs4YFMBG6tD9W72O6J1ZjoOuPWrhwoPGPZ0ZA35VtLXZF8EC
         qClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9rSVcTM5isWMqxzJGKW90POrieuFYpdnGZbWZFQ/27Q=;
        b=CciXAegyL4DaAbxTl2JR6VHaaDQ0VHCWqAqV6WpNoOO0QdvYcOGUpG9D7NfgiNfg3q
         7BUw66nJixjo2p6DMKRjxTYK4cLrPp3RYOFhXUrgNyI+uO0k+QevNXPCljDm2BZ4V+es
         JhWSKuDt611kc6fHUCIL+s9ovdCVh2OAzVLsGuZgMpTbR91zgw9fM9JbbEXoGlqoOQEN
         v3OCtJbEa4M08iO1giYpvPDvXJsN0enK7GuSY9DiqskiqWwONquEhyXKxIwdo/j9bViF
         1GhhCQ19LXhsHoVrZLxf8GWF4OfWwZj0zJVCoH7c+gMwTHx6P2p7ss1Ez3RtRD4crvYJ
         9umA==
X-Gm-Message-State: AOAM530PLanjZASdZTiRKNZWIrCahe79kNrsxqWfSF4PmDMN2PNRbOi7
        FMV7doiZ0LOOtHDeMaEuD0tXD77TFhU=
X-Google-Smtp-Source: ABdhPJxfPBrV/ZUYSEOIgAoK3+p3EBvQ9r33Amt3tz3uJBOxDM28UbklGUhQW5i54+7AXKwDzudu0Q==
X-Received: by 2002:aca:e189:: with SMTP id y131mr3287130oig.143.1615997032931;
        Wed, 17 Mar 2021 09:03:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22sm792622otf.25.2021.03.17.09.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 09:03:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] hwmon: corsair-psu: add support for critical values
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org
References: <YFIcqVsnD/yOH1w0@monster.powergraphx.local>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <639d9567-65bb-c6dd-8070-c94fb140cedf@roeck-us.net>
Date:   Wed, 17 Mar 2021 09:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFIcqVsnD/yOH1w0@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 8:13 AM, Wilken Gottwalt wrote:
> Adds support for reading the critical values of the temperature sensors
> and the rail sensors (voltage and current) once and caches them. Updates
> the naming of the constants following a more clear scheme. Also updates
> the documentation and fixes some typos. Updates is_visible and ops_read
> functions to be more readable.
> 
> The new sensors output of a Corsair HX850i will look like this:
> corsairpsu-hid-3-1
> Adapter: HID adapter
> v_in:        230.00 V
> v_out +12v:   12.14 V  (crit min =  +8.41 V, crit max = +15.59 V)
> v_out +5v:     5.03 V  (crit min =  +3.50 V, crit max =  +6.50 V)
> v_out +3.3v:   3.30 V  (crit min =  +2.31 V, crit max =  +4.30 V)
> psu fan:        0 RPM
> vrm temp:     +46.2°C  (crit = +70.0°C)
> case temp:    +39.8°C  (crit = +70.0°C)
> power total: 152.00 W
> power +12v:  108.00 W
> power +5v:    41.00 W
> power +3.3v:   5.00 W
> curr +12v:     9.00 A  (crit max = +85.00 A)
> curr +5v:      8.31 A  (crit max = +40.00 A)
> curr +3.3v:    1.62 A  (crit max = +40.00 A)
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v3:
>   - introduced a quirk check function to catch non-working commands
>   - split is_visible function into subfunctions
>   - moved the "is value valid" checks into the is_visibility subfunction
>   - simplified hwmon_ops_read function
>   - rearranged sysfs entries in the documentation like suggested
> 
> Changes in v2:
>   - simplified reading/caching of critical values and hwmon_ops_read function
>   - removed unnecessary debug output and comments
> ---
>  Documentation/hwmon/corsair-psu.rst |  13 +-
>  drivers/hwmon/corsair-psu.c         | 352 +++++++++++++++++++++++-----
>  2 files changed, 309 insertions(+), 56 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index 396b95c9a76a..e8378e7a1d8c 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -47,19 +47,30 @@ Sysfs entries
>  =======================	========================================================
>  curr1_input		Total current usage
>  curr2_input		Current on the 12v psu rail
> +curr2_crit		Current max critical value on the 12v psu rail
>  curr3_input		Current on the 5v psu rail
> +curr3_crit		Current max critical value on the 5v psu rail
>  curr4_input		Current on the 3.3v psu rail
> +curr4_crit		Current max critical value on the 3.3v psu rail
>  fan1_input		RPM of psu fan
>  in0_input		Voltage of the psu ac input
>  in1_input		Voltage of the 12v psu rail
> +in1_crit		Voltage max critical value on the 12v psu rail
> +in1_lcrit		Voltage min critical value on the 12v psu rail
>  in2_input		Voltage of the 5v psu rail
> -in3_input		Voltage of the 3.3 psu rail
> +in2_crit		Voltage max critical value on the 5v psu rail
> +in2_lcrit		Voltage min critical value on the 5v psu rail
> +in3_input		Voltage of the 3.3v psu rail
> +in3_crit		Voltage max critical value on the 3.3v psu rail
> +in3_lcrit		Voltage min critical value on the 3.3v psu rail
>  power1_input		Total power usage
>  power2_input		Power usage of the 12v psu rail
>  power3_input		Power usage of the 5v psu rail
>  power4_input		Power usage of the 3.3v psu rail
>  temp1_input		Temperature of the psu vrm component
> +temp1_crit		Temperature max cirtical value of the psu vrm component
>  temp2_input		Temperature of the psu case
> +temp2_crit		Temperature max critical value of psu case
>  =======================	========================================================
>  
>  Usage Notes
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index b0953eeeb2d3..83a6a141677c 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -53,11 +53,17 @@
>  #define CMD_TIMEOUT_MS		250
>  #define SECONDS_PER_HOUR	(60 * 60)
>  #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
> +#define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
> +#define TEMP_COUNT		2
>  
>  #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
> -#define PSU_CMD_IN_VOLTS	0x88 /* the rest of the commands expect length 3 */
> +#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
> +#define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
> +#define PSU_CMD_RAIL_AMPS_HCRIT	0x46
> +#define PSU_CMD_TEMP_HCRIT	0x4F
> +#define PSU_CMD_IN_VOLTS	0x88
>  #define PSU_CMD_IN_AMPS		0x89
> -#define PSU_CMD_RAIL_OUT_VOLTS	0x8B
> +#define PSU_CMD_RAIL_VOLTS	0x8B
>  #define PSU_CMD_RAIL_AMPS	0x8C
>  #define PSU_CMD_TEMP0		0x8D
>  #define PSU_CMD_TEMP1		0x8E
> @@ -107,6 +113,21 @@ static const char *const label_amps[] = {
>  	L_AMPS_3_3V
>  };
>  
> +struct corsairpsu_crit_values {
> +	long temp_crit[TEMP_COUNT];
> +	long in_crit[RAIL_COUNT];
> +	long in_lcrit[RAIL_COUNT];
> +	long curr_crit[RAIL_COUNT];
> +	u8 temp_crit_support;
> +	u8 in_crit_support;
> +	u8 in_lcrit_support;
> +	u8 curr_crit_support;
> +};
> +
> +struct corsairpsu_quirk_commands {
> +	u8 in_curr_support;

I don't see a value in having separate structures; it just adds complexity
to the code.

Also, in_curr_support should be a bool unless it is used as bitmap
(which is not the case).

> +};
> +
>  struct corsairpsu_data {
>  	struct hid_device *hdev;
>  	struct device *hwmon_dev;
> @@ -116,6 +137,8 @@ struct corsairpsu_data {
>  	u8 *cmd_buffer;
>  	char vendor[REPLY_SIZE];
>  	char product[REPLY_SIZE];
> +	struct corsairpsu_crit_values crit_values;
> +	struct corsairpsu_quirk_commands quirks;
>  };
>  
>  /* some values are SMBus LINEAR11 data which need a conversion */
> @@ -193,7 +216,10 @@ static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, voi
>  
>  	mutex_lock(&priv->lock);
>  	switch (cmd) {
> -	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_VOLTS_HCRIT:
> +	case PSU_CMD_RAIL_VOLTS_LCRIT:
> +	case PSU_CMD_RAIL_AMPS_HCRIT:
> +	case PSU_CMD_RAIL_VOLTS:
>  	case PSU_CMD_RAIL_AMPS:
>  	case PSU_CMD_RAIL_WATTS:
>  		ret = corsairpsu_usb_cmd(priv, 2, PSU_CMD_SELECT_RAIL, rail, NULL);
> @@ -229,9 +255,13 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	 */
>  	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
>  	switch (cmd) {
> +	case PSU_CMD_RAIL_VOLTS_HCRIT:
> +	case PSU_CMD_RAIL_VOLTS_LCRIT:
> +	case PSU_CMD_RAIL_AMPS_HCRIT:
> +	case PSU_CMD_TEMP_HCRIT:
>  	case PSU_CMD_IN_VOLTS:
>  	case PSU_CMD_IN_AMPS:
> -	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_VOLTS:
>  	case PSU_CMD_RAIL_AMPS:
>  	case PSU_CMD_TEMP0:
>  	case PSU_CMD_TEMP1:
> @@ -256,75 +286,284 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	return ret;
>  }
>  
> -static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
> -					       u32 attr, int channel)
> +static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
>  {
> -	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label))
> -		return 0444;
> -	else if (type == hwmon_fan && (attr == hwmon_fan_input || attr == hwmon_fan_label))
> -		return 0444;
> -	else if (type == hwmon_power && (attr == hwmon_power_input || attr == hwmon_power_label))
> -		return 0444;
> -	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label))
> +	struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	long tmp;
> +	int rail;
> +
> +	crits->temp_crit_support = 0;
> +	crits->in_crit_support = 0;
> +	crits->in_lcrit_support = 0;
> +	crits->curr_crit_support = 0;
> +

Unnecessary initializations.

> +	for (rail = 0; rail < TEMP_COUNT; ++rail) {
> +		if (!corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp)) {
> +			crits->temp_crit_support |= BIT(rail);
> +			crits->temp_crit[rail] = tmp;
> +		}
> +	}
> +
> +	for (rail = 0; rail < RAIL_COUNT; ++rail) {
> +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp)) {
> +			crits->in_crit_support |= BIT(rail);
> +			crits->in_crit[rail] = tmp;
> +		}
> +
> +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp)) {
> +			crits->in_lcrit_support |= BIT(rail);
> +			crits->in_lcrit[rail] = tmp;
> +		}
> +
> +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp)) {
> +			crits->curr_crit_support |= BIT(rail);
> +			crits->curr_crit[rail] = tmp;
> +		}
> +	}
> +}
> +
> +static void corsairpsu_check_quirks(struct corsairpsu_data *priv)

Hmm, this isn't really a 'quirk' in its common understanding. It is a function
that checks if input current reporting is supported. If you want to keep it generic,
something like corsairpsu_check_supported() might be a better name.

> +{
> +	struct corsairpsu_quirk_commands *quirks = &priv->quirks;
> +	long tmp;
> +
> +	quirks->in_curr_support = 0;

Unnecessary initialization. Besides,

> +
> +	if (!corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, &tmp))
> +		quirks->in_curr_support = 1;

	priv->in_curr_support = !corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, &tmp);

does the same without conditional.

> +}
> +
> +static umode_t corsairpsu_hwmon_temp_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +						int channel)
> +{
> +	const struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	umode_t res = 0444;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_label:
> +	case hwmon_temp_crit:
> +		if (channel > 0 && !(crits->temp_crit_support & BIT(channel - 1)))
> +			res = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return res;
> +}
> +
> +static umode_t corsairpsu_hwmon_fan_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +					       int channel)
> +{
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_label:
>  		return 0444;
> -	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label))
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static umode_t corsairpsu_hwmon_power_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +						 int channel)
> +{
> +	switch (attr) {
> +	case hwmon_power_input:
> +	case hwmon_power_label:
>  		return 0444;
> +	default:
> +		return 0;
> +	};
> +}
>  
> -	return 0;
> +static umode_t corsairpsu_hwmon_in_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +					      int channel)
> +{
> +	const struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	umode_t res = 0444;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +	case hwmon_in_label:
> +	case hwmon_in_crit:
> +		if (channel > 0 && !(crits->in_crit_support & BIT(channel - 1)))
> +			res = 0;
> +		break;
> +	case hwmon_in_lcrit:
> +		if (channel > 0 && !(crits->in_lcrit_support & BIT(channel - 1)))
> +			res = 0;
> +		break;
> +	default:
> +		break;
> +	};
> +
> +	return res;
>  }
>  
> -static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> -				     int channel, long *val)
> +static umode_t corsairpsu_hwmon_curr_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +						int channel)
>  {
> -	struct corsairpsu_data *priv = dev_get_drvdata(dev);
> -	int ret;
> +	const struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	const struct corsairpsu_quirk_commands *quirks = &priv->quirks;
> +	umode_t res = 0444;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		if (channel == 0 && !quirks->in_curr_support)
> +			res = 0;
> +		break;
> +	case hwmon_curr_label:
> +	case hwmon_curr_crit:
> +		if (channel > 0 && !(crits->curr_crit_support & BIT(channel - 1)))
> +			res = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return res;
> +}
>  
> -	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
> -		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
> -					   val);
> -	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
> -		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> -	} else if (type == hwmon_power && attr == hwmon_power_input) {
> +static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
> +					       u32 attr, int channel)
> +{
> +	const struct corsairpsu_data *priv = data;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return corsairpsu_hwmon_temp_is_visible(priv, attr, channel);
> +	case hwmon_fan:
> +		return corsairpsu_hwmon_fan_is_visible(priv, attr, channel);
> +	case hwmon_power:
> +		return corsairpsu_hwmon_power_is_visible(priv, attr, channel);
> +	case hwmon_in:
> +		return corsairpsu_hwmon_in_is_visible(priv, attr, channel);
> +	case hwmon_curr:
> +		return corsairpsu_hwmon_curr_is_visible(priv, attr, channel);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int corsairpsu_hwmon_temp_read(struct corsairpsu_data *priv, u32 attr, int channel,
> +				      long *val)
> +{
> +	struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	int err = -EOPNOTSUPP;
> +
> +	if (channel < 2) {

If you don't use a switch statement, the if() here is really unnecessary.

> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0,
> +						    channel, val);
> +		case hwmon_temp_crit:
> +			*val = crits->temp_crit[channel];
> +			err = 0;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int corsairpsu_hwmon_power_read(struct corsairpsu_data *priv, u32 attr, int channel,
> +				       long *val)
> +{
> +	if (attr == hwmon_power_input) {
>  		switch (channel) {
>  		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
>  		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);
>  		default:
> -			return -EOPNOTSUPP;
> +			break;
>  		}
> -	} else if (type == hwmon_in && attr == hwmon_in_input) {
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int corsairpsu_hwmon_in_read(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
> +{
> +	struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	int err = -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
>  		switch (channel) {
>  		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
>  		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1, val);
>  		default:
> -			return -EOPNOTSUPP;
> +			break;
>  		}
> -	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
> +		break;
> +	case hwmon_in_crit:
> +		*val = crits->in_crit[channel - 1];
> +		err = 0;
> +		break;
> +	case hwmon_in_lcrit:
> +		*val = crits->in_lcrit[channel - 1];
> +		err = 0;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static int corsairpsu_hwmon_curr_read(struct corsairpsu_data *priv, u32 attr, int channel,
> +				      long *val)
> +{
> +	struct corsairpsu_crit_values *crits = &priv->crit_values;
> +	int err = -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
>  		switch (channel) {
>  		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
>  		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
>  		default:
> -			return -EOPNOTSUPP;
> +			break;
>  		}
> -	} else {
> -		return -EOPNOTSUPP;
> +		break;
> +	case hwmon_curr_crit:
> +		*val = crits->curr_crit[channel - 1];
> +		err = 0;
> +		break;
> +	default:
> +		break;
>  	}
>  
> -	if (ret < 0)
> -		return ret;
> +	return err;
> +}
>  
> -	return 0;
> +static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				     int channel, long *val)
> +{
> +	struct corsairpsu_data *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return corsairpsu_hwmon_temp_read(priv, attr, channel, val);
> +	case hwmon_fan:
> +		if (attr == hwmon_fan_input)
> +			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> +		return -EOPNOTSUPP;
> +	case hwmon_power:
> +		return corsairpsu_hwmon_power_read(priv, attr, channel, val);
> +	case hwmon_in:
> +		return corsairpsu_hwmon_in_read(priv, attr, channel, val);
> +	case hwmon_curr:
> +		return corsairpsu_hwmon_curr_read(priv, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum hwmon_sensor_types type,
> @@ -360,8 +599,8 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
>  	HWMON_CHANNEL_INFO(chip,
>  			   HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL),
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
>  	HWMON_CHANNEL_INFO(fan,
>  			   HWMON_F_INPUT | HWMON_F_LABEL),
>  	HWMON_CHANNEL_INFO(power,
> @@ -371,14 +610,14 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
>  			   HWMON_P_INPUT | HWMON_P_LABEL),
>  	HWMON_CHANNEL_INFO(in,
>  			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL),
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT),
>  	HWMON_CHANNEL_INFO(curr,
>  			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL),
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT),
>  	NULL
>  };
>  
> @@ -513,6 +752,9 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
>  		goto fail_and_stop;
>  	}
>  
> +	corsairpsu_get_criticals(priv);
> +	corsairpsu_check_quirks(priv);
> +
>  	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
>  							  &corsairpsu_chip_info, 0);
>  
> 

