Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E309E3FA003
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhH0TcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhH0TcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:32:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A70C061757;
        Fri, 27 Aug 2021 12:31:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g18so4479491wrc.11;
        Fri, 27 Aug 2021 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=COIqd+BTbELXM7s10YvWhpKv6gNubEDT2i23tGtoIYE=;
        b=lORsPmBV2BGeuvXV9Vc4V9I83Snw1Jx38L99p8P/Tb398hRiS6S9ITIfMFui1NAFat
         O08ReQAPPAsS1Nlt1yJPv9Z0gfiRrz95M4OBHBhlYW4BWNqPZFcQHzoR5fZwYU3Wpyta
         KJKh44QukoPV1GQ5RF5Ronc/LAUSbaH4wlNLgI7FPC3c0XrR9HCX42C97Vj7LAu1ozEI
         veSiKIFSPEvu2gUouhRM6VZWTTxkKWGcG/4s9jfJMMZgpiG90aBIizP10ULNXXJRuhu1
         FQsfAXZKBsDcOzoF8aeSLV2GvCAOjHrL29irSxhvRrkpO4waHL5/rwTg3hXx3pHN7Py3
         6MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COIqd+BTbELXM7s10YvWhpKv6gNubEDT2i23tGtoIYE=;
        b=GG5Ao7zzQKl93vcCI8t+mBAu9GDS+UbRh0BwlC4tcJ2E0gZKIWq3MuYGphR8UYF3qk
         9IQppd6Nxq26xuSA8sF2NRHscgeAkoPROLHqBfbBASBLVKDMVelwrygsd9mg8bQmrW2f
         yuyb+waY0Ic6jcmcLY8GhG1k8DMWn08rF/agvwGFppx1H+FUBIQ6hxLSKfGAOMDiBdw1
         A5MIX5UMKQzS+IVr8pKf/vXnIaUzp088baT/lDYHSzxToa/Ch/1H0YiGXAw1HysK3nAn
         ibLmxM7BXpQQv5AS0zzP/KJ93jEuqwmnm2+CsI+LVayB+TdsWiiY8Gab7Wq+1fxASF3h
         /N1A==
X-Gm-Message-State: AOAM533xooxZQGyfnq6jurz/K2Ik9e7KgExeI9NvgGj/5iymMIOTp1DX
        cv/au5Avx3R3HdnEhAfdKi7MnQdQDWXIYtLf
X-Google-Smtp-Source: ABdhPJyHiw3LWwAgSERcWrsBYbs7lQSzWrXWsjMhzoEaOnoSe6Lzxc2DI2gl0mA7RSlG52laBPHfgg==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr12164249wrg.358.1630092670330;
        Fri, 27 Aug 2021 12:31:10 -0700 (PDT)
Received: from fedora (cable-178-148-241-131.dynamic.sbb.rs. [178.148.241.131])
        by smtp.gmail.com with ESMTPSA id h16sm7376279wre.52.2021.08.27.12.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 12:31:09 -0700 (PDT)
Date:   Fri, 27 Aug 2021 21:31:06 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: add driver for Aquacomputer D5 Next
Message-ID: <YSk9ehM45/rQrOOV@fedora>
References: <20210827082507.10591-1-savicaleksa83@gmail.com>
 <20210827154745.GA204608@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827154745.GA204608@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 08:47:45AM -0700, Guenter Roeck wrote:
