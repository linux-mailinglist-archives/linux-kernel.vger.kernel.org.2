Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78734DF89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhC3DoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:44:12 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:36728 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhC3DoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:44:00 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 4F4D8400064;
        Tue, 30 Mar 2021 05:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1617075838;
        bh=FFYgEVOStRWlcqZLHyAW8s+ALHQGkkL4BlDf5mBJInY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=DatryQ2aFl9GAj+RUX4ztRjUy9GPTqtOHKb/Fked+MsFb4Ve/hxzdTfqhZ9B0IZix
         8keHM/UNQii1ilEP03OFGrEN9QohTEgvjkHKSMET9ZwcPrrNvz5o1gGcveNSoORIbj
         KdGBKZTTvSjHG+08BTOBPEUcLyIY8qbJlCji21j9ZY7A+KdB7KrPk8RkJ6mAM6qIAF
         CNh/UL7VMGibAB1p5EI66DWFfikrze/qnP+XnMv1Ca9ICln4050gTFPqekYi2bDWuh
         LROs8MvBeIx5bu3NUhr4uY6noHT7lYj1ZPvb+46MOLOy4++LSgl8o/xNg5HVpSZ3dd
         zUQULXtHcLv9w==
Received: by mail-lf1-f49.google.com with SMTP id v15so21611800lfq.5;
        Mon, 29 Mar 2021 20:43:58 -0700 (PDT)
X-Gm-Message-State: AOAM530dT74ab+uD8a4xiF2pscfxJV50EdD4484eUIuUU8GNs6EwKYDd
        FDydGdps/GQxNQIjjQwGxkm9nS4FWOZjSUcyVFo=
X-Google-Smtp-Source: ABdhPJx2FCG4KsRf2iAllqw+eQXT0vvQsYp/Y1hmtv1AkWptEY8oQndydr7PZHeV5CnP8BeCiT8KjhL7vQXGxrFYO98=
X-Received: by 2002:a19:fc16:: with SMTP id a22mr6824104lfi.362.1617075837576;
 Mon, 29 Mar 2021 20:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210316175503.1003051-1-kubernat@cesnet.cz> <20210329222704.GA223476@roeck-us.net>
In-Reply-To: <20210329222704.GA223476@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Tue, 30 Mar 2021 05:43:46 +0200
X-Gmail-Original-Message-ID: <CABKa3nreTyO=6kJx3fXem1hsNshywEP7zHHtJe6gcH01zybC0A@mail.gmail.com>
Message-ID: <CABKa3nreTyO=6kJx3fXem1hsNshywEP7zHHtJe6gcH01zybC0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for the comments. I will fix the issues in a V3 patch.

About the mutex: I was looking at regmap and saw it did locking by
itself. But I suppose writing still has to be locked, because the
write function writes more than once. I will add the mutex back.

V=C3=A1clav

