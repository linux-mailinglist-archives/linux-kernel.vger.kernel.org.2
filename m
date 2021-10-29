Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFD440131
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ2RY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJ2RY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:24:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E6C061570;
        Fri, 29 Oct 2021 10:22:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so40378590edi.5;
        Fri, 29 Oct 2021 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkrfRinDn05XJ62yL/+nlM2qH2oXTAeCkRCAcWnxnw0=;
        b=H9rKAiNrUeQrMCQoFX9l/p7voMTdrky481wMjQVKGBp5k/s4R3j3lq+lxC0nSaWoo0
         Q1Et1C5KSr1EHJHR0Xoqw/iJRT5NGmuVpTIqVuB/n1pQNuCHKzFWIHO6xEi6BQSUmYSV
         pKSdTR+K/4Z95LAEF1qQLUA6WzLRyVGyu7jEKXbdHTZsxHQjiCATeA3/KceD1aLHXZVF
         VXgjODTZG8PLy6emegaLCtubLa303QYZ9E+ZFgPBE2nO0eVgumMDONGnosW7WDCbI1Bw
         I2N9a1VQyUpaq7Yyz4K7r1j75mRUOPxD5iwci2MYmXJIwsDXKWwNu81wblNNaWyBL6wJ
         1vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkrfRinDn05XJ62yL/+nlM2qH2oXTAeCkRCAcWnxnw0=;
        b=CqhK/lYHDZQkzH1T2Ry1FbdN2GWXaPyLsYGhXHaNlSxonLfwAAxaxIRz6+SkHQLg+/
         ENcH/2Nd39B4tJt3hXv0jsR16neN9eHx9UbHnSHX8OYNTk3g3rSPoGqLshqfnCVCRqh5
         wqbYgWeowaG/+sC4r8mdRGB1O540/daXlkux30qFQqfoc9xQbdNIcHDoXcF0bpp1mXyT
         C9JWHOw53QdbPWfJh5Gf3eH8SbGf8xR6oT7uGPFVks5J4YTZVaFGUhcbH7YOdsjE/0N3
         pebt2eMyBFAsguEf/TOx5nG8vAQCxjjTeO0Csl4a59B0c6Jas2H3AzyBEcClWuELktEg
         oEsQ==
X-Gm-Message-State: AOAM530xKVUbEN3fp0k51ULIK+8txC1Ieivio5Mx64cFqY9NGJ1qNygW
        vPC2OnR0Ze30FvzO3Bx6jsWFZGC2OtYfFa8RC5s=
X-Google-Smtp-Source: ABdhPJzfnN3F0KsatMWarRZXPkyI+8t6JhYRgFgOlbk5+OAEYalf/nJ182ZFSBq/JGVq9CGDWM+HdjlKsoXCi7BMVn8=
X-Received: by 2002:a05:6402:26d6:: with SMTP id x22mr16677099edd.165.1635528145829;
 Fri, 29 Oct 2021 10:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211009162700.1452857-1-aford173@gmail.com>
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 29 Oct 2021 12:22:14 -0500
Message-ID: <CAHCN7xJnvujdLDznezajSYQqRO=-V+2kxdTUt-b_Wd2povwHJA@mail.gmail.com>
Subject: Re: [PATCH V2 0/9] arm64: imx8mn: Enable additional power domains and peripherals
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 11:27 AM Adam Ford <aford173@gmail.com> wrote:
>
> The blk-ctrl and the GPCv2 in the i.MX8MN is similar but slightly different to that
> of the i.MX8MM.  This series is based on work from Lucas Stach for i.MX8MM, but
> adapted for i.MX8MN.  With the additional power domains and blk-ctrl enabled,
> additional peripherals like gpu and USB can be enabled.
>
> V2:  Add mising patches for expanding GPCv2 which are necessary
>        to make the blk-ctl operate.
>      Fix clk names
>      Fix missing references to structures in blk-ctl driver to link
>        them to the device tree.
>

I know Rob had some feedback on the DT bindings updates.  I can
address them in V3, I was hoping to get some feedback from this series
from others who may be interested.

I don't know if it's too late to get this into 5.16 or not, but I'll
submit a V3 this weekend.

adam
> Adam Ford (9):
>   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
>   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
>   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
>   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
>   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
>   arm64: dts: imx8mn: add GPC node
>   arm64: dts: imx8mn: put USB controller into power-domains
>   arm64: dts: imx8mn: add DISP blk-ctrl
>   arm64: dts: imx8mn: Enable GPU
>
>  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
>  drivers/soc/imx/gpcv2.c                       |  26 +++++
>  drivers/soc/imx/imx8m-blk-ctrl.c              |  75 ++++++++++++-
>  include/dt-bindings/power/imx8mn-power.h      |   5 +
>  5 files changed, 305 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
>
> --
> 2.25.1
>