> On Fri, Aug 27, 2021 at 10:25:05AM +0200, Aleksa Savic wrote:
> > This driver exposes hardware sensors of the Aquacomputer D5 Next
> > watercooling pump, which communicates through a proprietary USB HID
> > protocol.
> > 
> > Available sensors are pump and fan speed, power, voltage and current, as
> > well as coolant temperature. Also available through debugfs are the serial
> > number, firmware version and power-on count.
> > 
> > Attaching a fan is optional and allows it to be controlled using
> > temperature curves directly from the pump. If it's not connected,
> > the fan-related sensors will report zeroes.
> > 
> > The pump can be configured either through software or via its physical
> > interface. Configuring the pump through this driver is not implemented,
> > as it seems to require sending it a complete configuration. That
> > includes addressable RGB LEDs, for which there is no standard sysfs
> > interface. Thus, that task is better suited for userspace tools.
> > 
> > This driver has been tested on x86_64, both in-kernel and as a module.
> > 
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> > ---
> >  Documentation/hwmon/aquacomputer_d5next.rst |  61 ++++
> >  Documentation/hwmon/index.rst               |   1 +
> >  MAINTAINERS                                 |   7 +
> >  drivers/hwmon/Kconfig                       |  10 +
> >  drivers/hwmon/Makefile                      |   1 +
> >  drivers/hwmon/aquacomputer_d5next.c         | 366 ++++++++++++++++++++
> >  6 files changed, 446 insertions(+)
> >  create mode 100644 Documentation/hwmon/aquacomputer_d5next.rst
> >  create mode 100644 drivers/hwmon/aquacomputer_d5next.c
> > 
> > diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> > new file mode 100644
> > index 000000000000..1f4bb4ba2e4b
> > --- /dev/null
> > +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> > @@ -0,0 +1,61 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver aquacomputer-d5next
> > +=================================
> > +
> > +Supported devices:
> > +
> > +* Aquacomputer D5 Next watercooling pump
> > +
> > +Author: Aleksa Savic
> > +
> > +Description
> > +-----------
> > +
> > +This driver exposes hardware sensors of the Aquacomputer D5 Next watercooling
> > +pump, which communicates through a proprietary USB HID protocol.
> > +
> > +Available sensors are pump and fan speed, power, voltage and current, as
> > +well as coolant temperature. Also available through debugfs are the serial
> > +number, firmware version and power-on count.
> > +
> > +Attaching a fan is optional and allows it to be controlled using temperature
> > +curves directly from the pump. If it's not connected, the fan-related sensors
> > +will report zeroes.
> > +
> > +The pump can be configured either through software or via its physical
> > +interface. Configuring the pump through this driver is not implemented, as it
> > +seems to require sending it a complete configuration. That includes addressable
> > +RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
> > +better suited for userspace tools.
> > +
> > +Usage notes
> > +-----------
> > +
> > +The pump communicates via HID reports. The driver is loaded automatically by
> > +the kernel and supports hotswapping.
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +============ =============================================
> > +temp1_input  Coolant temperature (in millidegrees Celsius)
> > +fan1_input   Pump speed (in RPM)
> > +fan2_input   Fan speed (in RPM)
> > +power1_input Pump power (in micro Watts)
> > +power2_input Fan power (in micro Watts)
> > +in0_input    Pump voltage (in milli Volts)
> > +in1_input    Fan voltage (in milli Volts)
> > +in2_input    +5V rail voltage (in milli Volts)
> > +curr1_input  Pump current (in milli Amperes)
> > +curr2_input  Fan current (in milli Amperes)
> > +============ =============================================
> > +
> > +Debugfs entries
> > +---------------
> > +
> > +================ ===============================================
> > +serial_number    Serial number of the pump
> > +firmware_version Version of installed firmware
> > +power_cycles     Count of how many times the pump was powered on
> > +================ ===============================================
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index bc01601ea81a..77bfb2e2e8a9 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -39,6 +39,7 @@ Hardware Monitoring Kernel Drivers
> >     adt7475
> >     aht10
> >     amc6821
> > +   aquacomputer_d5next
> >     asb100
> >     asc7621
> >     aspeed-pwm-tacho
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d7b4f32875a9..ec0aa0dcf635 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1316,6 +1316,13 @@ L:	linux-media@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/media/i2c/aptina-pll.*
> >  
> > +AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
> > +M:	Aleksa Savic <savicaleksa83@gmail.com>
> > +L:	linux-hwmon@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/hwmon/aquacomputer_d5next.rst
> > +F:	drivers/hwmon/aquacomputer_d5next.c
> > +
> >  AQUANTIA ETHERNET DRIVER (atlantic)
> >  M:	Igor Russkikh <irusskikh@marvell.com>
> >  L:	netdev@vger.kernel.org
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index e3675377bc5d..2bd563850f87 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -254,6 +254,16 @@ config SENSORS_AHT10
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called aht10.
> >  
> > +config SENSORS_AQUACOMPUTER_D5NEXT
> > +	tristate "Aquacomputer D5 Next watercooling pump"
> > +	depends on USB_HID
> > +	help
> > +	  If you say yes here you get support for the Aquacomputer D5 Next
> > +	  watercooling pump sensors.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called aquacomputer_d5next.
> > +
> >  config SENSORS_AS370
> >  	tristate "Synaptics AS370 SoC hardware monitoring driver"
> >  	help
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index d712c61c1f5e..790a611a3188 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
> >  obj-$(CONFIG_SENSORS_AHT10)	+= aht10.o
> >  obj-$(CONFIG_SENSORS_AMD_ENERGY) += amd_energy.o
> >  obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
> > +obj-$(CONFIG_SENSORS_AQUACOMPUTER_D5NEXT) += aquacomputer_d5next.o
> >  obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
> >  obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
> >  obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
> > diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> > new file mode 100644
> > index 000000000000..0f831b0eb94c
> > --- /dev/null
> > +++ b/drivers/hwmon/aquacomputer_d5next.c
> > @@ -0,0 +1,366 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * hwmon driver for Aquacomputer D5 Next watercooling pump
> > + *
> > + * The D5 Next sends HID reports (with ID 0x01) every second to report sensor values
> > + * (coolant temperature, pump and fan speed, voltage, current and power). It responds to
> > + * Get_Report requests, but returns a dummy value of no use.
> > + *
> > + * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/hid.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> 
> #include <linux/seq_file.h>
> 
> > +
> > +#define DRIVER_NAME		      "aquacomputer-d5next"
> > +
> > +#define D5NEXT_STATUS_REPORT_ID	      0x01
> > +#define D5NEXT_STATUS_UPDATE_INTERVAL 1 /* In seconds */
> > +
> > +/* Register offsets for the D5 Next pump */
> > +
> > +#define D5NEXT_SERIAL_FIRST_PART      3
> > +#define D5NEXT_SERIAL_SECOND_PART     5
> > +#define D5NEXT_FIRMWARE_VERSION	      13
> 
> Please always use
> 
> #define<space>WHAT<tab>value
> 
> with aligned values.
> 
> > +#define D5NEXT_POWER_CYCLES	      24
> > +
> > +#define D5NEXT_COOLANT_TEMP	      87
> > +
> > +#define D5NEXT_PUMP_SPEED	      116
> > +#define D5NEXT_FAN_SPEED	      103
> > +
> > +#define D5NEXT_PUMP_POWER	      114
> > +#define D5NEXT_FAN_POWER	      101
> > +
> > +#define D5NEXT_PUMP_VOLTAGE	      110
> > +#define D5NEXT_FAN_VOLTAGE	      97
> > +#define D5NEXT_5V_VOLTAGE	      57
> > +
> > +#define D5NEXT_PUMP_CURRENT	      112
> > +#define D5NEXT_FAN_CURRENT	      99
> > +
> > +/* Labels for provided values */
> > +
> > +#define L_COOLANT_TEMP		      "Coolant temp"
> > +
> > +#define L_PUMP_SPEED		      "Pump speed"
> > +#define L_FAN_SPEED		      "Fan speed"
> > +
> > +#define L_PUMP_POWER		      "Pump power"
> > +#define L_FAN_POWER		      "Fan power"
> > +
> > +#define L_PUMP_VOLTAGE		      "Pump voltage"
> > +#define L_FAN_VOLTAGE		      "Fan voltage"
> > +#define L_5V_VOLTAGE		      "+5V voltage"
> > +
> > +#define L_PUMP_CURRENT		      "Pump current"
> > +#define L_FAN_CURRENT		      "Fan current"
> > +
> > +static const char *const label_temp[] = {
> > +	L_COOLANT_TEMP,
> > +};
> > +
> > +static const char *const label_speeds[] = {
> > +	L_PUMP_SPEED,
> > +	L_FAN_SPEED,
> > +};
> > +
> > +static const char *const label_power[] = {
> > +	L_PUMP_POWER,
> > +	L_FAN_POWER,
> > +};
> > +
> > +static const char *const label_voltages[] = {
> > +	L_PUMP_VOLTAGE,
> > +	L_FAN_VOLTAGE,
> > +	L_5V_VOLTAGE,
> > +};
> > +
> > +static const char *const label_current[] = {
> > +	L_PUMP_CURRENT,
> > +	L_FAN_CURRENT,
> > +};
> > +
> > +struct d5next_data {
> > +	struct hid_device *hdev;
> > +	struct device *hwmon_dev;
> > +	struct dentry *debugfs;
> > +	s32 temp_input[1];
> 
> This doesn't have to be an array.
> 
> > +	u16 speed_input[2];
> > +	u32 power_input[2];
> > +	u16 voltage_input[3];
> > +	u16 current_input[2];
> > +	u32 serial_number[2];
> > +	u16 firmware_version;
> > +	u32 power_cycles; /* How many times the device was powered on */
> > +	unsigned long updated;
> > +};
> > +
> > +static umode_t d5next_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> > +				 int channel)
> > +{
> > +	return 0444;
> > +}
> > +
> > +static int d5next_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> > +		       long *val)
> > +{
> > +	struct d5next_data *priv = dev_get_drvdata(dev);
> > +
> > +	if (time_after(jiffies, priv->updated + D5NEXT_STATUS_UPDATE_INTERVAL * HZ))
> > +		return -ENODATA;
> 
> This seems a bit strict; it results in ENODATA if a single update
> is missed or if it comes just a little late. I would suggest to relax
> it a bit.
> 
> Also, D5NEXT_STATUS_UPDATE_INTERVAL is always used with "* HZ".
> I would suggest to make that part of the define.
> 

Thanks for the feedback here and above! I'll send a v2 soon.

Aleksa

> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		*val = priv->temp_input[channel];
> > +		break;
> > +	case hwmon_fan:
> > +		*val = priv->speed_input[channel];
> > +		break;
> > +	case hwmon_power:
> > +		*val = priv->power_input[channel];
> > +		break;
> > +	case hwmon_in:
> > +		*val = priv->voltage_input[channel];
> > +		break;
> > +	case hwmon_curr:
> > +		*val = priv->current_input[channel];
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int d5next_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> > +			      int channel, const char **str)
> > +{
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		*str = label_temp[channel];
> > +		break;
> > +	case hwmon_fan:
> > +		*str = label_speeds[channel];
> > +		break;
> > +	case hwmon_power:
> > +		*str = label_power[channel];
> > +		break;
> > +	case hwmon_in:
> > +		*str = label_voltages[channel];
> > +		break;
> > +	case hwmon_curr:
> > +		*str = label_current[channel];
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops d5next_hwmon_ops = {
> > +	.is_visible = d5next_is_visible,
> > +	.read = d5next_read,
> > +	.read_string = d5next_read_string,
> > +};
> > +
> > +static const struct hwmon_channel_info *d5next_info[] = {
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> > +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL),
> > +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL, HWMON_P_INPUT | HWMON_P_LABEL),
> > +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL),
> > +	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_LABEL, HWMON_C_INPUT | HWMON_C_LABEL),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info d5next_chip_info = {
> > +	.ops = &d5next_hwmon_ops,
> > +	.info = d5next_info,
> > +};
> > +
> > +static int d5next_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
> > +{
> > +	struct d5next_data *priv;
> > +
> > +	if (report->id != D5NEXT_STATUS_REPORT_ID)
> > +		return 0;
> > +
> > +	priv = hid_get_drvdata(hdev);
> > +
> > +	/* Info provided with every report */
> > +
> > +	priv->serial_number[0] = get_unaligned_be16(data + D5NEXT_SERIAL_FIRST_PART);
> > +	priv->serial_number[1] = get_unaligned_be16(data + D5NEXT_SERIAL_SECOND_PART);
> > +
> > +	priv->firmware_version = get_unaligned_be16(data + D5NEXT_FIRMWARE_VERSION);
> > +	priv->power_cycles = get_unaligned_be32(data + D5NEXT_POWER_CYCLES);
> > +
> > +	/* Sensor readings */
> > +
> > +	priv->temp_input[0] = get_unaligned_be16(data + D5NEXT_COOLANT_TEMP) * 10;
> > +
> > +	priv->speed_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_SPEED);
> > +	priv->speed_input[1] = get_unaligned_be16(data + D5NEXT_FAN_SPEED);
> > +
> > +	priv->power_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_POWER) * 10000;
> > +	priv->power_input[1] = get_unaligned_be16(data + D5NEXT_FAN_POWER) * 10000;
> > +
> > +	priv->voltage_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_VOLTAGE) * 10;
> > +	priv->voltage_input[1] = get_unaligned_be16(data + D5NEXT_FAN_VOLTAGE) * 10;
> > +	priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
> > +
> > +	priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
> > +	priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
> > +
> > +	priv->updated = jiffies;
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +static int serial_number_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct d5next_data *priv = seqf->private;
> > +
> > +	seq_printf(seqf, "%05u-%05u\n", priv->serial_number[0], priv->serial_number[1]);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(serial_number);
> > +
> > +static int firmware_version_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct d5next_data *priv = seqf->private;
> > +
> > +	seq_printf(seqf, "%u\n", priv->firmware_version);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(firmware_version);
> > +
> > +static int power_cycles_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct d5next_data *priv = seqf->private;
> > +
> > +	seq_printf(seqf, "%u\n", priv->power_cycles);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(power_cycles);
> > +
> > +static void d5next_debugfs_init(struct d5next_data *priv)
> > +{
> > +	char name[32];
> > +
> > +	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
> > +
> > +	priv->debugfs = debugfs_create_dir(name, NULL);
> > +	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
> > +	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
> > +	debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
> > +}
> > +
> > +#else
> > +
> > +static void d5next_debugfs_init(struct d5next_data *priv)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > +{
> > +	struct d5next_data *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->hdev = hdev;
> > +	hid_set_drvdata(hdev, priv);
> > +
> > +	priv->updated = jiffies - D5NEXT_STATUS_UPDATE_INTERVAL * HZ;
> > +
> > +	ret = hid_parse(hdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hid_hw_open(hdev);
> > +	if (ret)
> > +		goto fail_and_stop;
> > +
> > +	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "d5next", priv,
> > +							  &d5next_chip_info, NULL);
> > +
> > +	if (IS_ERR(priv->hwmon_dev)) {
> > +		ret = PTR_ERR(priv->hwmon_dev);
> > +		goto fail_and_close;
> > +	}
> > +
> > +	d5next_debugfs_init(priv);
> > +
> > +	return 0;
> > +
> > +fail_and_close:
> > +	hid_hw_close(hdev);
> > +fail_and_stop:
> > +	hid_hw_stop(hdev);
> > +	return ret;
> > +}
> > +
> > +static void d5next_remove(struct hid_device *hdev)
> > +{
> > +	struct d5next_data *priv = hid_get_drvdata(hdev);
> > +
> > +	debugfs_remove_recursive(priv->debugfs);
> > +	hwmon_device_unregister(priv->hwmon_dev);
> > +
> > +	hid_hw_close(hdev);
> > +	hid_hw_stop(hdev);
> > +}
> > +
> > +static const struct hid_device_id d5next_table[] = {
> > +	{ HID_USB_DEVICE(0x0c70, 0xf00e) }, /* Aquacomputer D5 Next */
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(hid, d5next_table);
> > +
> > +static struct hid_driver d5next_driver = {
> > +	.name = DRIVER_NAME,
> > +	.id_table = d5next_table,
> > +	.probe = d5next_probe,
> > +	.remove = d5next_remove,
> > +	.raw_event = d5next_raw_event,
> > +};
> > +
> > +static int __init d5next_init(void)
> > +{
> > +	return hid_register_driver(&d5next_driver);
> > +}
> > +
> > +static void __exit d5next_exit(void)
> > +{
> > +	hid_unregister_driver(&d5next_driver);
> > +}
> > +
> > +/* Request to initialize after the HID bus to ensure it's not being loaded before */
> > +
> > +late_initcall(d5next_init);
> > +module_exit(d5next_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> > +MODULE_DESCRIPTION("Hwmon driver for Aquacomputer D5 Next pump");
> > -- 
> > 2.31.1
> > 
