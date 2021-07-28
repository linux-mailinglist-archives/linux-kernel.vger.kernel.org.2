Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8323D91B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhG1PUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhG1PUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:20:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42830C061757;
        Wed, 28 Jul 2021 08:20:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p145so3494279ybg.6;
        Wed, 28 Jul 2021 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C9e4N76VZyEvVhCoJ57+DYxJLCF2oxGdBxIJxV6PGVU=;
        b=CFgFbL44s+UPKBdiA2vhX8GjtA7RaAE2vpOFqAxLycDqjTP64RMRTWR7qrqUNYHiYq
         DL6eaVMJ1jwNsLi6mS7RhBy0UyU4TNoVwTVZ+uvWpCeCGdgTqkXlN9FePkQ0Lh4/aEBF
         JWPCx08mcGnGFnVtt3JIGHWEfBFeTlCRM1taZdRyyb81ehxgy1fJ9bdanexy8PtQgurQ
         1OMusjT7ycl/Eszzk8ah31ZIqsDCKTSzb/MUWN6oNALiYg+n7WU8IWwn1QKs/80qSAvi
         2+TOaMRuVwT+HCX+VDtiRj4Fl3mockQVaNT51tcgE0jFjIliUokh/9z548h1/JFkIOha
         +eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C9e4N76VZyEvVhCoJ57+DYxJLCF2oxGdBxIJxV6PGVU=;
        b=jlPjHEQnZUZZQtPPxN06ppJpW9U8Pi2nTje/wngXsMoydel9Ifg+SO3bcpu0/Sft10
         hzgwVDuE0BiFwWji3gqjoEXttmK1ntfwecVTqnUnTuDnd4OdeOrpq0Rj81LWn0B5BrBe
         JRL5j2hVOVaF9sd9AsW8RjIMe8JvecOeQ4q1U81RBEUOjlrzK4SThi4S4RVg1Mo557tg
         YI3RBwyJNNeAxArY/0cbAJr2GfYWeummf4bjEWoy3nrJ8LMqFKToeZWo4HkyYgfTduFc
         yYNyZH/SVsx++uaKzPnmOzLZ5XP+FwCIlbRfEViHmuQvBn0zjTO8BZYIEGIvG2Qtg8gO
         Vgvw==
X-Gm-Message-State: AOAM532Cr8VZRykqmdHqlJszFMOXVj1RDaw5KG2N0J5bEEWIa5mgGfTN
        QKpaOnXbC+23ciyAi+obmTqyP5vLSgFRJCoBL0g=
X-Google-Smtp-Source: ABdhPJyU3e/C/5c1p9vu84o+w1Z8Xd+bdL5IDbjuLp5JPTUVvRN7Jgosu43o7A0ZYvayBICL1tceMp6z5a5uBGrDI4o=
X-Received: by 2002:a5b:303:: with SMTP id j3mr227992ybp.433.1627485616549;
 Wed, 28 Jul 2021 08:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210728122606.697619-1-pgwipeout@gmail.com> <20210728122606.697619-4-pgwipeout@gmail.com>
 <3733382.QJadu78ljV@diego>
In-Reply-To: <3733382.QJadu78ljV@diego>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Jul 2021 11:20:03 -0400
Message-ID: <CAMdYzYpcqJHedu=xBBLC60j1wcFQ9zL1R73ahKy33RjUnw2xKA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] dt-bindings: usb: generic-ohci: increase maximum clocks
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:59 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Hi Peter,
>
> Am Mittwoch, 28. Juli 2021, 14:26:00 CEST schrieb Peter Geis:
> > The rk3568 generic ohci controller has four clocks.
> > Increase the maximum clocks in the documentation to account for this.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/=
Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > index 569777a76c90..850996e6f451 100644
> > --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > @@ -59,7 +59,7 @@ properties:
> >
> >    clocks:
> >      minItems: 1
> > -    maxItems: 3
> > +    maxItems: 4
> >      description: |
> >        In case the Renesas R-Car Gen3 SoCs:
> >          - if a host only channel: first clock should be host.
> >
>
> In the patch adding the usb nodes, I see that this 4th clock references
> the clock generated inside usbphy itself.
>
> Does the usb controller actually use that or is this just a way to
> enable the usbphy clock, which in that case should maybe just happen
> on phy-power-on in the phy driver?

I'll check if it works without it.

>
>
> Heiko
>
>
