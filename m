Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FF34028F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCRJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:56:50 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:40724 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCRJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:56:32 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 36A4940006E;
        Thu, 18 Mar 2021 10:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1616061390;
        bh=118lnbTxA8eKbWvGsXeQrykbruOxfABZX590YoptLLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=gQKF43tSlevn3W8JD9J5pbbIGBg9ddzI3OYQH+KuKI/iVDmkjqlFBkAtXXTRNylhQ
         kVIWanyAfcPy+oCqgaHPpGOH44U1GNTx4++31FSJy9rocSQjM7LAwj7UkiQacr7Qqt
         vfJOeLDzZBuIrS/EOpQf6NnDMT23cTN8A9i6Fvmix/vcN/tHqJ6BsYqO/oKoGY+pDI
         DnVXnneL6gnmnYLZpwa+Qvq1TI5hqaaxzjYQ7ArczcB2l2mu3FUmGoYODN6IsNRJgD
         l5CHTLphlli/oxWZNfDkOgtHX2tgu25D9Xi7oy38686yphMDX3JSqtyrhFTuYltLcd
         6vPsonIizT/sg==
Received: by mail-lf1-f42.google.com with SMTP id o10so3569206lfb.9;
        Thu, 18 Mar 2021 02:56:30 -0700 (PDT)
X-Gm-Message-State: AOAM530k5EntyruOdkUNyeRfugRWlrMZ5dPqDUzmrJ0sGM1G36yuzp2F
        ABfwD0UdUl/eLMO9b0qVpTIvqztLY7L0SPIEAcY=
X-Google-Smtp-Source: ABdhPJxARCmqbXdbDRzRNRWFk/MAi6vv9pFlHZeCLprLSzhHa4xpKbn0OjBvZy/32kAsx/jEYZrjOhvJAYoF425/Tlo=
X-Received: by 2002:a19:f608:: with SMTP id x8mr4943236lfe.380.1616061389690;
 Thu, 18 Mar 2021 02:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210316175503.1003051-1-kubernat@cesnet.cz> <20210317051239.GW2087@kadam>
In-Reply-To: <20210317051239.GW2087@kadam>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Thu, 18 Mar 2021 10:56:18 +0100
X-Gmail-Original-Message-ID: <CABKa3nooU84H=K0XqR63j7uR2MqHx-NLJ0ReaYtNx73hsd4Jow@mail.gmail.com>
Message-ID: <CABKa3nooU84H=K0XqR63j7uR2MqHx-NLJ0ReaYtNx73hsd4Jow@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

thanks, I will fix this in v3 of this patch series.

Vaclav

st 17. 3. 2021 v 6:14 odes=C3=ADlatel Dan Carpenter
<dan.carpenter@oracle.com> napsal:
>
> Hi "V=C3=A1clav,
>
> url:    https://github.com/0day-ci/linux/commits/V-clav-Kubern-t/hwmon-ma=
x31790-Rework-to-use-regmap/20210317-015931
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-stag=
ing.git hwmon-next
> config: x86_64-randconfig-m001-20210316 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/hwmon/max31790.c:263 max31790_fan_is_visible() warn: impossible c=
ondition '(fan_config < 0) =3D> (0-255 < 0)'
> drivers/hwmon/max31790.c:337 max31790_write_pwm() warn: impossible condit=
ion '(fan_config < 0) =3D> (0-255 < 0)'
> drivers/hwmon/max31790.c:372 max31790_pwm_is_visible() warn: impossible c=
ondition '(fan_config < 0) =3D> (0-255 < 0)'
>
> vim +263 drivers/hwmon/max31790.c
>
> 54187ff9d766b2 Guenter Roeck   2016-07-01  257  static umode_t max31790_f=
an_is_visible(const void *_data, u32 attr, int channel)
> 195a4b4298a795 Il Han          2015-08-30  258  {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  259          const struct max3=
1790_data *data =3D _data;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  260          struct =
regmap *regmap =3D data->regmap;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  261          u8 fan_=
config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANN=
EL));
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  262
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16 @263          if (fan=
_config < 0)
>                                                             ^^^^^^^^^^^^^=
^
> A u8 can't be negative.
>
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  264                 =
 return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  265
