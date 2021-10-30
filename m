Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A336D4409F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhJ3Pg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJ3Pg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 11:36:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CFC061570;
        Sat, 30 Oct 2021 08:34:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x16-20020a9d7050000000b00553d5d169f7so16458972otj.6;
        Sat, 30 Oct 2021 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=e4MAdTVNoJEzMYS3wa7TckXSDCDNg9lxkHfvQPQPbxI=;
        b=nDr6qOOgiOMoQYahzneVigcsCU3pLykkEesTbychdmzmg1JiV7ziuMhFrXW2DBjlgi
         lgdPYTTgdQnm31ah8So0mLn4zxtMlsa+cTKGLdkfcnq7kQMQOFBGrOAobpKFKveMpW0v
         +Fcf8+yFobMexERUSs/MXiJTZZXFlUdNy/+CAIf0KgDg0yLKzUvaEuhv7gmCIof8EPIH
         OV8bVVwd0hG6LSgQ5ni9KQtP433vPD7/DFbixN6qsfXO+AuMpCbLn7uS8Aq32dT5rAyG
         4bIRD20vUFKMV1Pv/UHwzdYAMCd5JiYsDvfQNMkaiNMIHgy/mQpsL85Cg+XfFYIhgIy2
         VDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=e4MAdTVNoJEzMYS3wa7TckXSDCDNg9lxkHfvQPQPbxI=;
        b=Gv8iLhDT8RumyAg+MOkaUh5CUWzJcjYh4x45pA1qBH2UXbn8qhzcsOcNst9n/yuaTr
         gbfkFyOEV/BNktdRn8aBrsrfzJsA0Wd+FYcqrgoz+ZB+ylEem8paozCu8Tor36U79Cir
         0yrGcHZeJivM6sTi6r+x5aJOQ3Do0+PHsdPbdxPR+dWASHkgrOMkPO9mNavmIqvHzk0J
         9u4bQGd8NJVO3+Iv7N3O/GWvZG8wceG+mFvqhOY9Wx/qEZWFCYmPk88z+dQwYX8vFjhi
         ReRZwaoDoFkc+wdTGlBRHsRh3OW6DBWXU0yFEWRuI/M87xRx3WaSVdW0ntqytdqGBg9U
         3L9A==
X-Gm-Message-State: AOAM532w1sFC4eqvlABUpaoYquvRFPQDsmuJXz161kEcsA6H9NSgTSCO
        2JE6Ii1ZbqtEHVt2S4ghNJY=
