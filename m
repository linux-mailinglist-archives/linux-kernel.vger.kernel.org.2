Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938B144C2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhKJOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhKJOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:12:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3F8610F7;
        Wed, 10 Nov 2021 14:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636553398;
        bh=TMVYRcClMrMnjOkcfX/xyXyhj+iNvrrAbzUfsnvayEg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljpx/m4aTJRauNVKBrH79Skl2ZoqSBnVzJdAuF8LrEWmCQklpmvOoUyemCJN50Uv/
         PBMQbyVQkuEj0XKF4k6BKKdICcMgKbTybKOtH41kIdamMxVN87zZyErrA9VLcS7cW0
         hrKj49GVUT+xQTLcBvPyGyzZQyA6eiw4z2hjeL0Y41T2Ekm4kV5QB7DjEy36hiiHNA
         0eldhJ+bax8oDjP1du5QzE/iKx49sMv7EYcrP6BrB3+rAzKP4Wt4dnKToUm1nLJtwV
         +HxkDSCUe2rVQepa94Cd5vAxqUe1G83HQDn7cPKDKc1St6hBwb2fbg09uTYmk4U8pd
         vL6GYsJ0oX9Fg==
Received: by mail-ed1-f53.google.com with SMTP id f8so11128554edy.4;
        Wed, 10 Nov 2021 06:09:58 -0800 (PST)
X-Gm-Message-State: AOAM533cljPpXlt+nR4Zx2ZgpXYM5dMQOasNLoOPc2QlBb91s8EIcddM
        n9OsdDrEi5F4yZ1gqw/T2lGragALff59gsB2/w==
X-Google-Smtp-Source: ABdhPJyU4ELoHDeudM+kIbrQMYQWl3X6dR1HSEdsyKTwWqp2P6iGsvWxoFhD/ZOE3EKPEWuDy+HvYtFj3NdCtH86FiY=
X-Received: by 2002:a05:6402:50d0:: with SMTP id h16mr21517987edb.70.1636553396848;
 Wed, 10 Nov 2021 06:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20211016133322.40771-1-paul@crapouillou.net> <YYqzT6ZjyQPMisXE@robh.at.kernel.org>
 <S4OB2R.59MVHDUBC2VP3@crapouillou.net>