> 54187ff9d766b2 Guenter Roeck   2016-07-01  266          switch (attr) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  267          case hwmon_fan_in=
put:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  268          case hwmon_fan_fa=
ult:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  269                  if (chann=
el < NR_CHANNEL ||
> 54187ff9d766b2 Guenter Roeck   2016-07-01  270                      (fan_=
config & MAX31790_FAN_CFG_TACH_INPUT))
> dc8dbb4d7672b7 Guenter Roeck   2018-12-10  271                          r=
eturn 0444;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  272                  return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  273          case hwmon_fan_ta=
rget:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  274                  if (chann=
el < NR_CHANNEL &&
> 54187ff9d766b2 Guenter Roeck   2016-07-01  275                      !(fan=
_config & MAX31790_FAN_CFG_TACH_INPUT))
> dc8dbb4d7672b7 Guenter Roeck   2018-12-10  276                          r=
eturn 0644;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  277                  return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  278          default:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  279                  return 0;
> 195a4b4298a795 Il Han          2015-08-30  280          }
> 195a4b4298a795 Il Han          2015-08-30  281  }
> 195a4b4298a795 Il Han          2015-08-30  282
> 54187ff9d766b2 Guenter Roeck   2016-07-01  283  static int max31790_read_=
pwm(struct device *dev, u32 attr, int channel,
> 54187ff9d766b2 Guenter Roeck   2016-07-01  284                           =
    long *val)
> 195a4b4298a795 Il Han          2015-08-30  285  {
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  286          struct =
max31790_data *data =3D dev_get_drvdata(dev);
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  287          struct =
regmap *regmap =3D data->regmap;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  288          int rea=
d;
> 195a4b4298a795 Il Han          2015-08-30  289
> 195a4b4298a795 Il Han          2015-08-30  290          if (IS_ERR(data))
> 195a4b4298a795 Il Han          2015-08-30  291                  return PT=
R_ERR(data);
> 195a4b4298a795 Il Han          2015-08-30  292
> 54187ff9d766b2 Guenter Roeck   2016-07-01  293          switch (attr) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  294          case hwmon_pwm_in=
put:
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  295                 =
 read =3D read_reg_word(regmap, MAX31790_REG_PWMOUT(channel));
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  296                 =
 if (read < 0)
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  297                 =
         return read;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  298
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  299                 =
 *val =3D read >> 8;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  300                  return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  301          case hwmon_pwm_en=
able:
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  302                 =
 read =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  303                 =
 if (read < 0)
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  304                 =
         return read;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  305
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  306                 =
 if (read & MAX31790_FAN_CFG_RPM_MODE)
> 54187ff9d766b2 Guenter Roeck   2016-07-01  307                          *=
val =3D 2;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  308                 =
 else if (read & MAX31790_FAN_CFG_TACH_INPUT_EN)
> 54187ff9d766b2 Guenter Roeck   2016-07-01  309                          *=
val =3D 1;
> 195a4b4298a795 Il Han          2015-08-30  310                  else
> 54187ff9d766b2 Guenter Roeck   2016-07-01  311                          *=
val =3D 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  312                  return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  313          default:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  314                  return -E=
OPNOTSUPP;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  315          }
> 195a4b4298a795 Il Han          2015-08-30  316  }
> 195a4b4298a795 Il Han          2015-08-30  317
> 54187ff9d766b2 Guenter Roeck   2016-07-01  318  static int max31790_write=
_pwm(struct device *dev, u32 attr, int channel,
> 54187ff9d766b2 Guenter Roeck   2016-07-01  319                           =
     long val)
> 195a4b4298a795 Il Han          2015-08-30  320  {
> 195a4b4298a795 Il Han          2015-08-30  321          struct max31790_d=
ata *data =3D dev_get_drvdata(dev);
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  322          struct =
regmap *regmap =3D data->regmap;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  323          u8 fan_config;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  324          int err =3D 0;
> 195a4b4298a795 Il Han          2015-08-30  325
> 54187ff9d766b2 Guenter Roeck   2016-07-01  326          switch (attr) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  327          case hwmon_pwm_in=
put:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  328                  if (val <=
 0 || val > 255) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  329                          e=
rr =3D -EINVAL;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  330                          b=
reak;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  331                  }
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  332                 =
 err =3D write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
