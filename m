Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9917743F2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhJ1W3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhJ1W3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:29:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514F460724;
        Thu, 28 Oct 2021 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635460027;
        bh=IRb7K8Scugbw79p/NGKJBlQoJGry2ngto823hUEGEXs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yf5anAcMBtVVkTQpCbcRofd+PD62RsVQ89MO1qIpqtDDFHWzVAdY203I6unG8xVU0
         XjtsI12TDdIT8OeN6WjCeAZkSftNbH2P8k0Qnhxnfq5cc/pCno4AlAPNTg74KNmInZ
         wp6E9P+jv7OpZqYdmDP7TZw7pwrzHK1lAnKKkw4DOYbvZ+J67/rtMQDBxatHNY1Ec5
         Hb0NwuD5QuAUFntWupLvggdszu8bfFXwXLUjZlQp5+k2CKU+7q40HF8/RnTMwyg66d
         GcglvdZ2hKsG9/xVHTiR3U18t01/IMGlW1ipdwehO14bXwnw0DkGUVR6CStssItnKk
         wHMw1GZf8Carg==
Received: by mail-ed1-f54.google.com with SMTP id h7so31425845ede.8;
        Thu, 28 Oct 2021 15:27:07 -0700 (PDT)
X-Gm-Message-State: AOAM533POUZP1qmbgEGy05Dz9++vxA73Qexs8o6yVk92HwpSVz+jP2vr
        13MZKBEUW00CylzH8EN6DxeS9R9yrpTDc9GeMg==
X-Google-Smtp-Source: ABdhPJzFTlJEyEZBeLoX8gbLZTqeBCF4HRrpqgvzZDMGlEcd9Rlm2NDmyjV99mlD28xMEO+ThsFmdXEcamqMH0cUx/c=
X-Received: by 2002:a05:6402:348c:: with SMTP id v12mr9451716edc.271.1635460025785;
 Thu, 28 Oct 2021 15:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211016133322.40771-1-paul@crapouillou.net> <YXiNLZ9ne8D8uv82@robh.at.kernel.org>
 <VCRO1R.FQ8R7TN6NPYP3@crapouillou.net>
In-Reply-To: <VCRO1R.FQ8R7TN6NPYP3@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Oct 2021 17:26:54 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wU=R_F3iNRfMaZtKUftQLDR2d-4Mt98QMWgt3HkOvQQ@mail.gmail.com>
Message-ID: <CAL_Jsq+wU=R_F3iNRfMaZtKUftQLDR2d-4Mt98QMWgt3HkOvQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Rename Ingenic CGU headers to ingenic,*.h
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, list@opendingux.net,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 6:46 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le mar., oct. 26 2021 at 18:20:13 -0500, Rob Herring <robh@kernel.org>
> a =C3=A9crit :
> > On Sat, Oct 16, 2021 at 02:33:21PM +0100, Paul Cercueil wrote:
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
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > However, this will be a pain to merge if there are any new users
> > coming
> > in during the merge window. If not, then Stephen can just take this.
> > If
> > there are, then at the end of the merge window is the best time. For
> > that to work, you need to track when all dependent changes are merged
> > and we need to agree who will pick this up. I usually have fixes from
> > breakages in the merge window anyways.
>
> I get Cc'd on all ingenic-related patches, so far I don't see anything
> that will cause a breakage. I think it would be okay to merge it now
> (we're at -rc7 after all).

Then can you apply this to linux-next and check it all works there.
Specifically, 'make dt_binding_check dtbs drivers/clk/' needs to work.
Or confirm you already did that.

Rob
