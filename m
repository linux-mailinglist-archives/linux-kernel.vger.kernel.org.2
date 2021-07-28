Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5103D91AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhG1PTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbhG1PTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:19:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896A4C061757;
        Wed, 28 Jul 2021 08:19:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id q15so4561019ybu.2;
        Wed, 28 Jul 2021 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6eWkFQouDwZToZfzqmLvZAa+8eHzBjwiwsCPEZ3T78=;
        b=oN9p2Q2hKZtCKNVMAT+NVxX1xipwNCvL4SYZ9WviVLfZeJ7CryQ9ipjmT2TDx9uLPZ
         1Xm33ENbeoCwWOM5CaEnziOHXZhHlPkfjq/PyX8Om+HUQOvGJgPjJkuxuYaI2zipt3GJ
         /GMhGb8wYkc2GKJOTVcUSda/yAUyUdgMN9IPEp30RTtQlbNTOyOz4M2JbLyZt4w6jsOI
         QWSJ/y1bfrjCPBKVSTg/W6U4DdFz+UU2GrgGekos3fTJrDfYcjGOJTG7dn2r5rTE5+qS
         TvLTgqMgUZkOrT63KGVItxnAlPD/U6VHa+DhdHdUHcuUU87n0M5Qjkz8Vc/eYhM2PyVO
         MrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6eWkFQouDwZToZfzqmLvZAa+8eHzBjwiwsCPEZ3T78=;
        b=CTAtS76amrAGkxkZiatrWI3SKjYZN/HenAeN/s4HD13ijEoGfPMKtQi1BJqUI+KbsA
         95yE77CzLa5GHMy+AeFWHBFeWrf4AJrq38BjRmvjelGWHz6DWKuJWV2pKJg+FbHasiZu
         ZYNJOq98N9QHXsOoCoGB3c4rh3d5T0VGU6+KSw8SVj20REM8rqwwhi/7uFbPW6G6VJnl
         4QDeria7TIbh+eav58+Ik5hmN2Hl0EURkTFvSbNpPbhnftmOsHbtctmeU1Bx+uZgRIwN
         Qpkof3TF9w3jN97bzYrEGYVUKaU19ulDf39DRppiDKL0CZamXODbeEPJQLKKhKjV5qi3
         nfkg==
X-Gm-Message-State: AOAM532MoVJkShIs3lCPkE96dMjNOkvJAuqxS5oEkwyGjLp3uLMbuWpr
        Ccr8tMMeF0MFduMEHX5tpQChUYcbklULjbp4+OM=
X-Google-Smtp-Source: ABdhPJycH7ZHcpeF3vjYS1kJ8DHksPXaFAYcATKn9VKTTwqXA64ilzqCFgKdeIJ43KoNBtYwMr8NcyT1fRpGgPY1ZCM=
X-Received: by 2002:a5b:48f:: with SMTP id n15mr242372ybp.457.1627485554814;
 Wed, 28 Jul 2021 08:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210728122606.697619-1-pgwipeout@gmail.com> <20210728122606.697619-3-pgwipeout@gmail.com>
 <c7ea6f09-bed0-15d2-1124-44cf98898538@gmail.com>
In-Reply-To: <c7ea6f09-bed0-15d2-1124-44cf98898538@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Jul 2021 11:19:02 -0400
Message-ID: <CAMdYzYoBHZ-8XfcAZ1uGGtT2EEY_wQQoAixhoArsBYVH62pbwA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] dt-bindings: phy: phy-rockchip-inno-usb2: add
 rk3568 documentation
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:14 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Peter,
>
> Some comments. Have a look if it's useful.
>
> On 7/28/21 2:25 PM, Peter Geis wrote:
> > The rk3568 usb2phy node is a standalone node with a single muxed
> > interrupt.
> > Add documentation for it to phy-rockchip-inno-usb2.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml   | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> > index 5bebd86bf8b6..f16fea5cad1c 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> > @@ -18,6 +18,7 @@ properties:
> >        - rockchip,rk3328-usb2phy
> >        - rockchip,rk3366-usb2phy
> >        - rockchip,rk3399-usb2phy
> > +      - rockchip,rk3568-usb2phy
> >        - rockchip,rv1108-usb2phy
> >
> >    reg:
> > @@ -50,6 +51,9 @@ properties:
> >      description:
> >        Phandle to the extcon device providing the cable state for the otg phy.
> >
>
> > +  interrupts:
>
> > +    description: Muxed interrupt for both ports
>
> My spelling checker suggest: Mixed. Don't know what's correct...

It is muxed, all interrupts come over the single line.

>
> > +
>
> For rk3568 only.
> Could you test/use something like this?
>
> if:
>   properties:
>     compatible:
>       contains:
>         const: rockchip,rk3568-usb2phy
>
> then:
>   properties:
>     interrupts:
>       maxItems: 1
>
>   required:
>        - interrupts
>
> >    rockchip,usbgrf:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >      description:
> > @@ -78,8 +82,6 @@ properties:
> >
>
> >      required:
> >        - "#phy-cells"
> > -      - interrupts
> > -      - interrupt-names
>
> These are still required for other Rockchip SoCs.
> Could you test/use something like this?
>
>       if:
>         properties:
>           compatible:
>             contains:
>               const: rockchip,rk3568-usb2phy
>
>       else:
>         required:
>           - interrupts
>           - interrupt-names

This is all sane to me, I'll check to ensure it works.

>
> >
> >    otg-port:
> >      type: object
> > @@ -109,8 +111,6 @@ properties:
> >
>
> >      required:
> >        - "#phy-cells"
> > -      - interrupts
> > -      - interrupt-names
>
> dito
>
> >
> >  required:
> >    - compatible
> >

Thank you for the feedback!
