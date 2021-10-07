Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14842582D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbhJGQn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhJGQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:43:28 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88EC061570;
        Thu,  7 Oct 2021 09:41:34 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id w6-20020a4aa446000000b002b5795cca03so2065755ool.6;
        Thu, 07 Oct 2021 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LevcJz8fyd649gRGbbcIH4to8NWDxStJ1uhIHj7wE5Q=;
        b=AWRJ87ObE02IPaZzEWG1n04kgQlKVXoT4oZ9yY/VOqjLbBkXVahwJJJQSsejcdw2iu
         Ozz9X+jCmiesVeVWTsfZWD1OJwpd9cOtovQ//M5PVLstFDTSQFIf7HWSw9vlsmTANnFH
         8nvo7w4eP0zkUFT1/e7FWeiNUwvtLA1k5U76xyH9Qiqe9o+iAYDkV/00XRXBmZKdZWCc
         rPncwAlr71jY5Ldu/6w+5bqVkPNEolLvDe1NXAOLM5fUnP713zIeVSg7YPWXQLfYUlJr
         X9ljMTna7SpEJmh/df0zkeg6O9aEl84/NU3B4aD4enOJ53ZLMr+XqMLYq/JZbfkvaCWX
         6I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LevcJz8fyd649gRGbbcIH4to8NWDxStJ1uhIHj7wE5Q=;
        b=NB3N/pbF1e+9H0L8ITqc5Nf76lhjX7blGQTu+xc7lBdPOt6aLz68MVUHm5cWW0b/Fp
         xNaPdo3x9DC1EUBjU3qSjNpYvqia0weRvi9pZ0T8hPlZ7499Thgfc5a7bTvXxn73GbWm
         MzKry2JX9YDbLZufAnTjhOG0kW9DuvkuwFAMp5J+6QLg/GhNv/fst3UN8LflWGCzqAWL
         ZBVP5WVOOaawVRgrM74xRPiTaLm5wdHcEYd+D1iGCYNRAmRvEYMVm7kHN4Y1aWZacULv
         GC8HbHWEF2YN0238/eoEJiMeZZh60d9TZYAaE/Iy9GcxLH5jNNxkJmqRrM2fJJKU9jkg
         oMag==
X-Gm-Message-State: AOAM531kv3cECb8pu9ioeOPnPuTiSlM25Smwty06ozQuyd4KNLK020Ie
        aeWw3C+JcPeyvUeFn2P/JCA5/qfJGto=
X-Google-Smtp-Source: ABdhPJxjpMFE0EqXRGZou6G5CRtNre9e4e6tlvFtdfvlA94L8hviV+nkzXXz7wgu4X5WbEjaw3N8Lg==
X-Received: by 2002:a4a:e7cd:: with SMTP id y13mr4146161oov.56.1633624893108;
        Thu, 07 Oct 2021 09:41:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10sm4696678ooj.24.2021.10.07.09.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 09:41:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20211006222502.645003-1-pauk.denis@gmail.com>
 <20211006222502.645003-3-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3ddba12c-94cc-04fa-5c21-983419d62a5f@roeck-us.net>
