Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2F333BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCJLsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCJLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:48:23 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1ECC06174A;
        Wed, 10 Mar 2021 03:48:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n14so17572059iog.3;
        Wed, 10 Mar 2021 03:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MgumKQ8A8vujpcGidnQ3C//AKqkYksiK7PMribHV3ho=;
        b=DYUnOI1xkybUKmjxUsxK/1caGOqEuExlhcOTDQXGlBsUyZc6CRZGuKVBBBULTOVD+P
         aXQM/f5OrhNjI1N8kqj4OVJJq6VRKWOacQ4wnVSC+WconVS3D06jcWFpgMWd4+fcGj7U
         YO3bCVtF/4IFiLXzdDU3KrFSxjQKz/uzYD+eOaA026la9A0q7zn7jCjnAgeeiS3eZDYr
         hTs3eD6uVyZLbk7pptQgtEJZhXd+shP7DyW466TFg7u5B8JREcn8RDDaIAuPUIm7urRj
         s+VBoOhVPPyNtvpqe+NQaeUCeZWUBFWtU18BF37s8A1fwwKdwCy+oP1jgFypQMNy6IYw
         Zr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MgumKQ8A8vujpcGidnQ3C//AKqkYksiK7PMribHV3ho=;
        b=g/JnMepo0ksPEkPwQFJsETeQpw31Mv6rffgMBEmEHPxrI39/kf8b/OKvWNr679Se/o
         D+qJ+2ww2Y88k0BAaQQMUzfTjX4gM5AT2d6kQpeVeqQ3qdLYIdu5lUpbhqMlYoDt2OiF
         DcAOoAyfmPCOgwdNxULCDFArjoxLYruBudWqfUFT/93NjBVP2VuzxCmnNZ6Rws/VfNEm
         GxjTOyI2jsdENGcEnFoGZXN43GtiSJVY/gIyPMyQJRiLP+QW5TgH9KQpgRdSQ0g7dSF6
         A2ja5MdVB0mUzAx1YHxGDLAxI1FBMgVMziPva2fhOQrZxq9QFCQhPPvrM/W5hZjPajSV
         UbiQ==
X-Gm-Message-State: AOAM532pFWqdOpGEA5BS3qZLuchiuhoH3p9y5FuBZU6wfMnLaCtP8rBk
        lp3d7h0gAcXvfw9ZzjMYzwZ2Y2A6/OMdWq1SIz8=
X-Google-Smtp-Source: ABdhPJyhYfR48luq7gEmplvCktrRBwsQTYvkmG1J4Fb6rJ6HGeOYQGGfk9FH8kWfX+Trko7XOFcRrXtMUeiW4aFdkd8=
X-Received: by 2002:a5e:cb4d:: with SMTP id h13mr2073997iok.68.1615376902761;
 Wed, 10 Mar 2021 03:48:22 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 10 Mar 2021 19:47:46 +0800
Message-ID: <CAL9mu0LwT7GqWQY1Dpw3zLnS+oX8KFq=Lrp6NSBJvSgcsxEQVQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board support
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for the device tree part , still waiting review. just a gentle ping.
if Mr Alexandre torgue can take a look, would be great.

thanks,

On Wed, Mar 3, 2021 at 4:05 PM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> This patchset intend to add art-pi board support, this board developed
> by rt-thread(https://www.rt-thread.org/).
>
> Board resources:
>
> 8MiB QSPI flash
> 16MiB SPI flash
> 32MiB SDRAM
> AP6212 wifi,bt,fm comb
>
> sw context:
> - as stm32h750 just has 128k bytes internal flash, so running a fw on
>   internal flash to download u-boot/kernel to qspi flash, boot
>   u-boot/kernel from qspi flash. this fw is based on rt-thread.
> - kernel can be xip on qspi flash or load to sdram
> - root filesystem is jffs2(created by buildroot), stored on spi flash
>
> to support the boad, add following changes.
> - fix r0-r3, r12 register restore failed after svc call,
> - add dts binding
> - update yaml doc
>
> dillon min (8):
>   ARM: ARMv7-M: Fix register restore corrupt after svc call
>   Documentation: arm: stm32: Add stm32h750 value line
>   dt-bindings: arm: stm32: Add compatible strings for ART-PI board
>   dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
>   ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h75x
>   ARM: dts: stm32: add stm32h750-pinctrl.dtsi
>   ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
>   ARM: stm32: add initial support for stm32h750
>
>  Documentation/arm/index.rst                        |   1 +
>  Documentation/arm/stm32/stm32h750-overview.rst     |  33 ++
>  .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
>  .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 392 +++++++++++++++++++++
>  arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +---------------
>  arch/arm/boot/dts/stm32h743.dtsi                   |  30 ++
>  arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  11 +
>  arch/arm/boot/dts/stm32h750.dtsi                   |   5 +
>  arch/arm/boot/dts/stm32h750i-art-pi.dts            | 227 ++++++++++++
>  arch/arm/mach-stm32/board-dt.c                     |   1 +
>  arch/arm/mm/proc-v7m.S                             |   5 +-
>  13 files changed, 716 insertions(+), 302 deletions(-)
>  create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
>  create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts
>
> --
> 2.7.4
>
