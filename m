Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC413690AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbhDWK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhDWK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:56:14 -0400
X-Greylist: delayed 124105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Apr 2021 03:55:38 PDT
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E1C061574;
        Fri, 23 Apr 2021 03:55:38 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id A77A140006D;
        Fri, 23 Apr 2021 12:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1619175335;
        bh=1yeYMi0WCy1lS6XRdT+6s3BjaTJRmrph2DZ2NtKBZ7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=T86DGbl0TWI1yW+XdIJtJqaJD269CdVyONMzoTqm6IfJPR+x5gd5ggMmsjISFqg3m
         WrUjl18Xl3n8AiGTD8MKLpJJhb18ztbUkKX0GlbDkcGYHuj4jx+larHfWAokvo5QQk
         kIKHDDA1a+Goh+khymOPgW+BKsOiepSFuB8ok8uDVeefS2N5KUGuRUas1l2lycE319
         zKoAvnsKLyVmeUcXB0lXuptuoDbUTdRWyFbbPtgPXfoLhyUoWjFmKGU/bWuZ8TmKc5
         nuldEkIhwCvNZyA7Ohs9ddc9E4JF5urzq8xhbnXk6g7AhBamJE+m3Trxj3GjZv7eUe
         IOJPbq2V/ufzQ==
Received: by mail-pf1-f176.google.com with SMTP id a12so33828035pfc.7;
        Fri, 23 Apr 2021 03:55:35 -0700 (PDT)
X-Gm-Message-State: AOAM532MAmEggtfrem0tPj1zvlHkkQjuzwicSedAFKdyhuXU0ImlZA8U
        GokBW63bvpHXnonCnQTbJDgvde5HnmhucLt71YI=
X-Google-Smtp-Source: ABdhPJxTQMjUty9JIMUAmqBUv09g1c3ZieG90DPp7astHFrXECz+Knz1xcW/Icqm5u6r+ivGxEfnfrypn7ockzIO8bo=
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr3189000pgb.110.1619175334091;
 Fri, 23 Apr 2021 03:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210413025948.901867-1-kubernat@cesnet.cz> <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
In-Reply-To: <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Fri, 23 Apr 2021 12:55:22 +0200
X-Gmail-Original-Message-ID: <CABKa3nquWmP4Hx+eY5CpQ08M2uo2ePpmtZP-6yi45pVOh-Mqzw@mail.gmail.com>
Message-ID: <CABKa3nquWmP4Hx+eY5CpQ08M2uo2ePpmtZP-6yi45pVOh-Mqzw@mail.gmail.com>
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

I agree that it makes sense to swap yes_ranges and no_ranges. I tested
that, but it seems like it doesn't have an effect, I could still see
fan*_input changing (that's where I don't want caching). Does caching
work automatically? As in, all registers are cached by default in
regmap, and only registers that are in the volatile yes_ranges aren't?

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