Date:   Thu, 7 Oct 2021 09:41:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006222502.645003-3-pauk.denis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 3:25 PM, Denis Pauk wrote:
> Linux HWMON sensors driver for ASUS motherboards to read
> sensors from the embedded controller.
> 
> Many ASUS motherboards do not publish all the available
> sensors via the Super I/O chip but the missing ones are
> available through the embedded controller (EC) registers.
> 
> This driver implements reading those sensor data via the
> WMI method BREC, which is known to be present in all ASUS
> motherboards based on the AMD 500 series chipsets (and
> probably is available in other models too). The driver
> needs to know exact register addresses for the sensors and
> thus support for each motherboard has to be added explicitly.
> 
> The EC registers do not provide critical values for the
> sensors and as such they are not published to the HWMON.
> 
> Supported motherboards:
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> 
> ---
> Changes in v2:
>   - Use utf8s_to_utf16s/utf16s_to_utf8s instead handmade fuctions.
>   - Use post increment.
>   - Use get_unaligned* for convert values.
>   - Use PTR_ERR_OR_ZERO.
>   - Specify per-board sensors in a declarative way (by Eugene Shalygin).
> ---
>   MAINTAINERS                         |   7 +
>   drivers/hwmon/Kconfig               |  13 +-
>   drivers/hwmon/Makefile              |   1 +
>   drivers/hwmon/asus_wmi_ec_sensors.c | 631 ++++++++++++++++++++++++++++
>   4 files changed, 651 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bae3f62f548f..bc2e981a54e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2937,6 +2937,13 @@ W:	http://acpi4asus.sf.net
>   F:	drivers/platform/x86/asus*.c
>   F:	drivers/platform/x86/eeepc*.c
>   
> +ASUS WMI HARDWARE MONITOR DRIVER
> +M:	Eugene Shalygin <eugene.shalygin@gmail.com>
> +M:	Denis Pauk <pauk.denis@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/asus_wmi_ec_sensors.c
> +
>   ASUS WIRELESS RADIO CONTROL DRIVER
>   M:	João Paulo Rechi Vita <jprvita@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7fde4c6e1e7f..b7107721a401 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1840,7 +1840,7 @@ config SENSORS_ADS7871
>   
>   config SENSORS_AMC6821
>   	tristate "Texas Instruments AMC6821"
> -	depends on I2C
> +	depends on I2C

Completely unrelated and unacceptable change.

