Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C05C33A77F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 19:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNSWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 14:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhCNSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 14:22:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE9C061574;
        Sun, 14 Mar 2021 11:22:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y131so29479742oia.8;
        Sun, 14 Mar 2021 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Um3oHa26bvv/QsLOYRMMyJaHD+1HiJFs47+EfsVcwhQ=;
        b=NMDOuXNhP9BWuwah2lJVEJxADGdydXB7O+VUR5eql5q5B/QBp99fdaXZH9GNzrqII2
         ZGwqqhcYJTSyLC5Q3nj4KKU2S1rGpPN+bFJ2X7u0zL0Sr8KkUrX1jFkjszdgHYCoM9JI
         BPuV6zWrJ8a9pmuzE/a71LGt2FSeDLzqCdqtrACyyLGJuWaAsP6azmwOLEks2R+V0w0e
         Rse7O5R+9S4AaIzyr3TEHdFh9jWYHydzxpavzVBb6PchU+4xY121pBUOi7+szDgGs8do
         ZmxRbTBJZXamlmZwoVch/DerJ0CWnwI3mU2AT7xkvr41Q3xVDK3NXT5YLh8tt4yPjhGk
         0bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Um3oHa26bvv/QsLOYRMMyJaHD+1HiJFs47+EfsVcwhQ=;
        b=oz3dDE51evtOs2ZtFmxwAioFe5Ca1ZCuJegvW9KyaW5jfXqB+Y5K7Pwozu8FOck05d
         DTg6lGXdoT/i0QQKl8KEdaTVLG6uM9F5PAlH7Sr4Zu9zaaPx4YheQwoAY5hn+UtjFayE
         gvh0WuSOkmzOueSA2rdbwUAHoDterVaYDr8WxNk10hZQB1iFOOsnhXaGwxCJU1snHySJ
         Z64fGdhE/Mp8KDjDn4VmLxu2+WHjnnKXnd3DpOxvwWdx516BB7o7rktPIA+5VMZNLrj4
         nK3Rm+1tUlXV6/P39dJ1TxzPoZrweZSDLaxW1mOOUzZA0S6kJzSXp0t/BZXE46BU1diI
         +0sA==
X-Gm-Message-State: AOAM530tlKm5H98EIZAinLQ0cI/z3thb+beVqEfJ904TnZFsDq0SYcVS
        YcgL/YJ+p0KM53GkqUb722axCFwGK9s=
