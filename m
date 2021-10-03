Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5302C420134
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJCKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:36:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF53C0613EC;
        Sun,  3 Oct 2021 03:35:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p13so24606545edw.0;
        Sun, 03 Oct 2021 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1HG+29+gqhma2V83gRUL2DGc+aLk960ZvsNryGC50Y=;
        b=BrRFDH2UcLGuCofTBcorCGPM/M3HZ26gLJhn/lh5idgyX0w7Mryyq2CEkw/iloM5o2
         JzVsugMTp5xXnCvCUSIGTt7PNQcwxXpPZDuaYsWa5V+GOVEVlqUStwhPsXiAIagw8F4c
         L6ZKmco5vGwGB/lDZSiCh3ngJz8/J/nrXD+27FuyqTJoj75t7aZYiOsDT+xaDJJHLIBz
         Ti9k/ZTAfGFRA800o7tAfgCSgSSH04wRZI/II8BNhbRKbVOpwZiZYuYGvUCoh0JMvM5A
         LR9W8CjTC5hskBnr34dwmZtvn0UOLprB3DqLLkL93Xo261dFiDFyDHPBbeXxhxXquaep
         mCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1HG+29+gqhma2V83gRUL2DGc+aLk960ZvsNryGC50Y=;
        b=rzMxq3a++9QCkjTPuLt1ih3gLMqaEVsBCDW8UAlY5FZiAfEePA1YNPlYd3iQz/q1EU
         90XKa3lXhMwxntdr1xX/aDGqIHD06C0KWJ+YSxJFpicPKf75GyIgU4UkzvA35QRAzmNx
         /Yxh9Yk0Yhu0NRDo9yibAL8EaIoot+J2WqYOQL05rnCm63fiDwLf1cAfX+g30RpwNPRC
         dumiHGC6oXSeeC4XkrvGMSk4+4fITiDZJpNe+O/z2qqjcpAyTTUZyqVJlfbhNcfatH8L
         9e+/PaAsCfE3w/INieq1J8VPJLsbYhlO40xzJuFVrleSMSIPyvRuahDDjD2Blsa/3H80
         KWJg==
X-Gm-Message-State: AOAM531uCKRCIMaN3ga/N19QY8TcnEJAGrWH5eI+u0GuQOYZScJEfQ9O
        LgryF7hJSdgQFPWy8dsSS6jxFtuElhYSyxCz1Xo=
X-Google-Smtp-Source: ABdhPJxlBZCmbxSjzkSaTebrIo4p9+OqjfaK4hkQsbwsQDVIVK8yjHdY0UJK0O2ZHRYOGLJDZT3AVLeO8sOVKtX42kg=
X-Received: by 2002:a05:6402:358a:: with SMTP id y10mr10094471edc.238.1633257304187;
 Sun, 03 Oct 2021 03:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211002210857.709956-4-pauk.denis@gmail.com>
In-Reply-To: <20211002210857.709956-4-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 13:34:27 +0300
Message-ID: <CAHp75VcOXtqgANhctxXfu__8K=fhW8t1Pw0hAZonB1K=U8aJAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (asus_wmi_sensors) Support access via Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 12:10 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>
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
> Supported motherboards:
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING

...

> +config SENSORS_ASUS_WMI
> +       tristate "ASUS WMI"

Provide a better short description here.

> +       depends on X86

COMPILE_TEST ?

> +       help
> +         If you say yes here you get support for the ACPI hardware
> +         monitoring interface found in many ASUS motherboards. This
> +         driver will provide readings of fans, voltages and temperatures
> +         through the system firmware.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called asus_wmi_sensors.

...

> +/*

> + * HWMON driver for ASUS motherboards that publish some sensor values
> + * via the embedded controller registers

I would drop the word 'some' here and...

> + *
> + * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>

...add a bit more elaborative text here to explain what values are
provided and what aren't.

> + */
...

> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Any real need for this?

...

> +#define DRVNAME "asus_wmi_sensors"

Can you use this directly?

...

> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/wmi.h>

Sorted?

...