> 195a4b4298a795 Il Han          2015-08-30  333                  break;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  334          case hwmon_pwm_en=
able:
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  335                 =
 fan_config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_=
CHANNEL));
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  336
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16 @337                 =
 if (fan_config < 0)
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  338                 =
         return fan_config;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  339
> 54187ff9d766b2 Guenter Roeck   2016-07-01  340                  if (val =
=3D=3D 0) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  341                          f=
an_config &=3D ~(MAX31790_FAN_CFG_TACH_INPUT_EN |
> 54187ff9d766b2 Guenter Roeck   2016-07-01  342                           =
               MAX31790_FAN_CFG_RPM_MODE);
> 54187ff9d766b2 Guenter Roeck   2016-07-01  343                  } else if=
 (val =3D=3D 1) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  344                          f=
an_config =3D (fan_config |
> 54187ff9d766b2 Guenter Roeck   2016-07-01  345                           =
             MAX31790_FAN_CFG_TACH_INPUT_EN) &
> 54187ff9d766b2 Guenter Roeck   2016-07-01  346                           =
            ~MAX31790_FAN_CFG_RPM_MODE;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  347                  } else if=
 (val =3D=3D 2) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  348                          f=
an_config |=3D MAX31790_FAN_CFG_TACH_INPUT_EN |
> 54187ff9d766b2 Guenter Roeck   2016-07-01  349                           =
             MAX31790_FAN_CFG_RPM_MODE;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  350                  } else {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  351                          e=
rr =3D -EINVAL;
> 195a4b4298a795 Il Han          2015-08-30  352                          b=
reak;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  353                  }
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  354                 =
 err =3D regmap_write(regmap,
> 54187ff9d766b2 Guenter Roeck   2016-07-01  355                           =
          MAX31790_REG_FAN_CONFIG(channel),
> 54187ff9d766b2 Guenter Roeck   2016-07-01  356                           =
          fan_config);
> 195a4b4298a795 Il Han          2015-08-30  357                  break;
> 195a4b4298a795 Il Han          2015-08-30  358          default:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  359                  err =3D -=
EOPNOTSUPP;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  360                  break;
> 195a4b4298a795 Il Han          2015-08-30  361          }
> 195a4b4298a795 Il Han          2015-08-30  362
> 195a4b4298a795 Il Han          2015-08-30  363          return err;
> 195a4b4298a795 Il Han          2015-08-30  364  }
> 195a4b4298a795 Il Han          2015-08-30  365
> 54187ff9d766b2 Guenter Roeck   2016-07-01  366  static umode_t max31790_p=
wm_is_visible(const void *_data, u32 attr, int channel)
> 195a4b4298a795 Il Han          2015-08-30  367  {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  368          const struct max3=
1790_data *data =3D _data;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  369          struct =
regmap *regmap =3D data->regmap;
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  370          u8 fan_=
config =3D read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANN=
EL));
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  371
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16 @372          if (fan=
_config < 0)
> 2c8602cfaeab63 V=C3=A1clav Kubern=C3=A1t 2021-03-16  373                 =
 return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  374
> 54187ff9d766b2 Guenter Roeck   2016-07-01  375          switch (attr) {
> 54187ff9d766b2 Guenter Roeck   2016-07-01  376          case hwmon_pwm_in=
put:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  377          case hwmon_pwm_en=
able:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  378                  if (!(fan=
_config & MAX31790_FAN_CFG_TACH_INPUT))
> dc8dbb4d7672b7 Guenter Roeck   2018-12-10  379                          r=
eturn 0644;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  380                  return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  381          default:
> 54187ff9d766b2 Guenter Roeck   2016-07-01  382                  return 0;
> 54187ff9d766b2 Guenter Roeck   2016-07-01  383          }
> 54187ff9d766b2 Guenter Roeck   2016-07-01  384  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
