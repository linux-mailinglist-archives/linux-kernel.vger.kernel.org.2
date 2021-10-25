Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C116E4399BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhJYPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhJYPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:13:01 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EADC061745;
        Mon, 25 Oct 2021 08:10:39 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so3228035ooi.7;
        Mon, 25 Oct 2021 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KxKO3tIdcyVqfB7709mfCTvZ0U3cw8GLzY3R64MNV0=;
        b=p+Kzd7mUQfucdrgv8qSNTta/jnBUj9bJLIo1sUeYvkjvactj3VfeJLGH98+pqjTc7H
         Ew+Vpcx3xt76y2OSoCh0kOrimD2hxOajqw8WDPkUCp2oRGbCP/eLSAXh+Gv1eDUlJNpH
         MqjsHH8Ql9SWi8IbZWUDMdSrMTQD7lGM/2mkXhBC0L2c1KMmyHOM0FFVizRIhZHebTmB
         xfjNjaODjTFAfWNw65Se3Hxt6ExVMMSdNty8L6yYvk8UbnObJh3T+rn3/1iARVDMzd5m
         kW4x3CCbLE7hYafN8B8WODFEZwbN+Sc93AxCYboI9zL4kJVbsaWk5kL+Vcn9c4f8Rtcs
         51iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KxKO3tIdcyVqfB7709mfCTvZ0U3cw8GLzY3R64MNV0=;
        b=scpApiiftHfqpFPDWFHJIP/t0M2I3LIdSHZTz5xKjo5wiIcD7xu4HA8ofv4ywbBDwv
         V/AlejUHMw3BbZFTY2UThqWqwNV3Kyr+YQ4c1YMc+on+4WQ7qS86L526CMolI07SiLwk
         77Kwe+kmBUWie5OdQHgld2ly889Fyn091TTHMqAlC/9GD53/4kWublGzU8xRkUJqFXTo
         ZDVvc+UTl7L5SBpTktMAuKIcuKW/IPP8FvsBt6qIw2bJbXvV949dDnX4ezCbJ+e/VazC
         HjLdkSHLQL5HrBIs6sagmEo8m716D7sY9qP7R6TiidMvhwlT4yzHstSvFbu+ykv5KlWq
         3y2g==
X-Gm-Message-State: AOAM532lLmVQ+wkzKgZzLXWDMhdlH/CAcvZHV2bjGwQhAel+vVGoF0N3
        1IpIaImt3Eul5sZoZ39u4QU/d7JyNpw=
X-Google-Smtp-Source: ABdhPJwEylKZLpclJwq/NeO+4WbN047rbOsuE+uLpYeppHjV5xMfHlPUvUZUPfsocuhgv4Qnm+Rxvw==
X-Received: by 2002:a05:6820:1015:: with SMTP id v21mr12598048oor.47.1635174638054;
        Mon, 25 Oct 2021 08:10:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m23sm3049847oom.34.2021.10.25.08.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:10:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, thomas@weissschuh.net,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211022200032.23267-1-pauk.denis@gmail.com>
 <20211022200032.23267-3-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8 2/3] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <d82f3e14-dd6d-2e61-c148-a9cbe67ca63f@roeck-us.net>
