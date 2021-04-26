Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5789B36B36A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhDZMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:47:25 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:46088 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:47:24 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 422A6400052;
        Mon, 26 Apr 2021 14:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1619441201;
        bh=vAAsbBiBH7LAbBh1t9loyx/hGv7nApOFY9XOY22lVNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=aKdaeQQmkMCROGpYjyLcjsOEBCprIG7wrCPrVQ5HqomHNBDoHwBPWJZCn6ZQXtabE
         pHsrmmkEicC00vRdQ2n3ELyIGG9hj3XNmHsb7seMPBpbRMk4Q/NN8hgtatP+uzMtfK
         jKMjKJ919ECBYJPOiu48KDaZ4LCsMsjXQiu+x94SSnZ1PVS+ar2BPU15ptVfEmUBDC
         q2DcT+/k3M0EI/fafovQ6F/XzFtvszfYxR+2EPp2j4Iw5QRegzB54985sppPZPT2IE
         FyuAXeCp25b03P1aV5z1IA+qSVfbEtfTAD+m4HcUohDQuNUMi554u1DRSJRJ2rKU0J
         d0IHLxGEQaWcg==
Received: by mail-pj1-f45.google.com with SMTP id md17so1524734pjb.0;
        Mon, 26 Apr 2021 05:46:41 -0700 (PDT)
X-Gm-Message-State: AOAM531het5S/UIIBVooOVqB7eNTSrGHke5axXrG277hgfLVdqCbv7TP
        WyJQLDVPDN97oJRw87FOZITEh30kCHgwcLCxngQ=
X-Google-Smtp-Source: ABdhPJw45wCj7QeQGS20UcVMLO74ChUMRhb/yYlOPI3Wl6DXngaPVEiVwR8/pT7CtHuZCHWgY8+dy+ZmltO0gzr0AcY=
X-Received: by 2002:a17:902:b408:b029:ec:e879:bbd8 with SMTP id
 x8-20020a170902b408b02900ece879bbd8mr12993884plr.65.1619441199370; Mon, 26
 Apr 2021 05:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210413025948.901867-1-kubernat@cesnet.cz> <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
In-Reply-To: <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Mon, 26 Apr 2021 14:46:27 +0200
X-Gmail-Original-Message-ID: <CABKa3npjrpq5Aw_Xqy3mFZtUHZcfB0YENxEDgo_MCwPUKqA4ww@mail.gmail.com>
Message-ID: <CABKa3npjrpq5Aw_Xqy3mFZtUHZcfB0YENxEDgo_MCwPUKqA4ww@mail.gmail.com>
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

Hello.

I'm sending a new version of my patch on max31790. This new version
fixes the cache issue and actually makes it work by setting
.cache_type. You were right about the "yes/no" ranges, so I flipped
those.

By the way, it seems that the reason your reply got lost is because of
weird addresses in the "Cc:" email field, they end with "cesnet.cz",
so it could be that I'm sending email incorrectly. Let me know if I'm
doing something wrong.

Thanks,
V=C3=A1clav

=C4=8Dt 22. 4. 2021 v 3:31 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.ne=
t> napsal:
>
> On 4/12/21 7:59 PM, V=C3=A1clav Kubern=C3=A1t wrote:
> > Converting the driver to use regmap makes it more generic. It also make=
s
> > it a lot easier to debug through debugfs.
> >
> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> > ---
> >  drivers/hwmon/Kconfig    |   1 +
> >  drivers/hwmon/max31790.c | 254 ++++++++++++++++++++-------------------
> >  2 files changed, 133 insertions(+), 122 deletions(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 1ecf697d8d99..9f11d036c316 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1095,6 +1095,7 @@ config SENSORS_MAX6697
> >  config SENSORS_MAX31790
> >       tristate "Maxim MAX31790 sensor chip"
> >       depends on I2C
> > +     select REGMAP_I2C
> >       help
> >         If you say yes here you get support for 6-Channel PWM-Output
> >         Fan RPM Controller.
> > diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> > index 2c6b333a28e9..e3765ce4444a 100644
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
> > @@ -46,92 +47,53 @@
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
>
> Looks like my reply to this got lost. Other regmap code suggests that
> volatile register ranges are identified with yes_ranges, not with no_rang=
es.
> "no" seems to mean "not volatile". Please verify and confirm if the
> above code does what you want it to do.
>
> Thanks,
> Guenter