X-Google-Smtp-Source: ABdhPJxDOZ8Tk6U9zAFpD0YvMhEAP4VsKOqAfndI8a8d5wTFEr6bQS/6nPksQADe/Vp+q1Q3nF5zeg==
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr2106015otp.280.1635608067122;
        Sat, 30 Oct 2021 08:34:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm2830313oif.12.2021.10.30.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 08:34:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 30 Oct 2021 08:34:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, thomas@weissschuh.net,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <20211030153424.GA3972535@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 12:17:04PM +0300, Denis Pauk wrote:
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
> * PRIME X570-PRO
> * Pro WS X570-ACE
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING
> 
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Tor Vic <torvic9@mailbox.org>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
> ---
> Changes in v9:
> - Fix memory leaks in asus_wmi_ec_block_read()
> - Fix buffer and parameter lengths in decode and encode algorithms
> - Simplify encoding in read query
> - Reshuffle structures to make pointer arithmetics simpler or
>   no-op in some cases
> - Shuffle parameters in some functions to make it more logical
> - Use temporary variable for EC info data structure
> - Many indentation fixes to improve readability (breaks 80 characters rule)
> 
> Changes in v8:
> - Fix codestyle in defines and comments.
> - Fix buffer length calculation.
> - Use hex2bin/bin2hex for convert values in buffers.
> - Remove unrequired acpi_os_free usage.
> - Call mutex_lock inside of functions.
> 
> Changes in v7:
> - Use dmi_first_match for directly get sensors list by board.
> - Add depends on ACPI_WMI to Kconfig.
> - Add response buffer size check in asus_wmi_ec_decode_reply_buffer.
> - Clean up defines names.
> 
> Changes in v6:
> - Generate query for all sensors on sensors setup
> - Move binary to sensor value logic to separate get_sensor_value
>   (by Eugene Shalygin)
> - Add asus_wmi_ec_sensor to documentation index.
> - Use acpi_os_free without NULL pointer check.
> 
> Changes in v5:
> - Fixes build issue reported by kernel test robot with disabled ACPI_WMI.
> 
> Changes in v4:
>  - implement wmi driver instead platform driver.
> 
> Changes in v3:
>  - Use MODULE_DEVICE_TABLE for match devices.
>  - Use get_unaligned_be32 instead incorrectly used get_unaligned_le32.
>  - Add documentaion for driver.
> 
> Changes in v2:
>  - Use utf8s_to_utf16s/utf16s_to_utf8s instead handmade fuctions.
>  - Use post increment.
>  - Use get_unaligned* for convert values.
>  - Use PTR_ERR_OR_ZERO.
>  - Specify per-board sensors in a declarative way (by Eugene Shalygin).
> ---
>  Documentation/hwmon/asus_wmi_ec_sensors.rst |  35 ++
>  Documentation/hwmon/index.rst               |   1 +
>  MAINTAINERS                                 |   7 +
>  drivers/hwmon/Kconfig                       |  12 +
>  drivers/hwmon/Makefile                      |   1 +
>  drivers/hwmon/asus_wmi_ec_sensors.c         | 612 ++++++++++++++++++++
>  6 files changed, 668 insertions(+)
>  create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
>  create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
> 
> diff --git a/Documentation/hwmon/asus_wmi_ec_sensors.rst b/Documentation/hwmon/asus_wmi_ec_sensors.rst
> new file mode 100644
> index 000000000000..7edf08579baa
> --- /dev/null
> +++ b/Documentation/hwmon/asus_wmi_ec_sensors.rst
> @@ -0,0 +1,35 @@
> +Kernel driver asus_wmi_ec_sensors
> +=================================
> +

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#121: FILE: Documentation/hwmon/asus_wmi_ec_sensors.rst:1:
+Kernel driver asus_wmi_ec_sensors

> +Supported boards:
> + * PRIME X570-PRO,
> + * Pro WS X570-ACE,
> + * ROG CROSSHAIR VIII DARK HERO,
> + * ROG CROSSHAIR VIII FORMULA,
> + * ROG CROSSHAIR VIII HERO,
> + * ROG STRIX B550-E GAMING,
> + * ROG STRIX X570-E GAMING.
> +
> +Authors:
> +    - Eugene Shalygin <eugene.shalygin@gmail.com>
> +
> +Description:
> +------------
> +ASUS mainboards publish hardware monitoring information via Super I/O
> +chip and the ACPI embedded controller (EC) registers. Some of the sensors
> +are only available via the EC.
> +
> +ASUS WMI interface provides a method (BREC) to read data from EC registers,
> +which is utilized by this driver to publish those sensor readings to the
> +HWMON system. The driver is aware of and reads the following sensors:
> +
> +1. Chipset (PCH) temperature
> +2. CPU package temperature
> +3. Motherboard temperature
> +4. Readings from the T_Sensor header
> +5. VRM temperature
> +6. CPU_Opt fan RPM
> +7. Chipset fan RPM
> +8. Readings from the "Water flow meter" header (RPM)
> +9. Readings from the "Water In" and "Water Out" temperature headers
> +10. CPU current
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 7046bf1870d9..23deb1a1202f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -43,6 +43,7 @@ Hardware Monitoring Kernel Drivers
>     asb100
>     asc7621
>     aspeed-pwm-tacho
> +   asus_wmi_ec_sensors
>     bcm54140
>     bel-pfe
>     bpa-rs600
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc5eaf4e65dc..05448435991d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2937,6 +2937,13 @@ W:	http://acpi4asus.sf.net
>  F:	drivers/platform/x86/asus*.c
>  F:	drivers/platform/x86/eeepc*.c
>  
> +ASUS WMI HARDWARE MONITOR DRIVER
> +M:	Eugene Shalygin <eugene.shalygin@gmail.com>
> +M:	Denis Pauk <pauk.denis@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/asus_wmi_ec_sensors.c
> +
>  ASUS WIRELESS RADIO CONTROL DRIVER
>  M:	João Paulo Rechi Vita <jprvita@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 64bd3dfba2c4..01d50fb9da54 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2215,6 +2215,18 @@ config SENSORS_ATK0110
>  	  This driver can also be built as a module. If so, the module
>  	  will be called asus_atk0110.
>  
> +config SENSORS_ASUS_WMI_EC
> +	tristate "ASUS WMI B550/X570"
> +	depends on ACPI_WMI
> +	help
> +	  If you say yes here you get support for the ACPI embedded controller
> +	  hardware monitoring interface found in B550/X570 ASUS motherboards.
> +	  This driver will provide readings of fans, voltages and temperatures
> +	  through the system firmware.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called asus_wmi_sensors_ec.
> +
>  endif # ACPI
>  
>  endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index baee6a8d4dd1..aae2ff5c7335 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
>  # APCI drivers
>  obj-$(CONFIG_SENSORS_ACPI_POWER) += acpi_power_meter.o
>  obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
> +obj-$(CONFIG_SENSORS_ASUS_WMI_EC)	+= asus_wmi_ec_sensors.o
>  
>  # Native drivers
>  # asb100, then w83781d go first, as they can override other drivers' addresses.
> diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
> new file mode 100644
> index 000000000000..9d02023e0c61
> --- /dev/null
> +++ b/drivers/hwmon/asus_wmi_ec_sensors.c
> @@ -0,0 +1,612 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * HWMON driver for ASUS B550/X570 motherboards that publish sensor
> + * values via the embedded controller registers.
> + *
> + * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
> + *
> + * EC provides:
> + * - Chipset temperature
> + * - CPU temperature
> + * - Motherboard temperature
> + * - T_Sensor temperature
> + * - VRM temperature
> + * - Water In temperature
> + * - Water Out temperature
> + * - CPU Optional Fan RPM
> + * - Chipset Fan RPM
> + * - Water Flow Fan RPM
> + * - CPU current
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nls.h>

