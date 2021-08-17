Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8A3EE656
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhHQFpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 01:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhHQFo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 01:44:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3899C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:44:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h11so30995605ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOKejl87y0ski0VdMRkyNRA2v7H+vqyupx7Esp13/wE=;
        b=a6IvKzyOyIQZqQYz+g/aLPoRbm5h20bCZsjIxf2QcwFz0VIyf7oEIDWaVkrgyH8dVy
         h4m6QRA7pfehKCUKoALq+XGDZt5U7OBbb0gKEDtP7fuIogf7goHUm/xLrW3OSFHRYE/2
         l/S0skrt0NKW06MSkEcsSsY+vfCoBhM6F24NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOKejl87y0ski0VdMRkyNRA2v7H+vqyupx7Esp13/wE=;
        b=bEO7cT5jyenpyWy4iWu36qkI8KxpAghA7kFFwQMbj/KA5MeJAz1R1S1GXKWGe7ryje
         EHUj7+uka4awX53z0WiSFzcptGr57IFZS8ZrWWbxE7m75n7KkLrRT7P4iNh3pq3p4QCE
         sZIbLUEsTbgE0HwcMnL3XrO6g7cI63/2gexLiYE9zFVQ7RCQ/U2KhFWV5ZOw/LYKlBKp
         vpwp6HSx/5Q666CsEapl55F+X9y56cegw1RXOVVe+NTAALN0Mx5qPEG24+xxNLViW8Pi
         M/Td3Pm21V7u+u0QS67jA8CGVxU+BHOrFVfAYmUXabzQ85ywKznQ6PqsLh3AHRm8m9L9
         FoqA==
X-Gm-Message-State: AOAM532E8Dvn2faPowTNElDySuYjSLu+UcfzmH+jLGUOx1Pm+RVm4xu8
        q9dKpGG+VjSDJDOQ7sYBm2S79LgCJKgoa7sbnHzWcA==
X-Google-Smtp-Source: ABdhPJwDdjRJIqMRTx/tVA7vEY9ayN6r0dWnuWHx5K0aCWGb+5ATkAUHpOt5qq3zzCPruae3ZI8O0IO36YD+eRA8lIM=
X-Received: by 2002:a05:651c:1785:: with SMTP id bn5mr1677465ljb.18.1629179065185;
 Mon, 16 Aug 2021 22:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210710081722.1828-1-zhiyong.tao@mediatek.com>
 <20210710081722.1828-2-zhiyong.tao@mediatek.com> <CAGXv+5GXg0RuOQkh4vaRmcLpehZiXnEUXBvEaObiatAa1sXvaA@mail.gmail.com>
 <1626940470.29611.9.camel@mhfsdcap03> <CAGXv+5F_-W4aNt0WVSDBGLo_t8orNUq59GMKk_4xVr+hMb9Ctg@mail.gmail.com>
 <07388dac4e25e0f260725e8f80ba099d5aa80949.camel@mediatek.com>
 <CAGXv+5EagmhYYpri+nzo6WgGz8A=oiU3Vy+2AVjho=eo6Z+DLw@mail.gmail.com>
 <CACRpkdZ4k9Km3vBtdN6AnBM89c4355GtPMzCQ0_YHaTb4V5cKA@mail.gmail.com>
 <CAGXv+5HohMwU8jow5QXO5MK1tO+u=5YsfhArBWCP4Dgm1Q8igg@mail.gmail.com>
 <4fd12d5c53f6492e5fa3ba94a78b9a149f5b6ed9.camel@mediatek.com>
 <CAGXv+5GCuNK=-z9VAOjkpJdZLUSZFPfUsQ09m1FhfTsbCYLLRw@mail.gmail.com>
 <CACRpkdbZKh8cqqiDRUik6Ooo33e+feGwYsLjcLRvBQnT3x5M3A@mail.gmail.com> <a7c8ab68ac3513865698cde27e665bdd554f459e.camel@mediatek.com>
