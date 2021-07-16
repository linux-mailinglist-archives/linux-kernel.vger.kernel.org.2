Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FE3CB780
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhGPMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhGPMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:51:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B762C06175F;
        Fri, 16 Jul 2021 05:48:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f9so11941764wrq.11;
        Fri, 16 Jul 2021 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xp6ybbuSHz6rB1wMPugmVWZSiMCkXBe4SRuGr4tycjs=;
        b=NVfcFSDxbEkQpFfxz0InCCXFkLc89/+kOH8YKIPIe1WyjGm6/pOJkrbHb6akM/1pt1
         JnTd+l4XoGRlMlipVN221E6pdeGL3JS7aso7ysSd5nvG3bYt0zGQWgFaHVtQOeiku8w5
         YhKQqR0hmb5fXpTbb/FF7vdoR2MKUSUYilGLmwWDK4Qmf7Iev4qwP8ECmrBlm7Auitlu
         QwVuO1YmPWiS4GYmkRjWn8sDASwmBK7p7gOmslp1WzLj2s7DN4gLG3rO9yEEYMZy8NhD
         TbCxbX/gW2Gxrau1Mza/2ZKpQnSw3m/2wjxMGtoyC3iCC10pMJrkeQQqScaSQTLG82O3
         i//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xp6ybbuSHz6rB1wMPugmVWZSiMCkXBe4SRuGr4tycjs=;
        b=cjgqduAhJ1M1y82UzfBS17WbGKXwj9QCEny9fxrjlcqyNV8mR3vPM4u6mNbpxBQiOm
         LTpQISZokBa8RQgEHaektrrR6HYdwmrVz81YM5AB7+vi+6VgnC+5QB5a2deGEF5E6KW+
         fDjfwNPpFQ6+y9+yZNuIAQ6Kp3gchj0X0JHZ1Vk2aCZ9IKVSQ6H55CjF8KXnbIjsHIEK
         dRSbjA2bDa4CMRDq3FaibaQA75W0L69UAGzB1sg2dmrlj9TRuCYC9Q8YqP7HLr8/8dUl
         n2ZhO6hmcdue7dqImsntv3IT2UPz4SV4RBpL/KiuDpsfHvLg4GvPf/4oCUX9QLPwIKb8
         D0NQ==
X-Gm-Message-State: AOAM530jLuDgX7nbah270C7jnZf2UlguxL8EDG2XtWbnDDFD4zGKi15P
        wlUKY0LSj3nsVkz4rf0uysyJ7vZluLP3n4tPs1Q=
X-Google-Smtp-Source: ABdhPJwSY5sFwqRsgoleEaGJNPODqiU+d1+8cFQz9ZB5a7U3ukhJm+PjGNGYqd1oqJQfHcGlxZKfrY3xJpr6Q/uLOi0=
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr12126769wrq.350.1626439689741;
 Fri, 16 Jul 2021 05:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210715115853.749025-1-daniel.baluta@oss.nxp.com> <DB6PR0402MB27600097731DB19975A2C4DC88119@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27600097731DB19975A2C4DC88119@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 16 Jul 2021 15:47:57 +0300
Message-ID: <CAEnQRZAJMJxE=iGk2SnGgRGOr0XUeUV5ctEOmuPHBPndFmHz1g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Add dsp node
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 5:05 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Daniel
>
> > Subject: [PATCH] arm64: dts: imx8mp: Add dsp node
> >
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > i.MX8 MPlus SoC integrates Cadence HIFI4 DSP. This core runs either a custom
> > firmware or the open source SOF firmware [1]
> >
> > DSP device is handled by SOF OF driver found in sound/soc/sof/sof-of-dev.c
> >
> > Notice that the DSP node makes use of:
> >       - dsp_reserved, a reserved memory region for various Audio
> >         resources (e.g firmware loading, audio buffers, etc).
> >       - Messaging Unit (mu2) for passing notifications betweem ARM
> >         core and DSP.
> >
> > [1] https://thesofproject.github.io/latest/platforms/index.html
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 28
> > +++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 9f7c7f587d38..264ba540f363 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -135,6 +135,17 @@ clk_ext4: clock-ext4 {
> >               clock-output-names = "clk_ext4";
> >       };
> >
> > +     reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             dsp_reserved: dsp@92400000 {
> > +                     reg = <0 0x92400000 0 0x2000000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> >       pmu {
> >               compatible = "arm,cortex-a53-pmu";
> >               interrupts = <GIC_PPI 7
> > @@ -698,6 +709,13 @@ mu: mailbox@30aa0000 {
> >                               #mbox-cells = <2>;
> >                       };
> >
> > +                     mu2: mailbox@30e60000 {
> > +                             compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";
> > +                             reg = <0x30e60000 0x10000>;
> > +                             interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> > +                             #mbox-cells = <2>;
>
> I think better mark this node as disabled. If its clock not enabled,
> kernel may hang.

Good point. Fixed in v2.
