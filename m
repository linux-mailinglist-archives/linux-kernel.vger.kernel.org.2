Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5173337166
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhCKLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhCKLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:30:44 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8AC061574;
        Thu, 11 Mar 2021 03:30:44 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f20so21464531ioo.10;
        Thu, 11 Mar 2021 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3gZoSD9XMt2F+FjYcYEcTAHARCmwRCAu6NWB4KbPUE=;
        b=PUY5Pqimw/LtaQS015tDeEsb0Na1mCtDp83x5RGTdUv3LPLgMI0AS1uPnsWjW3RtL4
         E3lmr9npg1f/OhjGISD7SW+x/US8XNtv2uAi3aE9c9nwAA1LgOqMZK0RnUYqSV5H8m5N
         3t7ZNkkRdX4VfodDBiHIgA8LzBFnji403cpsyiMCX6jmm1pAded7oBSHIranPa3UJOzs
         DsmR+5/O1UWJoz9DhzF9BkWhHSVUtEDokhRe4PxBYH+cC8Gg3QuklgkC3jJdFHGonWOg
         xT87mWU0eiUgrN0sk1XQ4IZjmcNgtKMJUqu779INoY8UXdPawwQ5kNvSVfh/BsjOmWVo
         Ok2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3gZoSD9XMt2F+FjYcYEcTAHARCmwRCAu6NWB4KbPUE=;
        b=pJI8qaE3S0yd2tsrKdgTLOkKqlbw3YcY36xMtZG4Beyg2lHzHTdN+naACjZ1Ns4IEK
         3xdbIMz+di6irjj2pMeb8gvAYZjyetvUXpykg9WMYrpE8Kj7lK/hNez8IzEwpATFRKWc
         cF5wusmSol+uDK8JPGK2Er+8yn7NnPjghefHtjX02x6mvajKFAURAszzoal+dQSVl9S6
         AThNs2aBptF/a2Xcqr5PuvIobENjKLCM3I5dv4QFeL9StYqsC8a5Xpr01vPXgiXIbkup
         4ncM4wCDHq/Qu07cp61f9TaojxCjhPgqEomDx6j+ZN5qquM+TuFS5BKY0jUHtfc8NLnm
         /Pwg==
X-Gm-Message-State: AOAM532oXu8K9NJpfIWEMUUJyq98z3934ssAFI7cSsqDnu68QeRMq5VK
        pUl9EYwp1/6QMhUtohhtvY77ayJPMAUNXS5ZD8KQs3XZ9oM=
X-Google-Smtp-Source: ABdhPJx75yQq9Oic5WhR5n+pmSd8IkVz6UYuv4TvW8OiGFfJTLOtXs7bupKajR21pW+rwaCgPveGvcy7/KWFeTD88rs=
X-Received: by 2002:a05:6638:388e:: with SMTP id b14mr3156986jav.62.1615462244043;
 Thu, 11 Mar 2021 03:30:44 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <CAL9mu0LwT7GqWQY1Dpw3zLnS+oX8KFq=Lrp6NSBJvSgcsxEQVQ@mail.gmail.com> <AS8PR10MB47127FD40F6782B279B5998BEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS8PR10MB47127FD40F6782B279B5998BEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 11 Mar 2021 19:30:07 +0800
Message-ID: <CAL9mu0LMrtJ+cSdhyTNx-_rsTxZ1jq5Wk7P2R5rOH0OnCHneDA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board support
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Alexandre.torgue@foss.st.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thanks for quickly responding.

On Thu, Mar 11, 2021 at 6:26 PM Alexandre TORGUE
<alexandre.torgue@st.com> wrote:
>
> Hi Dillon
>
> > -----Original Message-----
> > From: dillon min <dillon.minfei@gmail.com>
> > Sent: mercredi 10 mars 2021 12:48
> > To: Rob Herring <robh+dt@kernel.org>; Maxime Coquelin
> > <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> > <alexandre.torgue@st.com>; open list:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-stm32@st-md-
> > mailman.stormreply.com; Linux ARM <linux-arm-
> > kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux@armlinux.org.uk; Vladimir Murzin
> > <vladimir.murzin@arm.com>; afzal.mohd.ma@gmail.com
> > Subject: Re: [PATCH 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board
> > support
> >
> > for the device tree part , still waiting review. just a gentle ping.
> > if Mr Alexandre torgue can take a look, would be great.
> >
>
> Sorry for the delay. For next versions can you send it to
> Alexandre.torgue@foss.st.com please
Okay, I will add your new e-mail address to next review mailing list.
>
> Thanks
> Alex
>
> > thanks,
> >
> > On Wed, Mar 3, 2021 at 4:05 PM <dillon.minfei@gmail.com> wrote:
> > >
> > > From: dillon min <dillon.minfei@gmail.com>
> > >
> > > This patchset intend to add art-pi board support, this board developed
> > > by rt-thread(https://www.rt-thread.org/).
> > >
> > > Board resources:
> > >
> > > 8MiB QSPI flash
> > > 16MiB SPI flash
> > > 32MiB SDRAM
> > > AP6212 wifi,bt,fm comb
> > >
> > > sw context:
> > > - as stm32h750 just has 128k bytes internal flash, so running a fw on
> > >   internal flash to download u-boot/kernel to qspi flash, boot
> > >   u-boot/kernel from qspi flash. this fw is based on rt-thread.
> > > - kernel can be xip on qspi flash or load to sdram
> > > - root filesystem is jffs2(created by buildroot), stored on spi flash
> > >
> > > to support the boad, add following changes.
> > > - fix r0-r3, r12 register restore failed after svc call,
> > > - add dts binding
> > > - update yaml doc
> > >
> > > dillon min (8):
> > >   ARM: ARMv7-M: Fix register restore corrupt after svc call
> > >   Documentation: arm: stm32: Add stm32h750 value line
> > >   dt-bindings: arm: stm32: Add compatible strings for ART-PI board
> > >   dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
> > >   ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h75x
> > >   ARM: dts: stm32: add stm32h750-pinctrl.dtsi
> > >   ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
> > >   ARM: stm32: add initial support for stm32h750
> > >
> > >  Documentation/arm/index.rst                        |   1 +
> > >  Documentation/arm/stm32/stm32h750-overview.rst     |  33 ++
> > >  .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
> > >  .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
> > >  arch/arm/boot/dts/Makefile                         |   1 +
> > >  arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 392
> > +++++++++++++++++++++
> > >  arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +---------------
> > >  arch/arm/boot/dts/stm32h743.dtsi                   |  30 ++
> > >  arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  11 +
> > >  arch/arm/boot/dts/stm32h750.dtsi                   |   5 +
> > >  arch/arm/boot/dts/stm32h750i-art-pi.dts            | 227 ++++++++++++
> > >  arch/arm/mach-stm32/board-dt.c                     |   1 +
> > >  arch/arm/mm/proc-v7m.S                             |   5 +-
> > >  13 files changed, 716 insertions(+), 302 deletions(-)  create mode
> > > 100644 Documentation/arm/stm32/stm32h750-overview.rst
> > >  create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> > >  create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
> > >  create mode 100644 arch/arm/boot/dts/stm32h750.dtsi  create mode
> > > 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts
> > >
> > > --
> > > 2.7.4
> > >
