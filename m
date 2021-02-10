Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED27C317186
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhBJUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhBJUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:41:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F4C06174A;
        Wed, 10 Feb 2021 12:40:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j12so2047779pfj.12;
        Wed, 10 Feb 2021 12:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yhiCvUyqwB+Gy0G+54/j5J/bjxh290iesA/97iqEAo=;
        b=OdRNp4c7kpkYf5N4fUld+qsh3IV2vC1G+QZuGpVTAIxPMLrAd8Hsj+s6MUe1ZYVZzk
         R4oR6A6qNRygdg3bZpb2kc2OBo3vsC2esX4uI3AN8GEAw4o35hw9v+NtI8fLZ8xGEs5F
         FC2XcervKdOtyOpAF2qmgrPJHUWUzX3zSao0sArifhlRa8BsBXtiPbFGJgv6S+ztsgwy
         iJXU2aRC4wy0pRIAU0KCIK7TXKyBDx2FhkzT0Z8pbEgfpad8zEtGOOwHtjxFKydQ9i/p
         2BM+IGJjNy/MssZ5XZXciuIWIWzRVHzl4S15mW/ZCPtlij1ifmIeEKo2ynDB2hEQd3jn
         4xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yhiCvUyqwB+Gy0G+54/j5J/bjxh290iesA/97iqEAo=;
        b=XOZRcc2rPTO1bGr2YHdHaKa8bnj9wMK2PnKqDEYD3s93eBzOQosb3PizoZ5gTmR88b
         GtZ3CHU40ywSQgAMKPIxcGcbUs0N9nQspovZNS0HSrkqk8YLxgR/duHU5cpUepZJBKup
         lEIhVBgMW8bhg4c22B32zBGvG/TCvfpGuxOjhvxm3Pc4bb6GiuUf6tEj+rA+evAFCluC
         eonz4IuzBhe47+SHTmjTo7ANhhhsg1KnullfjmjbhYWvYcmaqgv662wuThW89EeArdi4
         vH1zCgieO7jR8kuZLPi5XVCIb/dNvOOc9kR30wwAl6+11BY5CQI2JzqBiElNw67++aPf
         zWSQ==
X-Gm-Message-State: AOAM530UE/y+K0YQMu04T89c8FpfJj67ldPkjM5UggHSSqnW34e0x2dZ
        KrWazsid97a+ND6XSVw7Fa6lz6NApDt0ZI4pVjLL92vq
X-Google-Smtp-Source: ABdhPJy2FblGuzAVVcOqh4QvALojrRqVJhHUlOaYQIOWyV8p8OzDVYkmAoxVIekTRr9cQaq9lTOvm4vbldoZhAWmIQk=
X-Received: by 2002:a63:2d3:: with SMTP id 202mr4670857pgc.438.1612989649405;
 Wed, 10 Feb 2021 12:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20210207185140.3653350-1-aford173@gmail.com> <20210210201841.GA2688439@robh.at.kernel.org>
In-Reply-To: <20210210201841.GA2688439@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 10 Feb 2021 14:40:38 -0600
Message-ID: <CAHCN7xJwd=u8O33j0Gkaw7=5-k5F=pEuSxqoe+hV=LxAPMk_vQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: clk: versaclock5: Add optional load
 capacitance property
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 2:18 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Feb 07, 2021 at 12:51:38PM -0600, Adam Ford wrote:
> > There are two registers which can set the load capacitance for
> > XTAL1 and XTAL2. These are optional registers when using an
> > external crystal.  Since XTAL1 and XTAL2 will set to the same value,
> > update the binding to support a single property called
> > xtal-load-femtofarads.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  No Change
> > V2:  No Change
> >
> > A couple people suggested that I not use the $ref, but without it,
> > the bindings check failed with errors.
> >
> > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > index 2ac1131fd922..c268debe5b8d 100644
> > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > @@ -59,6 +59,12 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> >
> > +  idt,xtal-load-femtofarads:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Don't need a type with standard unit suffix.

If I remove that line, the binding check fails.

adam
>
> > +    minimum: 9000
> > +    maximum: 22760
> > +    description: Optional load capacitor for XTAL1 and XTAL2
> > +
> >  patternProperties:
> >    "^OUT[1-4]$":
> >      type: object
> > --
> > 2.25.1
> >
