Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420EB347D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhCXQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:17:19 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:37579 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhCXQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:16:48 -0400
Received: by mail-il1-f170.google.com with SMTP id z9so21870065ilb.4;
        Wed, 24 Mar 2021 09:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QXqHoBlkPrNwRpEMtYqdUlQOXPQTYdJ14Lsi73wF+Zg=;
        b=irjvXcUNLsPTRh/AVVbJ7tvRR8p74XEXTX3VGAdZjlfXkMgLbo2r1UIEXHja9BYsLc
         0ySoIOPwoum9yd2ArAAkWLfZtxiozqzXfmoJNMEJ9TNZ/ErmeB3AJpSB7DZ5xuOMiGSz
         0Rk2KWiNdZK5xkXGA/FIXPO4NgTCQ5Li5lKK+KaFvHBKZZtTHZMn+S3O8WIYaz4h+eTV
         qxoFa03NwEOW3+t36sfPr0EOegQMshbAA5OG4NDBO1K0Q2NCsPpOmtTMH9CvqjkaJTiF
         CObMlymfjKHc/NbN8b1iDjiA//Kj1EV0ML79qVYWjiN6rnJupb0/Nzx2145U38soF2br
         dJQA==
X-Gm-Message-State: AOAM5332I/U3zKm8HIFkYeFU924sFU/Gskc+aJUBtubpv6hNeaYv0voF
        xQKLp9UBqlfi9rtJmIZUgA==
X-Google-Smtp-Source: ABdhPJzMyvEIIYrr73Ih8QIqBO2t7JAHQThpLoQIFcY0siF6lIGYTH+7kk66x+8FHWGn3D2H2WkCvg==
X-Received: by 2002:a92:5214:: with SMTP id g20mr3131964ilb.260.1616602607879;
        Wed, 24 Mar 2021 09:16:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m20sm1299949ilj.66.2021.03.24.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 09:16:46 -0700 (PDT)
Received: (nullmailer pid 3176722 invoked by uid 1000);
        Wed, 24 Mar 2021 16:16:43 -0000
Date:   Wed, 24 Mar 2021 10:16:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     matthias.bgg@kernel.org, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 2/7] dt-bindigns: regulator: mtk: Drop unneeded compatible
Message-ID: <20210324161643.GA3170381@robh.at.kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
 <20210312145545.26050-2-matthias.bgg@kernel.org>
 <CAFqH_500_xUU9=y1t=FFErD5LwUb8p9KT7qngW_t99_OPQWeVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_500_xUU9=y1t=FFErD5LwUb8p9KT7qngW_t99_OPQWeVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:11:56PM +0100, Enric Balletbo Serra wrote:
> Hi Matthias,
> 
> Thank you for your patch. There is a typo in the subject line
> s/dt-bindigns/dt-bindings/ Rob might miss this patch as he filters the
> patches by subject I guess.

I should, then I'd have a lot less to review...

> 
> Missatge de l'adreça <matthias.bgg@kernel.org> del dia dv., 12 de març
> 2021 a les 15:57:
> >
> > From: Matthias Brugger <mbrugger@suse.com>
> >
> > The regulator does not need to have a device tree compatible, if it's
> > part of an MFD. We leave the node name to the SoC specific name (e.g.
> > mt6323regulator) to allow older kernels to work with the new binding.
> >
> > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > ---
> >  .../bindings/regulator/mt6323-regulator.txt        |  2 +-
> >  .../bindings/regulator/mt6358-regulator.txt        |  4 +---
> >  .../bindings/regulator/mt6397-regulator.txt        | 14 +++++---------
> >  3 files changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> > index a48749db4df36..69f32e1a6702e 100644
> > --- a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> > @@ -19,7 +19,7 @@ LDO:
> >  Example:
> >
> >         pmic: mt6323 {

This one is wrong...

> > -               mt6323regulator: regulators {
> > +               mt6323regulator {

And this was right.

> 
> If you convert this binding to YAML, you'll probably get a review that
> the node name must be just 'regulators' here. And then, looking at the
> other patches something will break I guess ...
> 
> >                         mt6323_vproc_reg: buck_vproc{
> >                                 regulator-name = "vproc";
> >                                 regulator-min-microvolt = < 700000>;
> > diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> > index 9a90a92f2d7e1..ba1214da5bf7c 100644
> > --- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> > @@ -23,9 +23,7 @@ Example:
> >         pmic {
> >                 compatible = "mediatek,mt6358";
> >
> > -               mt6358regulator: mt6358regulator {
> > -                       compatible = "mediatek,mt6358-regulator";
> > -
> > +               mt6358regulator {
> >                         mt6358_vdram1_reg: buck_vdram1 {
> >                                 regulator-compatible = "buck_vdram1";
> >                                 regulator-name = "vdram1";
> > diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> > index c080086d3e629..2b14362ac56e1 100644
> > --- a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> > @@ -1,11 +1,9 @@
> >  Mediatek MT6397 Regulator
> >
> > -Required properties:
> > -- compatible: "mediatek,mt6397-regulator"
> > -- mt6397regulator: List of regulators provided by this controller. It is named
> > -  according to its regulator type, buck_<name> and ldo_<name>.
> > -  The definition for each of these nodes is defined using the standard binding
> > -  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> > +List of regulators provided by this controller. It is named
> > +according to its regulator type, buck_<name> and ldo_<name>.
> > +The definition for each of these nodes is defined using the standard binding
> > +for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> >
> >  The valid names for regulators are::
> >  BUCK:
> > @@ -23,9 +21,7 @@ Example:
> >         pmic {
> >                 compatible = "mediatek,mt6397";
> >
> > -               mt6397regulator: mt6397regulator {
> > -                       compatible = "mediatek,mt6397-regulator";
> > -
> > +               mt6397regulator {
> >                         mt6397_vpca15_reg: buck_vpca15 {
> >                                 regulator-compatible = "buck_vpca15";
> >                                 regulator-name = "vpca15";
> > --
> > 2.30.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