>   	help
>   	  If you say yes here you get support for the Texas Instruments
>   	  AMC6821 hardware monitoring chips.
> @@ -2215,6 +2215,17 @@ config SENSORS_ATK0110
>   	  This driver can also be built as a module. If so, the module
>   	  will be called asus_atk0110.
>   
> +config SENSORS_ASUS_WMI_EC
> +	tristate "ASUS WMI B550/X570"
> +	help
> +	  If you say yes here you get support for the ACPI embedded controller
> +	  hardware monitoring interface found in B550/X570 ASUS motherboards.
> +	  This driver will provide readings of fans, voltages and temperatures
> +	  through the system firmware.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called asus_wmi_sensors_ec.
> +
>   endif # ACPI
>   
>   endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index baee6a8d4dd1..aae2ff5c7335 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
>   # APCI drivers
>   obj-$(CONFIG_SENSORS_ACPI_POWER) += acpi_power_meter.o
>   obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
> +obj-$(CONFIG_SENSORS_ASUS_WMI_EC)	+= asus_wmi_ec_sensors.o
>   
>   # Native drivers
>   # asb100, then w83781d go first, as they can override other drivers' addresses.
> diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
> new file mode 100644
> index 000000000000..553d9ee8656d
> --- /dev/null
> +++ b/drivers/hwmon/asus_wmi_ec_sensors.c
> @@ -0,0 +1,631 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * HWMON driver for ASUS B550/X570 motherboards that publish sensor
> + * values via the embedded controller registers.
> + *
> + * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
> + *
> + * EC provided:
> + * Chipset temperature,
> + * CPU temperature,
> + * Motherboard temperature,
> + * T_Sensor temperature,
> + * VRM  temperature,
> + * Water In temperature,
> + * Water Out temperature,
> + * CPU Optional Fan,
> + * Chipset fan,
> + * Water Flow fan,
> + * CPU current.
> + *
> + */
> +#include <asm/unaligned.h>
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nls.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +#include <linux/wmi.h>
> +
> +#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_BLOCK_READ_EC		0x42524543 /* BREC */
> +
> +#define ASUS_WMI_BLOCK_READ_REGISTERS_MAX 0x10 /* from the ASUS DSDT source */
> +/* from the ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
> +#define ASUS_WMI_MAX_BUF_LEN 0x80
> +#define MAX_SENSOR_LABEL_LENGTH 0x10
> +
> +enum asus_wmi_ec_board {
> +	BOARD_PW_X570_A, /* Pro WS X570-ACE */
> +	BOARD_R_C8H, /* ROG Crosshair VIII Hero */
> +	BOARD_R_C8DH, /* ROG Crosshair VIII Dark Hero */
> +	BOARD_R_C8F, /* ROG Crosshair VIII Formula */
> +	BOARD_RS_B550_E_G, /* ROG STRIX B550-E GAMING */
> +	BOARD_RS_X570_E_G, /* ROG STRIX X570-E GAMING */
> +	BOARD_MAX
> +};
> +
> +/* boards with EC support */
> +static const char *const asus_wmi_ec_boards_names[] = {
> +	[BOARD_PW_X570_A] = "Pro WS X570-ACE",
> +	[BOARD_R_C8H] = "ROG CROSSHAIR VIII HERO",
> +	[BOARD_R_C8DH] = "ROG CROSSHAIR VIII DARK HERO",
> +	[BOARD_R_C8F] = "ROG CROSSHAIR VIII FORMULA",
> +	[BOARD_RS_B550_E_G] = "ROG STRIX B550-E GAMING",
> +	[BOARD_RS_X570_E_G] = "ROG STRIX X570-E GAMING",
> +};
> +
> +static u32 hwmon_attributes[] = {
> +	[hwmon_chip] = HWMON_C_REGISTER_TZ,
> +	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
> +	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
> +	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
> +	[hwmon_fan] = HWMON_F_INPUT | HWMON_F_LABEL,
> +};
> +
> +struct asus_wmi_ec_sensor_address {
> +	u8 index;
> +	u8 bank;
> +	u8 size;
> +};
> +
> +#define MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) \
> +	{ .size = size_i,\
> +	   .bank = bank_i,\
> +	   .index = index_i}
> +
> +struct ec_sensor_info {
> +	char label[MAX_SENSOR_LABEL_LENGTH];
> +	enum hwmon_sensor_types type;
> +	struct asus_wmi_ec_sensor_address addr;
> +};
> +
> +#define EC_SENSOR(sensor_label, sensor_type, size, bank, index) \
> +	{ .label = sensor_label,\
> +	.type = sensor_type, \
> +	.addr = MAKE_SENSOR_ADDRESS(size, bank, index) \
> +	}
> +
> +enum known_ec_sensor {
> +	SENSOR_TEMP_CHIPSET,
> +	SENSOR_TEMP_CPU,
> +	SENSOR_TEMP_MB,
> +	SENSOR_TEMP_T_SENSOR,
> +	SENSOR_TEMP_VRM,
> +	SENSOR_FAN_CPU_OPT,
> +	SENSOR_FAN_CHIPSET,
> +	SENSOR_FAN_WATER_FLOW,
> +	SENSOR_CURR_CPU,
> +	SENSOR_TEMP_WATER_IN,
> +	SENSOR_TEMP_WATER_OUT,
> +	SENSOR_MAX
> +};
> +
> +/*
> + * Array of the all known sensors for ASUS EC controllers
> + */
> +static const struct ec_sensor_info known_ec_sensors[] = {
> +	[SENSOR_TEMP_CHIPSET] = EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
> +	[SENSOR_TEMP_CPU] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
> +	[SENSOR_TEMP_MB] = EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
> +	[SENSOR_TEMP_T_SENSOR] = EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> +	[SENSOR_TEMP_VRM] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +	[SENSOR_FAN_CPU_OPT] = EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
> +	[SENSOR_FAN_CHIPSET] = EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
> +	[SENSOR_FAN_WATER_FLOW] = EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
> +	[SENSOR_CURR_CPU] = EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
> +	[SENSOR_TEMP_WATER_IN] = EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
> +	[SENSOR_TEMP_WATER_OUT] = EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> +};
> +
> +static const enum known_ec_sensor known_board_sensors[BOARD_MAX][SENSOR_MAX + 1] = {
> +	[BOARD_PW_X570_A] = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_MAX
> +	},
> +	[BOARD_R_C8H] = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET, SENSOR_FAN_WATER_FLOW,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +	[BOARD_R_C8DH] = { /* Same as Hero but without chipset fan */
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_WATER_FLOW,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +	[BOARD_R_C8F] = { /* Same as Hero but without water */
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +	[BOARD_RS_B550_E_G] = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CPU_OPT,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +	[BOARD_RS_X570_E_G] = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_MAX
> +	},
> +};
> +
> +struct ec_sensor {
> +	enum known_ec_sensor info_index;
> +	u32 cached_value;
> +};
> +
> +/**
> + * struct asus_wmi_ec_info - sensor info.
> + * @sensors: list of sensors.
> + * @read_arg: UTF-16 string to pass to BRxx() WMI function.
> + * @read_buffer: WMI function output.
> + * @nr_sensors: number of board EC sensors.
> + * @nr_registers: number of EC registers to read (sensor might span more than
> + *                         1 register).
> + * @last_updated: in jiffies.
> + */
> +struct asus_wmi_ec_info {
> +	struct ec_sensor sensors[SENSOR_MAX];
> +	char read_arg[((ASUS_WMI_BLOCK_READ_REGISTERS_MAX * 4) + 1) * 2];
> +	u8 read_buffer[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> +	unsigned int nr_sensors;
> +	unsigned int nr_registers;
> +	unsigned long last_updated;
> +};
> +
> +struct asus_wmi_sensors {
> +	/* lock access to instrnal cache */
> +	struct mutex lock;
> +	struct asus_wmi_ec_info ec;
> +
> +	int ec_board;
> +};
> +
> +struct asus_wmi_data {
> +	int ec_board;
> +};
> +
> +static void asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec, int board)
> +{
> +	const enum known_ec_sensor *bsi = known_board_sensors[board];
> +	struct ec_sensor *s = ec->sensors;
> +	int i;
> +
> +	ec->nr_sensors = 0;
> +	ec->nr_registers = 0;
> +
> +	for (i = 0; i < SENSOR_MAX && bsi[i] != SENSOR_MAX; i++) {
> +		s[i].info_index = bsi[i];
> +		s[i].cached_value = 0;
> +		ec->nr_sensors++;
> +		ec->nr_registers += known_ec_sensors[bsi[i]].addr.size;
> +	}
> +}
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
> +static void asus_wmi_ec_encode_registers(u16 *registers, u8 len, char *out)
> +{
> +	char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> +	char *pos = buffer;
> +	unsigned int i;
> +	u8 byte;
> +
> +	*out++ = len * 8;
> +	*out++ = 0;
> +
> +	for (i = 0; i < len; i++) {
> +		byte = registers[i] >> 8;
> +		*pos = hex_asc_hi(byte);
> +		pos++;
> +		*pos = hex_asc_lo(byte);
> +		pos++;
> +		byte = registers[i];
> +		*pos = hex_asc_hi(byte);
> +		pos++;
> +		*pos = hex_asc_lo(byte);
> +		pos++;
> +	}
> +
> +	utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN, (wchar_t *)out, len * 4);
> +}
> +
> +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
> +{
> +	u16 registers[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> +	const struct ec_sensor_info *si;
> +	long i, j, register_idx = 0;
> +
> +	/*
> +	 * if we can get values for all the registers in a single query,
> +	 * the query will not change from call to call
> +	 */
> +	if (ec->nr_registers <= ASUS_WMI_BLOCK_READ_REGISTERS_MAX &&
> +	    ec->read_arg[0] > 0) {
> +		/* no need to update */
> +		return;
> +	}
> +
> +	for (i = 0; i < ec->nr_sensors; i++) {
> +		si = &known_ec_sensors[ec->sensors[i].info_index];
> +		for (j = 0; j < si->addr.size;
> +		     j++, register_idx++) {
> +			registers[register_idx] = (si->addr.bank << 8) + si->addr.index + j;
> +		}
> +	}
> +
> +	asus_wmi_ec_encode_registers(registers, ec->nr_registers, ec->read_arg);
> +}
> +
> +static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)
> +{
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
> +		if (!obj)
> +			acpi_os_free(output.pointer);
> +
> +		return -EIO;
> +	}
> +	asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out);
> +	acpi_os_free(output.pointer);
> +	return 0;
> +}
> +
> +static int asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info *ec)
> +{
> +	const struct ec_sensor_info *si;
> +	struct ec_sensor *s;
> +
> +	u32 value;
> +	int status;
> +	u8 i_sensor, read_reg_ct;
> +
> +	asus_wmi_ec_make_block_read_query(ec);
> +	status = asus_wmi_ec_block_read(ASUSWMI_METHODID_BLOCK_READ_EC,
> +					ec->read_arg,
> +					ec->read_buffer);
> +	if (status)
> +		return status;
> +
> +	read_reg_ct = 0;
> +	for (i_sensor = 0; i_sensor < ec->nr_sensors; i_sensor++) {
> +		s = &ec->sensors[i_sensor];
> +		si = &known_ec_sensors[s->info_index];
> +
> +		if (si->addr.size == 1)
> +			value = ec->read_buffer[read_reg_ct];
> +		else if (si->addr.size == 2)
> +			value = get_unaligned_le16(&ec->read_buffer[read_reg_ct]);
> +		else if (si->addr.size == 4)
> +			value = get_unaligned_le32(&ec->read_buffer[read_reg_ct]);
> +
> +		read_reg_ct += si->addr.size;
> +		s->cached_value = value;
> +	}
> +	return 0;
> +}
> +
> +static int asus_wmi_ec_scale_sensor_value(u32 value, int data_type)
> +{
> +	switch (data_type) {
> +	case hwmon_curr:
> +	case hwmon_temp:
> +	case hwmon_in:
> +		return value * KILO;
> +	default:
> +		return value;
> +	}
> +}
> +
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
> +{
> +	int ret;
> +
> +	if (time_after(jiffies, state->ec.last_updated + HZ)) {
> +		ret = asus_wmi_ec_update_ec_sensors(&state->ec);
> +		if (ret)
> +			return ret;
> +
> +		state->ec.last_updated = jiffies;
> +	}
> +
> +	*value = state->ec.sensors[sensor_index].cached_value;
> +	return 0;
> +}
> +
> +/*
> + * Now follow the functions that implement the hwmon interface
> + */
> +
> +static int asus_wmi_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +				  u32 attr, int channel, long *val)
> +{
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +	int ret, sidx, info_index;
> +	u32 value = 0;
> +
> +	sidx = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
> +	if (sidx < 0)
> +		return sidx;
> +
> +	mutex_lock(&sensor_data->lock);
> +	ret = asus_wmi_ec_get_cached_value_or_update(sidx, sensor_data, &value);
> +	mutex_unlock(&sensor_data->lock);
> +	if (ret)
> +		return ret;
> +
> +	info_index = sensor_data->ec.sensors[sidx].info_index;
> +	*val = asus_wmi_ec_scale_sensor_value(value,
> +					      known_ec_sensors[info_index].type);
> +
> +	return ret;
> +}
> +
> +static int asus_wmi_ec_hwmon_read_string(struct device *dev,
> +					 enum hwmon_sensor_types type, u32 attr,
> +					 int channel, const char **str)
> +{
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +	int sensor_index;
> +
> +	sensor_index = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
> +	*str = known_ec_sensors[sensor_data->ec.sensors[sensor_index].info_index].label;
> +
> +	return 0;
> +}
> +
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
> +}
> +
> +static int asus_wmi_hwmon_add_chan_info(struct hwmon_channel_info *asus_wmi_hwmon_chan,
> +					struct device *dev, int num,
> +					enum hwmon_sensor_types type, u32 config)
> +{
> +	u32 *cfg;
> +
> +	cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	asus_wmi_hwmon_chan->type = type;
> +	asus_wmi_hwmon_chan->config = cfg;
> +	memset32(cfg, config, num);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops asus_wmi_ec_hwmon_ops = {
> +	.is_visible = asus_wmi_ec_hwmon_is_visible,
> +	.read = asus_wmi_ec_hwmon_read,
> +	.read_string = asus_wmi_ec_hwmon_read_string,
> +};
> +
> +static struct hwmon_chip_info asus_wmi_ec_chip_info = {
> +	.ops = &asus_wmi_ec_hwmon_ops,
> +};
> +
> +static int asus_wmi_ec_configure_sensor_setup(struct platform_device *pdev,
> +					      struct asus_wmi_sensors *sensor_data)
> +{
> +	struct hwmon_channel_info *asus_wmi_hwmon_chan;
> +	const struct hwmon_channel_info **ptr_asus_wmi_ci;
> +	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
> +	const struct hwmon_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +	const struct ec_sensor_info *si;
> +	enum hwmon_sensor_types type;
> +	struct device *hwdev;
> +	int i;
> +
> +	asus_wmi_ec_fill_board_sensors(&sensor_data->ec, sensor_data->ec_board);
> +
> +	if (!sensor_data->ec.nr_sensors)
> +		return -ENODEV;
> +
> +	for (i = 0; i < sensor_data->ec.nr_sensors; i++) {
> +		si = &known_ec_sensors[sensor_data->ec.sensors[i].info_index];
> +		if (!nr_count[si->type])
> +			nr_types++;
> +		nr_count[si->type]++;
> +	}
> +
> +	if (nr_count[hwmon_temp]) {
> +		nr_count[hwmon_chip]++;
> +		nr_types++;
> +	}
> +
> +	asus_wmi_hwmon_chan = devm_kcalloc(dev, nr_types,
> +					   sizeof(*asus_wmi_hwmon_chan),
> +					   GFP_KERNEL);
> +	if (!asus_wmi_hwmon_chan)
> +		return -ENOMEM;
> +
> +	ptr_asus_wmi_ci = devm_kcalloc(dev, nr_types + 1,
> +				       sizeof(*ptr_asus_wmi_ci), GFP_KERNEL);
> +	if (!ptr_asus_wmi_ci)
> +		return -ENOMEM;
> +
> +	asus_wmi_ec_chip_info.info = ptr_asus_wmi_ci;
> +	chip_info = &asus_wmi_ec_chip_info;
> +
> +	for (type = 0; type < hwmon_max; type++) {
> +		if (!nr_count[type])
> +			continue;
> +
> +		asus_wmi_hwmon_add_chan_info(asus_wmi_hwmon_chan, dev,
> +					     nr_count[type], type,
> +					     hwmon_attributes[type]);
> +		*ptr_asus_wmi_ci++ = asus_wmi_hwmon_chan++;
> +	}
> +
> +	dev_dbg(&pdev->dev, "%s board has %d EC sensors that span %d registers",
> +		asus_wmi_ec_boards_names[sensor_data->ec_board],
> +		sensor_data->ec.nr_sensors,
> +		sensor_data->ec.nr_registers);
> +
> +	hwdev = devm_hwmon_device_register_with_info(dev, KBUILD_MODNAME,
> +						     sensor_data, chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int asus_wmi_probe(struct platform_device *pdev)
> +{
> +	struct asus_wmi_sensors *sensor_data;
> +	struct device *dev = &pdev->dev;
> +	struct asus_wmi_data *data;
> +
> +	data = dev_get_platdata(dev);
> +
> +	sensor_data = devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
> +				   GFP_KERNEL);
> +	if (!sensor_data)
> +		return -ENOMEM;
> +
> +	mutex_init(&sensor_data->lock);
> +	sensor_data->ec_board = data->ec_board;
> +
> +	platform_set_drvdata(pdev, sensor_data);
> +
> +	/* ec init */
> +	return asus_wmi_ec_configure_sensor_setup(pdev,
> +						  sensor_data);
> +}
> +
> +static struct platform_driver asus_wmi_sensors_platform_driver = {
> +	.driver = {
> +		.name	= "asus-wmi-sensors",
> +	},
> +	.probe = asus_wmi_probe,
> +};
> +
> +static struct platform_device *sensors_pdev;
> +
> +static int __init asus_wmi_init(void)
> +{
> +	const char *board_vendor, *board_name;
> +	struct asus_wmi_data data;
> +
> +	data.ec_board = -1;
> +
> +	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (board_vendor && board_name &&
> +	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> +		if (!wmi_has_guid(ASUSWMI_MONITORING_GUID))
> +			return -ENODEV;
> +
> +		data.ec_board = match_string(asus_wmi_ec_boards_names,
> +					     ARRAY_SIZE(asus_wmi_ec_boards_names),
> +					     board_name);
> +	}
> +
> +	/* Nothing to support */
> +	if (data.ec_board < 0)
> +		return -ENODEV;
> +
> +	sensors_pdev = platform_create_bundle(&asus_wmi_sensors_platform_driver,
> +					      asus_wmi_probe,
> +					      NULL, 0,
> +					      &data, sizeof(struct asus_wmi_data));
> +
> +	return PTR_ERR_OR_ZERO(sensors_pdev);
> +}
> +module_init(asus_wmi_init);
> +
> +static void __exit asus_wmi_exit(void)
> +{
> +	platform_device_unregister(sensors_pdev);
> +	platform_driver_unregister(&asus_wmi_sensors_platform_driver);
> +}
> +module_exit(asus_wmi_exit);
> +
> +MODULE_AUTHOR("Ed Brindley <kernel@maidavale.org>");
> +MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");
> +MODULE_DESCRIPTION("Asus WMI Sensors Driver");
> +MODULE_LICENSE("GPL");
> 

