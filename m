Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A038B2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbhETPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhETPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:21:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8786261363;
        Thu, 20 May 2021 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621523999;
        bh=Vng7zXwIuCJZVNFsguZzrjtqA8ZMldPUOAscXDMmFRo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rICx6Jk4tyojHV8FMJ8B03JlTP8KcuDStU90JQ9K00pCmrh0egKgRnhnXf0D0DOcU
         70cPXvmX6by1fVF0blg8xgVIQbZZWyJeyHjb4d0hrcXTH1BSNysVKxCg5XUb9Oh7ou
         zFTTOWys6tDYXOUu3JHfJ/uGdtHQiOPQtiOeDoUr7aRD+mbTQviSBt/NFg7EQqYsBC
         RPHbO4D7/Ow9iVNQbyi/U268/ooa+aWcZAZhpat4ERPZ1PnID6d07G9XJ+J3FvKYrq
         kfF38x4Ff4dBdUvQi+Vj7KTHy44ud3vK0k6aEPAYlGo/Vy6P8+GqJ58cT2mcQGTHKr
         FxX9KwWfl1dng==
Received: by mail-ej1-f51.google.com with SMTP id gb17so7878444ejc.8;
        Thu, 20 May 2021 08:19:59 -0700 (PDT)
X-Gm-Message-State: AOAM532P1j2W4G4ItOCawgpKNNeHpEGfrRp39du+hN1kGPSN/GSW+dxN
        cqVKFbeJ2eApBDsTXKzRQHouEnbnvka2eZhHnA==
X-Google-Smtp-Source: ABdhPJwuQcGsfmiQL/tncYJdsumLLsd3GPx7QZ7OaLVcAr3r6WR2jZZdtUn5xwCWFoMQdZS7l7ws1RWUSvQepiUyXhc=
X-Received: by 2002:a17:907:78cd:: with SMTP id kv13mr5189426ejc.360.1621523998020;
 Thu, 20 May 2021 08:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210518232858.1535403-1-robh@kernel.org> <20210518232858.1535403-2-robh@kernel.org>
 <72b27bc0-838c-fd7d-32f8-bc00f8508d1d@ti.com>
In-Reply-To: <72b27bc0-838c-fd7d-32f8-bc00f8508d1d@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 May 2021 10:19:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLXK6nY9qHRdYK0VGCjAMmkKktWXe9rjkY6rsveYinhRg@mail.gmail.com>
Message-ID: <CAL_JsqLXK6nY9qHRdYK0VGCjAMmkKktWXe9rjkY6rsveYinhRg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: ti,j721e-system-controller: Fix mux
 node errors
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 9:42 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 19/05/21 4:58 am, Rob Herring wrote:
> > The ti,j721e-system-controller binding does not follow the standard mux
> > controller node name 'mux-controller' and the example is incomplete. Fix
> > these to avoid schema errors before the mux controller binding is
> > converted to schema.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../mfd/ti,j721e-system-controller.yaml       | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > index 19fcf59fd2fe..272832e9f8f2 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > @@ -43,12 +43,10 @@ properties:
> >
> >  patternProperties:
> >    # Optional children
> > -  "^serdes-ln-ctrl@[0-9a-f]+$":
> > +  "^mux-controller@[0-9a-f]+$":
> >      type: object
> > -    description: |
> > -      This is the SERDES lane control mux. It should follow the bindings
> > -      specified in
> > -      Documentation/devicetree/bindings/mux/reg-mux.txt
> > +    description:
> > +      This is the SERDES lane control mux.
> >
> >  required:
> >    - compatible
> > @@ -68,9 +66,18 @@ examples:
> >          #size-cells = <1>;
> >          ranges;
> >
> > -        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> > +        serdes_ln_ctrl: mux-controller@4080 {
> >              compatible = "mmio-mux";
> >              reg = <0x00004080 0x50>;
>
> "mmio-mux" compatible doesn't define using "reg" property. But a system
> can have multiple mux-controllers which would require us to use
> mux-controller@0, mux-controller@1,..

It does now in patch 3 as part of the schema conversion. It's optional
as getting folks to use 'reg' for syscon child nodes is an uphill
battle.

Rob
>
> And IIRC if we have "@", 'reg' will be a required required property.
> Would it be an issue here?
>
> Thanks
> Kishon
