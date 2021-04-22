Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD336763A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbhDVA1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhDVA1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:27:47 -0400
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1AEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:27:13 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 6B23340006F;
        Thu, 22 Apr 2021 02:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1619051225;
        bh=ZmF/r7mYwFTsWsCMUMfIsxKemaYlZAyFFv9421eoI+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=Qf63FRJEd+45MArzuqnBvcZ2xLxqUjGyxYaaqZvj4fZK4oAaUdHshp/4L1OFR5TlT
         Pr2xGthNNfe0m58SW/5TRFY0kS6KisOSSIGqBz27aDsp7QULx9MMwnqgI3xVtXFiqe
         DHsmG+BVzDiAlMXxcPsXF6qpE22BHzNTKjzy7N/cIPkB33KJtDJSSyT9ye//2kx5VM
         bh5xCpNPksafF0hMB/T/0tQsp/CLgFFnr2APU9kZjnv64s33UVULys/9qnAnG+a8gP
         +X3dLBhom1KrO+ThJtpXKczkcdpAKkfMuphkJ8r8DfDqFs6y0LXJ0rrFHup07mUjOe
         avTg4g3YKBe5w==
Received: by mail-pg1-f173.google.com with SMTP id t22so122481pgu.0;
        Wed, 21 Apr 2021 17:27:05 -0700 (PDT)
X-Gm-Message-State: AOAM532fI1j8WS8Ak++V6LCdyCwhneMVQYUabFIakVdZWh1ihAAcU99x
        IRVAi+caNPXcCsBVWT1qcVflv0HnPTPqESLBxIc=
X-Google-Smtp-Source: ABdhPJwDNNv4fs6YxJ2aMiKZ54+ieTK7Jeq7DTklONqdhvM6fxzirb+eKm8PBOorvYemcfRve7vV3xNq8clmFiQRh1U=
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr769382pgb.110.1619051223705;
 Wed, 21 Apr 2021 17:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210413025948.901867-1-kubernat@cesnet.cz> <20210413025948.901867-2-kubernat@cesnet.cz>
 <20210419223340.GA229491@roeck-us.net>
In-Reply-To: <20210419223340.GA229491@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Thu, 22 Apr 2021 02:26:52 +0200
X-Gmail-Original-Message-ID: <CABKa3no1k3uJ4dMgg16+FE+qb=Rbg-r_F3fV=P-OE8mBa30QAQ@mail.gmail.com>
Message-ID: <CABKa3no1k3uJ4dMgg16+FE+qb=Rbg-r_F3fV=P-OE8mBa30QAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] hwmon: (max31790) Fix and split pwm*_enable
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, no problem, I'll get rid of the full-speed mode (and update the
documentation) in the next version of the patch. Do you think I should
disable the value "0" in pwm*_enable?

V=C3=A1clav