> +struct asus_wmi_ec_info {
> +       struct asus_wmi_ec_sensor_info sensors[ASUSWMI_SENSORS_MAX];
> +       /* UTF-16 string to pass to BRxx() WMI function */
> +       char read_arg[((ASUS_WMI_BLOCK_READ_REGISTERS_MAX * 4) + 1) * 2];
> +       u8 read_buffer[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> +       u8 nr_sensors; /* number of board EC sensors */
> +       /* number of EC registers to read (sensor might span more than 1 register) */
> +       u8 nr_registers;
> +       unsigned long last_updated; /* in jiffies */
> +};

Convert those comments to a proper kernel doc format?

...

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

All above can probably use existing functions?
https://elixir.bootlin.com/linux/latest/source/fs/nls/nls_base.c#L132

...

> +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
> +{
> +       u16 registers[ASUS_EC_KNOWN_EC_REGISTERS];
> +       u8 i, j, register_idx = 0;

> +       /* if we can get values for all the registers in a single query,
> +        * the query will not change from call to call
> +        */

/*
 * Wrong multi-line style is in
 * use. Compare to this comment.
 */

> +       if (ec->nr_registers <= ASUS_WMI_BLOCK_READ_REGISTERS_MAX &&
> +           ec->read_arg[0] > 0) {
> +               /* no need to update */
> +               return;
> +       }
> +
> +       for (i = 0; i < ec->nr_sensors; ++i) {
> +               for (j = 0; j < ec->sensors[i].addr.addr.size;

> +                    ++j, ++register_idx) {

Here and in plenty other places, why _pre_-increment (or
_pre_-decrement in some cases)?

> +                       registers[register_idx] =
> +                               (ec->sensors[i].addr.addr.bank << 8) +
> +                               ec->sensors[i].addr.addr.index + j;
> +               }
> +       }
> +
> +       asus_wmi_ec_encode_registers(registers, ec->nr_registers, ec->read_arg);
> +}
> +
> +static int asus_wmi_ec_block_read(u32 method_id, const char *query, u8 *out)
> +{
> +       struct acpi_buffer input;

> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER,
> +                                     NULL }; // TODO use pre-allocated buffer

One line and drop this TODO, or fulfil it.

> +       acpi_status status;
> +       union acpi_object *obj;
> +
> +       /* the first byte of the BRxx() argument string has to be the string size */
> +       input.length = (acpi_size)query[0] + 2;

> +       input.pointer = (void *)query;

Redundant casting. Or is this due to const qualifier?

> +       status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input,
> +                                    &output);

> +

Here and in plenty of other places, redundant blank lines.

> +       if (ACPI_FAILURE(status)) {

> +               acpi_os_free(output.pointer);

Is it needed?

> +               return -EIO;
> +       }
> +
> +       obj = output.pointer;
> +       if (!obj || obj->type != ACPI_TYPE_BUFFER) {

> +               pr_err("unexpected reply type from ASUS ACPI code");

dev_err()

> +               acpi_os_free(output.pointer);

When !obj, this is not needed.

> +               return -EIO;
> +       }
> +       asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out);
> +       acpi_os_free(output.pointer);
> +       return 0;
> +}
> +
> +static int asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info *ec)
> +{
> +       struct asus_wmi_ec_sensor_info *si;
> +       u32 value;
> +       int status;
> +       u8 i_sensor, read_reg_ct, i_sensor_register;

Here and in all cases, reversed xmas tree order?

> +       asus_wmi_ec_make_block_read_query(ec);
> +       status = asus_wmi_ec_block_read(ASUSWMI_METHODID_BLOCK_READ_EC,
> +                                       ec->read_arg,
> +                                       ec->read_buffer);
> +       if (status)
> +               return status;
> +
> +       read_reg_ct = 0;
> +       for (i_sensor = 0; i_sensor < ec->nr_sensors; ++i_sensor) {

Why _pre_-increment?

> +               si = &ec->sensors[i_sensor];
> +               value = ec->read_buffer[read_reg_ct++];
> +               for (i_sensor_register = 1;
> +                    i_sensor_register < si->addr.addr.size;

> +                    ++i_sensor_register) {

Why _pre_-increment?

> +                       value <<= 8;
> +                       value += ec->read_buffer[read_reg_ct++];
> +               }

Is it something like get_unaligned_...32()?
Or some ...32_to_cpu() ?

Also provide the corresponding __le32/__be32 types where it's needed.

> +               si->cached_value = value;
> +       }
> +       return 0;
> +}

...

