Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2106B37B391
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhELBeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:34:07 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:52914 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:33:58 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 63AB840006D;
        Wed, 12 May 2021 03:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1620783169;
        bh=w189rxaxl4GMoBpdnK0cz61dSo3IEnt3oBnjZejbp0Y=;
        h=References:In-Reply-To:From:Date:Subject:To;
        b=OBwzECTGZnO0W8dupKHQEpGXq93y74+CwBbV5jNZDGuo1ZsoZ7mvNIHH7DYJRnsVy
         UpskvqOzo3m7DilRGkJcMxh4RNuo5L3KHPH43xgRUrSOPloTMZ/qg3+U3T3OBFcoaO
         nuS3WUZ/5lCRiGD7dzPksFXnsLsmMyBrvLTRiTNLm+2ajmKZcSvoKrI5R//kWNo/vY
         4ThTBR/YCcrzellBsv3BaFTs0iRvVHTNI7wxec2U3/n9l22eOJ8U/znpwZgrpwAd1G
         51fRTyesxJEOncUnjdv+xFOLCRwwJjcFDveNLESADqetU5hl+8UCYxdOOojzGVZmpc
         HA5fB7k0EUb3g==
Received: by mail-pl1-f174.google.com with SMTP id z18so8116771plg.8;
        Tue, 11 May 2021 18:32:49 -0700 (PDT)
X-Gm-Message-State: AOAM5324jf6yH+H5ZYxfwP/HdqWLRpJ2HztO8/8UJdMYELx1eqIQF46a
        ivZ8SScxT/mzxbAVyl0MUMEtvNz6pxkSf9iMDGU=
X-Google-Smtp-Source: ABdhPJzzZkzAI/4EPDLK4HMhoAI6OrY06rFrdrHlDR6tKL+eDWa3QZlXMfOUcLqoD6WBd13rd61w94O77W++gbTEZiw=
X-Received: by 2002:a17:902:b408:b029:ec:e879:bbd8 with SMTP id
 x8-20020a170902b408b02900ece879bbd8mr33058518plr.65.1620783167785; Tue, 11
 May 2021 18:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013052.903297-1-kubernat@cesnet.cz> <20210512013052.903297-2-kubernat@cesnet.cz>
In-Reply-To: <20210512013052.903297-2-kubernat@cesnet.cz>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Wed, 12 May 2021 03:32:36 +0200
X-Gmail-Original-Message-ID: <CABKa3noSQVtAp3Ath9=PNh2cDLgq8n8w2gudwWJerD5YQx5WMA@mail.gmail.com>
Message-ID: <CABKa3noSQVtAp3Ath9=PNh2cDLgq8n8w2gudwWJerD5YQx5WMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have updated the code and got rid of the "fullspeed" mode as
requested. Let me know what you think.

Thanks
V=C3=A1clav