=C3=BAt 30. 3. 2021 v 0:27 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.ne=
t> napsal:
>
> On Tue, Mar 16, 2021 at 06:54:58PM +0100, V=C3=A1clav Kubern=C3=A1t wrote=
:
> > Converting the driver to use regmap makes it more generic. It also make=
s
> > it a lot easier to debug through debugfs.
> >
> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
>
> Comments are in addition to comments from Dan and 0-day.
>
> > ---
> >  drivers/hwmon/Kconfig    |   1 +
> >  drivers/hwmon/max31790.c | 318 ++++++++++++++++++++-------------------
> >  2 files changed, 163 insertions(+), 156 deletions(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 54f04e61fb83..c2ec57672c4e 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1092,6 +1092,7 @@ config SENSORS_MAX6697
> >  config SENSORS_MAX31790
> >       tristate "Maxim MAX31790 sensor chip"
> >       depends on I2C
> > +     select REGMAP_I2C
> >       help
> >         If you say yes here you get support for 6-Channel PWM-Output
> >         Fan RPM Controller.
> > diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> > index 86e6c71db685..4e5add567890 100644
> > --- a/drivers/hwmon/max31790.c
> > +++ b/drivers/hwmon/max31790.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/init.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/module.h>
> > +#include <linux/regmap.h>
> >  #include <linux/slab.h>
> >
> >  /* MAX31790 registers */
> > @@ -46,92 +47,49 @@
> >
> >  #define NR_CHANNEL                   6
> >
> > +#define MAX31790_REG_USER_BYTE_67    0x67
> > +
> > +#define BULK_TO_U16(msb, lsb)                (((msb) << 8) + (lsb))
> > +#define U16_MSB(num)                 (((num) & 0xFF00) >> 8)
> > +#define U16_LSB(num)                 ((num) & 0x00FF)
> > +
> > +static const struct regmap_range max31790_ro_range =3D {
> > +     .range_min =3D MAX31790_REG_TACH_COUNT(0),
> > +     .range_max =3D MAX31790_REG_PWMOUT(0) - 1,
> > +};
> > +
> > +static const struct regmap_access_table max31790_wr_table =3D {
> > +     .no_ranges =3D &max31790_ro_range,
> > +     .n_no_ranges =3D 1,
> > +};
> > +
> > +static const struct regmap_range max31790_volatile_ranges[] =3D {
> > +     regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_CO=
UNT(12)),
> > +     regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN=
_FAULT_STATUS1),
> > +};
> > +
> > +static const struct regmap_access_table max31790_volatile_table =3D {
> > +     .no_ranges =3D max31790_volatile_ranges,
> > +     .n_no_ranges =3D 2,
> > +     .n_yes_ranges =3D 0
> > +};
> > +
> > +static const struct regmap_config max31790_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .reg_stride =3D 1,
> > +     .max_register =3D MAX31790_REG_USER_BYTE_67,
> > +     .wr_table =3D &max31790_wr_table,
> > +     .volatile_table =3D &max31790_volatile_table
> > +};
> > +
> >  /*
> >   * Client data (each client gets its own)
> >   */
> >  struct max31790_data {
> > -     struct i2c_client *client;
> > -     struct mutex update_lock;
> > -     bool valid; /* zero until following fields are valid */
> > -     unsigned long last_updated; /* in jiffies */
> > -
> > -     /* register values */
> > -     u8 fan_config[NR_CHANNEL];
> > -     u8 fan_dynamics[NR_CHANNEL];
> > -     u16 fault_status;
> > -     u16 tach[NR_CHANNEL * 2];
> > -     u16 pwm[NR_CHANNEL];
> > -     u16 target_count[NR_CHANNEL];
> > +     struct regmap *regmap;
> >  };
> >
> > -static struct max31790_data *max31790_update_device(struct device *dev=
)
> > -{
> > -     struct max31790_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > -     struct max31790_data *ret =3D data;
> > -     int i;
> > -     int rv;
> > -
> > -     mutex_lock(&data->update_lock);
> > -
> > -     if (time_after(jiffies, data->last_updated + HZ) || !data->valid)=
 {
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_FAULT_STATUS1);
> > -             if (rv < 0)
> > -                     goto abort;
> > -             data->fault_status =3D rv & 0x3F;
> > -
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_FAULT_STATUS2);
> > -             if (rv < 0)
> > -                     goto abort;
> > -             data->fault_status |=3D (rv & 0x3F) << 6;
> > -
> > -             for (i =3D 0; i < NR_CHANNEL; i++) {
> > -                     rv =3D i2c_smbus_read_word_swapped(client,
> > -                                     MAX31790_REG_TACH_COUNT(i));
> > -                     if (rv < 0)
> > -                             goto abort;
> > -                     data->tach[i] =3D rv;
> > -
> > -                     if (data->fan_config[i]
> > -                         & MAX31790_FAN_CFG_TACH_INPUT) {
> > -                             rv =3D i2c_smbus_read_word_swapped(client=
,
> > -                                     MAX31790_REG_TACH_COUNT(NR_CHANNE=
L
> > -                                                             + i));
> > -                             if (rv < 0)
> > -                                     goto abort;
> > -                             data->tach[NR_CHANNEL + i] =3D rv;
> > -                     } else {
> > -                             rv =3D i2c_smbus_read_word_swapped(client=
,
> > -                                             MAX31790_REG_PWMOUT(i));
> > -                             if (rv < 0)
> > -                                     goto abort;
> > -                             data->pwm[i] =3D rv;
> > -
> > -                             rv =3D i2c_smbus_read_word_swapped(client=
,
> > -                                             MAX31790_REG_TARGET_COUNT=
(i));
> > -                             if (rv < 0)
> > -                                     goto abort;
> > -                             data->target_count[i] =3D rv;
> > -                     }
> > -             }
> > -
> > -             data->last_updated =3D jiffies;
> > -             data->valid =3D true;
> > -     }
> > -     goto done;
> > -
> > -abort:
> > -     data->valid =3D false;
> > -     ret =3D ERR_PTR(rv);
> > -
> > -done:
> > -     mutex_unlock(&data->update_lock);
> > -
> > -     return ret;
> > -}
> > -
> >  static const u8 tach_period[8] =3D { 1, 2, 4, 8, 16, 32, 32, 32 };
> >
> >  static u8 get_tach_period(u8 fan_dynamics)
> > @@ -159,28 +117,89 @@ static u8 bits_for_tach_period(int rpm)
> >       return bits;
> >  }
> >
> > +static int read_reg_byte(struct regmap *regmap, u8 reg)
> > +{
> > +     int rv;
> > +     int val;
> > +
> > +     rv =3D regmap_read(regmap, reg, &val);
> > +
>
> lease no empty line between assignment and check.
>
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     return val;
> > +}
> > +
> > +static int read_reg_word(struct regmap *regmap, u8 reg)
> > +{
> > +     int rv;
> > +     u8 val_bulk[2];
> > +
> > +     rv =3D regmap_bulk_read(regmap, reg, val_bulk, 2);
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     return BULK_TO_U16(val_bulk[0], val_bulk[1]);
> > +}
> > +
> > +static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
> > +{
> > +     u8 bulk_val[2];
> > +
> > +     bulk_val[0] =3D U16_MSB(val);
> > +     bulk_val[1] =3D U16_LSB(val);
> > +
> > +     return regmap_bulk_write(regmap, reg, bulk_val, 2);
> > +}
> > +
> >  static int max31790_read_fan(struct device *dev, u32 attr, int channel=
,
> >                            long *val)
> >  {
> > -     struct max31790_data *data =3D max31790_update_device(dev);
> > -     int sr, rpm;
> > +     struct max31790_data *data =3D dev_get_drvdata(dev);
> > +     struct regmap *regmap =3D data->regmap;
> > +     int rpm, dynamics, tach, fault;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
>
> Now unnecessary.
>
> >
> >       switch (attr) {
> >       case hwmon_fan_input:
> > -             sr =3D get_tach_period(data->fan_dynamics[channel]);
> > -             rpm =3D RPM_FROM_REG(data->tach[channel], sr);
> > +             dynamics =3D read_reg_byte(regmap, MAX31790_REG_FAN_DYNAM=
ICS(channel));
> > +             if (dynamics < 0)
> > +                     return dynamics;
> > +
> > +             tach =3D read_reg_word(regmap, MAX31790_REG_TACH_COUNT(ch=
annel));
> > +             if (tach < 0)
> > +                     return tach;
> > +
> > +             rpm =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
> >               *val =3D rpm;
>
>                 *val =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
>
> >               return 0;
> >       case hwmon_fan_target:
> > -             sr =3D get_tach_period(data->fan_dynamics[channel]);
> > -             rpm =3D RPM_FROM_REG(data->target_count[channel], sr);
> > +             dynamics =3D read_reg_byte(regmap, MAX31790_REG_FAN_DYNAM=
ICS(channel));
> > +             if (dynamics < 0)
> > +                     return dynamics;
> > +
> > +             tach =3D read_reg_word(regmap, MAX31790_REG_TARGET_COUNT(=
channel));
> > +             if (tach < 0)
> > +                     return tach;
> > +
> > +             rpm =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
> >               *val =3D rpm;
>
>                 *val =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
>
> >               return 0;
> >       case hwmon_fan_fault:
> > -             *val =3D !!(data->fault_status & (1 << channel));
> > +             if (channel > 6)
> > +                     fault =3D read_reg_byte(regmap, MAX31790_REG_FAN_=
FAULT_STATUS2);
> > +             else
> > +                     fault =3D read_reg_byte(regmap, MAX31790_REG_FAN_=
FAULT_STATUS1);
> > +
> > +             if (fault < 0)
> > +                     return fault;
> > +
> > +             if (channel > 6)
> > +                     *val =3D !!(fault & (1 << (channel - 6)));
> > +             else
> > +                     *val =3D !!(fault & (1 << channel));
> >               return 0;
> >       default:
> >               return -EOPNOTSUPP;
> > @@ -191,52 +210,58 @@ static int max31790_write_fan(struct device *dev,=
 u32 attr, int channel,
> >                             long val)
> >  {
> >       struct max31790_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > +     struct regmap *regmap =3D data->regmap;
> >       int target_count;
> >       int err =3D 0;
> >       u8 bits;
> >       int sr;
> > -
> > -     mutex_lock(&data->update_lock);
> > +     int fan_dynamics;
> >
> >       switch (attr) {
> >       case hwmon_fan_target:
> >               val =3D clamp_val(val, FAN_RPM_MIN, FAN_RPM_MAX);
> >               bits =3D bits_for_tach_period(val);
> > -             data->fan_dynamics[channel] =3D
> > -                     ((data->fan_dynamics[channel] &
> > +             fan_dynamics =3D read_reg_byte(regmap, MAX31790_REG_FAN_D=
YNAMICS(channel));
> > +
> Unnecessary empty line.
>
> > +             if (fan_dynamics < 0)
> > +                     return fan_dynamics;
> > +
> > +             fan_dynamics =3D
> > +                     ((fan_dynamics &
> >                         ~MAX31790_FAN_DYN_SR_MASK) |
> >                        (bits << MAX31790_FAN_DYN_SR_SHIFT));
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                                     MAX31790_REG_FAN_DYNAMICS(channel=
),
> > -                                     data->fan_dynamics[channel]);
> > +             err =3D regmap_write(regmap,
> > +                                MAX31790_REG_FAN_DYNAMICS(channel),
> > +                                fan_dynamics);
> >               if (err < 0)
> >                       break;
> >
> > -             sr =3D get_tach_period(data->fan_dynamics[channel]);
> > +             sr =3D get_tach_period(fan_dynamics);
> >               target_count =3D RPM_TO_REG(val, sr);
> >               target_count =3D clamp_val(target_count, 0x1, 0x7FF);
> >
> > -             data->target_count[channel] =3D target_count << 5;
> > +             target_count =3D target_count << 5;
> >
> > -             err =3D i2c_smbus_write_word_swapped(client,
> > -                                     MAX31790_REG_TARGET_COUNT(channel=
),
> > -                                     data->target_count[channel]);
> > +             err =3D write_reg_word(regmap,
> > +                                  MAX31790_REG_TARGET_COUNT(channel),
> > +                                  target_count);
> >               break;
> >       default:
> >               err =3D -EOPNOTSUPP;
> >               break;
> >       }
> >
> > -     mutex_unlock(&data->update_lock);
> > -
> Why is this lock no longer required ? There are still multiple writes
> when writing hwmon_fan_target.
>
> >       return err;
> >  }
> >
> >  static umode_t max31790_fan_is_visible(const void *_data, u32 attr, in=
t channel)
> >  {
> >       const struct max31790_data *data =3D _data;
> > -     u8 fan_config =3D data->fan_config[channel % NR_CHANNEL];
> > +     struct regmap *regmap =3D data->regmap;
> > +     u8 fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(c=
hannel % NR_CHANNEL));
> > +
> > +     if (fan_config < 0)
> > +             return 0;
>
> fan_config needs to be int. Also, this is a poor way of handling
> this problem. Since fan_config does not change dynamically,
> this is one set of values that would make sense to keep cached
> locally.
>
> >
> >       switch (attr) {
> >       case hwmon_fan_input:
> > @@ -258,22 +283,29 @@ static umode_t max31790_fan_is_visible(const void=
 *_data, u32 attr, int channel)
> >  static int max31790_read_pwm(struct device *dev, u32 attr, int channel=
,
> >                            long *val)
> >  {
> > -     struct max31790_data *data =3D max31790_update_device(dev);
> > -     u8 fan_config;
> > +     struct max31790_data *data =3D dev_get_drvdata(dev);
> > +     struct regmap *regmap =3D data->regmap;
> > +     int read;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
>
> Now unnecessary.
>
> >
> > -     fan_config =3D data->fan_config[channel];
> > -
> >       switch (attr) {
> >       case hwmon_pwm_input:
> > -             *val =3D data->pwm[channel] >> 8;
> > +             read =3D read_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l));
> > +             if (read < 0)
> > +                     return read;
> > +
> > +             *val =3D read >> 8;
> >               return 0;
> >       case hwmon_pwm_enable:
> > -             if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
> > +             read =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(ch=
annel));
> > +             if (read < 0)
> > +                     return read;
> > +
> > +             if (read & MAX31790_FAN_CFG_RPM_MODE)
> >                       *val =3D 2;
> > -             else if (fan_config & MAX31790_FAN_CFG_TACH_INPUT_EN)
> > +             else if (read & MAX31790_FAN_CFG_TACH_INPUT_EN)
> >                       *val =3D 1;
> >               else
> >                       *val =3D 0;
> > @@ -287,25 +319,24 @@ static int max31790_write_pwm(struct device *dev,=
 u32 attr, int channel,
> >                             long val)
> >  {
> >       struct max31790_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > +     struct regmap *regmap =3D data->regmap;
> >       u8 fan_config;
> >       int err =3D 0;
> >
> > -     mutex_lock(&data->update_lock);
> > -
> >       switch (attr) {
> >       case hwmon_pwm_input:
> >               if (val < 0 || val > 255) {
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> > -             data->pwm[channel] =3D val << 8;
> > -             err =3D i2c_smbus_write_word_swapped(client,
> > -                                                MAX31790_REG_PWMOUT(ch=
annel),
> > -                                                data->pwm[channel]);
> > +             err =3D write_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l), val << 8);
> >               break;
> >       case hwmon_pwm_enable:
> > -             fan_config =3D data->fan_config[channel];
> > +             fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CON=
FIG(channel % NR_CHANNEL));
> > +
> > +             if (fan_config < 0)
> > +                     return fan_config;
> > +
> >               if (val =3D=3D 0) {
> >                       fan_config &=3D ~(MAX31790_FAN_CFG_TACH_INPUT_EN =
|
> >                                       MAX31790_FAN_CFG_RPM_MODE);
> > @@ -320,25 +351,26 @@ static int max31790_write_pwm(struct device *dev,=
 u32 attr, int channel,
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> > -             data->fan_config[channel] =3D fan_config;
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                                     MAX31790_REG_FAN_CONFIG(channel),
> > -                                     fan_config);
> > +             err =3D regmap_write(regmap,
> > +                                MAX31790_REG_FAN_CONFIG(channel),
> > +                                fan_config);
> >               break;
> >       default:
> >               err =3D -EOPNOTSUPP;
> >               break;
> >       }
> >
> > -     mutex_unlock(&data->update_lock);
> > -
> Are you sure this mutex is no longer needed here, ie that there
> can not be an interaction with multiple writes from multiple processes
> at the same time ?
>
> >       return err;
> >  }
> >
> >  static umode_t max31790_pwm_is_visible(const void *_data, u32 attr, in=
t channel)
> >  {
> >       const struct max31790_data *data =3D _data;
> > -     u8 fan_config =3D data->fan_config[channel];
> > +     struct regmap *regmap =3D data->regmap;
> > +     u8 fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(c=
hannel % NR_CHANNEL));
> > +
> > +     if (fan_config < 0)
> > +             return 0;
>
> int problem again.
>
> >
> >       switch (attr) {
> >       case hwmon_pwm_input:
> > @@ -426,35 +458,12 @@ static const struct hwmon_chip_info max31790_chip=
_info =3D {
> >       .info =3D max31790_info,
> >  };
> >
> > -static int max31790_init_client(struct i2c_client *client,
> > -                             struct max31790_data *data)
> > -{
> > -     int i, rv;
> > -
> > -     for (i =3D 0; i < NR_CHANNEL; i++) {
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_CONFIG(i));
> > -             if (rv < 0)
> > -                     return rv;
> > -             data->fan_config[i] =3D rv;
> > -
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_DYNAMICS(i));
> > -             if (rv < 0)
> > -                     return rv;
> > -             data->fan_dynamics[i] =3D rv;
>
> The above "cached" values are static, and it did make sense to keep those
> locally to avoid requiring unnecessary error handling (and to detect issu=
es
> with the chip early).
>
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static int max31790_probe(struct i2c_client *client)
> >  {
> >       struct i2c_adapter *adapter =3D client->adapter;
> >       struct device *dev =3D &client->dev;
> >       struct max31790_data *data;
> >       struct device *hwmon_dev;
> > -     int err;
> >
> >       if (!i2c_check_functionality(adapter,
> >                       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DA=
TA))
> > @@ -464,15 +473,12 @@ static int max31790_probe(struct i2c_client *clie=
nt)
> >       if (!data)
> >               return -ENOMEM;
> >
> > -     data->client =3D client;
> > -     mutex_init(&data->update_lock);
> > +     data->regmap =3D devm_regmap_init_i2c(client, &max31790_regmap_co=
nfig);
> >
> > -     /*
> > -      * Initialize the max31790 chip
> > -      */
> > -     err =3D max31790_init_client(client, data);
> > -     if (err)
> > -             return err;
> > +     if (IS_ERR(data->regmap)) {
> > +             dev_err(dev, "failed to allocate register map\n");
> > +             return PTR_ERR(data->regmap);
> > +     }
> >
> >       hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->n=
ame,
> >                                                        data,

=C3=BAt 30. 3. 2021 v 0:27 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.ne=
t> napsal:
>
> On Tue, Mar 16, 2021 at 06:54:58PM +0100, V=C3=A1clav Kubern=C3=A1t wrote=
:
> > Converting the driver to use regmap makes it more generic. It also make=
s
> > it a lot easier to debug through debugfs.
> >
> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
>
> Comments are in addition to comments from Dan and 0-day.
>
> > ---
> >  drivers/hwmon/Kconfig    |   1 +
> >  drivers/hwmon/max31790.c | 318 ++++++++++++++++++++-------------------
> >  2 files changed, 163 insertions(+), 156 deletions(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 54f04e61fb83..c2ec57672c4e 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1092,6 +1092,7 @@ config SENSORS_MAX6697
> >  config SENSORS_MAX31790
> >       tristate "Maxim MAX31790 sensor chip"
> >       depends on I2C
> > +     select REGMAP_I2C
> >       help
> >         If you say yes here you get support for 6-Channel PWM-Output
> >         Fan RPM Controller.
> > diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> > index 86e6c71db685..4e5add567890 100644
> > --- a/drivers/hwmon/max31790.c
> > +++ b/drivers/hwmon/max31790.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/init.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/module.h>
> > +#include <linux/regmap.h>
> >  #include <linux/slab.h>
> >
> >  /* MAX31790 registers */
> > @@ -46,92 +47,49 @@
> >
> >  #define NR_CHANNEL                   6
> >
> > +#define MAX31790_REG_USER_BYTE_67    0x67
> > +
> > +#define BULK_TO_U16(msb, lsb)                (((msb) << 8) + (lsb))
> > +#define U16_MSB(num)                 (((num) & 0xFF00) >> 8)
> > +#define U16_LSB(num)                 ((num) & 0x00FF)
> > +
> > +static const struct regmap_range max31790_ro_range =3D {
> > +     .range_min =3D MAX31790_REG_TACH_COUNT(0),
> > +     .range_max =3D MAX31790_REG_PWMOUT(0) - 1,
> > +};
> > +
> > +static const struct regmap_access_table max31790_wr_table =3D {
> > +     .no_ranges =3D &max31790_ro_range,
> > +     .n_no_ranges =3D 1,
> > +};
> > +
> > +static const struct regmap_range max31790_volatile_ranges[] =3D {
> > +     regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_CO=
UNT(12)),
> > +     regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN=
_FAULT_STATUS1),
> > +};
> > +
> > +static const struct regmap_access_table max31790_volatile_table =3D {
> > +     .no_ranges =3D max31790_volatile_ranges,
> > +     .n_no_ranges =3D 2,
> > +     .n_yes_ranges =3D 0
> > +};
> > +
> > +static const struct regmap_config max31790_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .reg_stride =3D 1,
> > +     .max_register =3D MAX31790_REG_USER_BYTE_67,
> > +     .wr_table =3D &max31790_wr_table,
> > +     .volatile_table =3D &max31790_volatile_table
> > +};
> > +
> >  /*
> >   * Client data (each client gets its own)
> >   */
> >  struct max31790_data {
> > -     struct i2c_client *client;
> > -     struct mutex update_lock;
> > -     bool valid; /* zero until following fields are valid */
> > -     unsigned long last_updated; /* in jiffies */
> > -
> > -     /* register values */
> > -     u8 fan_config[NR_CHANNEL];
> > -     u8 fan_dynamics[NR_CHANNEL];
> > -     u16 fault_status;
> > -     u16 tach[NR_CHANNEL * 2];
> > -     u16 pwm[NR_CHANNEL];
> > -     u16 target_count[NR_CHANNEL];
> > +     struct regmap *regmap;
> >  };
> >
> > -static struct max31790_data *max31790_update_device(struct device *dev=
)
> > -{
> > -     struct max31790_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > -     struct max31790_data *ret =3D data;
> > -     int i;
> > -     int rv;
> > -
> > -     mutex_lock(&data->update_lock);
> > -
> > -     if (time_after(jiffies, data->last_updated + HZ) || !data->valid)=
 {
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_FAULT_STATUS1);
> > -             if (rv < 0)
> > -                     goto abort;
> > -             data->fault_status =3D rv & 0x3F;
> > -
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_FAULT_STATUS2);
> > -             if (rv < 0)
> > -                     goto abort;
> > -             data->fault_status |=3D (rv & 0x3F) << 6;
> > -
> > -             for (i =3D 0; i < NR_CHANNEL; i++) {
> > -                     rv =3D i2c_smbus_read_word_swapped(client,
> > -                                     MAX31790_REG_TACH_COUNT(i));
> > -                     if (rv < 0)
> > -                             goto abort;
> > -                     data->tach[i] =3D rv;
> > -
> > -                     if (data->fan_config[i]
> > -                         & MAX31790_FAN_CFG_TACH_INPUT) {
> > -                             rv =3D i2c_smbus_read_word_swapped(client=
,
> > -                                     MAX31790_REG_TACH_COUNT(NR_CHANNE=
L
> > -                                                             + i));
> > -                             if (rv < 0)
> > -                                     goto abort;
> > -                             data->tach[NR_CHANNEL + i] =3D rv;
> > -                     } else {
> > -                             rv =3D i2c_smbus_read_word_swapped(client=
,
> > -                                             MAX31790_REG_PWMOUT(i));
> > -                             if (rv < 0)
> > -                                     goto abort;
> > -                             data->pwm[i] =3D rv;
> > -
> > -                             rv =3D i2c_smbus_read_word_swapped(client=
,
> > -                                             MAX31790_REG_TARGET_COUNT=
(i));
> > -                             if (rv < 0)
> > -                                     goto abort;
> > -                             data->target_count[i] =3D rv;
> > -                     }
> > -             }
> > -
> > -             data->last_updated =3D jiffies;
> > -             data->valid =3D true;
> > -     }
> > -     goto done;
> > -
> > -abort:
> > -     data->valid =3D false;
> > -     ret =3D ERR_PTR(rv);
> > -
> > -done:
> > -     mutex_unlock(&data->update_lock);
> > -
> > -     return ret;
> > -}
> > -
> >  static const u8 tach_period[8] =3D { 1, 2, 4, 8, 16, 32, 32, 32 };
> >
> >  static u8 get_tach_period(u8 fan_dynamics)
> > @@ -159,28 +117,89 @@ static u8 bits_for_tach_period(int rpm)
> >       return bits;
> >  }
> >
> > +static int read_reg_byte(struct regmap *regmap, u8 reg)
> > +{
> > +     int rv;
> > +     int val;
> > +
> > +     rv =3D regmap_read(regmap, reg, &val);
> > +
>
> lease no empty line between assignment and check.
>
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     return val;
> > +}
> > +
> > +static int read_reg_word(struct regmap *regmap, u8 reg)
> > +{
> > +     int rv;
> > +     u8 val_bulk[2];
> > +
> > +     rv =3D regmap_bulk_read(regmap, reg, val_bulk, 2);
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     return BULK_TO_U16(val_bulk[0], val_bulk[1]);
> > +}
> > +
> > +static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
> > +{
> > +     u8 bulk_val[2];
> > +
> > +     bulk_val[0] =3D U16_MSB(val);
> > +     bulk_val[1] =3D U16_LSB(val);
> > +
> > +     return regmap_bulk_write(regmap, reg, bulk_val, 2);
> > +}
> > +
> >  static int max31790_read_fan(struct device *dev, u32 attr, int channel=
,
> >                            long *val)
> >  {
> > -     struct max31790_data *data =3D max31790_update_device(dev);
> > -     int sr, rpm;
> > +     struct max31790_data *data =3D dev_get_drvdata(dev);
> > +     struct regmap *regmap =3D data->regmap;
> > +     int rpm, dynamics, tach, fault;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
>
> Now unnecessary.
>
> >
> >       switch (attr) {
> >       case hwmon_fan_input:
> > -             sr =3D get_tach_period(data->fan_dynamics[channel]);
> > -             rpm =3D RPM_FROM_REG(data->tach[channel], sr);
> > +             dynamics =3D read_reg_byte(regmap, MAX31790_REG_FAN_DYNAM=
ICS(channel));
> > +             if (dynamics < 0)
> > +                     return dynamics;
> > +
> > +             tach =3D read_reg_word(regmap, MAX31790_REG_TACH_COUNT(ch=
annel));
> > +             if (tach < 0)
> > +                     return tach;
> > +
> > +             rpm =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
> >               *val =3D rpm;
>
>                 *val =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
>
> >               return 0;
> >       case hwmon_fan_target:
> > -             sr =3D get_tach_period(data->fan_dynamics[channel]);
> > -             rpm =3D RPM_FROM_REG(data->target_count[channel], sr);
> > +             dynamics =3D read_reg_byte(regmap, MAX31790_REG_FAN_DYNAM=
ICS(channel));
> > +             if (dynamics < 0)
> > +                     return dynamics;
> > +
> > +             tach =3D read_reg_word(regmap, MAX31790_REG_TARGET_COUNT(=
channel));
> > +             if (tach < 0)
> > +                     return tach;
> > +
> > +             rpm =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
> >               *val =3D rpm;
>
>                 *val =3D RPM_FROM_REG(tach, get_tach_period(dynamics));
>
> >               return 0;
> >       case hwmon_fan_fault:
> > -             *val =3D !!(data->fault_status & (1 << channel));
> > +             if (channel > 6)
> > +                     fault =3D read_reg_byte(regmap, MAX31790_REG_FAN_=
FAULT_STATUS2);
> > +             else
> > +                     fault =3D read_reg_byte(regmap, MAX31790_REG_FAN_=
FAULT_STATUS1);
> > +
> > +             if (fault < 0)
> > +                     return fault;
> > +
> > +             if (channel > 6)
> > +                     *val =3D !!(fault & (1 << (channel - 6)));
> > +             else
> > +                     *val =3D !!(fault & (1 << channel));
> >               return 0;
> >       default:
> >               return -EOPNOTSUPP;
> > @@ -191,52 +210,58 @@ static int max31790_write_fan(struct device *dev,=
 u32 attr, int channel,
> >                             long val)
> >  {
> >       struct max31790_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > +     struct regmap *regmap =3D data->regmap;
> >       int target_count;
> >       int err =3D 0;
> >       u8 bits;
> >       int sr;
> > -
> > -     mutex_lock(&data->update_lock);
> > +     int fan_dynamics;
> >
> >       switch (attr) {
> >       case hwmon_fan_target:
> >               val =3D clamp_val(val, FAN_RPM_MIN, FAN_RPM_MAX);
> >               bits =3D bits_for_tach_period(val);
> > -             data->fan_dynamics[channel] =3D
> > -                     ((data->fan_dynamics[channel] &
> > +             fan_dynamics =3D read_reg_byte(regmap, MAX31790_REG_FAN_D=
YNAMICS(channel));
> > +
> Unnecessary empty line.
>
> > +             if (fan_dynamics < 0)
> > +                     return fan_dynamics;
> > +
> > +             fan_dynamics =3D
> > +                     ((fan_dynamics &
> >                         ~MAX31790_FAN_DYN_SR_MASK) |
> >                        (bits << MAX31790_FAN_DYN_SR_SHIFT));
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                                     MAX31790_REG_FAN_DYNAMICS(channel=
),
> > -                                     data->fan_dynamics[channel]);
> > +             err =3D regmap_write(regmap,
> > +                                MAX31790_REG_FAN_DYNAMICS(channel),
> > +                                fan_dynamics);
> >               if (err < 0)
> >                       break;
> >
> > -             sr =3D get_tach_period(data->fan_dynamics[channel]);
> > +             sr =3D get_tach_period(fan_dynamics);
> >               target_count =3D RPM_TO_REG(val, sr);
> >               target_count =3D clamp_val(target_count, 0x1, 0x7FF);
> >
> > -             data->target_count[channel] =3D target_count << 5;
> > +             target_count =3D target_count << 5;
> >
> > -             err =3D i2c_smbus_write_word_swapped(client,
> > -                                     MAX31790_REG_TARGET_COUNT(channel=
),
> > -                                     data->target_count[channel]);
> > +             err =3D write_reg_word(regmap,
> > +                                  MAX31790_REG_TARGET_COUNT(channel),
> > +                                  target_count);
> >               break;
> >       default:
> >               err =3D -EOPNOTSUPP;
> >               break;
> >       }
> >
> > -     mutex_unlock(&data->update_lock);
> > -
> Why is this lock no longer required ? There are still multiple writes
> when writing hwmon_fan_target.
>
> >       return err;
> >  }
> >
> >  static umode_t max31790_fan_is_visible(const void *_data, u32 attr, in=
t channel)
> >  {
> >       const struct max31790_data *data =3D _data;
> > -     u8 fan_config =3D data->fan_config[channel % NR_CHANNEL];
> > +     struct regmap *regmap =3D data->regmap;
> > +     u8 fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(c=
hannel % NR_CHANNEL));
> > +
> > +     if (fan_config < 0)
> > +             return 0;
>
> fan_config needs to be int. Also, this is a poor way of handling
> this problem. Since fan_config does not change dynamically,
> this is one set of values that would make sense to keep cached
> locally.
>
> >
> >       switch (attr) {
> >       case hwmon_fan_input:
> > @@ -258,22 +283,29 @@ static umode_t max31790_fan_is_visible(const void=
 *_data, u32 attr, int channel)
> >  static int max31790_read_pwm(struct device *dev, u32 attr, int channel=
,
> >                            long *val)
> >  {
> > -     struct max31790_data *data =3D max31790_update_device(dev);
> > -     u8 fan_config;
> > +     struct max31790_data *data =3D dev_get_drvdata(dev);
> > +     struct regmap *regmap =3D data->regmap;
> > +     int read;
> >
> >       if (IS_ERR(data))
> >               return PTR_ERR(data);
>
> Now unnecessary.
>
> >
> > -     fan_config =3D data->fan_config[channel];
> > -
> >       switch (attr) {
> >       case hwmon_pwm_input:
> > -             *val =3D data->pwm[channel] >> 8;
> > +             read =3D read_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l));
> > +             if (read < 0)
> > +                     return read;
> > +
> > +             *val =3D read >> 8;
> >               return 0;
> >       case hwmon_pwm_enable:
> > -             if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
> > +             read =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(ch=
annel));
> > +             if (read < 0)
> > +                     return read;
> > +
> > +             if (read & MAX31790_FAN_CFG_RPM_MODE)
> >                       *val =3D 2;
> > -             else if (fan_config & MAX31790_FAN_CFG_TACH_INPUT_EN)
> > +             else if (read & MAX31790_FAN_CFG_TACH_INPUT_EN)
> >                       *val =3D 1;
> >               else
> >                       *val =3D 0;
> > @@ -287,25 +319,24 @@ static int max31790_write_pwm(struct device *dev,=
 u32 attr, int channel,
> >                             long val)
> >  {
> >       struct max31790_data *data =3D dev_get_drvdata(dev);
> > -     struct i2c_client *client =3D data->client;
> > +     struct regmap *regmap =3D data->regmap;
> >       u8 fan_config;
> >       int err =3D 0;
> >
> > -     mutex_lock(&data->update_lock);
> > -
> >       switch (attr) {
> >       case hwmon_pwm_input:
> >               if (val < 0 || val > 255) {
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> > -             data->pwm[channel] =3D val << 8;
> > -             err =3D i2c_smbus_write_word_swapped(client,
> > -                                                MAX31790_REG_PWMOUT(ch=
annel),
> > -                                                data->pwm[channel]);
> > +             err =3D write_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l), val << 8);
> >               break;
> >       case hwmon_pwm_enable:
> > -             fan_config =3D data->fan_config[channel];
> > +             fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CON=
FIG(channel % NR_CHANNEL));
> > +
> > +             if (fan_config < 0)
> > +                     return fan_config;
> > +
> >               if (val =3D=3D 0) {
> >                       fan_config &=3D ~(MAX31790_FAN_CFG_TACH_INPUT_EN =
|
> >                                       MAX31790_FAN_CFG_RPM_MODE);
> > @@ -320,25 +351,26 @@ static int max31790_write_pwm(struct device *dev,=
 u32 attr, int channel,
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> > -             data->fan_config[channel] =3D fan_config;
> > -             err =3D i2c_smbus_write_byte_data(client,
> > -                                     MAX31790_REG_FAN_CONFIG(channel),
> > -                                     fan_config);
> > +             err =3D regmap_write(regmap,
> > +                                MAX31790_REG_FAN_CONFIG(channel),
> > +                                fan_config);
> >               break;
> >       default:
> >               err =3D -EOPNOTSUPP;
> >               break;
> >       }
> >
> > -     mutex_unlock(&data->update_lock);
> > -
> Are you sure this mutex is no longer needed here, ie that there
> can not be an interaction with multiple writes from multiple processes
> at the same time ?
>
> >       return err;
> >  }
> >
> >  static umode_t max31790_pwm_is_visible(const void *_data, u32 attr, in=
t channel)
> >  {
> >       const struct max31790_data *data =3D _data;
> > -     u8 fan_config =3D data->fan_config[channel];
> > +     struct regmap *regmap =3D data->regmap;
> > +     u8 fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(c=
hannel % NR_CHANNEL));
> > +
> > +     if (fan_config < 0)
> > +             return 0;
>
> int problem again.
>
> >
> >       switch (attr) {
> >       case hwmon_pwm_input:
> > @@ -426,35 +458,12 @@ static const struct hwmon_chip_info max31790_chip=
_info =3D {
> >       .info =3D max31790_info,
> >  };
> >
> > -static int max31790_init_client(struct i2c_client *client,
> > -                             struct max31790_data *data)
> > -{
> > -     int i, rv;
> > -
> > -     for (i =3D 0; i < NR_CHANNEL; i++) {
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_CONFIG(i));
> > -             if (rv < 0)
> > -                     return rv;
> > -             data->fan_config[i] =3D rv;
> > -
> > -             rv =3D i2c_smbus_read_byte_data(client,
> > -                             MAX31790_REG_FAN_DYNAMICS(i));
> > -             if (rv < 0)
> > -                     return rv;
> > -             data->fan_dynamics[i] =3D rv;
>
> The above "cached" values are static, and it did make sense to keep those
> locally to avoid requiring unnecessary error handling (and to detect issu=
es
> with the chip early).
>
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static int max31790_probe(struct i2c_client *client)
> >  {
> >       struct i2c_adapter *adapter =3D client->adapter;
> >       struct device *dev =3D &client->dev;
> >       struct max31790_data *data;
> >       struct device *hwmon_dev;
> > -     int err;
> >
> >       if (!i2c_check_functionality(adapter,
> >                       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DA=
TA))
> > @@ -464,15 +473,12 @@ static int max31790_probe(struct i2c_client *clie=
nt)
> >       if (!data)
> >               return -ENOMEM;
> >
> > -     data->client =3D client;
> > -     mutex_init(&data->update_lock);
> > +     data->regmap =3D devm_regmap_init_i2c(client, &max31790_regmap_co=
nfig);
> >
> > -     /*
> > -      * Initialize the max31790 chip
> > -      */
> > -     err =3D max31790_init_client(client, data);
> > -     if (err)
> > -             return err;
> > +     if (IS_ERR(data->regmap)) {
> > +             dev_err(dev, "failed to allocate register map\n");
> > +             return PTR_ERR(data->regmap);
> > +     }
> >
> >       hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->n=
ame,
> >                                                        data,