X-Google-Smtp-Source: ABdhPJzdJOfr0PcULn5RDxoKNIidKCtYR9jElBeqipzTwCqIcLVypkGGlLGupF2+iTvAIXFkLxy32w==
X-Received: by 2002:a05:6808:148a:: with SMTP id e10mr16216465oiw.138.1615746123730;
        Sun, 14 Mar 2021 11:22:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 106sm5587450oth.81.2021.03.14.11.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 11:22:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: corsair-psu: add support for critical values
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org
References: <YE4Ex4cslcSZsHHs@monster.powergraphx.local>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4015dd7d-3cb1-193d-4aa3-fc0bc20f55a6@roeck-us.net>
Date:   Sun, 14 Mar 2021 11:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YE4Ex4cslcSZsHHs@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 5:42 AM, Wilken Gottwalt wrote:
> Adds support for reading the critical values of the temperature sensors
> and the rail sensors (voltage and current) once and caches them. Updates
> the naming of the constants following a more clear scheme. Also updates
> the documentation and fixes a typo.
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
> curr in:          N/A
> curr +12v:     9.00 A  (crit max = +85.00 A)
> curr +5v:      8.31 A  (crit max = +40.00 A)
> curr +3.3v:    1.62 A  (crit max = +40.00 A)
> 
> This patch changes:
> - hwmon corsair-psu documentation
> - hwmon corsair-psu driver
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
>  Documentation/hwmon/corsair-psu.rst |  13 +-
>  drivers/hwmon/corsair-psu.c         | 185 ++++++++++++++++++++++------
>  2 files changed, 157 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index 396b95c9a76a..b77e53810a13 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -45,19 +45,30 @@ Sysfs entries
>  -------------
>  
>  =======================	========================================================
> +curr2_crit		Current max critical value on the 12v psu rail
> +curr3_crit		Current max critical value on the 5v psu rail
> +curr4_crit		Current max critical value on the 3.3v psu rail
>  curr1_input		Total current usage
>  curr2_input		Current on the 12v psu rail
>  curr3_input		Current on the 5v psu rail
>  curr4_input		Current on the 3.3v psu rail
>  fan1_input		RPM of psu fan
> +in1_crit		Voltage max critical value on the 12v psu rail
> +in2_crit		Voltage max critical value on the 5v psu rail
> +in3_crit		Voltage max critical value on the 3.3v psu rail
>  in0_input		Voltage of the psu ac input
>  in1_input		Voltage of the 12v psu rail
>  in2_input		Voltage of the 5v psu rail
> -in3_input		Voltage of the 3.3 psu rail
> +in3_input		Voltage of the 3.3v psu rail
> +in1_lcrit		Voltage min critical value on the 12v psu rail
> +in2_lcrit		Voltage min critical value on the 5v psu rail
> +in3_lcrit		Voltage min critical value on the 3.3v psu rail
>  power1_input		Total power usage
>  power2_input		Power usage of the 12v psu rail
>  power3_input		Power usage of the 5v psu rail
>  power4_input		Power usage of the 3.3v psu rail
> +temp1_crit		Temperature max cirtical value of the psu vrm component
> +temp2_crit		Temperature max critical value of psu case
>  temp1_input		Temperature of the psu vrm component
>  temp2_input		Temperature of the psu case
>  =======================	========================================================
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index b0953eeeb2d3..141a5079ea7e 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -53,11 +53,21 @@
>  #define CMD_TIMEOUT_MS		250
>  #define SECONDS_PER_HOUR	(60 * 60)
>  #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
> +#define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
> +#define CRIT_VALUES_COUNT	11 /* 2 temp crit + 6 rail volts (low and high) + 3 rails amps */
> +#define TEMP_HCRIT		0
> +#define VOLTS_RAIL_HCRIT	2
> +#define VOLTS_RAIL_LCRIT	5
> +#define AMPS_RAIL_HCRIT		8
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
> @@ -113,6 +123,7 @@ struct corsairpsu_data {
>  	struct dentry *debugfs;
>  	struct completion wait_completion;
>  	struct mutex lock; /* for locking access to cmd_buffer */
> +	long crit_values[CRIT_VALUES_COUNT];
>  	u8 *cmd_buffer;
>  	char vendor[REPLY_SIZE];
>  	char product[REPLY_SIZE];
> @@ -193,7 +204,10 @@ static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, voi
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
> @@ -229,9 +243,13 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
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
> @@ -256,18 +274,70 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	return ret;
>  }
>  
> +static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
> +{
> +	long tmp;
> +	int rail;
> +	int ret;
> +
> +	ret = corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, 0, &tmp);
> +	if (ret < 0)
> +		pr_debug("%s: unable to read temp0 critical value\n", DRIVER_NAME);
> +	else
> +		priv->crit_values[TEMP_HCRIT] = tmp;
> +
> +	ret = corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, 1, &tmp);
> +	if (ret < 0)
> +		pr_debug("%s: unable to read temp1 cirtical value\n", DRIVER_NAME);
> +	else
> +		priv->crit_values[TEMP_HCRIT + 1] = tmp;
> +
> +	for (rail = 0; rail < RAIL_COUNT; ++rail) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp);
> +		if (ret < 0) {
> +			pr_debug("%s: unable to read volts rail %d high critical value\n",
> +				 DRIVER_NAME, rail);
> +		} else {
> +			priv->crit_values[VOLTS_RAIL_HCRIT + rail] = tmp;
> +		}
> +	}
> +
> +	for (rail = 0; rail < RAIL_COUNT; ++rail) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp);
> +		if (ret < 0) {
> +			pr_debug("%s: unable to read volts rail %d low critical value\n",
> +				 DRIVER_NAME, rail);
> +		} else {
> +			priv->crit_values[VOLTS_RAIL_LCRIT + rail] = tmp;
> +		}

I am not happy with this code. First, it is quite complex. Second,
it uses crit_values[] to indicate both valid limits and error codes.
That is mostly fine until there is ever a negative limit (which can happen
if there is ever a low temperature limit).

It would be much better to have a limit_supported bit map as well as limit arrays.
On top of that, I am not sure if bundling all limits into a single array is worth it.
Something like

		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp);
		if (ret == 0) {
			priv->lcrit_in_supported |= BIT(rail);
			priv->lcrit_in[rail] = tmp;
		}

would be much easier to understand, and it would and be much less error prone.

The is_visible function could then simply check for
		if (priv->lcrit_in_supported & BIT(channel))
to determine if limits are supported for a channel.

I also don't see a value in the debug messages. That is either is a bug, or it is
normal operation for some PSUs. If it is a bug, it should be reported as such
and result in an error. If it is normal operation, the result can be seen
in the non-existing attribute, and there is no need for an extra message.

