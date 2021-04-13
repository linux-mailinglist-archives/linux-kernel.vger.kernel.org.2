Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC835D5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhDMDKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:10:41 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:41058 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbhDMDKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:10:40 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 222EC40006E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1618283417;
        bh=Xz9fql98jHeYw4yi83czzXIXxODxe9R7YJUvclimJRM=;
        h=References:In-Reply-To:From:Date:Subject:Cc;
        b=NUgPbIyTycJ7m0ddKZjgkl4AdDeI9t8OJWX2Hz9P6iqv0uujh8HjtRIbChIKCqdc8
         9uSDjJwqiGGZ3FvzmH583/LAAPBtMZLh3thTciQ0jT8521kf1M0FqdTl2LWhgTS7EB
         zp5rYDe66S+BsYz2JeLbAewX5b2iPcMuHt3XN194T93L9b9Dbt+9UI6AD3muCSAHHU
         5Kiy9mf720Eh5KgDiMHcTJT8ycEwVlxqeFSbRtWq1CpgI6r952VDFlr039mLBmbMns
         u5l4xZx94/YZMutKzuHNGyPxDPxs4+TqrGkClUnoX24kTDF/wAXgOgBmBee+5Pb6Ar
         yMKHWWpEXcxEw==
Received: by mail-pf1-f171.google.com with SMTP id b26so5357875pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:10:16 -0700 (PDT)
X-Gm-Message-State: AOAM532u2HdY7xyJ+PER6BYJO1+x2XVSvfjFPGXseeGYH8g+RI/TubFP
        3Ior2jLsAjPgXuqZxgbKNAVzBCECRO9/pAyLyhE=
X-Received: by 2002:aa7:8e0d:0:b029:214:a511:d88b with SMTP id
 c13-20020aa78e0d0000b0290214a511d88bmt23028563pfr.2.1618283415079; Mon, 12
 Apr 2021 20:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210413025948.901867-1-kubernat@cesnet.cz>
In-Reply-To: <20210413025948.901867-1-kubernat@cesnet.cz>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Tue, 13 Apr 2021 05:10:03 +0200
X-Gmail-Original-Message-ID: <CABKa3nqFzs4fCnrJ-ackq33B0uvXWp9dF0f-JBmhKhm2S9W85A@mail.gmail.com>
Message-ID: <CABKa3nqFzs4fCnrJ-ackq33B0uvXWp9dF0f-JBmhKhm2S9W85A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm uploading a new version of my patches on max31790. This is a "v3"
patch, but I have mistakenly tagged it as "v2". Hopefully, this is not
a big issue.

Changes:
- I have reintroduced locking. However, I'm not sure if it's enough, I
think, locking needs to happen even when reading, but I'm not sure
- fan_config and fan_dynamics are now saved locally
- I have fixed formatting issues

V=C3=A1clav