In-Reply-To: <S4OB2R.59MVHDUBC2VP3@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Nov 2021 08:09:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJcWu1e2ecMLXS8Nt_Wee1raxWATGPm2rDOhthzUGUD4g@mail.gmail.com>
Message-ID: <CAL_JsqJcWu1e2ecMLXS8Nt_Wee1raxWATGPm2rDOhthzUGUD4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Rename Ingenic CGU headers to ingenic,*.h
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        list@opendingux.net, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 2:41 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le mar., nov. 9 2021 at 11:43:43 -0600, Rob Herring <robh@kernel.org> a
> =C3=A9crit :
> > On Sat, 16 Oct 2021 14:33:21 +0100, Paul Cercueil wrote:
> >>  Tidy up a bit the tree, by prefixing all include/dt-bindings/clock/
> >> files
> >>  related to Ingenic SoCs with 'ingenic,'.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>
> >>  Notes:
> >>      v2: Fix x1000-cgu.h and x1830-cgu.h incorrectly renamed to
> >>          x1000.h / x1830.h
> >>
> >>   Documentation/devicetree/bindings/clock/ingenic,cgu.yaml      | 2
> >> +-
> >>   Documentation/devicetree/bindings/display/ingenic,ipu.yaml    | 2
> >> +-
> >>   Documentation/devicetree/bindings/display/ingenic,lcd.yaml    | 4
> >> ++--
> >>   Documentation/devicetree/bindings/dma/ingenic,dma.yaml        | 2
> >> +-
> >>   Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml        | 2
> >> +-
> >>   Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml    | 2
> >> +-
> >>   .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml  | 2
> >> +-
> >>   .../devicetree/bindings/mips/ingenic/ingenic,cpu.yaml         | 2
> >> +-
> >>   Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml        | 2
> >> +-
> >>   Documentation/devicetree/bindings/mtd/ingenic,nand.yaml       | 2
> >> +-
> >>   Documentation/devicetree/bindings/net/ingenic,mac.yaml        | 2
> >> +-
> >>   .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml       | 2
> >> +-
> >>   Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml    | 2
> >> +-
> >>   Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml | 2
> >> +-
> >>   Documentation/devicetree/bindings/rng/ingenic,trng.yaml       | 2
> >> +-
> >>   Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml        | 2
> >> +-
> >>   Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2
> >> +-
> >>   Documentation/devicetree/bindings/sound/ingenic,aic.yaml      | 2
> >> +-
> >>   Documentation/devicetree/bindings/sound/ingenic,codec.yaml    | 2
> >> +-
> >>   Documentation/devicetree/bindings/timer/ingenic,sysost.yaml   | 2
> >> +-
> >>   Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 2
> >> +-
> >>   Documentation/devicetree/bindings/usb/ingenic,musb.yaml       | 2
> >> +-
> >>   arch/mips/boot/dts/ingenic/jz4725b.dtsi                       | 2
> >> +-
> >>   arch/mips/boot/dts/ingenic/jz4740.dtsi                        | 2
> >> +-
> >>   arch/mips/boot/dts/ingenic/jz4770.dtsi                        | 2
> >> +-
> >>   arch/mips/boot/dts/ingenic/jz4780.dtsi                        | 2
> >> +-
> >>   arch/mips/boot/dts/ingenic/x1000.dtsi                         | 2
> >> +-
> >>   arch/mips/boot/dts/ingenic/x1830.dtsi                         | 2
> >> +-
> >>   drivers/clk/ingenic/jz4725b-cgu.c                             | 2
> >> +-
> >>   drivers/clk/ingenic/jz4740-cgu.c                              | 2
> >> +-
> >>   drivers/clk/ingenic/jz4760-cgu.c                              | 2
> >> +-
> >>   drivers/clk/ingenic/jz4770-cgu.c                              | 2
> >> +-
> >>   drivers/clk/ingenic/jz4780-cgu.c                              | 2
> >> +-
> >>   drivers/clk/ingenic/x1000-cgu.c                               | 2
> >> +-
> >>   drivers/clk/ingenic/x1830-cgu.c                               | 2
> >> +-
> >>   .../clock/{jz4725b-cgu.h =3D> ingenic,jz4725b-cgu.h}            | 0
> >>   .../dt-bindings/clock/{jz4740-cgu.h =3D> ingenic,jz4740-cgu.h}  | 0
> >>   .../dt-bindings/clock/{jz4760-cgu.h =3D> ingenic,jz4760-cgu.h}  | 0
> >>   .../dt-bindings/clock/{jz4770-cgu.h =3D> ingenic,jz4770-cgu.h}  | 0
> >>   .../dt-bindings/clock/{jz4780-cgu.h =3D> ingenic,jz4780-cgu.h}  | 0
> >>   .../dt-bindings/clock/{x1000-cgu.h =3D> ingenic,x1000-cgu.h}    | 0
> >>   .../dt-bindings/clock/{x1830-cgu.h =3D> ingenic,x1830-cgu.h}    | 0
> >>   42 files changed, 36 insertions(+), 36 deletions(-)
> >>   rename include/dt-bindings/clock/{jz4725b-cgu.h =3D>
> >> ingenic,jz4725b-cgu.h} (100%)
> >>   rename include/dt-bindings/clock/{jz4740-cgu.h =3D>
> >> ingenic,jz4740-cgu.h} (100%)
> >>   rename include/dt-bindings/clock/{jz4760-cgu.h =3D>
> >> ingenic,jz4760-cgu.h} (100%)
> >>   rename include/dt-bindings/clock/{jz4770-cgu.h =3D>
> >> ingenic,jz4770-cgu.h} (100%)
> >>   rename include/dt-bindings/clock/{jz4780-cgu.h =3D>
> >> ingenic,jz4780-cgu.h} (100%)
> >>   rename include/dt-bindings/clock/{x1000-cgu.h =3D>
> >> ingenic,x1000-cgu.h} (100%)
> >>   rename include/dt-bindings/clock/{x1830-cgu.h =3D>
> >> ingenic,x1830-cgu.h} (100%)
> >>
> >
> > Applied, thanks!
> >
> > I'll let Stephen take patch 2 after rc1.
>
> Perfect, thanks!
>
> I will later send a patch to update the spi/ingenic-spi.yaml example
> (the one that was in linux-next and not yet in master) so that it
> points to the right include.

It's already in Linus' tree. I've included the change to spi/ingenic-spi.ya=
ml.

Rob
