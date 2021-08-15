Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF13EC8DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbhHOL4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhHOL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 07:56:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41DC061764;
        Sun, 15 Aug 2021 04:56:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id j18so4086655ioj.8;
        Sun, 15 Aug 2021 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WKPXHo4mcX7xDNr3Qfy2ytPy2yrYvE6/voU48e47FhY=;
        b=jHihczY6+kYqTKLMrPpO/5Y/F8bNFOHWT2HlLznT4p4U37/A6Un98FXRrwqQ/EEqrf
         VAgtqPzdqC6/LcRGYAwb9tzZ8YhNZnoCTJTmwLPf6wsj0QUrs/KJfd5kFRC4ZJ4fS5Qs
         fZ8SYSLVN/dzqjnF4WFJ0rLegMM1dB/LTd/R1Fy+QFr6HVLraOtgTRqYfM7N3pudUkno
         pzczuDBP9gVjupvNd2LxfLeNdDyC0QgqqupsVXC2frmpMMwnBTcktLBewuw/G6H4JAg3
         a6JYQ9/w/cKqGlca9sh+2fzisuGh8TubPyjred9/5wkl/XxzQZpOJf9McRRAJD/jol9u
         3eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WKPXHo4mcX7xDNr3Qfy2ytPy2yrYvE6/voU48e47FhY=;
        b=IJEkllJ0/7T3ljR7nr3s+R3kGGuB/a2lygUVKS9iGTEty+CT6dasuT+DwGYfEFnab8
         XgiJNSyqcGpRLNSTZRv7BxsUWf9kHSor4yi+NO9rzbdZ1A8kHwfAHrVoIYibNoRdGYnP
         gpkyWRHS+nNSklbl7y2XuzQMj+Oa2zOKMde1zSNjhkK+hGDiajAGPN3o4B9lCaNn1tJg
         ziSeJAljYwj27WRd3E5nihsQ5dmb+4CIS8OrzcBvmoVVjyPMwzJnUvfbdbDtr/Qc2soc
         lFrGOJjkboE8ajqMXyXsscACxEh8d+ZAfYtUtroStgyiEf0gL96ww3BJfSaznxnRkFtS
         y5CQ==
X-Gm-Message-State: AOAM530N8G1Eef6BAU4COarJj4N4Gf1Lko56gDajS6/gUiQb3HOQQ6uT
        H9fY80g13hrX5G05ki8T0OPxTkYwQ12zatTx2R8=
X-Google-Smtp-Source: ABdhPJxtLiCDisGQyFqO/tNALjrJn75wU23SFH9Eo0P29bXH4NS8pqUVXagXQ4QFE/wO1YzfasxFEZW/7VlfnHvegeE=
X-Received: by 2002:a05:6638:3048:: with SMTP id u8mr10610500jak.91.1629028583494;
 Sun, 15 Aug 2021 04:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210807103940.152-1-alistair@alistair23.me> <20210807103940.152-3-alistair@alistair23.me>
 <YRIwcXggWWj1+DDf@google.com>
In-Reply-To: <YRIwcXggWWj1+DDf@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 15 Aug 2021 21:55:57 +1000
Message-ID: <CAKmqyKOPBt2GA2D8UOr1TP_g42gFFUx_xe6UQ4znWUSaviX8vA@mail.gmail.com>
Subject: Re: [PATCH v10 02/11] mfd: simple-mfd-i2c: Add a Kconfig name
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

On Tue, Aug 10, 2021 at 5:53 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Sat, 07 Aug 2021, Alistair Francis wrote:
>
> You need a better commit message.
>
> What are you doing?
> Why are you doing it?
> What happens if you don't do it?
>
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/mfd/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I guess there's no harm in it.
>
> That does mean you'll need a bespoke defconfig to run your build,
> which is not advisable for generic maintenance and testing purposes.
> What architecture does your H/W operate on?

My hardware uses the ARMv7 i.MX architecture. I'm testing it with the
`imx_v6_v7_defconfig` config.

Alistair

>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6a3fd2d75f96..09a939f8b7ff 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
> >         module will be called si476x-core.
> >
> >  config MFD_SIMPLE_MFD_I2C
> > -     tristate
> > +     tristate "Simple MFD device"
>
> That's not right.  You're saying:
>
>   "Simple Multi-Functional Device device"
>
> It should be something more like:
>
>   "Simple Multi-Functional Device support (I2C)"
>
> >       depends on I2C
> >       select REGMAP_I2C
> >       help
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
