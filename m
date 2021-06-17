Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18C03AB309
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhFQLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhFQLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:53:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:50:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n12so4735749pgs.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sKn9UvDVlydbDfhyjcKiR8IQebdYWuPzRo3dE9qFvzU=;
        b=HTT19X0V095oJRTCzBuNJaVN4HZknbDw48KwzexgYxUe8fSxFHwWmx5qCuxOySbqY8
         oIhrj+O7sEtFlIQnJUWc8B3UDDiWZ7L1eX+0I1whFlp2IFctgF1Yqe1T6dpLJVdywUwi
         PnSOnmgj0c1OGJ0xVWQh8sAzW5NzMZoXHcglUWLoaCW+5qtIOnvVlJcA2IUv9VijrNbJ
         +w0wJnCaVH4AG3cNaf10KKxvykGRkz4rzk461fN+Y+f3xL4ZsAqVxFlqDmQ9byYf3XlY
         a3nzvcDFou6GLpDPGfHO9wQEClE2m9vU5ZIbj2FddMNRAanPHC78pShAINAcd0YZzSyG
         BitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sKn9UvDVlydbDfhyjcKiR8IQebdYWuPzRo3dE9qFvzU=;
        b=fHJJdo247M1F0//2xM8XJ9FJyAYY1knbjQLgaK1flEgtbBWNlgePp7u4axP4GuqFlF
         eqzfswac3V1c9QR6Hj2CXfqY6bnvheylZLwvD7oVk/gQrCtDob4uLuKXWoWEHPEWSZq5
         KZve9O5d+iO7SPv3uKWpEptmQGKW0N7KQ9nXzOjdYL9a3Eaoz2CobPbNG1wooI8dzd7U
         UXU5L1S4Q5iMTiTFYjEuTtdGNGSf9k1EOmwzFhB2cK2l4GV2CaFIEiGMVza0bJrWKxOs
         6VqQnxPDa6fxqHHW1IxfoaiY71asP3wQEs4+fgb+Za3Ftsrfb0sfBJPC6QCB/gwsO5/t
         m7HA==
X-Gm-Message-State: AOAM530O2q3KYM9SYWcGXAY3b3Jeh+lkQqhv7BJXTQrDCj4qU167KpKT
        2kfL86lVREc874bKHaaH31T4+aan0HuP04X0qETSwonULQdk
X-Google-Smtp-Source: ABdhPJzLsfs3op+S3slb9TqsEE9rDKBjbpT/kYfZDNwghaNqG6qtKFP/8gazWOPOPVAsKMwERdZcGU0aiuCW4mmYCy4=
X-Received: by 2002:a63:f344:: with SMTP id t4mr4676265pgj.314.1623930653336;
 Thu, 17 Jun 2021 04:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130326.2044-1-fengzheng923@gmail.com> <20210615132207.GG5149@sirena.org.uk>
 <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com> <20210617104828.GA5067@sirena.org.uk>
In-Reply-To: <20210617104828.GA5067@sirena.org.uk>
From:   =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date:   Thu, 17 Jun 2021 19:50:42 +0800
Message-ID: <CAE=m618Gtx_RQ4+h=8+TFvbcuSTpNWVcx1bry+8OggL6uDCzfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        p.zabel@pengutronix.de, Samuel Holland <samuel@sholland.org>,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=EF=BC=8C

Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8817=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 17, 2021 at 03:42:43PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A
>
> > > > @@ -0,0 +1,408 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * ALSA SoC DMIC Audio Layer
> > > > + *
> > > > + * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> > > > + *
>
> > > Please make the entire comment a C++ one so things look more
> > > intentional.
>
> > For example;
> > // SPDX-License-Identifier: GPL-2.0-or-later
> > /*
> >  * This driver supports the DMIC in Allwinner's H6 SoCs.
> >  *
> >  * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> >  *
> >  */
> > is this OK?
>
> No, that's what you have already make the entire thing a C++ comment
> with //s.

I don=E2=80=99t understand. For example, sun4i-codec.c sun4i-i2s.c
sun8i-codec.c and sun4i-spdif.c files are the same as mine.
Which file can I refer to? what should I do......
>
> > > > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +     base =3D devm_ioremap_resource(&pdev->dev, res);
> > >
> > > devm_platform_ioremap_resource()
> >
> > But I need to get the register base address of DMIC. E.g res->start.
> > host->dma_params_rx.addr =3D res->start + SUN50I_DMIC_DATA;
>
> OK.