=C3=BAt 20. 4. 2021 v 0:33 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.ne=
t> napsal:
>
> On Tue, Apr 13, 2021 at 04:59:45AM +0200, V=C3=A1clav Kubern=C3=A1t wrote=
:
> > In the old code, pwm*_enable does two things. Firstly, it sets whether
> > the chip should run in PWM or RPM mode. Secondly, it tells the chip
> > whether it should monitor fan RPM. However, these two settings aren't
> > tied together, so they shouldn't be set with a single value. In the new
> > code, fan*_enable now controls fan RPM monitoring (pwm*_enable no longe=
r
> > controls that).
> >
> > According to the sysfs hwmon documentation, pwm*_enable has three
> > possible values, 0 for "no control / full-speed", 1 for manual mode, an=
d
> > 2+ for automatic. The old code works fine for 1 and 2, but 0 only
> > differs from 1 in that it just turns off fan speed monitoring. The chip
> > actually does have a way to turn off fan controls (and only monitor),
> > but what that does is that it sets PWM to 0% duty cycle (which is the
> > opposite to full-speed) AND it also turns off fan speed monitoring.
> > Because of this, I implemented the 0 value by setting PWM mode to 100%.
> > This method does come with a problem: it is impossible to differentiate
> > between full-speed and PWM mode just from the values on the chip. The
> > new code solves this by saving a value indicating whether we're in
> > full-speed mode. This value is initialized to 0, so full-speed mode
> > won't persist across reboots.
> >
> I don't think this is a good idea, sorry. It is not just a problem across
> reboots, but also when unloading and reloading the driver. I think we
> should stick with chip capabilities and adjust the documentation
> accordingly.
>
> Guenter
>
> > These two changes are closely connected together, mainly because the
> > detection of the pwm*_enable value depended on whether fan speed
> > monitoring is enabled (which is now controlled as written in the first
> > paragraph).
> >
> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> > ---
> >  Documentation/hwmon/max31790.rst |  8 +--
> >  drivers/hwmon/max31790.c         | 87 ++++++++++++++++++++++----------
> >  2 files changed, 66 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max=
31790.rst
> > index f301385d8cef..8979c8a02cd1 100644
> > --- a/Documentation/hwmon/max31790.rst
> > +++ b/Documentation/hwmon/max31790.rst
> > @@ -34,10 +34,12 @@ also be configured to serve as tachometer inputs.
> >  Sysfs entries
> >  -------------
> >
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +fan[1-12]_enable   RW  enable fan speed monitoring
> >  fan[1-12]_input    RO  fan tachometer speed in RPM
> >  fan[1-12]_fault    RO  fan experienced fault
> >  fan[1-6]_target    RW  desired fan speed in RPM
> > -pwm[1-6]_enable    RW  regulator mode, 0=3Ddisabled, 1=3Dmanual mode, =
2=3Drpm mode
> > +pwm[1-6]_enable    RW  regulator mode, 0=3Dfull speed, 1=3Dmanual (pwm=
) mode, 2=3Drpm mode
> > +                       setting rpm mode sets fan*_enable to 1
> >  pwm[1-6]           RW  fan target duty cycle (0-255)
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> > index e3765ce4444a..ecdd55e12ffe 100644
> > --- a/drivers/hwmon/max31790.c
> > +++ b/drivers/hwmon/max31790.c
> > @@ -39,6 +39,7 @@
> >
> >  #define FAN_RPM_MIN                  120
> >  #define FAN_RPM_MAX                  7864320
> > +#define MAX_PWM                              0XFF80
> >
> >  #define RPM_FROM_REG(reg, sr)                (((reg) >> 4) ? \
> >                                        ((60 * (sr) * 8192) / ((reg) >> =
4)) : \
> > @@ -90,6 +91,7 @@ struct max31790_data {
> >       struct regmap *regmap;
> >
> >       struct mutex update_lock;
> > +     bool full_speed[NR_CHANNEL];
> >       u8 fan_config[NR_CHANNEL];
> >       u8 fan_dynamics[NR_CHANNEL];
> >  };
> > @@ -191,6 +193,9 @@ static int max31790_read_fan(struct device *dev, u3=
2 attr, int channel,
> >               else
> >                       *val =3D !!(fault & (1 << channel));
> >               return 0;
> > +     case hwmon_fan_enable:
> > +             *val =3D !!(data->fan_config[channel] & MAX31790_FAN_CFG_=
TACH_INPUT_EN);
> > +             return 0;
> >       default:
> >               return -EOPNOTSUPP;
> >       }
> > @@ -233,6 +238,15 @@ static int max31790_write_fan(struct device *dev, =
u32 attr, int channel,
> >                                    MAX31790_REG_TARGET_COUNT(channel),
> >                                    target_count);
> >               break;
> > +     case hwmon_fan_enable:
> > +             if (val =3D=3D 0)
> > +                     data->fan_config[channel] &=3D ~MAX31790_FAN_CFG_=
TACH_INPUT_EN;
> > +             else
> > +                     data->fan_config[channel] |=3D MAX31790_FAN_CFG_T=
ACH_INPUT_EN;
> > +             err =3D regmap_write(regmap,
> > +                                MAX31790_REG_FAN_CONFIG(channel),
> > +                                data->fan_config[channel]);
> > +             break;
> >       default:
> >               err =3D -EOPNOTSUPP;
> >               break;
> > @@ -260,6 +274,11 @@ static umode_t max31790_fan_is_visible(const void =
*_data, u32 attr, int channel)
> >                   !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> >                       return 0644;
> >               return 0;
> > +     case hwmon_fan_enable:
> > +             if (channel < NR_CHANNEL ||
> > +                 (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> > +                     return 0644;
> > +             return 0;
> >       default:
> >               return 0;
> >       }
> > @@ -281,12 +300,12 @@ static int max31790_read_pwm(struct device *dev, =
u32 attr, int channel,
> >               *val =3D read >> 8;
> >               return 0;
> >       case hwmon_pwm_enable:
> > -             if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE=
)
> > +             if (data->full_speed[channel])
> > +                     *val =3D 0;
> > +             else if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM=
_MODE)
> >                       *val =3D 2;
> > -             else if (data->fan_config[channel] & MAX31790_FAN_CFG_TAC=
H_INPUT_EN)
> > +             else
> >                       *val =3D 1;
> > -             else
> > -                     *val =3D 0;
> >               return 0;
> >       default:
> >               return -EOPNOTSUPP;
> > @@ -305,28 +324,42 @@ static int max31790_write_pwm(struct device *dev,=
 u32 attr, int channel,
> >
> >       switch (attr) {
> >       case hwmon_pwm_input:
> > -             if (val < 0 || val > 255) {
> > +             if (data->full_speed[channel] || val < 0 || val > 255) {
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> > +
> >               err =3D write_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l), val << 8);
> >               break;
> >       case hwmon_pwm_enable:
> >               fan_config =3D data->fan_config[channel];
> > -             if (val =3D=3D 0) {
> > -                     fan_config &=3D ~(MAX31790_FAN_CFG_TACH_INPUT_EN =
|
> > -                                     MAX31790_FAN_CFG_RPM_MODE);
> > -             } else if (val =3D=3D 1) {
> > -                     fan_config =3D (fan_config |
> > -                                   MAX31790_FAN_CFG_TACH_INPUT_EN) &
> > -                                  ~MAX31790_FAN_CFG_RPM_MODE;
> > +             if (val =3D=3D 0 || val =3D=3D 1) {
> > +                     fan_config &=3D ~MAX31790_FAN_CFG_RPM_MODE;
> >               } else if (val =3D=3D 2) {
> > -                     fan_config |=3D MAX31790_FAN_CFG_TACH_INPUT_EN |
> > -                                   MAX31790_FAN_CFG_RPM_MODE;
> > +                     fan_config |=3D MAX31790_FAN_CFG_RPM_MODE;
> >               } else {
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> > +
> > +             /*
> > +              * The chip sets PWM to zero when using its "monitor only=
" mode
> > +              * and 0 means full speed.
> > +              */
> > +             if (val =3D=3D 0) {
> > +                     data->full_speed[channel] =3D true;
> > +                     err =3D write_reg_word(regmap, MAX31790_REG_PWMOU=
T(channel), MAX_PWM);
> > +             } else {
> > +                     data->full_speed[channel] =3D false;
> > +             }
> > +
> > +             /*
> > +              * RPM mode implies enabled TACH input, so enable it in R=
PM
> > +              * mode.
> > +              */
> > +             if (val =3D=3D 2)
> > +                     fan_config |=3D MAX31790_FAN_CFG_TACH_INPUT_EN;
> > +
> >               data->fan_config[channel] =3D fan_config;
> >               err =3D regmap_write(regmap,
> >                                  MAX31790_REG_FAN_CONFIG(channel),
> > @@ -400,18 +433,18 @@ static umode_t max31790_is_visible(const void *da=
ta,
> >
> >  static const struct hwmon_channel_info *max31790_info[] =3D {
> >       HWMON_CHANNEL_INFO(fan,
> > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> > -                        HWMON_F_INPUT | HWMON_F_FAULT,
> > -                        HWMON_F_INPUT | HWMON_F_FAULT,
> > -                        HWMON_F_INPUT | HWMON_F_FAULT,
> > -                        HWMON_F_INPUT | HWMON_F_FAULT,
> > -                        HWMON_F_INPUT | HWMON_F_FAULT,
> > -                        HWMON_F_INPUT | HWMON_F_FAULT),
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> > +                        HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
),
> >       HWMON_CHANNEL_INFO(pwm,
> >                          HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> >                          HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> > @@ -448,6 +481,8 @@ static int max31790_init_client(struct regmap *regm=
ap,
> >               if (rv < 0)
> >                       return rv;
> >               data->fan_dynamics[i] =3D rv;
> > +
> > +             data->full_speed[i] =3D false;
> >       }
> >
> >       return 0;
