Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581C43DB8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhG3Mqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbhG3Mos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:44:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A2C0617A3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:44:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b21so12135115ljo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5XQMaz35GQWI34eEmf85Zx/0SDB9xb9F4beO3eG0XQ=;
        b=RpUdgmOB94oKKBxx25fYPzJfPirqOqPOiI9Az6hFs3LBDAaNX33ixBDdZbSkXcVt2y
         orsjULwTyJ19wTZ7kDCwurpUtf2DoJZdKM2dz/Prd0WCs6z1DINKVUc2r2+4AYOtOGVa
         z1vVE0jOOuH348DsSgMLXLJnnwApuZyvpe4OWpuTjDeVYbw44TC9iRRKjaGmJpv2Vrb9
         +8+i06tBsvnfM+RZtu+r3Yv2tCwYQVMWce5oLHcllClGJrtK9tjzosAVZdxSEQ8x1u1H
         bWd6rdj7+yh+fWGtT+mZdgOpGLLZsiYMgk6ev3FuwwfCJ3f2Evxc9L2hacEvhFfUFAgh
         QSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5XQMaz35GQWI34eEmf85Zx/0SDB9xb9F4beO3eG0XQ=;
        b=mByfEDUwIrcwylWVy6DctuTE7u6xiB/FL52v9fnWB5RWB2AFYrySH1iDyx0xxDyujl
         7K1wkSMJBcKbI1sgmtAMug/S0lRrT/RWbGFkab8s0/KNcaFzvZGhEQTWW7c5de2htkcb
         kFZlFsTKYNkVcwyNQMu+91CmHo2UFPNz6UGaSZCqwVwEXLc37YkxZG6i0VSh6xO5jhe+
         WSRqLPaA1aqMpoiHinfafICBN/Y2NmrX2JyqXooMYyVjm2vK9qEAS5xsptfPg1lLW0dA
         H66l4IFCe2l8s8t9U3hcEEEgvh2Z0zI2mtwzCegrtbxEyjv9cSVKTjOp2PK2JTWZzCHl
         hC3A==
X-Gm-Message-State: AOAM533OpRYn9ecGvYDo4kQZ6V6tG0HBfGDhc0PgnuT9LydXUiL+K4rd
        DpyimOZG718J0DZdLMPBSDbCjw1GyH13BGVoPrMy0w==
X-Google-Smtp-Source: ABdhPJxtTbhsXYkjhw0pIqrXNFx09EJLycc+oiEbbtK8QeKVWUojjl8+nDB0lnoHOK7O+8o+Hx46gdF6gTSo1NaQeTM=
X-Received: by 2002:a05:651c:169a:: with SMTP id bd26mr1511169ljb.368.1627649048309;
 Fri, 30 Jul 2021 05:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <1626868353-96475-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1626868353-96475-5-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com> <YQMIhBPwcNw1YqMq@robh.at.kernel.org>
In-Reply-To: <YQMIhBPwcNw1YqMq@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 14:43:57 +0200
Message-ID: <CACRpkdYrHTMLL_CQi0BoNZsXV3=2dBK38pkvd+EEkuPrzoG_Cw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm: dts: zynq: Replace 'io-standard' with
 'power-source' property
To:     Rob Herring <robh@kernel.org>
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 9:59 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jul 21, 2021 at 05:22:33PM +0530, Sai Krishna Potthuri wrote:
> > Replace 'io-standard' property with 'power-source' property in all zynq dts
> > files to be in sync with Zynq pinctrl driver.
> >
> > Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> > ---
> >  arch/arm/boot/dts/zynq-ebaz4205.dts |  8 ++++----
> >  arch/arm/boot/dts/zynq-microzed.dts |  2 +-
> >  arch/arm/boot/dts/zynq-zc702.dts    | 20 ++++++++++----------
> >  arch/arm/boot/dts/zynq-zc706.dts    | 18 +++++++++---------
> >  4 files changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/zynq-ebaz4205.dts b/arch/arm/boot/dts/zynq-ebaz4205.dts
> > index b0b836aedd76..be7eae611fb7 100644
> > --- a/arch/arm/boot/dts/zynq-ebaz4205.dts
> > +++ b/arch/arm/boot/dts/zynq-ebaz4205.dts
> > @@ -57,7 +57,7 @@
> >
> >               conf {
> >                       groups = "gpio0_20_grp", "gpio0_32_grp";
> > -                     io-standard = <3>;
> > +                     power-source = <3>;
>
> This will break using a new DT with a kernel without patch 3.

The old (Linux) kernel never supported the "io-standard" property
anyway.

Unless someone is running som BSD or Windows with support for
this property it can be merged by the quality of zero real-world
impacts (no-one there to hear the tree fall in the forest).

Sai Krishna: correct?

Yours,
Linus Walleij