> +static int asus_wmi_ec_scale_sensor_value(u32 value, int data_type)
> +{
> +       switch (data_type) {
> +       case hwmon_curr:
> +       case hwmon_temp:
> +       case hwmon_in:

> +               return value * 1000;

In units.h we have SI multipliers, can you use one to show what is this exactly?

> +       default:
> +               return value;
> +       }
> +}
> +
> +static u8 asus_wmi_ec_find_sensor_index(const struct asus_wmi_ec_info *ec,
> +                                       enum hwmon_sensor_types type, int channel)
> +{
> +       u8 i;

In some cases you are using int i, here u8 i. Be consistent and use, e.g.
unsigned int i;
everywhere for (never been negative) counters.

> +       for (i = 0; i < ec->nr_sensors; ++i) {
> +               if (ec->sensors[i].type == type) {
> +                       if (channel == 0)
> +                               return i;

> +                       --channel;

Why _pre_-decrement?

> +               }
> +       }

> +       return 0xFF;

0xff, but why? Can't you use the proper error code instead?

> +}
> +
> +static int asus_wmi_ec_get_cached_value_or_update(int sensor_index,
> +                                                 struct asus_wmi_sensors *state,
> +                                                 u32 *value)
> +{
> +       int ret;
> +
> +       if (time_after(jiffies, state->ec.last_updated + HZ)) {

> +               ret = asus_wmi_ec_update_ec_sensors(&state->ec);

> +

Redundant blank line.

> +               if (ret) {

> +                       pr_err("asus_wmi_ec_update_ec_sensors() failure\n");

Can you use dev_err()?

> +                       return -EIO;

Why shadowed the real error code? Or is it not an error code there?

> +               }
> +
> +               state->ec.last_updated = jiffies;
> +       }
> +
> +       *value = state->ec.sensors[sensor_index].cached_value;
> +       return 0;
> +}
> +
> +/*
> + * Now follow the functions that implement the hwmon interface
> + */
> +
> +static int asus_wmi_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +                                 u32 attr, int channel, long *val)
> +{
> +       int ret;
> +       u32 value = 0;
> +       struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
> +
> +       u8 sidx = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
> +
> +       mutex_lock(&sensor_data->lock);

> +

Seems redundant blank line.

> +       ret = asus_wmi_ec_get_cached_value_or_update(sidx, sensor_data, &value);
> +       mutex_unlock(&sensor_data->lock);

> +       if (!ret)
> +               *val = asus_wmi_ec_scale_sensor_value(value, sensor_data->ec.sensors[sidx].type);
> +
> +       return ret;

Why not the standard pattern?

mutex_lock(...);
ret = ...;
mutex_unlock(...);
if (ret)
  return ret;

*val = ...
return 0;


> +}

...

> +static umode_t asus_wmi_ec_hwmon_is_visible(const void *drvdata,
> +                                           enum hwmon_sensor_types type, u32 attr,
> +                                           int channel)
> +{
> +       const struct asus_wmi_sensors *sensor_data = drvdata;

> +       return asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel) != 0xFF ?
> +                            0444 :
> +                            0;

This will look better with temporary variables

... index;

index = asus_wmi_ec_find_sensor_index();
return index == 0xff ? 0 : 0444;

(also note small letters for hex value).

> +}
> +
> +static int asus_wmi_hwmon_add_chan_info(struct hwmon_channel_info *asus_wmi_hwmon_chan,
> +                                       struct device *dev, int num,
> +                                       enum hwmon_sensor_types type, u32 config)
> +{
> +       int i;

> +       u32 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
> +
> +       if (!cfg)
> +               return -ENOMEM;

Use the following pattern which is slightly better.

u32 *cfg;

cfg = ...;
if (!cfg)
  return -ENOMEM;

> +       asus_wmi_hwmon_chan->type = type;
> +       asus_wmi_hwmon_chan->config = cfg;

> +       for (i = 0; i < num; i++, cfg++)
> +               *cfg = config;

memset32() ?

> +       return 0;
> +}

...