Why is this include needed ?

> +#include <linux/units.h>
> +#include <linux/wmi.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

The include of linux/hwmon-sysfs.h is unnecessary, and linux/hwmon.h
should be included in alphabetical order.

> +
> +#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_BLOCK_READ_EC	0x42524543 /* BREC */
> +/* From the ASUS DSDT source */
> +#define ASUSWMI_BREC_REGISTERS_MAX	16
> +#define ASUSWMI_MAX_BUF_LEN		128
> +#define SENSOR_LABEL_LEN		16
> +
> +static u32 hwmon_attributes[] = {
> +	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
> +	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
> +	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
> +	[hwmon_curr]	= HWMON_C_INPUT | HWMON_C_LABEL,
> +	[hwmon_fan]	= HWMON_F_INPUT | HWMON_F_LABEL,
> +};
> +
> +struct asus_wmi_ec_sensor_address {
> +	u8 index;
> +	u8 bank;
> +	u8 size;
> +};
> +
> +#define MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) {	\
> +	.size = size_i,					\
> +	.bank = bank_i,					\
> +	.index = index_i,				\
> +}
> +
> +struct ec_sensor_info {
> +	struct asus_wmi_ec_sensor_address addr;
> +	char label[SENSOR_LABEL_LEN];
> +	enum hwmon_sensor_types type;
> +};
> +
> +#define EC_SENSOR(sensor_label, sensor_type, size, bank, index) {	\
> +	.addr = MAKE_SENSOR_ADDRESS(size, bank, index),			\
> +	.label = sensor_label,						\
> +	.type = sensor_type,						\
> +}
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
> +/* All known sensors for ASUS EC controllers */
> +static const struct ec_sensor_info known_ec_sensors[] = {
> +	[SENSOR_TEMP_CHIPSET]	= EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
> +	[SENSOR_TEMP_CPU]	= EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
> +	[SENSOR_TEMP_MB]	= EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
> +	[SENSOR_TEMP_T_SENSOR]	= EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> +	[SENSOR_TEMP_VRM]	= EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +	[SENSOR_FAN_CPU_OPT]	= EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
> +	[SENSOR_FAN_CHIPSET]	= EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
> +	[SENSOR_FAN_WATER_FLOW]	= EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
> +	[SENSOR_CURR_CPU]	= EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
> +	[SENSOR_TEMP_WATER_IN]	= EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
> +	[SENSOR_TEMP_WATER_OUT]	= EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> +};
> +
> +struct asus_wmi_data {
> +	const enum known_ec_sensor known_board_sensors[SENSOR_MAX + 1];
> +};
> +
> +/* boards with EC support */
> +static struct asus_wmi_data sensors_board_PW_X570_P = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_PW_X570_A = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_R_C8H = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET, SENSOR_FAN_WATER_FLOW,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +/* Same as Hero but without chipset fan */
> +static struct asus_wmi_data sensors_board_R_C8DH = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_WATER_FLOW,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +/* Same as Hero but without water */
> +static struct asus_wmi_data sensors_board_R_C8F = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_RS_B550_E_G = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CPU_OPT,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_RS_X570_E_G = {
> +	.known_board_sensors = {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, sensors) {			\
> +	.matches = {								\
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),	\
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),				\
> +	},									\
> +	.driver_data = sensors,							\
> +}
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
> +struct ec_sensor {
> +	enum known_ec_sensor info_index;
> +	u32 cached_value;

Is it known that the API does not return negative values (specifically
for temperatures) ?

> +};
> +
> +/**
> + * struct asus_wmi_ec_info - sensor info.
> + * @sensors: list of sensors.
> + * @read_arg: UTF-16LE string to pass to BRxx() WMI function.
> + * @read_buffer: decoded output from WMI result.
> + * @nr_sensors: number of board EC sensors.
> + * @nr_registers: number of EC registers to read (sensor might span more than 1 register).
> + * @last_updated: in jiffies.
> + */
> +struct asus_wmi_ec_info {
> +	struct ec_sensor sensors[SENSOR_MAX];
> +	char read_arg[(ASUSWMI_BREC_REGISTERS_MAX * 4 + 1) * 2];
> +	u8 read_buffer[ASUSWMI_BREC_REGISTERS_MAX];
> +	unsigned int nr_sensors;
> +	unsigned int nr_registers;
> +	unsigned long last_updated;
> +};
> +
> +struct asus_wmi_sensors {
> +	struct asus_wmi_ec_info ec;
> +	/* lock access to internal cache */
> +	struct mutex lock;
> +};
> +
> +static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec,
> +					  const enum known_ec_sensor *bsi)
> +{
> +	struct ec_sensor *s = ec->sensors;
> +	int i;
> +
> +	ec->nr_sensors = 0;
> +	ec->nr_registers = 0;
> +
> +	for (i = 0; bsi[i] != SENSOR_MAX; i++) {
> +		s[i].info_index = bsi[i];
> +		ec->nr_sensors++;
> +		ec->nr_registers += known_ec_sensors[bsi[i]].addr.size;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * The next four functions convert to or from BRxx string argument format.
> + * The format of the string is as follows:
> + * - The string consists of two-byte UTF-16LE characters.
> + * - The value of the very first byte in the string is equal to the total
> + *   length of the next string in bytes, thus excluding the first two-byte
> + *   character.
> + * - The rest of the string encodes the pairs of (bank, index) pairs, where
> + *   both values are byte-long (0x00 to 0xFF).
> + * - Numbers are encoded as UTF-16LE hex values.
> + */
> +static int asus_wmi_ec_decode_reply_buffer(const u8 *in, u32 length, u8 *out)
> +{
> +	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
> +	u32 len = min_t(u32, get_unaligned_le16(in), length - 2);
> +
> +	utf16s_to_utf8s((wchar_t *)(in + 2), len / 2, UTF16_LITTLE_ENDIAN, buffer, sizeof(buffer));
> +
> +	return hex2bin(out, buffer, len / 4);
> +}
> +
> +static void asus_wmi_ec_encode_registers(const u8 *in, u32 len, char *out)
> +{
> +	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
> +
> +	bin2hex(buffer, in, len);
> +
> +	utf8s_to_utf16s(buffer, len * 2, UTF16_LITTLE_ENDIAN, (wchar_t *)(out + 2), len * 2);
> +
> +	put_unaligned_le16(len * 4, out);
> +}
> +
> +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
> +{
> +	u8 registers[ASUSWMI_BREC_REGISTERS_MAX * 2];
> +	const struct ec_sensor_info *si;
> +	int i, j, offset;
> +
> +	offset = 0;
> +	for (i = 0; i < ec->nr_sensors; i++) {
> +		si = &known_ec_sensors[ec->sensors[i].info_index];
> +		for (j = 0; j < si->addr.size; j++) {
> +			registers[offset++] = si->addr.bank;
> +			registers[offset++] = si->addr.index + j;
> +		}
> +	}
> +
> +	asus_wmi_ec_encode_registers(registers, offset, ec->read_arg);
> +}
> +
> +static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)
> +{
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret;
> +
> +	/* The first byte of the BRxx() argument string has to be the string size. */
> +	input.length = query[0] + 2;
> +	input.pointer = query;
> +	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = output.pointer;
> +	if (!obj)
> +		return -EIO;
> +
> +	ret = -EIO;

I don't see the point of initializing ret here.

> +	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 2)
> +		goto out_free_obj;

	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 2) {
		ret = -EIO;
		goto out_free_obj;
	}

