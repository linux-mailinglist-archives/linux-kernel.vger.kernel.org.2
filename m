Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43263349354
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCYNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCYNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:51:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD2C06174A;
        Thu, 25 Mar 2021 06:51:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u10so2237162ilb.0;
        Thu, 25 Mar 2021 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6SqcI7wfV+RRHYGPRjS+pVaFs+2AUelArIaZQWbVrio=;
        b=fHGDpiK3JBh/PsiCtP3z2LFWYIAz5AKbfErqmPootKMXzYWpSTTqPp0BQljhhwtOqj
         PaOltLKGnzVNkFzGyUOvG1Wy6U4+JI0PTF3OC532D66DubQzlJB/Nwm3OtVEj7ycf43K
         O6eA26dGlT51MJ8gXJ0VZQQl8aNMhQceyIcZh82ExO8PRhcozq6NkOkOWx/W3BqaZpkJ
         uzuzA7cbdeffuYav3x5pU9My4r6VBWi2Y2hH9cVc40Z0PjjBYR7G1BkKYClFzx+0V7bk
         xonk63iqekj2iHqqzSul0JPtOVV1WLn5Jbhbcx40tiAmh3pBAqQKhvhWSyKc0sK7uuzG
         Z0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6SqcI7wfV+RRHYGPRjS+pVaFs+2AUelArIaZQWbVrio=;
        b=kDChoENCXZD+uaZtximapPc/6lv7PkX0GOZv5uhNPVacvx49bUabt738RE6JxxACGd
         maRT0zDtMXbrJLZ5LlGWfsHslf01Z3ARIsln1w655bJ+4QebzixcmQE1+fhyB24gCYdB
         u05CMmStFAaKCldxWq2eaJvZZ3FPz/ZW8JN0Vb7DFpY9XJvu6p3Fo5nEyVPgy5a7xgWW
         yf7UWNC+arbfb1n2CINDVcB0oxM4hMwbCLhM2VRJnZTiEda6svPQNoel27WrDEaoobOm
         rWULwQNX4XRnbfb/AKxhPtsGox7yD5wJb3ZXIsuNAjmwSuEoJiWns+4o4ovupbU54Dq4
         WmkQ==
X-Gm-Message-State: AOAM530RKZaYhHKTHG1Ax3TpWYI60624hvKeUx2zmQFacM4zPBU2OF+c
        usiDsgMbaW/QqFZDCfMbCH+ScXBpezZX4W9yVD4=
X-Google-Smtp-Source: ABdhPJx13+Xbo2EG3QB9CGCcNSzLt5MSw6DR7Ob9QMd0kl4el4ADLGx4iyB29+6HkjcKeyUVXZ1Q8ZQrsyfHhgXbtVQ=
X-Received: by 2002:a92:da89:: with SMTP id u9mr3177383iln.131.1616680299834;
 Thu, 25 Mar 2021 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210117042539.1609-1-alistair@alistair23.me> <20210117042539.1609-2-alistair@alistair23.me>
 <20210204103126.GA2789116@dell> <CAKmqyKOJ251sRUaxUKJ_U=puYRkypPEHAVZOnAKbQtP2skMJBA@mail.gmail.com>
 <20210323093541.GQ2916463@dell>
In-Reply-To: <20210323093541.GQ2916463@dell>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 25 Mar 2021 09:49:39 -0400
Message-ID: <CAKmqyKNaVmj2thEbuxZShjnX_UCsP0YW5gjBrjdAr3YtAn5Yhg@mail.gmail.com>
Subject: Re: [PATCH 2/6] mfd: Initial commit of sy7636a
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 5:35 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Sat, 20 Mar 2021, Alistair Francis wrote:
>
> > On Thu, Feb 4, 2021 at 5:31 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Sat, 16 Jan 2021, Alistair Francis wrote:
> > >
> > > > Initial support for the Silergy SY7636A Power Management chip
> > > > driver.
> > >
> > > Please remove "driver", as this is not support for the driver, it *is=
*
> > > the driver which supports the chip.
> >
> > Sorry for the long delay here.
> >
> > I have addressed your comments.
>
> [...]
>
> > > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > > new file mode 100644
> > > > index 000000000000..39aac965d854
> > > > --- /dev/null
> > > > +++ b/drivers/mfd/sy7636a.c
> > > > @@ -0,0 +1,252 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * MFD driver for SY7636A chip
> > >
> > > "Parent driver".
> > >
> > > > + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> > >
> > > This is quite out of date.  Please update.
> >
> > I don't own this copyright, so I would rather not change it.
>
> I'm not comfortable taking a new driver with an old Copyright.
>
> Maybe ask reMarkable if it's okay to bump it.
>
> > > > + * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com=
>
>
> Or ping this guy.

I reached out to him and have permission to bump the year.

>
> [...]
>
> > > > +int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom)
> > > > +{
> > > > +     int ret;
> > > > +     unsigned int val;
> > > > +
> > > > +     if (vcom < 0 || vcom > 5000)
> > >
> > > Please define min/max values.
> > >
> > > > +             return -EINVAL;
> > > > +
> > > > +     val =3D (unsigned int)(vcom / 10) & 0x1ff;
> > >
> > > As above.
> >
> > I have used defines for all of these.
> >
> > >
> > > > +     ret =3D regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, =
val);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, =
val >> 8);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > Who calls these?
> >
> > They sysfs store and show functions.
>
> They should be in a power/regulator driver really.

Ok, I have moved these to the regulator.

>
> [...]
>
> > > > +     if (val >=3D ARRAY_SIZE(states)) {
> > > > +             dev_err(sy7636a->dev, "Unexpected value read from dev=
ice: %u\n", val);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     return snprintf(buf, PAGE_SIZE, "%s\n", states[val]);
> > > > +}
> > > > +static DEVICE_ATTR(state, 0444, state_show, NULL);
> > >
> > > You need to document new sysfs entries.
> >
> > I'm not sure how to document this. Do you mind pointing out an example
> > I can use?
>
> See the final paragraph in:
>
>   Documentation/filesystems/sysfs.rst

Thanks!

>
> [...]
>
> > > > +static struct attribute *sy7636a_sysfs_attrs[] =3D {
> > > > +     &dev_attr_state.attr,
> > > > +     &dev_attr_power_good.attr,
> > > > +     &dev_attr_vcom.attr,
> > > > +     NULL,
> > > > +};
> > >
> > > These all look like power options?  Do they really belong here?
> >
> > From what I can tell I think they do. Let me know if you don't think so=
.
>
> As above, I think they should be in power or regulator.

Done.

Alistair

>
> [...]
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
