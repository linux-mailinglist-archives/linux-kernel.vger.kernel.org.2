Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7543C42DADB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhJNNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhJNNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:54:28 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6ADC061570;
        Thu, 14 Oct 2021 06:52:22 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6D246C3D986;
        Thu, 14 Oct 2021 15:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1634219538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qpnhth6XORIT2OLJKX566m8HgSgu4IlFmV0Dsgor838=;
        b=VHFjpG0Yo46St2VrDTXVUO1zJlFEQfbx/ZJivmJ1qe878FYrO34xmSEL6Hs7ThoFnxZ0F0
        yEFbGYhJphFk3xcsW7MrkcNVhtAqfwDObn+kalyphfYMK7gMasCTCqQYcTSyKLXEB0oU5M
        yJTK8zyiZXZbJUKlVcTJnCuK89hJTXY=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
Date:   Thu, 14 Oct 2021 15:52:16 +0200
Message-ID: <11844462.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20211014072537.190816-2-pauk.denis@gmail.com>
References: <20211014072537.190816-1-pauk.denis@gmail.com> <20211014072537.190816-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 14. =C5=99=C3=ADjna 2021 9:25:34 CEST Denis Pauk wrote:
> Linux HWMON sensors driver for ASUS motherboards to read
> sensors from the embedded controller.
>=20
> Many ASUS motherboards do not publish all the available
> sensors via the Super I/O chip but the missing ones are
> available through the embedded controller (EC) registers.
>=20
> This driver implements reading those sensor data via the
> WMI method BREC, which is known to be present in all ASUS
> motherboards based on the AMD 500 series chipsets (and
> probably is available in other models too). The driver
> needs to know exact register addresses for the sensors and
> thus support for each motherboard has to be added explicitly.
>=20
> The EC registers do not provide critical values for the
> sensors and as such they are not published to the HWMON.
>=20
> Supported motherboards:
> * PRIME X570-PRO

+ Pro WS X570-ACE

> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING
>=20
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Tested-by: Tor Vic <torvic9@mailbox.org>
> Reported-by: kernel test robot <lkp@intel.com>

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