> +
> +	ret = asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, obj->buffer.length, out);
> +
> +out_free_obj:
> +	ACPI_FREE(obj);
> +	return ret;
> +}
> +
> +static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
> +{
> +	switch (si->addr.size) {
> +	case 1:
> +		return *data;
> +	case 2:
> +		return get_unaligned_be16(data);
> +	case 4:
> +		return get_unaligned_be32(data);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info *ec)
> +{
> +	const struct ec_sensor_info *si;
> +	struct ec_sensor *s;
> +	u8 i_sensor;
> +	u8 *data;
> +
> +	data = ec->read_buffer;
> +	for (i_sensor = 0; i_sensor < ec->nr_sensors; i_sensor++) {
> +		s = &ec->sensors[i_sensor];
> +		si = &known_ec_sensors[s->info_index];
> +		s->cached_value = get_sensor_value(si, data);
> +		data += si->addr.size;
> +	}
> +}
> +
> +static int asus_wmi_ec_scale_sensor_value(u32 value, int data_type)

Why is the return value an int and not long ?

> +{
> +	switch (data_type) {
> +	case hwmon_curr:
> +	case hwmon_temp:
> +	case hwmon_in:
> +		return value * MILLI;
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
> +static int asus_wmi_ec_get_cached_value_or_update(struct asus_wmi_sensors *sensor_data,
> +						  int sensor_index,
> +						  u32 *value)
> +{
> +	struct asus_wmi_ec_info *ec = &sensor_data->ec;
> +	int ret;
> +
> +	mutex_lock(&sensor_data->lock);
> +
> +	if (time_after(jiffies, ec->last_updated + HZ)) {
> +		ret = asus_wmi_ec_block_read(ASUSWMI_METHODID_BLOCK_READ_EC,
> +					     ec->read_arg, ec->read_buffer);
> +		if (ret)
> +			goto unlock;
> +
> +		asus_wmi_ec_update_ec_sensors(ec);
> +		ec->last_updated = jiffies;
> +	}
> +
> +	*value = ec->sensors[sensor_index].cached_value;
> +
> +unlock:
> +	mutex_unlock(&sensor_data->lock);
> +
> +	return ret;

ret can be uninitialized here.

> +}
> +
> +/* Now follow the functions that implement the hwmon interface */
> +
> +static int asus_wmi_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +				  u32 attr, int channel, long *val)
> +{
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +	struct asus_wmi_ec_info *ec = &sensor_data->ec;
> +	int ret, sidx, info_index;
> +	u32 value = 0;
> +
> +	sidx = asus_wmi_ec_find_sensor_index(ec, type, channel);
> +	if (sidx < 0)
> +		return sidx;
> +
> +	ret = asus_wmi_ec_get_cached_value_or_update(sensor_data, sidx, &value);
> +	if (ret)
> +		return ret;
> +
> +	info_index = ec->sensors[sidx].info_index;
> +	*val = asus_wmi_ec_scale_sensor_value(value, known_ec_sensors[info_index].type);
> +
> +	return ret;
> +}
> +
> +static int asus_wmi_ec_hwmon_read_string(struct device *dev,
> +					 enum hwmon_sensor_types type, u32 attr,
> +					 int channel, const char **str)
> +{
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +	struct asus_wmi_ec_info *ec = &sensor_data->ec;
> +	int sensor_index;
> +
> +	sensor_index = asus_wmi_ec_find_sensor_index(ec, type, channel);
> +	*str = known_ec_sensors[ec->sensors[sensor_index].info_index].label;
> +
> +	return 0;
> +}
> +
> +static umode_t asus_wmi_ec_hwmon_is_visible(const void *drvdata,
> +					    enum hwmon_sensor_types type, u32 attr,
> +					    int channel)
> +{
> +	const struct asus_wmi_sensors *sensor_data = drvdata;
> +	const struct asus_wmi_ec_info *ec = &sensor_data->ec;
> +	int index;
> +
> +	index = asus_wmi_ec_find_sensor_index(ec, type, channel);
> +
> +	return index < 0 ? 0 : 0444;
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
> +static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
> +					      const enum known_ec_sensor *bsi)
> +{
> +	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +	struct asus_wmi_ec_info *ec = &sensor_data->ec;
> +	struct hwmon_channel_info *asus_wmi_hwmon_chan;
> +	const struct hwmon_channel_info **asus_wmi_ci;
> +	int nr_count[hwmon_max] = {}, nr_types = 0;
> +	const struct hwmon_chip_info *chip_info;
> +	const struct ec_sensor_info *si;
> +	enum hwmon_sensor_types type;
> +	struct device *hwdev;
> +	int i, ret;
> +
> +	ret = asus_wmi_ec_fill_board_sensors(ec, bsi);
> +	if (ret)
> +		return ret;
> +
> +	if (!sensor_data->ec.nr_sensors)
> +		return -ENODEV;
> +
> +	for (i = 0; i < ec->nr_sensors; i++) {
> +		si = &known_ec_sensors[ec->sensors[i].info_index];
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
> +	/*
> +	 * If we can get values for all the registers in a single query,
> +	 * the query will not change from call to call.
> +	 */
> +	asus_wmi_ec_make_block_read_query(ec);
> +
> +	asus_wmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*asus_wmi_hwmon_chan),
> +					   GFP_KERNEL);
> +	if (!asus_wmi_hwmon_chan)
> +		return -ENOMEM;
> +
> +	asus_wmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*asus_wmi_ci), GFP_KERNEL);
> +	if (!asus_wmi_ci)
> +		return -ENOMEM;
> +
> +	asus_wmi_ec_chip_info.info = asus_wmi_ci;
> +	chip_info = &asus_wmi_ec_chip_info;
> +
> +	for (type = 0; type < hwmon_max; type++) {
> +		if (!nr_count[type])
> +			continue;
> +
> +		ret = asus_wmi_hwmon_add_chan_info(asus_wmi_hwmon_chan, dev,
> +						   nr_count[type], type,
> +						   hwmon_attributes[type]);
> +		if (ret)
> +			return ret;
> +
> +		*asus_wmi_ci++ = asus_wmi_hwmon_chan++;
> +	}
> +
> +	dev_dbg(dev, "board has %d EC sensors that span %d registers",
> +		ec->nr_sensors, ec->nr_registers);
> +
> +	hwdev = devm_hwmon_device_register_with_info(dev, "asus_wmi_ec_sensors",
> +						     sensor_data, chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct asus_wmi_sensors *sensor_data;
> +	struct asus_wmi_data *board_sensors;
> +	const struct dmi_system_id *dmi_id;
> +	const enum known_ec_sensor *bsi;
> +	struct device *dev = &wdev->dev;
> +
> +	dmi_id = dmi_first_match(asus_wmi_ec_dmi_table);
> +	if (!dmi_id)
> +		return -ENODEV;
> +
> +	board_sensors = dmi_id->driver_data;
> +	if (!board_sensors)
> +		return -ENODEV;

That is technically impossible.

> +
> +	bsi = board_sensors->known_board_sensors;
> +
> +	sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
> +	if (!sensor_data)
> +		return -ENOMEM;
> +
> +	mutex_init(&sensor_data->lock);
> +
> +	dev_set_drvdata(dev, sensor_data);
> +
> +	return asus_wmi_ec_configure_sensor_setup(dev, bsi);
> +}
> +
> +static const struct wmi_device_id asus_ec_wmi_id_table[] = {
> +	{ ASUSWMI_MONITORING_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver asus_sensors_wmi_driver = {
> +	.driver = {
> +		.name = "asus_wmi_ec_sensors",
> +	},
> +	.id_table = asus_ec_wmi_id_table,
> +	.probe = asus_wmi_probe,
> +};
> +module_wmi_driver(asus_sensors_wmi_driver);
> +
> +MODULE_AUTHOR("Ed Brindley <kernel@maidavale.org>");
> +MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");
> +MODULE_DESCRIPTION("Asus WMI Sensors Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.33.0
> 
