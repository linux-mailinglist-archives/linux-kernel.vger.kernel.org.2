Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CEC42DDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhJNPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:12:37 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:44901 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232713AbhJNPMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:12:23 -0400
Date:   Thu, 14 Oct 2021 17:10:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1634224214; bh=gb8TV/mqJ07WL6W25Kw3pyYMlfgycWeea7eiktr/Dxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eaV5YBAK5nmrz9SgCAQaABTChr3MQHB2XayZ7iMRTupjDEj0D8V89XUblHgP5b7Cq
         glTTtYN2oqPysc8DqI3Zo9sPWk51PZGc2Smz4vTqhMTeJK09Io1OCGGzfoVve4Uvgr
         JMoML6ho1hIn7p6X5ET2UBjKP5zkfMuX6ChbUFtA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <a0bca430-df9a-4164-a7f4-3c32e485fdb8@t-8ch.de>
References: <20211014072537.190816-1-pauk.denis@gmail.com>
 <20211014072537.190816-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014072537.190816-2-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-14T10:25+0300, Denis Pauk wrote:
> +static struct asus_wmi_data *board_sensors;
> +
> +static int __init asus_wmi_dmi_matched(const struct dmi_system_id *d)
> +{
> +	board_sensors = d->driver_data;
> +	return 0;
> +}
> +
> +#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, sensors) \
> +	{ \
> +		.callback = asus_wmi_dmi_matched, \
> +		.matches = { \
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, \
> +					"ASUSTeK COMPUTER INC."), \
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, name), \
> +		}, \
> +		.driver_data = sensors, \
> +	}
> +
> +static const struct dmi_system_id asus_wmi_ec_dmi_table[] = {
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO", &sensors_board_PW_X570_P),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE", &sensors_board_PW_X570_A),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO", &sensors_board_R_C8DH),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII FORMULA", &sensors_board_R_C8F),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO", &sensors_board_R_C8H),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING", &sensors_board_RS_B550_E_G),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING", &sensors_board_RS_X570_E_G),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, asus_wmi_ec_dmi_table);
> +
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
> +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out)
> +{
> +	unsigned int len = ACPI_MIN(ASUS_WMI_MAX_BUF_LEN, inp[0] / 4);

The general `min()` would be better.
(Or `min3()` when also validating the ACPI buffer, see below)

> +	char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> +	const char *pos = buffer;
> +	const u8 *data = inp + 2;
> +	unsigned int i;
> +
> +	utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
> +
> +	for (i = 0; i < len; i++, pos += 2)
> +		out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
> +}
> +
> +static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)
> +{
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER,
> +				      NULL };
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +
> +	/* the first byte of the BRxx() argument string has to be the string size */
> +	input.length = (acpi_size)query[0] + 2;
> +	input.pointer = query;
> +	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input,
> +				     &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = output.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_BUFFER) {
> +		acpi_os_free(obj);
> +		return -EIO;
> +	}
> +	asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out);

If this buffer is empty or the length in the first byte is incorrect then
out-of-bound memory will be accessed.

> +	acpi_os_free(obj);
> +	return 0;
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
> +					      struct asus_wmi_sensors *sensor_data)
> +{
> [..]
> +}
> +
> +static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct asus_wmi_sensors *sensor_data;
> +	struct device *dev = &wdev->dev;
> +
> +	if (!dmi_check_system(asus_wmi_ec_dmi_table))
> +		return -ENODEV;

Instead of using the callback to assign the static variable `board_sensors` you
could use `dmi_first_match()` here and pass around the result explicitly.
This would remove the need for a static variable and should cut the code down a
bit.

> +	sensor_data = devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
> +				   GFP_KERNEL);
> +	if (!sensor_data)
> +		return -ENOMEM;
> +
> +	mutex_init(&sensor_data->lock);
> +
> +	dev_set_drvdata(dev, sensor_data);
> +
> +	/* ec init */
> +	return asus_wmi_ec_configure_sensor_setup(dev,
> +						  sensor_data);
> +}
> +