=C3=BAt 13. 4. 2021 v 5:02 odes=C3=ADlatel V=C3=A1clav Kubern=C3=A1t <kuber=
nat@cesnet.cz> napsal:
>
> Converting the driver to use regmap makes it more generic. It also makes
> it a lot easier to debug through debugfs.
>
> Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> ---
>  drivers/hwmon/Kconfig    |   1 +
>  drivers/hwmon/max31790.c | 254 ++++++++++++++++++++-------------------
>  2 files changed, 133 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1ecf697d8d99..9f11d036c316 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1095,6 +1095,7 @@ config SENSORS_MAX6697
>  config SENSORS_MAX31790
>         tristate "Maxim MAX31790 sensor chip"
>         depends on I2C
> +       select REGMAP_I2C
>         help
>           If you say yes here you get support for 6-Channel PWM-Output
>           Fan RPM Controller.
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 2c6b333a28e9..e3765ce4444a 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>
>  /* MAX31790 registers */
> @@ -46,92 +47,53 @@
>
>  #define NR_CHANNEL                     6
>
> +#define MAX31790_REG_USER_BYTE_67      0x67
> +
> +#define BULK_TO_U16(msb, lsb)          (((msb) << 8) + (lsb))
> +#define U16_MSB(num)                   (((num) & 0xFF00) >> 8)
> +#define U16_LSB(num)                   ((num) & 0x00FF)
> +
> +static const struct regmap_range max31790_ro_range =3D {
> +       .range_min =3D MAX31790_REG_TACH_COUNT(0),
> +       .range_max =3D MAX31790_REG_PWMOUT(0) - 1,
> +};
> +
> +static const struct regmap_access_table max31790_wr_table =3D {
> +       .no_ranges =3D &max31790_ro_range,
> +       .n_no_ranges =3D 1,
> +};
> +
> +static const struct regmap_range max31790_volatile_ranges[] =3D {
> +       regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_CO=
UNT(12)),
> +       regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN=
_FAULT_STATUS1),
> +};
> +
> +static const struct regmap_access_table max31790_volatile_table =3D {
> +       .no_ranges =3D max31790_volatile_ranges,
> +       .n_no_ranges =3D 2,
> +       .n_yes_ranges =3D 0
> +};
> +
> +static const struct regmap_config max31790_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .reg_stride =3D 1,
> +       .max_register =3D MAX31790_REG_USER_BYTE_67,
> +       .wr_table =3D &max31790_wr_table,
> +       .volatile_table =3D &max31790_volatile_table
> +};
> +
>  /*
>   * Client data (each client gets its own)
>   */
>  struct max31790_data {
> -       struct i2c_client *client;
> +       struct regmap *regmap;
> +
>         struct mutex update_lock;
> -       bool valid; /* zero until following fields are valid */
> -       unsigned long last_updated; /* in jiffies */
> -
> -       /* register values */
>         u8 fan_config[NR_CHANNEL];
>         u8 fan_dynamics[NR_CHANNEL];
> -       u16 fault_status;
> -       u16 tach[NR_CHANNEL * 2];
> -       u16 pwm[NR_CHANNEL];
> -       u16 target_count[NR_CHANNEL];
>  };
>
> -static struct max31790_data *max31790_update_device(struct device *dev)
> -{
> -       struct max31790_data *data =3D dev_get_drvdata(dev);
> -       struct i2c_client *client =3D data->client;
> -       struct max31790_data *ret =3D data;
> -       int i;
> -       int rv;
> -
> -       mutex_lock(&data->update_lock);
> -
> -       if (time_after(jiffies, data->last_updated + HZ) || !data->valid)=
 {
> -               rv =3D i2c_smbus_read_byte_data(client,
> -                               MAX31790_REG_FAN_FAULT_STATUS1);
> -               if (rv < 0)
> -                       goto abort;
> -               data->fault_status =3D rv & 0x3F;
> -
> -               rv =3D i2c_smbus_read_byte_data(client,
> -                               MAX31790_REG_FAN_FAULT_STATUS2);
> -               if (rv < 0)
> -                       goto abort;
> -               data->fault_status |=3D (rv & 0x3F) << 6;
> -
> -               for (i =3D 0; i < NR_CHANNEL; i++) {
> -                       rv =3D i2c_smbus_read_word_swapped(client,
> -                                       MAX31790_REG_TACH_COUNT(i));
> -                       if (rv < 0)
> -                               goto abort;
> -                       data->tach[i] =3D rv;
> -
> -                       if (data->fan_config[i]
> -                           & MAX31790_FAN_CFG_TACH_INPUT) {
> -                               rv =3D i2c_smbus_read_word_swapped(client=
,
> -                                       MAX31790_REG_TACH_COUNT(NR_CHANNE=
L
> -                                                               + i));
> -                               if (rv < 0)
> -                                       goto abort;
> -                               data->tach[NR_CHANNEL + i] =3D rv;
> -                       } else {
> -                               rv =3D i2c_smbus_read_word_swapped(client=
,
> -                                               MAX31790_REG_PWMOUT(i));
> -                               if (rv < 0)
> -                                       goto abort;
> -                               data->pwm[i] =3D rv;
> -
> -                               rv =3D i2c_smbus_read_word_swapped(client=
,
> -                                               MAX31790_REG_TARGET_COUNT=
(i));
> -                               if (rv < 0)
> -                                       goto abort;
> -                               data->target_count[i] =3D rv;
> -                       }
> -               }
> -
> -               data->last_updated =3D jiffies;
> -               data->valid =3D true;
> -       }
> -       goto done;
> -
> -abort:
> -       data->valid =3D false;
> -       ret =3D ERR_PTR(rv);
> -
> -done:
> -       mutex_unlock(&data->update_lock);
> -
> -       return ret;
> -}
> -
>  static const u8 tach_period[8] =3D { 1, 2, 4, 8, 16, 32, 32, 32 };
>
>  static u8 get_tach_period(u8 fan_dynamics)
> @@ -159,28 +121,75 @@ static u8 bits_for_tach_period(int rpm)
>         return bits;
>  }
>
> +static int read_reg_byte(struct regmap *regmap, u8 reg)
> +{
> +       int rv;
> +       int val;
> +
> +       rv =3D regmap_read(regmap, reg, &val);
> +       if (rv < 0)
> +               return rv;
> +
> +       return val;
> +}
> +
> +static int read_reg_word(struct regmap *regmap, u8 reg)
> +{
> +       int rv;
> +       u8 val_bulk[2];
> +
> +       rv =3D regmap_bulk_read(regmap, reg, val_bulk, 2);
> +       if (rv < 0)
> +               return rv;
> +
> +       return BULK_TO_U16(val_bulk[0], val_bulk[1]);
> +}
> +
> +static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
> +{
> +       u8 bulk_val[2];
> +
> +       bulk_val[0] =3D U16_MSB(val);
> +       bulk_val[1] =3D U16_LSB(val);
> +
> +       return regmap_bulk_write(regmap, reg, bulk_val, 2);
> +}
> +
>  static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>                              long *val)
>  {
> -       struct max31790_data *data =3D max31790_update_device(dev);
> -       int sr, rpm;
> -
> -       if (IS_ERR(data))
> -               return PTR_ERR(data);
> +       struct max31790_data *data =3D dev_get_drvdata(dev);
> +       struct regmap *regmap =3D data->regmap;
> +       int tach, fault;
>
>         switch (attr) {
>         case hwmon_fan_input:
> -               sr =3D get_tach_period(data->fan_dynamics[channel]);
> -               rpm =3D RPM_FROM_REG(data->tach[channel], sr);
> -               *val =3D rpm;
> +               tach =3D read_reg_word(regmap, MAX31790_REG_TACH_COUNT(ch=
annel));
> +               if (tach < 0)
> +                       return tach;
> +
> +               *val =3D RPM_FROM_REG(tach, get_tach_period(data->fan_dyn=
amics[channel]));
>                 return 0;
>         case hwmon_fan_target:
> -               sr =3D get_tach_period(data->fan_dynamics[channel]);
> -               rpm =3D RPM_FROM_REG(data->target_count[channel], sr);
> -               *val =3D rpm;
> +               tach =3D read_reg_word(regmap, MAX31790_REG_TARGET_COUNT(=
channel));
> +               if (tach < 0)
> +                       return tach;
> +
> +               *val =3D RPM_FROM_REG(tach, get_tach_period(data->fan_dyn=
amics[channel]));
>                 return 0;
>         case hwmon_fan_fault:
> -               *val =3D !!(data->fault_status & (1 << channel));
> +               if (channel > 6)
> +                       fault =3D read_reg_byte(regmap, MAX31790_REG_FAN_=
FAULT_STATUS2);
> +               else
> +                       fault =3D read_reg_byte(regmap, MAX31790_REG_FAN_=
FAULT_STATUS1);
> +
> +               if (fault < 0)
> +                       return fault;
> +
> +               if (channel > 6)
> +                       *val =3D !!(fault & (1 << (channel - 6)));
> +               else
> +                       *val =3D !!(fault & (1 << channel));
>                 return 0;
>         default:
>                 return -EOPNOTSUPP;
> @@ -191,7 +200,7 @@ static int max31790_write_fan(struct device *dev, u32=
 attr, int channel,
>                               long val)
>  {
>         struct max31790_data *data =3D dev_get_drvdata(dev);
> -       struct i2c_client *client =3D data->client;
> +       struct regmap *regmap =3D data->regmap;
>         int target_count;
>         int err =3D 0;
>         u8 bits;
> @@ -207,9 +216,10 @@ static int max31790_write_fan(struct device *dev, u3=
2 attr, int channel,
>                         ((data->fan_dynamics[channel] &
>                           ~MAX31790_FAN_DYN_SR_MASK) |
>                          (bits << MAX31790_FAN_DYN_SR_SHIFT));
> -               err =3D i2c_smbus_write_byte_data(client,
> -                                       MAX31790_REG_FAN_DYNAMICS(channel=
),
> -                                       data->fan_dynamics[channel]);
> +
> +               err =3D regmap_write(regmap,
> +                                  MAX31790_REG_FAN_DYNAMICS(channel),
> +                                  data->fan_dynamics[channel]);
>                 if (err < 0)
>                         break;
>
> @@ -217,11 +227,11 @@ static int max31790_write_fan(struct device *dev, u=
32 attr, int channel,
>                 target_count =3D RPM_TO_REG(val, sr);
>                 target_count =3D clamp_val(target_count, 0x1, 0x7FF);
>
> -               data->target_count[channel] =3D target_count << 5;
> +               target_count =3D target_count << 5;
>
> -               err =3D i2c_smbus_write_word_swapped(client,
> -                                       MAX31790_REG_TARGET_COUNT(channel=
),
> -                                       data->target_count[channel]);
> +               err =3D write_reg_word(regmap,
> +                                    MAX31790_REG_TARGET_COUNT(channel),
> +                                    target_count);
>                 break;
>         default:
>                 err =3D -EOPNOTSUPP;
> @@ -258,22 +268,22 @@ static umode_t max31790_fan_is_visible(const void *=
_data, u32 attr, int channel)
>  static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
>                              long *val)
>  {
> -       struct max31790_data *data =3D max31790_update_device(dev);
> -       u8 fan_config;
> -
> -       if (IS_ERR(data))
> -               return PTR_ERR(data);
> -
> -       fan_config =3D data->fan_config[channel];
> +       struct max31790_data *data =3D dev_get_drvdata(dev);
> +       struct regmap *regmap =3D data->regmap;
> +       int read;
>
>         switch (attr) {
>         case hwmon_pwm_input:
> -               *val =3D data->pwm[channel] >> 8;
> +               read =3D read_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l));
> +               if (read < 0)
> +                       return read;
> +
> +               *val =3D read >> 8;
>                 return 0;
>         case hwmon_pwm_enable:
> -               if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
> +               if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE=
)
>                         *val =3D 2;
> -               else if (fan_config & MAX31790_FAN_CFG_TACH_INPUT_EN)
> +               else if (data->fan_config[channel] & MAX31790_FAN_CFG_TAC=
H_INPUT_EN)
>                         *val =3D 1;
>                 else
>                         *val =3D 0;
> @@ -287,7 +297,7 @@ static int max31790_write_pwm(struct device *dev, u32=
 attr, int channel,
>                               long val)
>  {
>         struct max31790_data *data =3D dev_get_drvdata(dev);
> -       struct i2c_client *client =3D data->client;
> +       struct regmap *regmap =3D data->regmap;
>         u8 fan_config;
>         int err =3D 0;
>
> @@ -299,10 +309,7 @@ static int max31790_write_pwm(struct device *dev, u3=
2 attr, int channel,
>                         err =3D -EINVAL;
>                         break;
>                 }
> -               data->pwm[channel] =3D val << 8;
> -               err =3D i2c_smbus_write_word_swapped(client,
> -                                                  MAX31790_REG_PWMOUT(ch=
annel),
> -                                                  data->pwm[channel]);
> +               err =3D write_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l), val << 8);
>                 break;
>         case hwmon_pwm_enable:
>                 fan_config =3D data->fan_config[channel];
> @@ -321,9 +328,9 @@ static int max31790_write_pwm(struct device *dev, u32=
 attr, int channel,
>                         break;
>                 }
>                 data->fan_config[channel] =3D fan_config;
> -               err =3D i2c_smbus_write_byte_data(client,
> -                                       MAX31790_REG_FAN_CONFIG(channel),
> -                                       fan_config);
> +               err =3D regmap_write(regmap,
> +                                  MAX31790_REG_FAN_CONFIG(channel),
> +                                  fan_config);
>                 break;
>         default:
>                 err =3D -EOPNOTSUPP;
> @@ -426,20 +433,18 @@ static const struct hwmon_chip_info max31790_chip_i=
nfo =3D {
>         .info =3D max31790_info,
>  };
>
> -static int max31790_init_client(struct i2c_client *client,
> +static int max31790_init_client(struct regmap *regmap,
>                                 struct max31790_data *data)
>  {
>         int i, rv;
>
>         for (i =3D 0; i < NR_CHANNEL; i++) {
> -               rv =3D i2c_smbus_read_byte_data(client,
> -                               MAX31790_REG_FAN_CONFIG(i));
> +               rv =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(i % =
NR_CHANNEL));
>                 if (rv < 0)
>                         return rv;
>                 data->fan_config[i] =3D rv;
>
> -               rv =3D i2c_smbus_read_byte_data(client,
> -                               MAX31790_REG_FAN_DYNAMICS(i));
> +               rv =3D read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(i)=
);
>                 if (rv < 0)
>                         return rv;
>                 data->fan_dynamics[i] =3D rv;
> @@ -464,13 +469,18 @@ static int max31790_probe(struct i2c_client *client=
)
>         if (!data)
>                 return -ENOMEM;
>
> -       data->client =3D client;
>         mutex_init(&data->update_lock);
>
> +       data->regmap =3D devm_regmap_init_i2c(client, &max31790_regmap_co=
nfig);
> +       if (IS_ERR(data->regmap)) {
> +               dev_err(dev, "failed to allocate register map\n");
> +               return PTR_ERR(data->regmap);
> +       }
> +
>         /*
>          * Initialize the max31790 chip
>          */
> -       err =3D max31790_init_client(client, data);
> +       err =3D max31790_init_client(data->regmap, data);
>         if (err)
>                 return err;
>
> --
> 2.31.1
>
