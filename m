Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E693CB60E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhGPK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbhGPK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:27:03 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312DC061766
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:24:08 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j5so7807970ilk.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ex/yhDEeIknXwXGk501wHnuwGxY//6Xn6CYZS4Q3oVI=;
        b=HlcKi3zt5byBuuvxCQ8kgWUUobfgYY4cnsEljSmwCN2glXyDeixxxRGywpRnQp2GRz
         yo9o3pO54zBM6SR4LK/BkA7ExQtc4D55fKjlDDREfmcBIZLG+ramZI/KBx2sA8Zg7LAJ
         WZlbJ0XL1v0YV/vqZEz4jjTERIHGEcZXKN/GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ex/yhDEeIknXwXGk501wHnuwGxY//6Xn6CYZS4Q3oVI=;
        b=lzzUIAFudoIKXENeCdNKDo9FQhsIYJeIgzFo1P5Xi5UPFfJWqOBY5GDZwP0R6QrbwI
         tnublrkcd/P/k2mCkh3nh8mpRaF93xwwa7cTHGLYvYDemb9naEhNQynk/fW3UhDbxB5o
         JoPQujfYX2RjPtRk4PFMONWxzV4pVffmQqJZ3uJvSRWLs+y9gSW8GwK8L9GKD92E4AJw
         XgyztCAh1nxU7cusqtY3Dh1WzJFTO8nCF8+Acen+OJxogajVV04WL/OOIOmkruDdTcHU
         I2+uUHr2VfZoZgqhtxGtuzY9NHk5ilwfxFlRx9t6ws9jNTgClIF9TwZKlIkH7oLBfvMW
         5M9A==
X-Gm-Message-State: AOAM531OMH/y1TtPbG81U1BBwlhmdXoavVVUHg5XiCkKCYIhYbYH6px2
        pP5/qCr6CO1IoRm+TzTwe225wEkacYYOYQ==
X-Google-Smtp-Source: ABdhPJwI7iU4AfzLkJG6m3MxdPBFADodnCEjicVdWjrTdi5s/qCVXJks1aYLrJ2NmGswJ8lDVtlPJQ==
X-Received: by 2002:a92:db4b:: with SMTP id w11mr6249729ilq.297.1626431047543;
        Fri, 16 Jul 2021 03:24:07 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id p10sm4321535ilh.57.2021.07.16.03.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:24:06 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id a7so7800398iln.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:24:06 -0700 (PDT)
X-Received: by 2002:a92:3209:: with SMTP id z9mr6121460ile.115.1626431045834;
 Fri, 16 Jul 2021 03:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210629094339.874120-1-fshao@chromium.org> <20210629094339.874120-2-fshao@chromium.org>
 <YPE9ZSu1lYtRb1DA@google.com>
In-Reply-To: <YPE9ZSu1lYtRb1DA@google.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 16 Jul 2021 18:23:29 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhc6a8JMn1DozTUGK=nvuP3ZB8Tmk9g-RtXwVvBHyQZLA@mail.gmail.com>
Message-ID: <CAC=S1nhc6a8JMn1DozTUGK=nvuP3ZB8Tmk9g-RtXwVvBHyQZLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: mt6360: Restore error message to regmap_read failure
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 4:03 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 29 Jun 2021, Fei Shao wrote:
>
> > This adds back a missing error message for better log readability.
> >
> > Fixes: e84702940613 ("mfd: mt6360: Fix flow which is used to check ic
> > exist")
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  drivers/mfd/mt6360-core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index 6eaa6775b888..0ff8dae4536c 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -351,8 +351,10 @@ static int mt6360_check_vendor_info(struct mt6360_=
ddata *ddata)
> >       int ret;
> >
> >       ret =3D regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             dev_err(ddata->dev, "Failed to read device info from regm=
ap\n");
>
> I'm not fussed about this change either, but if you insist, please
> change the commit message to be a little more generic.  Users don't
> care about Regmaps and developers can grep it in the source.
>
> Suggest: "Failed to fetch device information from H/W"

I think I was a bit too paranoid about this. Please ignore this as it
doesn't make much sense, and thanks both of you for the feedback. :)

Fei

>
> >               return ret;
> > +     }
> >
> >       if ((info & CHIP_VEN_MASK) !=3D CHIP_VEN_MT6360) {
> >               dev_err(ddata->dev, "Device not supported\n");
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
