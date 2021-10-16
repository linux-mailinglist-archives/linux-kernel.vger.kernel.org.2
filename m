Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8194304E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbhJPU1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhJPU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:27:17 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4CC061765;
        Sat, 16 Oct 2021 13:25:09 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id i22so1326457ual.10;
        Sat, 16 Oct 2021 13:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfkgH+5HDgYtR7YWqYLeCoYstFv8zcTUYf5AcpNjJ8Y=;
        b=gzjZ99UpuYbjT0PK+kWiJAX4ZCdtIxiVsCDjbtjxCHibUt9A+FWvfd5+uenomb6RX+
         hEsLaSTtvrf5C1xrWaN7Zk/uXTy/4P6S/AM54ez6L1BcqyvQsBH4DiDCNDOOqBNR3Vd+
         6AgdufGQHeJ/qXMF6Z4z1RPbDT0DsJyh3dPwO8t4H6mb4hMPhDjC4AgnxHDHGiAAbIPE
         YuK/bzTX1GbfplTddjpcnq49hc8R6nYJKqQYpKTZ/ykEjGXFSFqyyhdUAA0ofN0+r61L
         9oUsliZFu3M0kGR6/zAd6YqFlZpVWqlSZs+rG16+HP+Vz+mQCu/uY09CbjcYz1Dka08t
         2b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfkgH+5HDgYtR7YWqYLeCoYstFv8zcTUYf5AcpNjJ8Y=;
        b=cGArBAGRkLRdchIqwSFouBC7/Psg07KqCtQ0EHjdwO0Ea2PgKr8zl9Us2fW4Ty6rRv
         9PARVHkB+s614a20shoLIYFnsFzSDYa7L/9MiC5Grs3/MNS7v/SP5ozR7KzRnV+a+K+E
         0cVmenmMPHpkKoOlDrdtHwOTgjLIoJU3V3p0VaKRafZd3qVII/hAXs4qcIZtWc6Lr+XU
         gLlxvlCadujr/PXEYPa9N8zie07ngCPZMeEWyUIA8nO7BdswpQDU0fy2TqIItl6Cjvha
         7hcOQ/hXGDWJDoq7K1EfXlQZ6kh03B08Mt8utF0IO0XC0UHobZbbwfr7cqLQqdhBLP15
         PYVg==
X-Gm-Message-State: AOAM5322dQ0LDOcZmDL8lmU9H8HpjPZscp9sH5ZJVEPVKaUu9Dmpo2yP
        UiH2RvAwhzPPhGLaNjW7t1p5j+xyGNDevQjMyIV4QpSo
X-Google-Smtp-Source: ABdhPJy0QIwpDL8uznBiQrJpCC2idBLMA9M4pH9GFWhQ9aEwE2FttTLiILy67Qzl+E8cn6mWOli9Mkp9Ul9518Mx9M0=
X-Received: by 2002:a05:6102:e11:: with SMTP id o17mr3506251vst.55.1634415908603;
 Sat, 16 Oct 2021 13:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211015191741.12963-1-sergio.paracuellos@gmail.com> <YWrgu42kSW/rpijq@robh.at.kernel.org>
In-Reply-To: <YWrgu42kSW/rpijq@robh.at.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 16 Oct 2021 22:24:57 +0200
Message-ID: <CAMhs-H_S+cHYUWmDvfoyx=bbUc2Rr-AW7X7eYwanMTkMK4d=-w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: bus: add palmbus device tree bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, John Crispin <john@phrozen.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 4:25 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 09:17:41PM +0200, Sergio Paracuellos wrote:
> > Add device tree bindings for palmbus controller present in all the MIPS
> > ralink based SoCs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../devicetree/bindings/bus/palmbus.yaml      | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
> > new file mode 100644
> > index 000000000000..d5159a4f3cf8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/palmbus.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/palmbus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ralink PalmBus Device Tree Bindings
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +description: |
> > +  The ralink palmbus controller can be found in all ralink MIPS
> > +  SoCs. It provides an external bus for connecting multiple
> > +  external devices to the SoC.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^palmbus(@[0-9a-f]+)?$"
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  compatible:
> > +    const: palmbus
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  # All other properties should be child nodes with unit-address and 'reg'
> > +  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+$":
>
> The node name pattern is already checked elsewhere. You only need to
> define the unit-address part which should be lowercase hex. So just:
>
> '@[0-9a-f]+$'

Ok, thanks. Changed and send v4.

Best regards,
     Sergio Paracuellos

>
> > +    type: object
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - reg
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    palmbus@1e000000 {
> > +        compatible = "palmbus";
> > +        reg = <0x1e000000 0x100000>
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges = <0x0 0x1e000000 0x0fffff>;
> > +
> > +        syscon@0 {
> > +            compatible = "mediatek,mt7621-sysc", "syscon";
> > +            reg = <0x0 0x100>;
> > +            #clock-cells = <1>;
> > +            #reset-cells = <1>;
> > +            ralink,memctl = <&memc>;
> > +            clock-output-names = "xtal", "cpu", "bus",
> > +                                 "50m", "125m", "150m",
> > +                                 "250m", "270m";
> > +        };
> > +
> > +        wdt@100 {
> > +            compatible = "mediatek,mt7621-wdt";
> > +            reg = <0x100 0x100>;
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.33.0
> >
> >