>=20
> ---
> Changes in v6:
> - Generate query for all sensors on sensors setup
> - Move binary to sensor value logic to separate get_sensor_value
>   (by Eugene Shalygin)
> - Add asus_wmi_ec_sensor to documentation index.
> - Use acpi_os_free without NULL pointer check.
>=20
> Changes in v5:
> - Fixes build issue reported by kernel test robot with disabled ACPI_WMI.
>=20
> Changes in v4:
>  - implement wmi driver instead platform driver.
>=20
> Changes in v3:
>  - Use MODULE_DEVICE_TABLE for match devices.
>  - Use get_unaligned_be32 instead incorrectly used get_unaligned_le32.
>  - Add documentaion for driver.
>=20
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
>  drivers/hwmon/Kconfig                       |  11 +
>  drivers/hwmon/Makefile                      |   1 +
>  drivers/hwmon/asus_wmi_ec_sensors.c         | 637 ++++++++++++++++++++
>  6 files changed, 692 insertions(+)
>  create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
>  create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
>=20
> diff --git a/Documentation/hwmon/asus_wmi_ec_sensors.rst
> b/Documentation/hwmon/asus_wmi_ec_sensors.rst new file mode 100644
> index 000000000000..e4f603804a82
> --- /dev/null
> +++ b/Documentation/hwmon/asus_wmi_ec_sensors.rst
> @@ -0,0 +1,35 @@
> +Kernel driver asus-wmi-ec-sensors
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
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
> +        Eugene Shalygin <eugene.shalygin@gmail.com>
> +
> +Description:
> +------------
> +ASUS mainboards publish hardware monitoring information via Super I/O
> +chip and the ACPI embedded controller (EC) registers. Some of the sensors
> +are only available via the EC.
> +
> +ASUS WMI interface provides a method (BREC) to read data from EC registe=
rs,
> +which is utilized by this driver to publish those sensor readings to the
> +HWMON system. The driver is aware of and reads the following sensors: +
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
>=20
> +ASUS WMI HARDWARE MONITOR DRIVER
> +M:	Eugene Shalygin <eugene.shalygin@gmail.com>
> +M:	Denis Pauk <pauk.denis@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/asus_wmi_ec_sensors.c
> +
>  ASUS WIRELESS RADIO CONTROL DRIVER
>  M:	Jo=C3=83=C2=A3o Paulo Rechi Vita <jprvita@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7fde4c6e1e7f..430a438432a0 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2215,6 +2215,17 @@ config SENSORS_ATK0110
>  	  This driver can also be built as a module. If so, the module
>  	  will be called asus_atk0110.
>=20
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
>  endif # ACPI
>=20
>  endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index baee6a8d4dd1..aae2ff5c7335 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_HWMON_VID)		+=3D hwmon-vid.o
>  # APCI drivers
>  obj-$(CONFIG_SENSORS_ACPI_POWER) +=3D acpi_power_meter.o
>  obj-$(CONFIG_SENSORS_ATK0110)	+=3D asus_atk0110.o
> +obj-$(CONFIG_SENSORS_ASUS_WMI_EC)	+=3D asus_wmi_ec_sensors.o
>=20
>  # Native drivers
>  # asb100, then w83781d go first, as they can override other drivers'
> addresses. diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c
> b/drivers/hwmon/asus_wmi_ec_sensors.c new file mode 100644
> index 000000000000..632c1d500664
> --- /dev/null
> +++ b/drivers/hwmon/asus_wmi_ec_sensors.c
> @@ -0,0 +1,637 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * HWMON driver for ASUS B550/X570 motherboards that publish sensor
> + * values via the embedded controller registers.
> + *
> + * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
> + *
> + * EC provides:
> + * Chipset temperature,
> + * CPU temperature,
> + * Motherboard temperature,
> + * T_Sensor temperature,
> + * VRM  temperature,
> + * Water In temperature,
> + * Water Out temperature,
> + * CPU Optional Fan RPM,
> + * Chipset Fan RPM,
> + * Water Flow Fan RPM,
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
> +#include <linux/units.h>
> +#include <linux/wmi.h>
> +
> +#define ASUSWMI_MONITORING_GUID	=09
"466747A0-70EC-11DE-8A39-0800200C9A66"
> +#define ASUSWMI_METHODID_BLOCK_READ_EC		0x42524543 /* BREC */
> +
> +#define ASUS_WMI_BLOCK_READ_REGISTERS_MAX 0x10 /* from the ASUS DSDT sou=
rce
> */ +/* from the ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
> +#define ASUS_WMI_MAX_BUF_LEN 0x80
> +#define MAX_SENSOR_LABEL_LENGTH 0x10
> +
> +static u32 hwmon_attributes[] =3D {
> +	[hwmon_chip] =3D HWMON_C_REGISTER_TZ,
> +	[hwmon_temp] =3D HWMON_T_INPUT | HWMON_T_LABEL,
> +	[hwmon_in] =3D HWMON_I_INPUT | HWMON_I_LABEL,
> +	[hwmon_curr] =3D HWMON_C_INPUT | HWMON_C_LABEL,
> +	[hwmon_fan] =3D HWMON_F_INPUT | HWMON_F_LABEL,
> +};
> +
> +struct asus_wmi_ec_sensor_address {
> +	u8 index;
> +	u8 bank;
> +	u8 size;
> +};
> +
> +#define MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) \
> +	{ .size =3D size_i,\
> +	   .bank =3D bank_i,\
> +	   .index =3D index_i}
> +
> +struct ec_sensor_info {
> +	char label[MAX_SENSOR_LABEL_LENGTH];
> +	enum hwmon_sensor_types type;
> +	struct asus_wmi_ec_sensor_address addr;
> +};
> +
> +#define EC_SENSOR(sensor_label, sensor_type, size, bank, index) \
> +	{ .label =3D sensor_label,\
> +	.type =3D sensor_type, \
> +	.addr =3D MAKE_SENSOR_ADDRESS(size, bank, index) \
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
> + * All the known sensors for ASUS EC controllers
> + */
> +static const struct ec_sensor_info known_ec_sensors[] =3D {
> +	[SENSOR_TEMP_CHIPSET] =3D EC_SENSOR("Chipset", hwmon_temp, 1, 0x00,=20
0x3a),
> +	[SENSOR_TEMP_CPU] =3D EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
> +	[SENSOR_TEMP_MB] =3D EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c=
),
> +	[SENSOR_TEMP_T_SENSOR] =3D EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00,=20
0x3d),
> +	[SENSOR_TEMP_VRM] =3D EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +	[SENSOR_FAN_CPU_OPT] =3D EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
> +	[SENSOR_FAN_CHIPSET] =3D EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
> +	[SENSOR_FAN_WATER_FLOW] =3D EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00,
> 0xbc), +	[SENSOR_CURR_CPU] =3D EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4=
),
> +	[SENSOR_TEMP_WATER_IN] =3D EC_SENSOR("Water_In", hwmon_temp, 1, 0x01,
> 0x00), +	[SENSOR_TEMP_WATER_OUT] =3D EC_SENSOR("Water_Out", hwmon_temp, 1,
> 0x01, 0x01), +};
> +
> +struct asus_wmi_data {
> +	const enum known_ec_sensor known_board_sensors[SENSOR_MAX + 1];
> +};
> +
> +/* boards with EC support */
> +static struct asus_wmi_data sensors_board_PW_X570_P =3D {
> +	.known_board_sensors =3D {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,=20
SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_PW_X570_A =3D {
> +	.known_board_sensors =3D {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,=20
SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_R_C8H =3D {
> +	.known_board_sensors =3D {
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
> +static struct asus_wmi_data sensors_board_R_C8DH =3D {
> +	.known_board_sensors =3D {
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
> +static struct asus_wmi_data sensors_board_R_C8F =3D {
> +	.known_board_sensors =3D {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CPU_OPT, SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_RS_B550_E_G =3D {
> +	.known_board_sensors =3D {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CPU_OPT,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data sensors_board_RS_X570_E_G =3D {
> +	.known_board_sensors =3D {
> +		SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB,
> +		SENSOR_TEMP_T_SENSOR, SENSOR_TEMP_VRM,
> +		SENSOR_FAN_CHIPSET,
> +		SENSOR_CURR_CPU,
> +		SENSOR_MAX
> +	},
> +};
> +
> +static struct asus_wmi_data *board_sensors;
> +
> +static int __init asus_wmi_dmi_matched(const struct dmi_system_id *d)
> +{
> +	board_sensors =3D d->driver_data;
> +	return 0;
> +}
> +
> +#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, sensors) \
> +	{ \
> +		.callback =3D asus_wmi_dmi_matched, \
> +		.matches =3D { \
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, \
> +					"ASUSTeK COMPUTER INC."), \
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, name), \
> +		}, \
> +		.driver_data =3D sensors, \
> +	}
> +
> +static const struct dmi_system_id asus_wmi_ec_dmi_table[] =3D {
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO",
> &sensors_board_PW_X570_P), +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS
> X570-ACE", &sensors_board_PW_X570_A),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO",
> &sensors_board_R_C8DH), +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG=20
CROSSHAIR
> VIII FORMULA", &sensors_board_R_C8F),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO",
> &sensors_board_R_C8H), +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E
> GAMING", &sensors_board_RS_B550_E_G),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING",
> &sensors_board_RS_X570_E_G), +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, asus_wmi_ec_dmi_table);
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
> + * @read_buffer: decoded output from WMI result.
> + * @nr_sensors: number of board EC sensors.
> + * @nr_registers: number of EC registers to read (sensor might span more
> than + *                         1 register).
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
> +	/* lock access to internal cache */
> +	struct mutex lock;
> +	struct asus_wmi_ec_info ec;
> +};
> +
> +static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec)
> +{
> +	const enum known_ec_sensor *bsi;
> +	struct ec_sensor *s =3D ec->sensors;
> +	int i;
> +
> +	if (!board_sensors)
> +		return -ENODEV;
> +
> +	bsi =3D board_sensors->known_board_sensors;
> +	ec->nr_sensors =3D 0;
> +	ec->nr_registers =3D 0;
> +
> +	for (i =3D 0; i < SENSOR_MAX && bsi[i] !=3D SENSOR_MAX; i++) {
> +		s[i].info_index =3D bsi[i];
> +		s[i].cached_value =3D 0;
> +		ec->nr_sensors++;
> +		ec->nr_registers +=3D known_ec_sensors[bsi[i]].addr.size;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * The next four functions converts to/from BRxx string argument format
> + * The format of the string is as follows:
> + * The string consists of two-byte UTF-16 characters
> + * The value of the very first byte int the string is equal to the total
> length + * of the next string in bytes, thus excluding the first two-byte
> character + * The rest of the string encodes pairs of (bank, index) pairs,
> where both + * values are byte-long (0x00 to 0xFF)
> + * Numbers are encoded as UTF-16 hex values
> + */
> +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out)
> +{
> +	unsigned int len =3D ACPI_MIN(ASUS_WMI_MAX_BUF_LEN, inp[0] / 4);
> +	char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> +	const char *pos =3D buffer;
> +	const u8 *data =3D inp + 2;
> +	unsigned int i;
> +
> +	utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer,
> len * 2); +
> +	for (i =3D 0; i < len; i++, pos +=3D 2)
> +		out[i] =3D (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
> +}
> +
> +static void asus_wmi_ec_encode_registers(u16 *registers, u8 len, char *o=
ut)
> +{
> +	char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> +	char *pos =3D buffer;
> +	unsigned int i;
> +	u8 byte;
> +
> +	*out++ =3D len * 8;
> +	*out++ =3D 0;
> +
> +	for (i =3D 0; i < len; i++) {
> +		byte =3D registers[i] >> 8;
> +		*pos =3D hex_asc_hi(byte);
> +		pos++;
> +		*pos =3D hex_asc_lo(byte);
> +		pos++;
> +		byte =3D registers[i];
> +		*pos =3D hex_asc_hi(byte);
> +		pos++;
> +		*pos =3D hex_asc_lo(byte);
> +		pos++;
> +	}
> +
> +	utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN, (wchar_t *)out,=20
len
> * 4); +}
> +
> +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *e=
c)
> +{
> +	u16 registers[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> +	const struct ec_sensor_info *si;
> +	int i, j, register_idx =3D 0;
> +
> +	for (i =3D 0; i < ec->nr_sensors; i++) {
> +		si =3D &known_ec_sensors[ec->sensors[i].info_index];
> +		for (j =3D 0; j < si->addr.size;
> +		     j++, register_idx++) {
> +			registers[register_idx] =3D (si->addr.bank << 8) + si-
>addr.index + j;
> +		}
> +	}
> +
> +	asus_wmi_ec_encode_registers(registers, ec->nr_registers, ec-
>read_arg);
> +}
> +
> +static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)
> +{
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER,
> +				      NULL };
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +
> +	/* the first byte of the BRxx() argument string has to be the string=20
size
> */ +	input.length =3D (acpi_size)query[0] + 2;
> +	input.pointer =3D query;
> +	status =3D wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id,
> &input, +				     &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj =3D output.pointer;
> +	if (!obj || obj->type !=3D ACPI_TYPE_BUFFER) {
> +		acpi_os_free(obj);
> +		return -EIO;
> +	}
> +	asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out);
> +	acpi_os_free(obj);
> +	return 0;
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8
> *data) +{
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
> +	u8 i_sensor;
> +	struct ec_sensor *s;
> +	u8 *data;
> +
> +	data =3D ec->read_buffer;
> +	for (i_sensor =3D 0; i_sensor < ec->nr_sensors; i_sensor++) {
> +		s =3D &ec->sensors[i_sensor];
> +		si =3D &known_ec_sensors[s->info_index];
> +		s->cached_value =3D get_sensor_value(si, data);
> +		data +=3D si->addr.size;
> +	}
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
> +static int asus_wmi_ec_find_sensor_index(const struct asus_wmi_ec_info *=
ec,
> +					 enum hwmon_sensor_types type, int=20
channel)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ec->nr_sensors; i++) {
> +		if (known_ec_sensors[ec->sensors[i].info_index].type =3D=3D type) {
> +			if (channel =3D=3D 0)
> +				return i;
> +
> +			channel--;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int asus_wmi_ec_get_cached_value_or_update(int sensor_index,
> +						  struct asus_wmi_sensors=20
*state,
> +						  u32 *value)
> +{
> +	int ret;
> +
> +	if (time_after(jiffies, state->ec.last_updated + HZ)) {
> +		ret =3D asus_wmi_ec_block_read(ASUSWMI_METHODID_BLOCK_READ_EC,
> +					     state->ec.read_arg,
> +					     state->ec.read_buffer);
> +		if (ret)
> +			return ret;
> +
> +		asus_wmi_ec_update_ec_sensors(&state->ec);
> +		state->ec.last_updated =3D jiffies;
> +	}
> +
> +	*value =3D state->ec.sensors[sensor_index].cached_value;
> +	return 0;
> +}
> +
> +/*
> + * Now follow the functions that implement the hwmon interface
> + */
> +
> +static int asus_wmi_ec_hwmon_read(struct device *dev, enum
> hwmon_sensor_types type, +				  u32 attr, int=20
channel, long *val)
> +{
> +	struct asus_wmi_sensors *sensor_data =3D dev_get_drvdata(dev);
> +	int ret, sidx, info_index;
> +	u32 value =3D 0;
> +
> +	sidx =3D asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
> +	if (sidx < 0)
> +		return sidx;
> +
> +	mutex_lock(&sensor_data->lock);
> +	ret =3D asus_wmi_ec_get_cached_value_or_update(sidx, sensor_data,=20
&value);
> +	mutex_unlock(&sensor_data->lock);
> +	if (ret)
> +		return ret;
> +
> +	info_index =3D sensor_data->ec.sensors[sidx].info_index;
> +	*val =3D asus_wmi_ec_scale_sensor_value(value,
> +					     =20
known_ec_sensors[info_index].type);
> +
> +	return ret;
> +}
> +
> +static int asus_wmi_ec_hwmon_read_string(struct device *dev,
> +					 enum hwmon_sensor_types type, u32=20
attr,
> +					 int channel, const char **str)
> +{
> +	struct asus_wmi_sensors *sensor_data =3D dev_get_drvdata(dev);
> +	int sensor_index;
> +
> +	sensor_index =3D asus_wmi_ec_find_sensor_index(&sensor_data->ec, type,
> channel); +	*str =3D
> known_ec_sensors[sensor_data->ec.sensors[sensor_index].info_index].label;=
 +
> +	return 0;
> +}
> +
> +static umode_t asus_wmi_ec_hwmon_is_visible(const void *drvdata,
> +					    enum hwmon_sensor_types type, u32=20
attr,
> +					    int channel)
> +{
> +	int index;
> +	const struct asus_wmi_sensors *sensor_data =3D drvdata;
> +
> +	index =3D asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel=
);
> +
> +	return index =3D=3D 0xff ? 0 : 0444;
> +}
> +
> +static int asus_wmi_hwmon_add_chan_info(struct hwmon_channel_info
> *asus_wmi_hwmon_chan, +					struct device *dev,=20
int num,
> +					enum hwmon_sensor_types type, u32=20
config)
> +{
> +	u32 *cfg;
> +
> +	cfg =3D devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	asus_wmi_hwmon_chan->type =3D type;
> +	asus_wmi_hwmon_chan->config =3D cfg;
> +	memset32(cfg, config, num);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops asus_wmi_ec_hwmon_ops =3D {
> +	.is_visible =3D asus_wmi_ec_hwmon_is_visible,
> +	.read =3D asus_wmi_ec_hwmon_read,
> +	.read_string =3D asus_wmi_ec_hwmon_read_string,
> +};
> +
> +static struct hwmon_chip_info asus_wmi_ec_chip_info =3D {
> +	.ops =3D &asus_wmi_ec_hwmon_ops,
> +};
> +
> +static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
> +					      struct asus_wmi_sensors=20
*sensor_data)
> +{
> +	struct hwmon_channel_info *asus_wmi_hwmon_chan;
> +	const struct hwmon_channel_info **ptr_asus_wmi_ci;
> +	int nr_count[hwmon_max] =3D { 0 }, nr_types =3D 0;
> +	const struct hwmon_chip_info *chip_info;
> +	const struct ec_sensor_info *si;
> +	enum hwmon_sensor_types type;
> +	struct device *hwdev;
> +	int i, ret;
> +
> +	ret =3D asus_wmi_ec_fill_board_sensors(&sensor_data->ec);
> +	if (ret)
> +		return ret;
> +
> +	if (!sensor_data->ec.nr_sensors)
> +		return -ENODEV;
> +
> +	for (i =3D 0; i < sensor_data->ec.nr_sensors; i++) {
> +		si =3D &known_ec_sensors[sensor_data->ec.sensors[i].info_index];
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
> +	 * if we can get values for all the registers in a single query,
> +	 * the query will not change from call to call
> +	 */
> +	asus_wmi_ec_make_block_read_query(&sensor_data->ec);
> +
> +	asus_wmi_hwmon_chan =3D devm_kcalloc(dev, nr_types,
> +					   sizeof(*asus_wmi_hwmon_chan),
> +					   GFP_KERNEL);
> +	if (!asus_wmi_hwmon_chan)
> +		return -ENOMEM;
> +
> +	ptr_asus_wmi_ci =3D devm_kcalloc(dev, nr_types + 1,
> +				       sizeof(*ptr_asus_wmi_ci), GFP_KERNEL);
> +	if (!ptr_asus_wmi_ci)
> +		return -ENOMEM;
> +
> +	asus_wmi_ec_chip_info.info =3D ptr_asus_wmi_ci;
> +	chip_info =3D &asus_wmi_ec_chip_info;
> +
> +	for (type =3D 0; type < hwmon_max; type++) {
> +		if (!nr_count[type])
> +			continue;
> +
> +		ret =3D asus_wmi_hwmon_add_chan_info(asus_wmi_hwmon_chan, dev,
> +						   nr_count[type], type,
> +						   hwmon_attributes[type]);
> +		if (ret)
> +			return ret;
> +
> +		*ptr_asus_wmi_ci++ =3D asus_wmi_hwmon_chan++;
> +	}
> +
> +	dev_dbg(dev, "board has %d EC sensors that span %d registers",
> +		sensor_data->ec.nr_sensors,
> +		sensor_data->ec.nr_registers);
> +
> +	hwdev =3D devm_hwmon_device_register_with_info(dev, KBUILD_MODNAME,
> +						     sensor_data, chip_info,=20
NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct asus_wmi_sensors *sensor_data;
> +	struct device *dev =3D &wdev->dev;
> +
> +	if (!dmi_check_system(asus_wmi_ec_dmi_table))
> +		return -ENODEV;
> +
> +	sensor_data =3D devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
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
> +static const struct wmi_device_id asus_ec_wmi_id_table[] =3D {
> +	{ ASUSWMI_MONITORING_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver asus_sensors_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D KBUILD_MODNAME,
> +	},
> +	.id_table =3D asus_ec_wmi_id_table,
> +	.probe =3D asus_wmi_probe,
> +};
> +module_wmi_driver(asus_sensors_wmi_driver);
> +
> +MODULE_AUTHOR("Ed Brindley <kernel@maidavale.org>");
> +MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");
> +MODULE_DESCRIPTION("Asus WMI Sensors Driver");
> +MODULE_LICENSE("GPL");


=2D-=20
Oleksandr Natalenko (post-factum)