st 12. 5. 2021 v 3:31 odes=C3=ADlatel V=C3=A1clav Kubern=C3=A1t <kubernat@c=
esnet.cz> napsal:
>
> In the old code, pwm*_enable does two things. Firstly, it sets whether
> the chip should run in PWM or RPM mode. Secondly, it tells the chip
> whether it should monitor fan RPM. However, these two settings aren't
> tied together, so they shouldn't be set with a single value. In the new
> code, fan*_enable now controls fan RPM monitoring (pwm*_enable no longer
> controls that).
>
> According to the sysfs hwmon documentation, pwm*_enable has three
> possible values, 0 for "no control / full-speed", 1 for manual mode, and
> 2+ for automatic. The old code works fine for 1 and 2, but 0 only
> differs from 1 in that it just turns off fan speed monitoring. The chip
> actually does have a way to turn off fan controls (and only monitor),
> and what that does is that it sets PWM to 0% duty cycle. In the new
> code, 0 in pwm*_enable turns off the "control" feature of the chip.
>
> These two changes are closely connected together, mainly because the
> detection of the pwm*_enable value depended on whether fan speed
> monitoring is enabled (which is now controlled as written in the first
> paragraph).
>
> Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> ---
>  Documentation/hwmon/max31790.rst | 10 ++--
>  drivers/hwmon/max31790.c         | 78 +++++++++++++++++++++-----------
>  2 files changed, 58 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31=
790.rst
> index f301385d8cef..d2ac4e926905 100644
> --- a/Documentation/hwmon/max31790.rst
> +++ b/Documentation/hwmon/max31790.rst
> @@ -34,10 +34,14 @@ also be configured to serve as tachometer inputs.
>  Sysfs entries
>  -------------
>
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +fan[1-12]_enable   RW  enable fan speed monitoring
>  fan[1-12]_input    RO  fan tachometer speed in RPM
>  fan[1-12]_fault    RO  fan experienced fault
>  fan[1-6]_target    RW  desired fan speed in RPM
> -pwm[1-6]_enable    RW  regulator mode, 0=3Ddisabled, 1=3Dmanual mode, 2=
=3Drpm mode
> +pwm[1-6]_enable    RW  regulator mode, 0=3Dno control, sets 0% PWM,
> +                                      1=3Dmanual (pwm) mode,
> +                                      2=3Drpm mode
> +                       setting rpm mode sets fan*_enable to 1
>  pwm[1-6]           RW  fan target duty cycle (0-255)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index e3765ce4444a..5d4c551df010 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -30,6 +30,7 @@
>  #define MAX31790_FAN_CFG_RPM_MODE      0x80
>  #define MAX31790_FAN_CFG_TACH_INPUT_EN 0x08
>  #define MAX31790_FAN_CFG_TACH_INPUT    0x01
> +#define MAX31790_FAN_CFG_CTRL_MON      0x10
>
>  /* Fan Dynamics register bits */
>  #define MAX31790_FAN_DYN_SR_SHIFT      5
> @@ -191,6 +192,9 @@ static int max31790_read_fan(struct device *dev, u32 =
attr, int channel,
>                 else
>                         *val =3D !!(fault & (1 << channel));
>                 return 0;
> +       case hwmon_fan_enable:
> +               *val =3D !!(data->fan_config[channel] & MAX31790_FAN_CFG_=
TACH_INPUT_EN);
> +               return 0;
>         default:
>                 return -EOPNOTSUPP;
>         }
> @@ -233,6 +237,15 @@ static int max31790_write_fan(struct device *dev, u3=
2 attr, int channel,
>                                      MAX31790_REG_TARGET_COUNT(channel),
>                                      target_count);
>                 break;
> +       case hwmon_fan_enable:
> +               if (val =3D=3D 0)
> +                       data->fan_config[channel] &=3D ~MAX31790_FAN_CFG_=
TACH_INPUT_EN;
> +               else
> +                       data->fan_config[channel] |=3D MAX31790_FAN_CFG_T=
ACH_INPUT_EN;
> +               err =3D regmap_write(regmap,
> +                                  MAX31790_REG_FAN_CONFIG(channel),
> +                                  data->fan_config[channel]);
> +               break;
>         default:
>                 err =3D -EOPNOTSUPP;
>                 break;
> @@ -260,6 +273,11 @@ static umode_t max31790_fan_is_visible(const void *_=
data, u32 attr, int channel)
>                     !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
>                         return 0644;
>                 return 0;
> +       case hwmon_fan_enable:
> +               if (channel < NR_CHANNEL ||
> +                   (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> +                       return 0644;
> +               return 0;
>         default:
>                 return 0;
>         }
> @@ -281,12 +299,12 @@ static int max31790_read_pwm(struct device *dev, u3=
2 attr, int channel,
>                 *val =3D read >> 8;
>                 return 0;
>         case hwmon_pwm_enable:
> -               if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE=
)
> +               if (data->fan_config[channel] & MAX31790_FAN_CFG_CTRL_MON=
)
> +                       *val =3D 0;
> +               else if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM=
_MODE)
>                         *val =3D 2;
> -               else if (data->fan_config[channel] & MAX31790_FAN_CFG_TAC=
H_INPUT_EN)
> +               else
>                         *val =3D 1;
> -               else
> -                       *val =3D 0;
>                 return 0;
>         default:
>                 return -EOPNOTSUPP;
> @@ -298,35 +316,41 @@ static int max31790_write_pwm(struct device *dev, u=
32 attr, int channel,
>  {
>         struct max31790_data *data =3D dev_get_drvdata(dev);
>         struct regmap *regmap =3D data->regmap;
> -       u8 fan_config;
> +       u8 fan_config =3D data->fan_config[channel];
>         int err =3D 0;
>
>         mutex_lock(&data->update_lock);
>
>         switch (attr) {
>         case hwmon_pwm_input:
> -               if (val < 0 || val > 255) {
> +               if (fan_config & MAX31790_FAN_CFG_CTRL_MON || val < 0 || =
val > 255) {
>                         err =3D -EINVAL;
>                         break;
>                 }
> +
>                 err =3D write_reg_word(regmap, MAX31790_REG_PWMOUT(channe=
l), val << 8);
>                 break;
>         case hwmon_pwm_enable:
>                 fan_config =3D data->fan_config[channel];
> -               if (val =3D=3D 0) {
> -                       fan_config &=3D ~(MAX31790_FAN_CFG_TACH_INPUT_EN =
|
> -                                       MAX31790_FAN_CFG_RPM_MODE);
> -               } else if (val =3D=3D 1) {
> -                       fan_config =3D (fan_config |
> -                                     MAX31790_FAN_CFG_TACH_INPUT_EN) &
> -                                    ~MAX31790_FAN_CFG_RPM_MODE;
> +               if (val =3D=3D 0)
> +                       fan_config |=3D MAX31790_FAN_CFG_CTRL_MON;
> +               else if (val =3D=3D 1) {
> +                       fan_config &=3D ~(MAX31790_FAN_CFG_RPM_MODE | MAX=
31790_FAN_CFG_CTRL_MON);
>                 } else if (val =3D=3D 2) {
> -                       fan_config |=3D MAX31790_FAN_CFG_TACH_INPUT_EN |
> -                                     MAX31790_FAN_CFG_RPM_MODE;
> +                       fan_config &=3D ~(MAX31790_FAN_CFG_CTRL_MON);
> +                       fan_config |=3D MAX31790_FAN_CFG_RPM_MODE;
>                 } else {
>                         err =3D -EINVAL;
>                         break;
>                 }
> +
> +               /*
> +                * RPM mode implies enabled TACH input, so enable it in R=
PM
> +                * mode.
> +                */
> +               if (val =3D=3D 2)
> +                       fan_config |=3D MAX31790_FAN_CFG_TACH_INPUT_EN;
> +
>                 data->fan_config[channel] =3D fan_config;
>                 err =3D regmap_write(regmap,
>                                    MAX31790_REG_FAN_CONFIG(channel),
> @@ -400,18 +424,18 @@ static umode_t max31790_is_visible(const void *data=
,
>
>  static const struct hwmon_channel_info *max31790_info[] =3D {
>         HWMON_CHANNEL_INFO(fan,
> -                          HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> -                          HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> -                          HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> -                          HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> -                          HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> -                          HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT=
,
> -                          HWMON_F_INPUT | HWMON_F_FAULT,
> -                          HWMON_F_INPUT | HWMON_F_FAULT,
> -                          HWMON_F_INPUT | HWMON_F_FAULT,
> -                          HWMON_F_INPUT | HWMON_F_FAULT,
> -                          HWMON_F_INPUT | HWMON_F_FAULT,
> -                          HWMON_F_INPUT | HWMON_F_FAULT),
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T | HWMON_F_FAULT,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT=
),
>         HWMON_CHANNEL_INFO(pwm,
>                            HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>                            HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> --
> 2.31.1
>
