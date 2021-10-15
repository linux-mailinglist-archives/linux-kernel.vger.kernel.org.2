Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60AE42F869
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhJOQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:41:09 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:32893 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235894AbhJOQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:41:08 -0400
Date:   Fri, 15 Oct 2021 18:38:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1634315938;
        bh=BdM/MiBquRGKWBf5ex7P/Eueuf6sv5qpuQAqP4mi+4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Frnb8HXX49zeNR+wJVPVqmLM0V1WgMpSRNLcqysXybmm1k+T7zSyMbIXnV2yHRhIe
         JioGLQJNJnGPf14iwZOvoME3MTHZA23KdMDtMg5Ymq+5lU9wWW4ZSN2MEJvQCH97yF
         4UWLP8ryzuyygi+C5NlFhn0cfHcFDjlBVAH3LuP8=
From:   thomas@weissschuh.net
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <0590836c-156d-4b67-b0f6-255afaceeb5e@t-8ch.de>
References: <20211015055808.327453-1-pauk.denis@gmail.com>
 <20211015055808.327453-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211015055808.327453-2-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-15T08:58+0300, Denis Pauk wrote:
> +/*
> + * The next four functions converts to/from BRxx string argument format
> + * The format of the string is as follows:
> + * The string consists of two-byte UTF-16 characters
> + * The value of the very first byte int the string is equal to the total length
> + * of the next string in bytes, thus excluding the first two-byte character
> + * The rest of the string encodes pairs of (bank, index) pairs, where both
> + * values are byte-long (0x00 to 0xFF)
> + * Numbers are encoded as UTF-16 hex values
> + */
> +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out, u32 length)
> +{
> +	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
> +	const char *pos = buffer;
> +	const u8 *data = inp + 2;
> +	unsigned int i;
> +	u32 len;
> +
> +	len = min3((u32)ASUSWMI_MAX_BUF_LEN, (length - 2) / 4, (u32)inp[0] / 4);

This will still access out of bounds memory when length == 0.

> +
> +	utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
> +
> +	for (i = 0; i < len; i++, pos += 2)
> +		out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
> +}

> +static int asus_wmi_ec_find_sensor_index(const struct asus_wmi_ec_info *ec,
> +					 enum hwmon_sensor_types type, int channel)
> +{
> +	int i;
> +
> +	for (i = 0; i < ec->nr_sensors; i++) {
> +		if (known_ec_sensors[ec->sensors[i].info_index].type == type) {
> +			if (channel == 0)
> +				return i;
> +
> +			channel--;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int asus_wmi_ec_get_cached_value_or_update(int sensor_index,
> +						  struct asus_wmi_sensors *state,
> +						  u32 *value)

In both drivers there is function like this where the caller is responsible
for halding the mutex. Maybe the mutex could be handled by the function
directly.

> +{
> +	int ret;
> +
> +	if (time_after(jiffies, state->ec.last_updated + HZ)) {
> +		ret = asus_wmi_ec_block_read(ASUSWMI_METHODID_BREC,
> +					     state->ec.read_arg,
> +					     state->ec.read_buffer);
> +		if (ret)
> +			return ret;
> +
> +		asus_wmi_ec_update_ec_sensors(&state->ec);
> +		state->ec.last_updated = jiffies;
> +	}
> +
> +	*value = state->ec.sensors[sensor_index].cached_value;
> +	return 0;
> +}

> +static umode_t asus_wmi_ec_hwmon_is_visible(const void *drvdata,
> +					    enum hwmon_sensor_types type, u32 attr,
> +					    int channel)
> +{
> +	int index;
> +	const struct asus_wmi_sensors *sensor_data = drvdata;
> +
> +	index = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
> +
> +	return index == 0xff ? 0 : 0444;

Should this not check for index < 0?

> +}

> +static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct asus_wmi_sensors *sensor_data;
> +	struct asus_wmi_data *board_sensors;
> +	const enum known_ec_sensor *bsi;
> +	const struct dmi_system_id *dmi_id;
> +	struct device *dev = &wdev->dev;
> +
> +	dmi_id = dmi_first_match(asus_wmi_ec_dmi_table);
> +	if (!dmi_id)
> +		return -ENODEV;
> +
> +	board_sensors = dmi_id->driver_data;
> +	if (!board_sensors)
> +		return -ENODEV;
> +
> +	bsi = board_sensors->known_board_sensors;
> +
> +	sensor_data = devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
> +				   GFP_KERNEL);

sizeof(*sensor_data);

> +	if (!sensor_data)
> +		return -ENOMEM;
> +
> +	mutex_init(&sensor_data->lock);
> +
> +	dev_set_drvdata(dev, sensor_data);
> +
> +	/* ec init */
> +	return asus_wmi_ec_configure_sensor_setup(dev,
> +						  sensor_data, bsi);
> +}