Date:   Mon, 25 Oct 2021 08:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022200032.23267-3-pauk.denis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 1:00 PM, Denis Pauk wrote:
> Provides a Linux kernel module "asus_wmi_sensors" that provides sensor
> readouts via ASUS' WMI interface present in the UEFI of
> X370/X470/B450/X399 Ryzen motherboards.
> 
> Supported motherboards:
> * ROG CROSSHAIR VI HERO,
> * PRIME X399-A,
> * PRIME X470-PRO,
> * ROG CROSSHAIR VI EXTREME,
> * ROG CROSSHAIR VI HERO (WI-FI AC),
> * ROG CROSSHAIR VII HERO,
> * ROG CROSSHAIR VII HERO (WI-FI),
> * ROG STRIX B450-E GAMING,
> * ROG STRIX B450-F GAMING,
> * ROG STRIX B450-I GAMING,
> * ROG STRIX X399-E GAMING,
> * ROG STRIX X470-F GAMING,
> * ROG STRIX X470-I GAMING,
> * ROG ZENITH EXTREME,
> * ROG ZENITH EXTREME ALPHA.
> 
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Ed Brindley <kernel@maidavale.org>
> Signed-off-by: Ed Brindley <kernel@maidavale.org>
> 
> ---
> Changes in v8:
> - Fix codestyle in defines and comments.
> - Call mutex_lock inside of functions.
> 
> Changes in v7:
> - Add depends on ACPI_WMI to Kconfig.
> - Clean up defines names.
> 
> Changes in v6:
> - Add asus_wmi_sensor to documentation index.
> 
> Changes in v5:
> - Fixes build issue reported by kernel test robot with disabled ACPI_WMI.
> - Remove sensor->name check as always eevaluated to true.
> 
> Changes in v4:
> - Implement wmi driver instead platform driver.
> - Update documentation.
> 
> Changes in v3:
> - Use MODULE_DEVICE_TABLE for match devices.
> - Add documentaion for driver.
> 
> Changes in v2:
> - Add module for boards with support of WMI interface returned sensor name and
>    value of sensor..
> ---
>   Documentation/hwmon/asus_wmi_sensors.rst |  74 +++
>   Documentation/hwmon/index.rst            |   1 +
>   MAINTAINERS                              |   1 +
>   drivers/hwmon/Kconfig                    |  12 +
>   drivers/hwmon/Makefile                   |   1 +
>   drivers/hwmon/asus_wmi_sensors.c         | 616 +++++++++++++++++++++++
>   6 files changed, 705 insertions(+)
>   create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
>   create mode 100644 drivers/hwmon/asus_wmi_sensors.c
> 
> diff --git a/Documentation/hwmon/asus_wmi_sensors.rst b/Documentation/hwmon/asus_wmi_sensors.rst
> new file mode 100644
> index 000000000000..cc88adc8915f
> --- /dev/null
> +++ b/Documentation/hwmon/asus_wmi_sensors.rst
> @@ -0,0 +1,74 @@
> +Kernel driver asus_wmi_sensors
> +=================================
> +
> +Supported boards:
> + * PRIME X399-A,
> + * PRIME X470-PRO,
> + * ROG CROSSHAIR VI EXTREME,
> + * ROG CROSSHAIR VI HERO,
> + * ROG CROSSHAIR VI HERO (WI-FI AC),
> + * ROG CROSSHAIR VII HERO,
> + * ROG CROSSHAIR VII HERO (WI-FI),
> + * ROG STRIX B450-E GAMING,
> + * ROG STRIX B450-F GAMING,
> + * ROG STRIX B450-I GAMING,
> + * ROG STRIX X399-E GAMING,
> + * ROG STRIX X470-F GAMING,
> + * ROG STRIX X470-I GAMING,
> + * ROG ZENITH EXTREME,
> + * ROG ZENITH EXTREME ALPHA.
> +
> +Authors:
> +    - Ed Brindley <kernel@maidavale.org>
> +
> +Description:
> +------------
> +ASUS mainboards publish hardware monitoring information via WMI interface.
> +
> +ASUS WMI interface provides a methods to get list of sensors and values of
> +such, which is utilized by this driver to publish those sensor readings to the
> +HWMON system. The driver is aware of and reads the following sensors:
> + * CPU Core Voltage,
> + * CPU SOC Voltage,
> + * DRAM Voltage,
> + * VDDP Voltage,
> + * 1.8V PLL Voltage,
> + * +12V Voltage,
> + * +5V Voltage,
> + * 3VSB Voltage,
> + * VBAT Voltage,
> + * AVCC3 Voltage,
> + * SB 1.05V Voltage,
> + * CPU Core Voltage,
> + * CPU SOC Voltage,
> + * DRAM Voltage,
> + * CPU Fan RPM,
> + * Chassis Fan 1 RPM,
> + * Chassis Fan 2 RPM,
> + * Chassis Fan 3 RPM,
> + * HAMP Fan RPM,
> + * Water Pump RPM,
> + * CPU OPT RPM,
> + * Water Flow RPM,
> + * AIO Pump RPM,
> + * CPU Temperature,
> + * CPU Socket Temperature,
> + * Motherboard Temperature,
> + * Chipset Temperature,
> + * Tsensor 1 Temperature,
> + * CPU VRM Temperature,
> + * Water In,
> + * Water Out,
> + * CPU VRM Output Current.
> +
> +Known Issues:
> +* The WMI implementation in some of Asus' BIOSes is buggy. This can result in
> +   fans stopping, fans getting stuck at max speed, or temperature readouts
> +   getting stuck. This is not an issue with the driver, but the BIOS. The Prime
> +   X470 Pro seems particularly bad for this. The more frequently the WMI
> +   interface is polled the greater the potential for this to happen. Until you
> +   have subjected your computer to an extended soak test while polling the
> +   sensors frequently, don't leave you computer unattended. Upgrading to new
> +   BIOS version with method version greater than or equal to two should
> +   rectify the issue.
> +* A few boards report 12v voltages to be ~10v.
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 23deb1a1202f..6dca9df9d24a 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -44,6 +44,7 @@ Hardware Monitoring Kernel Drivers
>      asc7621
>      aspeed-pwm-tacho
>      asus_wmi_ec_sensors
> +   asus_wmi_sensors
>      bcm54140
>      bel-pfe
>      bpa-rs600
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05448435991d..46036c184330 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2943,6 +2943,7 @@ M:	Denis Pauk <pauk.denis@gmail.com>
>   L:	linux-hwmon@vger.kernel.org
>   S:	Maintained
>   F:	drivers/hwmon/asus_wmi_ec_sensors.c
> +F:	drivers/hwmon/asus_wmi_sensors.c
>   
>   ASUS WIRELESS RADIO CONTROL DRIVER
>   M:	João Paulo Rechi Vita <jprvita@gmail.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 01b6338d70ff..f4e53d02d3d7 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2215,6 +2215,18 @@ config SENSORS_ATK0110
>   	  This driver can also be built as a module. If so, the module
>   	  will be called asus_atk0110.
>   
> +config SENSORS_ASUS_WMI
> +	tristate "ASUS WMI X370/X470/B450/X399"
> +	depends on ACPI_WMI
> +	help
> +	  If you say yes here you get support for the ACPI hardware monitoring
> +	  interface found in X370/X470/B450/X399 ASUS motherboards. This driver
> +	  will provide readings of fans, voltages and temperatures through the system
> +	  firmware.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called asus_wmi_sensors.
> +
>   config SENSORS_ASUS_WMI_EC
>   	tristate "ASUS WMI B550/X570"
>   	depends on ACPI_WMI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index aae2ff5c7335..656a6191a0f8 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
>   # APCI drivers
>   obj-$(CONFIG_SENSORS_ACPI_POWER) += acpi_power_meter.o
>   obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
> +obj-$(CONFIG_SENSORS_ASUS_WMI)	+= asus_wmi_sensors.o
>   obj-$(CONFIG_SENSORS_ASUS_WMI_EC)	+= asus_wmi_ec_sensors.o
>   
>   # Native drivers
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
> new file mode 100644
> index 000000000000..45709b6cbbf5
> --- /dev/null
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * HWMON driver for ASUS motherboards that provides sensor readouts via WMI
> + * interface present in the UEFI of the X370/X470/B450/X399 Ryzen motherboards.
> + *
> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
> + *
> + * WMI interface provides:
> + * CPU Core Voltage,
> + * CPU SOC Voltage,
> + * DRAM Voltage,
> + * VDDP Voltage,
> + * 1.8V PLL Voltage,
> + * +12V Voltage,
> + * +5V Voltage,
> + * 3VSB Voltage,
> + * VBAT Voltage,
> + * AVCC3 Voltage,
> + * SB 1.05V Voltage,
> + * CPU Core Voltage,
> + * CPU SOC Voltage,
> + * DRAM Voltage,
> + * CPU Fan RPM,
> + * Chassis Fan 1 RPM,
> + * Chassis Fan 2 RPM,
> + * Chassis Fan 3 RPM,
> + * HAMP Fan RPM,
> + * Water Pump RPM,
> + * CPU OPT RPM,
> + * Water Flow RPM,
> + * AIO Pump RPM,
> + * CPU Temperature,
> + * CPU Socket Temperature,
> + * Motherboard Temperature,
> + * Chipset Temperature,
> + * Tsensor 1 Temperature,
> + * CPU VRM Temperature,
> + * Water In,
> + * Water Out,
> + * CPU VRM Output Current.
> + */
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/units.h>
> +#include <linux/wmi.h>
> +
> +#define ASUSWMI_MONITORING_GUID	"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_GET_VALUE	0x52574543 /* RWEC */
> +#define ASUSWMI_METHODID_UPDATE_BUFFER	0x51574543 /* QWEC */
> +#define ASUSWMI_METHODID_GET_INFO	0x50574543 /* PWEC */
> +#define ASUSWMI_METHODID_GET_NUMBER	0x50574572 /* PWEr */
> +#define ASUSWMI_METHODID_GET_VERSION	0x50574574 /* PWEt */
> +
> +#define ASUS_WMI_MAX_STR_SIZE	32
> +
> +#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name) {			\
> +	.matches = {						\
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR,		\
> +				"ASUSTeK COMPUTER INC."),	\
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),		\
> +	},							\
> +}
> +
> +static const struct dmi_system_id asus_wmi_dmi_table[] = {
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X399-A"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X470-PRO"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI EXTREME"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO (WI-FI AC)"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO (WI-FI)"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-E GAMING"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-F GAMING"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B450-I GAMING"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X399-E GAMING"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X470-F GAMING"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X470-I GAMING"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH EXTREME"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH EXTREME ALPHA"),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, asus_wmi_dmi_table);
> +
> +enum asus_wmi_sensor_class {
> +	VOLTAGE = 0x0,
> +	TEMPERATURE_C = 0x1,
> +	FAN_RPM = 0x2,
> +	CURRENT = 0x3,
> +	WATER_FLOW = 0x4,
> +};
> +
> +enum asus_wmi_location {
> +	CPU = 0x0,
> +	CPU_SOC = 0x1,
> +	DRAM = 0x2,
> +	MOTHERBOARD = 0x3,
> +	CHIPSET = 0x4,
> +	AUX = 0x5,
> +	VRM = 0x6,
> +	COOLER = 0x7
> +};
> +
> +enum asus_wmi_type {
> +	SIGNED_INT = 0x0,
> +	UNSIGNED_INT = 0x1,
> +	SCALED = 0x3,
> +};
> +
> +enum asus_wmi_source {
> +	SIO = 0x1,
> +	EC = 0x2
> +};
> +
> +static enum hwmon_sensor_types asus_data_types[] = {
> +	[VOLTAGE] = hwmon_in,
> +	[TEMPERATURE_C] = hwmon_temp,
> +	[FAN_RPM] = hwmon_fan,
> +	[CURRENT] = hwmon_curr,
> +	[WATER_FLOW] = hwmon_fan,
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
> +/**
> + * struct asus_wmi_sensor_info - sensor info.
> + * @id: sensor id.
> + * @data_type: sensor class e.g. voltage, temp etc.
> + * @location: sensor location.
> + * @name: sensor name.
> + * @source: sensor source.
> + * @type: sensor type signed, unsigned etc.
> + * @cached_value: cached sensor value.
> + */
> +struct asus_wmi_sensor_info {
> +	u32 id;
> +	int data_type;
> +	int location;
> +	char name[ASUS_WMI_MAX_STR_SIZE];
> +	int source;
> +	int type;
> +	u32 cached_value;
> +};
> +
> +struct asus_wmi_wmi_info {
> +	u8 buffer;
> +	unsigned long source_last_updated[3];	/* in jiffies */
> +	int sensor_count;
> +
> +	const struct asus_wmi_sensor_info **info[hwmon_max];
> +	struct asus_wmi_sensor_info **info_by_id;
> +};
> +
> +struct asus_wmi_sensors {
> +	/* lock access to internal cache */
> +	struct mutex lock;
> +	struct asus_wmi_wmi_info wmi;
> +};
> +
> +/*
> + * Universal method for calling WMI method
> + */
> +static int asus_wmi_call_method(u32 method_id, u32 *args, struct acpi_buffer *output)
> +{
> +	struct acpi_buffer input = {(acpi_size) sizeof(*args), args };
> +	acpi_status status;
> +
> +	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0,
> +				     method_id, &input, output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/*
> + * Gets the version of the ASUS sensors interface implemented
> + */
> +static int asus_wmi_get_version(u32 *version)
> +{
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	u32 args[] = {0, 0, 0};
> +	union acpi_object *obj;
> +	int err;
> +
> +	err = asus_wmi_call_method(ASUSWMI_METHODID_GET_VERSION, args, &output);
> +	if (err)
> +		return err;
> +
> +	obj = output.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_INTEGER)
> +		return -EIO;
> +
> +	*version = obj->integer.value;
> +
> +	return 0;
> +}
> +
> +/*
> + * Gets the number of sensor items
> + */
> +static int asus_wmi_get_item_count(u32 *count)
> +{
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	u32 args[] = {0, 0, 0};
> +	union acpi_object *obj;
> +	int err;
> +
> +	err = asus_wmi_call_method(ASUSWMI_METHODID_GET_NUMBER, args, &output);
> +	if (err)
> +		return err;
> +
> +	obj = output.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_INTEGER)
> +		return -EIO;
> +
> +	*count = obj->integer.value;
> +
> +	return 0;
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
> +/*
> + * For a given sensor item returns details e.g. type (voltage/temperature/fan speed etc), bank etc
> + */
> +static int asus_wmi_sensor_info(int index, struct asus_wmi_sensor_info *s)
> +{
> +	union acpi_object name_obj, data_type_obj, location_obj, source_obj, type_obj;
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	u32 args[] = {index, 0};
> +	union acpi_object *obj;
> +	int err;
> +
> +	err = asus_wmi_call_method(ASUSWMI_METHODID_GET_INFO, args, &output);
> +	if (err)
> +		return err;
> +
> +	s->id = index;
> +
> +	obj = output.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_PACKAGE)
> +		return -EIO;
> +
Similar to the other driver, it needs to be explained why it is not necessary to
release output.pointer even though ACPI_ALLOCATE_BUFFER is set.

> +	if (obj->package.count != 5)
> +		return 1;
> +
> +	name_obj = obj->package.elements[0];
> +
> +	if (name_obj.type != ACPI_TYPE_STRING)
> +		return 1;
> +
> +	strncpy(s->name, name_obj.string.pointer, sizeof(s->name) - 1);
> +
> +	data_type_obj = obj->package.elements[1];
> +
> +	if (data_type_obj.type != ACPI_TYPE_INTEGER)
> +		return 1;
> +
> +	s->data_type = data_type_obj.integer.value;
> +
> +	location_obj = obj->package.elements[2];
> +
> +	if (location_obj.type != ACPI_TYPE_INTEGER)
> +		return 1;
> +
> +	s->location = location_obj.integer.value;
> +
> +	source_obj = obj->package.elements[3];
> +
> +	if (source_obj.type != ACPI_TYPE_INTEGER)
> +		return 1;
> +
> +	s->source = source_obj.integer.value;
> +
> +	type_obj = obj->package.elements[4];
> +
> +	if (type_obj.type != ACPI_TYPE_INTEGER)
> +		return 1;
> +
> +	s->type = type_obj.integer.value;
> +
> +	return 0;
> +}
> +
> +static int asus_wmi_update_buffer(u8 source)
> +{
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	u32 args[] = {source, 0};
> +
> +	return asus_wmi_call_method(ASUSWMI_METHODID_UPDATE_BUFFER, args, &output);
> +}
> +
> +static int asus_wmi_get_sensor_value(u8 index, u32 *value)
> +{
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	u32 args[] = {index, 0};
> +	union acpi_object *obj;
> +	int err;
> +
> +	err = asus_wmi_call_method(ASUSWMI_METHODID_GET_VALUE, args, &output);
> +	if (err)
> +		return err;
> +
> +	obj = output.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_INTEGER)
> +		return -EIO;
> +
> +	*value = obj->integer.value;
> +
> +	return 0;
> +}
> +
> +static void asus_wmi_update_values_for_source(u8 source, struct asus_wmi_sensors *sensor_data)
> +{
> +	struct asus_wmi_sensor_info *sensor;
> +	int value = 0;
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < sensor_data->wmi.sensor_count; i++) {
> +		sensor = sensor_data->wmi.info_by_id[i];
> +		if (sensor && sensor->source == source) {
> +			ret = asus_wmi_get_sensor_value(sensor->id, &value);
> +			if (!ret)
> +				sensor->cached_value = value;

Errors are ignored ? That warrants an explanation.

> +		}
> +	}
> +}
> +
> +static int asus_wmi_scale_sensor_value(u32 value, int data_type)
> +{
> +	/* FAN_RPM and WATER_FLOW don't need scaling */
> +	switch (data_type) {
> +	case VOLTAGE:
> +		return DIV_ROUND_CLOSEST(value,  MILLI);

voltage is provided in uV ? Just asking.

> +	case TEMPERATURE_C:
> +		return value * MILLI;
> +	case CURRENT:
> +		return value * MILLI;
> +	}
> +	return value;
> +}
> +
> +static int asus_wmi_get_cached_value_or_update(const struct asus_wmi_sensor_info *sensor,
> +					       struct asus_wmi_sensors *sensor_data,
> +					       u32 *value)
> +{
> +	int ret;
> +
> +	mutex_lock(&sensor_data->lock);
> +
> +	if (time_after(jiffies, sensor_data->wmi.source_last_updated[sensor->source] + HZ)) {
> +		ret = asus_wmi_update_buffer(sensor->source);
> +		if (ret) {
> +			mutex_unlock(&sensor_data->lock);
> +			return -EIO;
> +		}
> +
> +		sensor_data->wmi.buffer = sensor->source;
> +
> +		asus_wmi_update_values_for_source(sensor->source, sensor_data);
> +		sensor_data->wmi.source_last_updated[sensor->source] = jiffies;
> +	}
> +
> +	*value = sensor->cached_value;
> +
> +	mutex_unlock(&sensor_data->lock);
> +
> +	return 0;
> +}
> +
> +/* Now follow the functions that implement the hwmon interface */
> +static int asus_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			       u32 attr, int channel, long *val)
> +{
> +	const struct asus_wmi_sensor_info *sensor;
> +	u32 value = 0;
> +	int ret;
> +
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +
> +	sensor = *(sensor_data->wmi.info[type] + channel);
> +
> +	ret = asus_wmi_get_cached_value_or_update(sensor, sensor_data, &value);
> +	if (!ret)
> +		*val = asus_wmi_scale_sensor_value(value, sensor->data_type);
> +
> +	return ret;
> +}
> +
> +static int asus_wmi_hwmon_read_string(struct device *dev,
> +				      enum hwmon_sensor_types type, u32 attr,
> +				      int channel, const char **str)
> +{
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +	const struct asus_wmi_sensor_info *sensor;
> +
> +	sensor = *(sensor_data->wmi.info[type] + channel);
> +	*str = sensor->name;
> +
> +	return 0;
> +}
> +
> +static umode_t asus_wmi_hwmon_is_visible(const void *drvdata,
> +					 enum hwmon_sensor_types type, u32 attr,
> +					 int channel)
> +{
> +	const struct asus_wmi_sensors *sensor_data = drvdata;
> +	const struct asus_wmi_sensor_info *sensor;
> +
> +	sensor = *(sensor_data->wmi.info[type] + channel);
> +	if (sensor)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops asus_wmi_hwmon_ops = {
> +	.is_visible = asus_wmi_hwmon_is_visible,
> +	.read = asus_wmi_hwmon_read,
> +	.read_string = asus_wmi_hwmon_read_string,
> +};
> +
> +static struct hwmon_chip_info asus_wmi_chip_info = {
> +	.ops = &asus_wmi_hwmon_ops,
> +	.info = NULL,
> +};
> +
> +static int asus_wmi_configure_sensor_setup(struct device *dev,
> +					   struct asus_wmi_sensors *sensor_data)
> +{
> +	const struct hwmon_channel_info **ptr_asus_wmi_ci;
> +	struct hwmon_channel_info *asus_wmi_hwmon_chan;
> +	int nr_count[hwmon_max] = {}, nr_types = 0;
> +	struct asus_wmi_sensor_info *temp_sensor;
> +	const struct hwmon_chip_info *chip_info;
> +	enum hwmon_sensor_types type;
> +	struct device *hwdev;
> +	int i, idx;
> +	int err;
> +
> +	sensor_data->wmi.buffer = -1;
> +	temp_sensor = devm_kcalloc(dev, 1, sizeof(*temp_sensor), GFP_KERNEL);
> +	if (!temp_sensor)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < sensor_data->wmi.sensor_count; i++) {
> +		err = asus_wmi_sensor_info(i, temp_sensor);
> +		if (err)
> +			return -EINVAL;
> +
Please have asus_wmi_sensor_info() always return a proper error code
and return that instead of replacing it.

> +		switch (temp_sensor->data_type) {
> +		case TEMPERATURE_C:
> +		case VOLTAGE:
> +		case CURRENT:
> +		case FAN_RPM:
> +		case WATER_FLOW:
> +			type = asus_data_types[temp_sensor->data_type];
> +			if (!nr_count[type])
> +				nr_types++;
> +			nr_count[type]++;
> +			break;
> +		}
> +	}
> +
> +	if (nr_count[hwmon_temp])
> +		nr_count[hwmon_chip]++, nr_types++;
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
> +	asus_wmi_chip_info.info = ptr_asus_wmi_ci;
> +	chip_info = &asus_wmi_chip_info;
> +
> +	sensor_data->wmi.info_by_id = devm_kcalloc(dev, sensor_data->wmi.sensor_count,
> +						   sizeof(*sensor_data->wmi.info_by_id),
> +						   GFP_KERNEL);
> +
> +	if (!sensor_data->wmi.info_by_id)
> +		return -ENOMEM;
> +
> +	for (type = 0; type < hwmon_max; type++) {
> +		if (!nr_count[type])
> +			continue;
> +
> +		asus_wmi_hwmon_add_chan_info(asus_wmi_hwmon_chan, dev,
> +					     nr_count[type], type,
> +					     hwmon_attributes[type]);
> +		*ptr_asus_wmi_ci++ = asus_wmi_hwmon_chan++;
> +
> +		sensor_data->wmi.info[type] = devm_kcalloc(dev,
> +							   nr_count[type],
> +							   sizeof(*sensor_data->wmi.info),
> +							   GFP_KERNEL);
> +		if (!sensor_data->wmi.info[type])
> +			return -ENOMEM;
> +	}
> +
> +	for (i = sensor_data->wmi.sensor_count - 1; i >= 0; i--) {
> +		temp_sensor = devm_kzalloc(dev, sizeof(*temp_sensor), GFP_KERNEL);
> +		if (!temp_sensor)
> +			return -ENOMEM;
> +
> +		err = asus_wmi_sensor_info(i, temp_sensor);
> +		if (err)
> +			continue;
> +
> +		switch (temp_sensor->data_type) {
> +		case TEMPERATURE_C:
> +		case VOLTAGE:
> +		case CURRENT:
> +		case FAN_RPM:
> +		case WATER_FLOW:
> +			type = asus_data_types[temp_sensor->data_type];
> +			idx = --nr_count[type];
> +			*(sensor_data->wmi.info[type] + idx) = temp_sensor;
> +			sensor_data->wmi.info_by_id[i] = temp_sensor;
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(dev, "board has %d sensors",
> +		sensor_data->wmi.sensor_count);
> +
> +	hwdev = devm_hwmon_device_register_with_info(dev, "asus_wmi_sensors",
> +						     sensor_data, chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct asus_wmi_sensors *sensor_data;
> +	struct device *dev = &wdev->dev;
> +	u32 version = 0;
> +
> +	if (!dmi_check_system(asus_wmi_dmi_table))
> +		return -ENODEV;
> +
> +	sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
> +	if (!sensor_data)
> +		return -ENOMEM;
> +
> +	if (asus_wmi_get_version(&version))
> +		return -ENODEV;
> +
> +	if (asus_wmi_get_item_count(&sensor_data->wmi.sensor_count))
> +		return -ENODEV;
> +
> +	if (sensor_data->wmi.sensor_count  <= 0 || version < 2) {
> +		dev_info(dev, "version: %u with %d sensors is unsupported\n",
> +			 version, sensor_data->wmi.sensor_count);
> +
> +		return -ENODEV;
> +	}
> +
> +	mutex_init(&sensor_data->lock);
> +
> +	dev_set_drvdata(dev, sensor_data);
> +
> +	return asus_wmi_configure_sensor_setup(dev, sensor_data);
> +}
> +
> +static const struct wmi_device_id asus_wmi_id_table[] = {
> +	{ ASUSWMI_MONITORING_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver asus_sensors_wmi_driver = {
> +	.driver = {
> +		.name = "asus_wmi_sensors",
> +	},
> +	.id_table = asus_wmi_id_table,
> +	.probe = asus_wmi_probe,
> +};
> +module_wmi_driver(asus_sensors_wmi_driver);
> +
> +MODULE_AUTHOR("Ed Brindley <kernel@maidavale.org>");
> +MODULE_DESCRIPTION("Asus WMI Sensors Driver");
> +MODULE_LICENSE("GPL");
> 

