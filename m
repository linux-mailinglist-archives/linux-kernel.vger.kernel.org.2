Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D492539D9DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:38:22 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:37806 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFGKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:38:21 -0400
Received: by mail-il1-f180.google.com with SMTP id j26so5545023ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiaUZQSofCIi4r2SfalFndwmWlZJcTarRV4+u/yqcYE=;
        b=vVbzaRQRaCoWTotFw/igMrwnAiDpYyr6wOEy3euMxHpRA2rwz/sdvZso/X2deYgo/2
         wsTg7UQ/ABaIEEpkxKp4f61PI5B/FMR9DBMkBB6Vdg6tOHADuVv1QQw+Fhdl2nLNN7Dg
         yj4JTkEDiw11UwzcUjoUH/8OYJjaG77QbXc+O0NoHaBXaNuUD33LfnGPPUn1TjCTWkLH
         0dtmBI0rPKOe2Gf5kqwPoidbRjoypAh4LdKHvUcrKMnjcHMlEnUYmNmyhptqqMC61/40
         GoBTMmKeBRWMGJwsW+iW2Zf7MghUYYIZnJor1gc+iKeGmlMPRd3wo8sz7AZorBYGQDXV
         87CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiaUZQSofCIi4r2SfalFndwmWlZJcTarRV4+u/yqcYE=;
        b=soWGq3eFk8B3dWBkp+3LKFtHmluHYw2LxsClLSbmYPF+HjxKcEwU8ycthkwjtOScBt
         0hqBvlW6dEa9iYQrNfBGsbfdJAgWV4e/3k7zbBrWI8rqTmyqQRtc6ysyxmRET7/5DZvJ
         yA1+iN5aOArcZ9ySOZ/aHzztAXZm0jlDjSTsl/NsR5tVtK7FCZOxupDp6YC3vW2SlzxS
         C6u4fLS/sFpBrMdmau7QC5xe0e+EQIdX5fpiMUqkqNCgYgfhRgDNtqdRerNZsL579759
         1BMZN/E2zaNCHDHvS3/k78wy3FAo3VaCBLg0jj4N+EjzW2wXMixvWZbW7PLYNXiLZR6u
         O5/g==
X-Gm-Message-State: AOAM531f/J0X37CncDyoW7mJzem1whBHm7PefrGKVsAadw5vlQZ9iTPh
        8snrtjvsLMTwBgCKO40Tp4u0f3FmP3fPtrqkxZAQPA==
X-Google-Smtp-Source: ABdhPJwHHqZewNoX1bQdkxU3Gh7TLseGllkvcoFsgy6913KEkZLX3LJ9pU1iNNimk5i4skTk7Dxzv9Q+bq6nA2wOc9A=
X-Received: by 2002:a05:6e02:2196:: with SMTP id j22mr1576968ila.267.1623062129824;
 Mon, 07 Jun 2021 03:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210604153612.2903839-1-robert.marko@sartura.hr> <20210606125938.GA2887422@roeck-us.net>
In-Reply-To: <20210606125938.GA2887422@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 7 Jun 2021 12:35:19 +0200
Message-ID: <CA+HBbNFbUDaTNKXYebHHe0d=GZPqBiVBCg=Uoo8iCs4OQ7S4TQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
        trivial@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        jmp@epiphyte.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 2:59 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Jun 04, 2021 at 05:36:10PM +0200, Robert Marko wrote:
> > This adds support for the Delta DPS-920AB PSU.
> >
> > Only missing feature is fan control which the PSU supports.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> > Changes in v3:
> > * Use generic pmbus_read/write_word_data()
> > * Correct word data return code
> > * Cache PMBUS_MFR_ID and PMBUS_MFR_MODEL instead
> > of reading them everytime that debugfs is read
> >
> > Changes in v2:
> > * Check for Manufacturer and Model
> > * Restrict word read/write to supported only
> > * Update documentation to reflect driver changes
> > * Add basic debugfs entries
> >
> >  Documentation/hwmon/dps920ab.rst |  73 +++++++++++
> >  Documentation/hwmon/index.rst    |   1 +
> >  drivers/hwmon/pmbus/Kconfig      |   9 ++
> >  drivers/hwmon/pmbus/Makefile     |   1 +
> >  drivers/hwmon/pmbus/dps920ab.c   | 207 +++++++++++++++++++++++++++++++
> >  5 files changed, 291 insertions(+)
> >  create mode 100644 Documentation/hwmon/dps920ab.rst
> >  create mode 100644 drivers/hwmon/pmbus/dps920ab.c
> >
> > diff --git a/Documentation/hwmon/dps920ab.rst b/Documentation/hwmon/dps920ab.rst
> > new file mode 100644
> > index 000000000000..c33b4cdc0a60
> > --- /dev/null
> > +++ b/Documentation/hwmon/dps920ab.rst
> > @@ -0,0 +1,73 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver dps920ab
> > +========================
> > +
> > +Supported chips:
> > +
> > +  * Delta DPS920AB
> > +
> > +    Prefix: 'dps920ab'
> > +
> > +    Addresses scanned: -
> > +
> > +Authors:
> > +    Robert Marko <robert.marko@sartura.hr>
> > +
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements support for Delta DPS920AB 920W 54V DC single output
> > +power supply with PMBus support.
> > +
> > +The driver is a client driver to the core PMBus driver.
> > +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > +
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not auto-detect devices. You will have to instantiate the
> > +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> > +details.
> > +
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +======================= ======================================================
> > +curr1_label          "iin"
> > +curr1_input          Measured input current
> > +curr1_alarm          Input current high alarm
> > +
> > +curr2_label          "iout1"
> > +curr2_input          Measured output current
> > +curr2_max            Maximum output current
> > +curr2_rated_max              Maximum rated output current
> > +
> > +in1_label            "vin"
> > +in1_input            Measured input voltage
> > +in1_alarm            Input voltage alarm
> > +
> > +in2_label            "vout1"
> > +in2_input            Measured output voltage
> > +in2_rated_min                Minimum rated output voltage
> > +in2_rated_max                Maximum rated output voltage
> > +in2_alarm            Output voltage alarm
> > +
> > +power1_label         "pin"
> > +power1_input         Measured input power
> > +power1_alarm         Input power high alarm
> > +
> > +power2_label         "pout1"
> > +power2_input         Measured output power
> > +power2_rated_max     Maximum rated output power
> > +
> > +temp[1-3]_input              Measured temperature
> > +temp[1-3]_alarm              Temperature alarm
> > +
> > +fan1_alarm           Fan 1 warning.
> > +fan1_fault           Fan 1 fault.
> > +fan1_input           Fan 1 speed in RPM.
> > +======================= ======================================================
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 8d5a2df1ecb6..b24436f22052 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -54,6 +54,7 @@ Hardware Monitoring Kernel Drivers
> >     dell-smm-hwmon
> >     dme1737
> >     drivetemp
> > +   dps920ab
>
> Alphabetic order please.
>
> >     ds1621
> >     ds620
> >     emc1403
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 32d2fc850621..865ade0aa205 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -66,6 +66,15 @@ config SENSORS_IBM_CFFPS
> >         This driver can also be built as a module. If so, the module will
> >         be called ibm-cffps.
> >
> > +config SENSORS_DPS920AB
> > +     tristate "Delta DPS920AB Power Supply"
> > +     help
> > +       If you say yes here you get hardware monitoring support for Delta
> > +       DPS920AB Power Supplies.
> > +
> > +       This driver can also be built as a module. If so, the module will
> > +       be called dps920ab.
> > +
> >  config SENSORS_INSPUR_IPSPS
> >       tristate "INSPUR Power System Power Supply"
> >       help
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > index 6a4ba0fdc1db..f59ba0123d68 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266) += adm1266.o
> >  obj-$(CONFIG_SENSORS_ADM1275)        += adm1275.o
> >  obj-$(CONFIG_SENSORS_BEL_PFE)        += bel-pfe.o
> >  obj-$(CONFIG_SENSORS_IBM_CFFPS)      += ibm-cffps.o
> > +obj-$(CONFIG_SENSORS_DPS920AB)       += dps920ab.o
> >  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> >  obj-$(CONFIG_SENSORS_IR35221)        += ir35221.o
> >  obj-$(CONFIG_SENSORS_IR38064)        += ir38064.o
> > diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
> > new file mode 100644
> > index 000000000000..5ae536cba302
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/dps920ab.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Delta DPS920AB PSU
> > + *
> > + * Copyright (C) 2021 Delta Networks, Inc.
> > + * Copyright (C) 2021 Sartura Ltd.
> > + */
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include "pmbus.h"
> > +
> > +struct dps920ab_data {
> > +     struct i2c_client *client;
> > +     struct dentry *debugfs_dir;
> > +     char *mfr_model;
> > +     char *mfr_id;
> > +};
> > +
> > +static int dps920ab_read_word_data(struct i2c_client *client, int page, int phase, int reg)
> > +{
> > +     /*
> > +      * This masks commands which are not supported.
> > +      * PSU advertises that all features are supported,
> > +      * in reality that unfortunately is not true.
> > +      * So enable only those that the datasheet confirms.
> > +      */
> > +     switch (reg) {
> > +     case PMBUS_FAN_COMMAND_1:
> > +     case PMBUS_IOUT_OC_WARN_LIMIT:
> > +     case PMBUS_STATUS_WORD:
> > +     case PMBUS_READ_VIN:
> > +     case PMBUS_READ_IIN:
> > +     case PMBUS_READ_VOUT:
> > +     case PMBUS_READ_IOUT:
> > +     case PMBUS_READ_TEMPERATURE_1:
> > +     case PMBUS_READ_TEMPERATURE_2:
> > +     case PMBUS_READ_TEMPERATURE_3:
> > +     case PMBUS_READ_FAN_SPEED_1:
> > +     case PMBUS_READ_POUT:
> > +     case PMBUS_READ_PIN:
> > +     case PMBUS_MFR_VOUT_MIN:
> > +     case PMBUS_MFR_VOUT_MAX:
> > +     case PMBUS_MFR_IOUT_MAX:
> > +     case PMBUS_MFR_POUT_MAX:
> > +             return pmbus_read_word_data(client, page, phase, reg);
> > +     default:
> > +             return -ENXIO;
> > +     }
> > +}
> > +
> > +static int dps920ab_write_word_data(struct i2c_client *client, int page, int reg,
> > +                                 u16 word)
> > +{
> > +     /*
> > +      * This masks commands which are not supported.
> > +      * PSU only has one R/W register and that is
> > +      * for the fan.
> > +      */
> > +     switch (reg) {
> > +     case PMBUS_FAN_COMMAND_1:
> > +             return pmbus_write_word_data(client, page, reg, word);
> > +     default:
> > +             return -EACCES;
> > +     }
> > +}
> > +
> > +static struct pmbus_driver_info dps920ab_info = {
> > +     .pages = 1,
> > +
> > +     .format[PSC_VOLTAGE_IN] = linear,
> > +     .format[PSC_VOLTAGE_OUT] = linear,
> > +     .format[PSC_CURRENT_IN] = linear,
> > +     .format[PSC_CURRENT_OUT] = linear,
> > +     .format[PSC_POWER] = linear,
> > +     .format[PSC_FAN] = linear,
> > +     .format[PSC_TEMPERATURE] = linear,
> > +
> > +     .func[0] =
> > +             PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> > +             PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
> > +             PMBUS_HAVE_TEMP  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> > +             PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12 |
> > +             PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> > +             PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> > +     .read_word_data = dps920ab_read_word_data,
> > +     .write_word_data = dps920ab_write_word_data,
> > +};
> > +
> > +static int dps920ab_mfr_id_show(struct seq_file *s, void *data)
> > +{
> > +     struct dps920ab_data *priv = s->private;
> > +
> > +     seq_printf(s, "%s\n", priv->mfr_id);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(dps920ab_mfr_id);
> > +
> > +static int dps920ab_mfr_model_show(struct seq_file *s, void *data)
> > +{
> > +     struct dps920ab_data *priv = s->private;
> > +
> > +     seq_printf(s, "%s\n", priv->mfr_model);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(dps920ab_mfr_model);
> > +
> > +static void dps920ab_init_debugfs(struct dps920ab_data *data)
> > +{
> > +     struct dentry *root;
> > +
> > +     root = pmbus_get_debugfs_dir(data->client);
> > +     if (!root)
> > +             return;
> > +
> > +     data->debugfs_dir = debugfs_create_dir(data->client->name, root);
>
> debugfs_dir is only used here. Please just use a local variable.
>
> > +     if (!data->debugfs_dir)
> > +             return;
> > +
> > +     debugfs_create_file("mfr_id",
> > +                         0400,
> > +                         data->debugfs_dir,
> > +                         data,
> > +                         &dps920ab_mfr_id_fops);
> > +
> > +     debugfs_create_file("mfr_model",
> > +                         0400,
> > +                         data->debugfs_dir,
> > +                         data,
> > +                         &dps920ab_mfr_model_fops);
> > +}
> > +
> > +static int dps920ab_probe(struct i2c_client *client)
> > +{
> > +     u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> > +     struct dps920ab_data *data;
> > +     int ret;
> > +
> > +     data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> > +             return ret;
> > +     }
> > +     if (ret != 5 || strncmp(buf, "DELTA", 5)) {
> > +             buf[ret] = '\0';
> > +             dev_err(&client->dev, "Unsupported Manufacturer ID '%s'\n", buf);
> > +             return -ENODEV;
> > +     }
> > +     data->mfr_id = devm_kstrdup(&client->dev, buf, GFP_KERNEL);
>
> There is no guarantee that the returned string is terminated.
> For this to work, "buf[ret] = '\0';" needs to be ahead of the if
> statement above.
>
> > +     if (!data->mfr_id)
> > +             return -ENOMEM;
> > +
> > +     ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "Failed to read Manufacturer Model\n");
> > +             return ret;
> > +     }
> > +     if (ret != 11 || strncmp(buf, "DPS-920AB", 9)) {
> > +             buf[ret] = '\0';
> > +             dev_err(&client->dev, "Unsupported Manufacturer Model '%s'\n", buf);
> > +             return -ENODEV;
> > +     }
> > +     data->mfr_model = devm_kstrdup(&client->dev, buf, GFP_KERNEL);
>
> Same as above.
>
> > +     if (!data->mfr_model)
> > +             return -ENOMEM;
> > +
> > +     ret = pmbus_do_probe(client, &dps920ab_info);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->client = client;
>
> data->client is only used in dps920ab_init_debugfs(). Just pass 'client'
> as additional argument to that function.

Thanks for the comments,
I have sent v4 resolving these.

Regards,
Robert
>
> > +
> > +     dps920ab_init_debugfs(data);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id __maybe_unused dps920ab_of_match[] = {
> > +     { .compatible = "delta,dps920ab", },
> > +     {}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, dps920ab_of_match);
> > +
> > +static struct i2c_driver dps920ab_driver = {
> > +     .driver = {
> > +                .name = "dps920ab",
> > +                .of_match_table = of_match_ptr(dps920ab_of_match),
> > +     },
> > +     .probe_new = dps920ab_probe,
> > +};
> > +
> > +module_i2c_driver(dps920ab_driver);
> > +
> > +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
> > +MODULE_DESCRIPTION("PMBus driver for Delta DPS920AB PSU");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.31.1
> >



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
