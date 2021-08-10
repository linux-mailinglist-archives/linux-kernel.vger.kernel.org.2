Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A225F3E5414
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhHJHEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHJHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:04:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D55C0613D3;
        Tue, 10 Aug 2021 00:04:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w4so4870773ilq.13;
        Tue, 10 Aug 2021 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CRgVYbQb3U4KJJpbnla1/MQYFRgYupowMXh7LlyjTy4=;
        b=HKjXrr24nvourgRK3JgGuh+okvDa3fKScHfrZ9mdXbwcUZEvneA7wqhLLz1IL01do7
         Zx/tgmLFIaWkVs/NMgHgZNNrYctRA3K1ttkhCoBN/OYAD7/G5F5fumM8xbrHjRltruCU
         XxbKWzJsibd9olGRGfG/nmT3EojJV0TYwTLuc+oRlqE0b14tvDtHdfh6va/vLhDSrpqg
         3W0gctggh0Hb00Sz3IOKRWF/JYtKDia5XNgvpZO4asUNHue3Kzq2QLfcRYwk/Yc5knGy
         n4NAH3djoYqsti4yTK+M9MlyvP3cWBrpUQaMis5DtNu0LD3FS1649633h5NMzU2I1tLG
         JHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CRgVYbQb3U4KJJpbnla1/MQYFRgYupowMXh7LlyjTy4=;
        b=idm9eh61BZTMhRB0zlUn9VHkjQfNBGB2+1EES2Qh3DwCCJLrcKwljZDagU926enuCd
         8H3z9VbTPmv4RLHtODDsXIlOK90r69ZpkM0HohImPT5LmgmiyzvrEGhLe5vywALPLqu1
         2cD+qHX/WQq9XOqzlV9Qd4i7CrRUu/mwuNJL/8xMNacCaosvywaPvr1HUZeZghgk8gZ8
         rVEBrAideQo1VwNJERObwQDspps/W7FdeezuSIKPEVIlSda97PCSsN/HhhSzHvbYAr2D
         fiknsv4ZUqRfX13Hk9gXgdjaWCC27NpVMTr53i79LphWCyfa01077o47Kuq0GPfbaIR/
         U2Fw==
X-Gm-Message-State: AOAM532p/ZPklehcwaqokR2fH4SPkpuEkui2mTExRFAtv6NMKq5PFD9O
        Q5S+vFtbxGLqTq1IYZs3KFX0j4YwenbdzhsrldY=
X-Google-Smtp-Source: ABdhPJzfuq+IVAk5YYrWnu5gD/r6do+ig0Dc4/FfqJAljwyqqIiAPFcfuuF48yIJSGSWUaBlYV16uuxCNyhhbLGhPVk=
X-Received: by 2002:a05:6e02:1d8d:: with SMTP id h13mr452911ila.40.1628579040897;
 Tue, 10 Aug 2021 00:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210806091058.141-1-alistair@alistair23.me> <20210806091058.141-4-alistair@alistair23.me>
 <YQ0fPEeZGYe7f1cC@google.com> <20210806114541.GY26252@sirena.org.uk> <YREOMY4Q5xY8Qn9N@google.com>
In-Reply-To: <YREOMY4Q5xY8Qn9N@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 10 Aug 2021 17:03:34 +1000
Message-ID: <CAKmqyKMtFYC8KN4pD-8cnUQq39WmOJHDotK6FT2BsisOoM2=8w@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] mfd: simple-mfd-i2c: Save the register client data
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 9:14 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 06 Aug 2021, Mark Brown wrote:
>
> > On Fri, Aug 06, 2021 at 12:38:36PM +0100, Lee Jones wrote:
> > > On Fri, 06 Aug 2021, Alistair Francis wrote:
> >
> > > > + i2c_set_clientdata(i2c, regmap);
> > > > +
> >
> > > No need to store this here.
> >
> > > Just do this in the child device:
> >
> > >      dev_get_regmap(pdev->dev.parent, NULL);
> >
> > Note that dev_get_regmap() is relatively expensive compared to a simple
> > driver data reference since it needs to go search for the device to fin=
d
> > the regmap, it's not the end of the world especially in the context of
> > doing I2C I/O but storing it isn't a terrible idea.
>
> It would be nice if someone could do some metrics on this.

I updated it to use `dev_get_regmap()` in version 10 of the series

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