> +static struct hwmon_chip_info asus_wmi_ec_chip_info = {
> +       .ops = &asus_wmi_ec_hwmon_ops,

> +       .info = NULL,

Redundant assignment.

> +};
> +
> +static int asus_wmi_ec_configure_sensor_setup(struct platform_device *pdev,
> +                                             struct asus_wmi_sensors *sensor_data)
> +{
> +       int i;
> +       int nr_count[HWMON_MAX] = { 0 }, nr_types = 0;
> +       struct device *hwdev;
> +       struct device *dev = &pdev->dev;
> +       struct hwmon_channel_info *asus_wmi_hwmon_chan;
> +       const struct hwmon_channel_info **ptr_asus_wmi_ci;
> +       const struct hwmon_chip_info *chip_info;
> +       const struct asus_wmi_ec_sensor_info *si;
> +       enum hwmon_sensor_types type;

Reversed xmas tree order?

> +       if (sensor_data->ec_board < 0)
> +               return 0;

Is it ever possible?

> +       asus_wmi_ec_fill_board_sensors(&sensor_data->ec, sensor_data->ec_board);
> +
> +       if (!sensor_data->ec.nr_sensors)
> +               return -ENODEV;
> +
> +       for (i = 0; i < sensor_data->ec.nr_sensors; ++i) {
> +               si = &sensor_data->ec.sensors[i];
> +               if (!nr_count[si->type])
> +                       ++nr_types;
> +               ++nr_count[si->type];

What's wrong with post increments?

> +       }

> +       if (nr_count[hwmon_temp])
> +               nr_count[hwmon_chip]++, nr_types++;

This is suspicious code. Refactor to make it easier to understand.

> +       asus_wmi_hwmon_chan = devm_kcalloc(dev, nr_types,
> +                                          sizeof(*asus_wmi_hwmon_chan),
> +                                          GFP_KERNEL);
> +       if (!asus_wmi_hwmon_chan)
> +               return -ENOMEM;
> +
> +       ptr_asus_wmi_ci = devm_kcalloc(dev, nr_types + 1,
> +                                      sizeof(*ptr_asus_wmi_ci), GFP_KERNEL);
> +       if (!ptr_asus_wmi_ci)
> +               return -ENOMEM;
> +
> +       asus_wmi_ec_chip_info.info = ptr_asus_wmi_ci;
> +       chip_info = &asus_wmi_ec_chip_info;
> +
> +       for (type = 0; type < HWMON_MAX; type++) {
> +               if (!nr_count[type])
> +                       continue;
> +
> +               asus_wmi_hwmon_add_chan_info(asus_wmi_hwmon_chan, dev,
> +                                            nr_count[type], type,
> +                                            hwmon_attributes[type]);
> +               *ptr_asus_wmi_ci++ = asus_wmi_hwmon_chan++;
> +       }

> +       pr_info("%s board has %d EC sensors that span %d registers",
> +               asus_wmi_ec_boards_names[sensor_data->ec_board],
> +               sensor_data->ec.nr_sensors,
> +               sensor_data->ec.nr_registers);

First of all, why not dev_info()? Second, do you really need this?
Seems to me like a debug leftover.

> +       hwdev = devm_hwmon_device_register_with_info(dev, "asuswmiecsensors",

No delimiters, like -, _ or spaces?

> +                                                    sensor_data, chip_info, NULL);
> +
> +       return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int asus_wmi_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct asus_wmi_data *data = dev_get_platdata(dev);
> +       struct asus_wmi_sensors *sensor_data;
> +       int err;
> +
> +       sensor_data = devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
> +                                  GFP_KERNEL);
> +       if (!sensor_data)
> +               return -ENOMEM;
> +
> +       mutex_init(&sensor_data->lock);
> +       sensor_data->ec_board = data->ec_board;
> +
> +       platform_set_drvdata(pdev, sensor_data);
> +
> +       /* ec init */

> +       err = asus_wmi_ec_configure_sensor_setup(pdev,
> +                                                sensor_data);
> +
> +       return err;

return asus_wmi_ec_configure_sensor_setup(...);

> +}

...

> +static struct platform_driver asus_wmi_sensors_platform_driver = {
> +       .driver = {
> +               .name   = "asus-wmi-sensors",
> +       },
> +       .probe = asus_wmi_probe

+ Comma.

> +};

...

> +static int __init asus_wmi_init(void)
> +{
> +       const char *board_vendor, *board_name;
> +       struct asus_wmi_data data;
> +
> +       data.ec_board = -1;
> +
> +       board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +       board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +       if (board_vendor && board_name &&
> +           !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> +               if (!wmi_has_guid(ASUSWMI_MONITORING_GUID))
> +                       return -ENODEV;
> +
> +               data.ec_board = match_string(asus_wmi_ec_boards_names,
> +                                            ARRAY_SIZE(asus_wmi_ec_boards_names),
> +                                            board_name);
> +       }
> +
> +       /* Nothing to support */
> +       if (data.ec_board < 0)
> +               return -ENODEV;
> +
> +       sensors_pdev = platform_create_bundle(&asus_wmi_sensors_platform_driver,
> +                                             asus_wmi_probe,
> +                                             NULL, 0,
> +                                             &data, sizeof(struct asus_wmi_data));

> +       if (IS_ERR(sensors_pdev))
> +               return PTR_ERR(sensors_pdev);
> +
> +       return 0;

return PTR_ERR_OR_ZERO();

> +}
> +
> +static void __exit asus_wmi_exit(void)
> +{
> +       platform_device_unregister(sensors_pdev);
> +       platform_driver_unregister(&asus_wmi_sensors_platform_driver);
> +}

Can we decouple driver and board code? And put board code to the PDx86 folder?

...

> +MODULE_VERSION("1");

No, the version of the driver is the same as git commit ID. Drop this.

...

> +module_init(asus_wmi_init);
> +module_exit(asus_wmi_exit);

Can you move this to the respective functions?

-- 
With Best Regards,
Andy Shevchenko