In-Reply-To: <a7c8ab68ac3513865698cde27e665bdd554f459e.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 17 Aug 2021 13:44:13 +0800
Message-ID: <CAGXv+5FtL2zaSWx4tUymx6mpCSb5dXG4XNWM9AJL+b6Ok3dxMg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: pinctrl: mt8195: add rsel define
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:21 AM zhiyong.tao <zhiyong.tao@mediatek.com> wrote:
>
> On Tue, 2021-08-17 at 01:00 +0200, Linus Walleij wrote:
> > On Mon, Aug 16, 2021 at 5:38 PM Chen-Yu Tsai <wenst@chromium.org>
> > wrote:
> > > On Mon, Aug 16, 2021 at 6:48 PM zhiyong.tao <
> > > zhiyong.tao@mediatek.com> wrote:
> > > > > I'll take that as "use SI units whenever possible and
> > > > > reasonable".
> > > >
> > > > ==> so It doesn't need to change the define, is it right?
> > > > we will keep the common define.
> > >
> > > Actually I think it would be possible and reasonable to use SI
> > > units
> > > in this case, since you are the vendor and have the resistor values
> > > to implement the support. Having different sets of values for
> > > different
> > > chips is nothing out of the ordinary. We already have to account
> > > for
> > > different number of pins and different pin functions. That is what
> > > compatible strings are for.
> >
> > I fully agree with Chen-Yu's analysis here.
> >
> > Zhiyong can you make an attempt to use SI units (Ohms) and see
> > what it will look like? I think it will look better for users and it
> > will
> > be less risk to make mistakes.
> >
> > Yours,
> > Linus Walleij
>
> Hi Linus & chen-yu,
>
> The rsel actual bias resistance of each setting is different in
> different IC. For example, in mt8195, the rsel actual bias resistance
> setting like as:
> MTK_PULL_SET_RSEL_000:75K in PU, 75k in PD;
> MTK_PULL_SET
> _RSEL_001:10k in PU, 5k in PD;
> MTK_PULL_SET_RSEL_010:5k in PU, 75k in
> PD;
> MTK_PULL_SET_RSEL_011:4k in PU, 5K in PD;
> MTK_PULL_SET_RSEL_100:3k in
> PU, 75k in PD;
> MTK_PULL_SET_RSEL_101:2k in PU, 5K in PD;
> MTK_PULL_SET_RSE
> L_110:1.5k in PU, 75k in PD;
> MTK_PULL_SET_RSEL_111:1k in PU, 5k in PD.
>
> but in mt8192, the rsel actual bias resistance setting like as:
> MTK_PULL_SET_RSEL_000:75K in PU, 75k in PD;
> MTK_PULL_SET_RSEL_001:3k in PU, 5k in PD;
> MTK_PULL_SET_RSEL_010:10k in PU, 75k in PD;
> MTK_PULL_SET_RSEL_011:1k in PU, 5K in PD;
>
> Can you help me to provide a suggestion common define for the all
> different IC?
> It seems that we should add a new define, if we upstream a new IC
> pinctrl driver in the future.

I assume you mean the macros used in the device tree?

The point of using SI units is to get rid of the macros. Instead of:

    bias-pull-up = <MTK_PULL_SET_RSEL_000>;

and

    bias-pull-down = <MTK_PULL_SET_RSEL_011>;

We want:

    bias-pull-up = <75000>;

and

    bias-pull-down = <5000>;

And the pinctrl driver then converts the real values in the device tree
into register values using some lookup table.

The DT schema could then enumerate all the valid resistor values,
and get proper validity checking.

Now if you really wanted to keep some symbols for mapping hardware
register values to resistor values, you could have

    #define MT8192_PULL_UP_RSEL_001      75000
    #define MT8192_PULL_DOWN_RSEL_001     5000

or have them all named MTK_PULL_{UP,DOWN}_RSEL_NNN, but split into
different header files, one per SoC.

Personally I think having the macros is a bad idea if proper values
are available. It just adds another layer of indirection, and another
area where errors can creep in.


Regards
ChenYu