> +	}
> +
> +	for (rail = 0; rail < RAIL_COUNT; ++rail) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp);
> +		if (ret < 0) {
> +			pr_debug("%s: unable to read amps rail %d hight critical value\n",
> +				 DRIVER_NAME, rail);
> +		} else {
> +			priv->crit_values[AMPS_RAIL_HCRIT + rail] = tmp;
> +		}
> +	}
> +}
> +
>  static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
>  					       u32 attr, int channel)
>  {
> -	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label))
> +	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label ||
> +				   attr == hwmon_temp_crit))
>  		return 0444;
>  	else if (type == hwmon_fan && (attr == hwmon_fan_input || attr == hwmon_fan_label))
>  		return 0444;
>  	else if (type == hwmon_power && (attr == hwmon_power_input || attr == hwmon_power_label))
>  		return 0444;
> -	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label))
> +	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label ||
> +				      attr == hwmon_in_lcrit || attr == hwmon_in_crit))
>  		return 0444;
> -	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label))
> +	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label ||
> +					attr == hwmon_curr_crit))
>  		return 0444;
>  
>  	return 0;
> @@ -277,11 +347,18 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
>  				     int channel, long *val)
>  {
>  	struct corsairpsu_data *priv = dev_get_drvdata(dev);
> -	int ret;
> -
> -	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
> -		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
> -					   val);
> +	int ret = 0;
> +
> +	if (type == hwmon_temp && channel < 2) {
> +		if (attr == hwmon_temp_input) {
> +			ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0,
> +						   channel, val);
> +		} else if (attr == hwmon_temp_crit) {
> +			if (priv->crit_values[TEMP_HCRIT + channel] != -EOPNOTSUPP)
> +				*val = priv->crit_values[TEMP_HCRIT + channel];
> +			else
> +				ret = -EOPNOTSUPP;
> +		}
>  	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
>  		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
>  	} else if (type == hwmon_power && attr == hwmon_power_input) {
> @@ -295,27 +372,48 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
>  		default:
>  			return -EOPNOTSUPP;
>  		}
> -	} else if (type == hwmon_in && attr == hwmon_in_input) {
> -		switch (channel) {
> -		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> -			break;
> -		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, val);
> -			break;
> -		default:
> -			return -EOPNOTSUPP;
> +	} else if (type == hwmon_in) {
> +		if (attr == hwmon_in_input) {
> +			switch (channel) {
> +			case 0:
> +				ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> +				break;
> +			case 1 ... 3:
> +				ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1,
> +							   val);
> +				break;
> +			default:
> +				return -EOPNOTSUPP;
> +			}
> +		} else if (attr == hwmon_in_crit && channel > 0 && channel < 4) {
> +			if (priv->crit_values[VOLTS_RAIL_HCRIT + channel - 1] != -EOPNOTSUPP)
> +				*val = priv->crit_values[VOLTS_RAIL_HCRIT + channel - 1];
> +			else
> +				ret = -EOPNOTSUPP;
> +		} else if (attr == hwmon_in_lcrit && channel > 0 && channel < 4) {
> +			if (priv->crit_values[VOLTS_RAIL_LCRIT + channel - 1] != -EOPNOTSUPP)
> +				*val = priv->crit_values[VOLTS_RAIL_LCRIT + channel - 1];
> +			else
> +				ret = -EOPNOTSUPP;
>  		}
> -	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
> -		switch (channel) {
> -		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> -			break;
> -		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
> -			break;
> -		default:
> -			return -EOPNOTSUPP;
> +	} else if (type == hwmon_curr) {
> +		if (attr == hwmon_curr_input) {
> +			switch (channel) {
> +			case 0:
> +				ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> +				break;
> +			case 1 ... 3:
> +				ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1,
> +							   val);
> +				break;
> +			default:
> +				return -EOPNOTSUPP;
> +			}
> +		} else if (attr == hwmon_curr_crit && channel > 0 && channel < 4) {
> +			if (priv->crit_values[AMPS_RAIL_HCRIT + channel - 1] != -EOPNOTSUPP)
> +				*val = priv->crit_values[AMPS_RAIL_HCRIT + channel - 1];
> +			else
> +				ret = -EOPNOTSUPP;
>  		}

Due to the channel range check, this returns a random value if the function is ever called
with attr == hwmon_curr_crit && channel == 0. This shows that the channel check is
really unnecessary (but also that the code is getting dificult to understand).

>  	} else {
>  		return -EOPNOTSUPP;

I think it is time to split this code into per-type functions. It is getting unreadable.

> @@ -360,8 +458,8 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
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
> @@ -371,14 +469,14 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
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
> @@ -472,6 +570,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>  static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>  	struct corsairpsu_data *priv;
> +	int i;
>  	int ret;
>  
>  	priv = devm_kzalloc(&hdev->dev, sizeof(struct corsairpsu_data), GFP_KERNEL);
> @@ -482,6 +581,9 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
>  	if (!priv->cmd_buffer)
>  		return -ENOMEM;
>  
> +	for (i = 0; i < CRIT_VALUES_COUNT; ++i)
> +		priv->crit_values[i] = -EOPNOTSUPP;
> +
>  	ret = hid_parse(hdev);
>  	if (ret)
>  		return ret;
> @@ -513,6 +615,9 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
>  		goto fail_and_stop;
>  	}
>  
> +	/* this can fail and is considered non-fatal */
> +	corsairpsu_get_criticals(priv);
> +

The comment does not add value, but it does add confusion. "Fail" implies
that something is wrong. However, I suspect that it only means that not all
power supplies report limits. That is not a failure, it is normal operation.

Thanks,
Guenter

>  	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
>  							  &corsairpsu_chip_info, 0);
>  
> 

