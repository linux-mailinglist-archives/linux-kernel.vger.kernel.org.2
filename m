Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C10340DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhCRTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhCRTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:01:52 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B0BC06174A;
        Thu, 18 Mar 2021 12:01:52 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso6185811ott.13;
        Thu, 18 Mar 2021 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/V3VO2OK9RdGHqtuIe/jUKhcQK6vlopYroFWSrZ2ghY=;
        b=QtTcTf9h0EHI6FrjzzNW7cnl0lyp2P4CgqnKyZXqcOSyLcfToRvbcvwwU1hAqF6FHq
         IT3a7c8rHSuhJZsGtZJ4U3RuGwT9FzLO1o9u0MghU+kJOUfhjkPZ6stzsHf6/T2Z5yT8
         Cdr47P/4y8WKpidIYvCSAlJ/vR9saEuZMSzv252rQbeAy5IYHAjNB2jEBA8sp7z3e4IG
         wX9jMVUTb4Lb9I9cuyp9piKg4XPNsP6APN4jULGCecwnK6Ivcu/s3Wr3OmRzMzwI1va5
         U22wx/M2U3qD0jPxaNLUM2uK60l0df6GyoNLZeSS11KljS9DrYOK5mQN7inBiavybj2J
         EBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/V3VO2OK9RdGHqtuIe/jUKhcQK6vlopYroFWSrZ2ghY=;
        b=GQZ2iaagng6mO0/oYjlTxO2ZVWfpzOojej3WPshsLdpq77Y7wF5AViEQlU8wwLjUiL
         BfvZVd1Rbmu/hV9hbtXAFu3cZFlk3n6pyxdodWo4eWA1d3AKqXHB6/Z4sgxt4bIpKwt1
         8F0Fa1qreyrJsgtnIyos6+dLbkRcD31MUxTliLDFw8IJUYFXTXC6CHtJcWqn8bwDEFI8
         bRYV/uSvdJTuTpmDXZw32S4pGqdEv1iGpKvj67QyzQTRoZYlYP0XTK+183H5TEm0oYDB
         AbEWHmSCgoJ/9gMkCQQRp0iNzYfOXbLJFmY3f+FE0ZHVcON6LYbGRBHijjWr3/0D8XJG
         I7fA==
X-Gm-Message-State: AOAM533NnzaQr3633EiQiE8RmH4irBkdhU+nZLjwtMGvxo4Otn+loAyV
        yvfYlorZ6vD0qryecwU3i5c=
X-Google-Smtp-Source: ABdhPJwbwWZKZUkVyvf8CCSSUNAI6QUQu2WzrZ4psY04q9W4qIPWanvPKxXVT1umY4qGrdSji8uM3A==
X-Received: by 2002:a05:6830:1513:: with SMTP id k19mr8280980otp.51.1616094111955;
        Thu, 18 Mar 2021 12:01:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4sm712774oie.23.2021.03.18.12.01.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Mar 2021 12:01:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Mar 2021 12:01:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: corsair-psu: add support for critical values
Message-ID: <20210318190150.GA152326@roeck-us.net>
References: <YFNg6vGk3sQmyqgB@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFNg6vGk3sQmyqgB@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:17:14PM +0100, Wilken Gottwalt wrote:
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

Applied.

Thanks,
Guenter

> ---
> Changed in v4:
>   - simplified private data structure and collection of critical values and
>     unsupported command check
> 
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
>  drivers/hwmon/corsair-psu.c         | 325 +++++++++++++++++++++++-----
>  2 files changed, 282 insertions(+), 56 deletions(-)
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
> index b0953eeeb2d3..3a5807e4a2ef 100644
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
> @@ -116,6 +122,15 @@ struct corsairpsu_data {
>  	u8 *cmd_buffer;
>  	char vendor[REPLY_SIZE];
>  	char product[REPLY_SIZE];
> +	long temp_crit[TEMP_COUNT];
> +	long in_crit[RAIL_COUNT];
> +	long in_lcrit[RAIL_COUNT];
> +	long curr_crit[RAIL_COUNT];
> +	u8 temp_crit_support;
> +	u8 in_crit_support;
> +	u8 in_lcrit_support;
> +	u8 curr_crit_support;
> +	bool in_curr_cmd_support; /* not all commands are supported on every PSU */
>  };
>  
>  /* some values are SMBus LINEAR11 data which need a conversion */
> @@ -193,7 +208,10 @@ static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, voi
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
> @@ -229,9 +247,13 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
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
> @@ -256,75 +278,265 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
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
> +	long tmp;
> +	int rail;
> +
> +	for (rail = 0; rail < TEMP_COUNT; ++rail) {
> +		if (!corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp)) {
> +			priv->temp_crit_support |= BIT(rail);
> +			priv->temp_crit[rail] = tmp;
> +		}
> +	}
> +
> +	for (rail = 0; rail < RAIL_COUNT; ++rail) {
> +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp)) {
> +			priv->in_crit_support |= BIT(rail);
> +			priv->in_crit[rail] = tmp;
> +		}
> +
> +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp)) {
> +			priv->in_lcrit_support |= BIT(rail);
> +			priv->in_lcrit[rail] = tmp;
> +		}
> +
> +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp)) {
> +			priv->curr_crit_support |= BIT(rail);
> +			priv->curr_crit[rail] = tmp;
> +		}
> +	}
> +}
> +
> +static void corsairpsu_check_cmd_support(struct corsairpsu_data *priv)
> +{
> +	long tmp;
> +
> +	priv->in_curr_cmd_support = !corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, &tmp);
> +}
> +
> +static umode_t corsairpsu_hwmon_temp_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +						int channel)
> +{
> +	umode_t res = 0444;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_label:
> +	case hwmon_temp_crit:
> +		if (channel > 0 && !(priv->temp_crit_support & BIT(channel - 1)))
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
> +	umode_t res = 0444;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +	case hwmon_in_label:
> +	case hwmon_in_crit:
> +		if (channel > 0 && !(priv->in_crit_support & BIT(channel - 1)))
> +			res = 0;
> +		break;
> +	case hwmon_in_lcrit:
> +		if (channel > 0 && !(priv->in_lcrit_support & BIT(channel - 1)))
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
> +	umode_t res = 0444;
>  
> -	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
> -		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
> -					   val);
> -	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
> -		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> -	} else if (type == hwmon_power && attr == hwmon_power_input) {
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		if (channel == 0 && !priv->in_curr_cmd_support)
> +			res = 0;
> +		break;
> +	case hwmon_curr_label:
> +	case hwmon_curr_crit:
> +		if (channel > 0 && !(priv->curr_crit_support & BIT(channel - 1)))
> +			res = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return res;
> +}
> +
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
> +	int err = -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0,
> +					    channel, val);
> +	case hwmon_temp_crit:
> +		*val = priv->temp_crit[channel];
> +		err = 0;
> +		break;
> +	default:
> +		break;
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
> +		*val = priv->in_crit[channel - 1];
> +		err = 0;
> +		break;
> +	case hwmon_in_lcrit:
> +		*val = priv->in_lcrit[channel - 1];
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
> +		*val = priv->curr_crit[channel - 1];
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
> @@ -360,8 +572,8 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
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
> @@ -371,14 +583,14 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
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
> @@ -513,6 +725,9 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
>  		goto fail_and_stop;
>  	}
>  
> +	corsairpsu_get_criticals(priv);
> +	corsairpsu_check_cmd_support(priv);
> +
>  	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
>  							  &corsairpsu_chip_info, 0);
>  
