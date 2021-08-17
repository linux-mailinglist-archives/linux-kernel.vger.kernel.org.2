Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E83EF520
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhHQVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 17:44:37 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40772 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHQVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:44:35 -0400
Received: by mail-oi1-f180.google.com with SMTP id r5so1308214oiw.7;
        Tue, 17 Aug 2021 14:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZMyVTSz00omtED+yJU35WSO6/6GKOSZju3UYtA2Jto=;
        b=WbpElWXIBUWC7QluQNFxM5aFNs8YCSAqncutXU2vvg/p4FtXPU7qJJm+F2VC2CVI5i
         pxleoBl8eqnfkW3qdKV7qSC6TrdCqWz7Do7NT8RD8yQ9csVheQo9XdmjgP6L83+OIzoh
         jWudOcr0CkNLOksIZ/8PhyNBlThZjOCaY/5Cc5D0ykkEGE33+WiZrlh0hDEtUFJuFBXF
         ZB4YtC4zF0b0XJMbIUssBMdu4mg+GBttEDrGG5NDHyyGJRy/FvZuFjEad8T7f++rSaJO
         +vrlMpVsNx9o0CTbB1yYhHXCeYU2ULVq3gLkfiUTNlDhnQtf2D0HEMV6sOJ1q85vY4k8
         1x+w==
X-Gm-Message-State: AOAM533mVMQqoMgb1ACUGLQn8Nzn8J2b8mOqEysd+tY6oocdK7NWENOT
        86n9ohF6wRgy7CsQ7DM37A==
X-Google-Smtp-Source: ABdhPJz4Jz497LdrZ1zW7H9CD5rs1AWEeBLYA9sSHle3vr/l2xc8jj1U1zg7qlDuXt5XaVqNe/gL6A==
X-Received: by 2002:a05:6808:bd3:: with SMTP id o19mr4201525oik.10.1629236641847;
        Tue, 17 Aug 2021 14:44:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y16sm612500otq.1.2021.08.17.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:44:00 -0700 (PDT)
Received: (nullmailer pid 893186 invoked by uid 1000);
        Tue, 17 Aug 2021 21:43:59 -0000
Date:   Tue, 17 Aug 2021 16:43:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: phy-rockchip-inno-usb2: add
 rk3568 documentation
Message-ID: <YRwtnxucxIeq+ayx@robh.at.kernel.org>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
 <20210812204116.2303617-3-pgwipeout@gmail.com>
 <c7ff9234-cc3b-3679-bc63-73c5eb825269@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ff9234-cc3b-3679-bc63-73c5eb825269@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:52:15PM +0200, Johan Jonker wrote:
> Hi Peter,
> 
> Some comments. Have a look if it's useful.
> 
> On 8/12/21 10:41 PM, Peter Geis wrote:
> > The rk3568 usb2phy node is a standalone node with a single muxed
> > interrupt.
> > Add documentation for it to phy-rockchip-inno-usb2.
> > 
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  .../bindings/phy/phy-rockchip-inno-usb2.yaml  | 31 ++++++++++++++++---
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> > index 5bebd86bf8b6..d2a749c3f9a3 100644
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
> > +    description: Muxed interrupt for both ports
> > +
> 
> This allows every Rockchip SoC dtsi to add an interrupt here.
> You have only restricted the requirements.
> The goal is to restrict things and filter bogus properties.
> If it was done because it doesn't compile, maybe could you try/test/use
> something like the rockchip-io-domain.yaml $defs format.

Don't use $defs unless there's more than 1 copy needed of something. If 
it happens to bypass some checks, it's only a matter of time til I fix 
that.

This may be better solved with another schema file rather than a long 
if/then schema. It's a judgement call.

> 
> ===
> 
> unevaluatedProperties: false
> 
> allOf:
>   - $ref: "#/$defs/rk3568"
> 
> $defs:
>   rk3568:
>     if:
>       properties:
>         compatible:
>           contains:
>             const: rockchip,rk3568-usb2phy
> 
>     then:
>       properties:
>         interrupts:
>           maxItems: 1
> 
>       required:
>         - interrupts
> 
>     else:
>       properties:
>         host-port:
>           properties:
>             interrupts:
>               description: host linestate interrupt
> 
>             interrupt-names:
>               const: linestate
> 
>           required:
>             - interrupts
>             - interrupt-names
> 
>         otg-port:
>           properties:
> 
>            interrupts:
>              minItems: 1
>              maxItems: 3
> 
>            interrupt-names:
>              oneOf:
>                - const: linestate
>                - const: otg-mux
>                - items:
>                    - const: otg-bvalid
>                    - const: otg-id
>                    - const: linestate
> 
>           required:
>             - interrupts
>             - interrupt-names
> 
> >    rockchip,usbgrf:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >      description:
> > @@ -78,8 +82,6 @@ properties:
> >  
> >      required:
> >        - "#phy-cells"
> 
> > -      - interrupts
> > -      - interrupt-names
> 
> Also remove them as properties in this part when a separate $defs is used.
> 
> >  
> >    otg-port:
> >      type: object
> > @@ -109,8 +111,6 @@ properties:
> >  
> >      required:
> >        - "#phy-cells"
> 
> > -      - interrupts
> > -      - interrupt-names
> 
> dito
> 
> >  
> >  required:
> >    - compatible
> > @@ -120,6 +120,29 @@ required:
> >    - host-port
> >    - otg-port
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: rockchip,rk3568-usb2phy
> 
> > +      then:
> 
> Test "if then else" alignment with yamllint

yamllint is not going to help there. What's needed is a meta-schema that 
adds the dependencies.

> 
> > +        properties:
> > +          interrupts:
> > +            maxItems: 1
> > +        required:
> > +          - interrupts
> 
> > +      else:
> 
> alignment
> 
> > +        properties:
> > +          host-port:
> > +            required:
> > +              - interrupts
> > +              - interrupt-names
> > +          otg-port:
> > +            required:
> > +              - interrupts
> > +              - interrupt-names
> > +
> 
> >  additionalProperties: false
> 
> additionalProperties does workn't with allOf: - $ref. Use
> unevaluatedProperties.
> 
> >  
> >  examples:
> > 
> 
