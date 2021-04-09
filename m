Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697EB359173
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhDIB26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:28:57 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B76C061760;
        Thu,  8 Apr 2021 18:28:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u3so1902820qvj.8;
        Thu, 08 Apr 2021 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=1nd1zrOJxkb2H8zst/bpfvU3v6ARcnkntcly2FZiX3w=;
        b=oYuQd05kigAV2xeiUc1nOCPZT8kxpBmstPuIcn7BRRfN34VIs5CYfzxS1QJ7lFc8oO
         6eieSZYKRV5p5sQ+kDIKkE8cYVD4+z+DgPqsbzrebTxCeW0GOpUGyIoClUv8lGBhxf4q
         FIbd+Z680QfTO+03Lz0RsTowUcJ4EwkctLfcvhNfWlClzwkDm4cLK/ueu/xl0Hfji9N6
         tVwTPe9nGIVaCChp451vbYPVuNBDJTId4Q6qPkqyArwrvVaLjvQyukN7ve1oO24bnYjO
         aQ5XRjBJjneQ6S6nISqFBMawVTccnpFk02GaH7Kw+GTtFflXldiGkvQGi83OCRKvPYPV
         FEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=1nd1zrOJxkb2H8zst/bpfvU3v6ARcnkntcly2FZiX3w=;
        b=H4ayfPwjfWWqF1aJhY2KszVqporDo5wUBF7uS9k+0VN60msP0i5q/YtF4ZApkq27+Y
         adejHu/f0sX/vykrb9JWZQfxHUH+d6EfvhZPE2uCJxb56kFDcJ2WQM4WUMgtLIxguSk4
         1KEZJN2FtU5nNuOiQxR46XFCSQ8uLjrih9oF+B54JrnIsCni6acfOmD2coeVum+JFY9L
         OU/G9ZsqYgMjxFUSlCicCCgE8X7keArdhZNiirgaiegcb94C/JFCUHYU9fU48MfKO3va
         TVcBbLu34FOHXBhhdlOmGWLFKOVujjgbYEf9VGQURbx3VN6MeCIuzzvosACQsaVl/qMj
         tdGg==
X-Gm-Message-State: AOAM533EZWJGkstjWWfGGW1ao2Cb4HpaC6k2BflNz2U516/d3Ofs7oQ8
        PnSpaR8we00WFTNsrczBnXyg1scw8KkDv+EH
X-Google-Smtp-Source: ABdhPJyadvptk+KR6Zzuwdmo6DsGctjbQF28VqYLJejNf+xZnjju2XXBPDQlRRMnJz71+RkjFcWhmA==
X-Received: by 2002:a05:6214:204:: with SMTP id i4mr11888545qvt.47.1617931724379;
        Thu, 08 Apr 2021 18:28:44 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id c19sm846743qte.75.2021.04.08.18.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 18:28:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Apr 2021 21:28:42 -0400
Message-Id: <CAISXGCUW7ZQ.3N1ABIICBHUHE@shaak>
Cc:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: clock: add ti,lmk04832 bindings
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Rob Herring" <robh@kernel.org>
References: <20210407005330.2890430-1-liambeguin@gmail.com>
 <20210407005330.2890430-4-liambeguin@gmail.com>
 <20210408201333.GA1882021@robh.at.kernel.org>
In-Reply-To: <20210408201333.GA1882021@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 8, 2021 at 4:13 PM EDT, Rob Herring wrote:
> On Tue, Apr 06, 2021 at 08:53:30PM -0400, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Document devicetree bindings for Texas Instruments' LMK04832.
> > The LMK04208 is a high performance clock conditioner with superior cloc=
k
> > jitter cleaning, generation, and distribution with JEDEC JESD204B
> > support.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../bindings/clock/ti,lmk04832.yaml           | 209 ++++++++++++++++++
> >  1 file changed, 209 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832=
.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b=
/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> > new file mode 100644
> > index 000000000000..a9f8b9b720fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> > @@ -0,0 +1,209 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/ti,lmk04832.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Clock bindings for the Texas Instruments LMK04832
> > +
> > +maintainers:
> > +  - Liam Beguin <liambeguin@gmail.com>
> > +
> > +description: |
> > +  Devicetree binding for the LMK04832, a clock conditioner with JEDEC =
JESD204B
> > +  support. The LMK04832 is pin compatible with the LMK0482x family.
> > +
> > +  Link to datasheet, https://www.ti.com/lit/ds/symlink/lmk04832.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,lmk04832
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  spi-max-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Maximum SPI clocking speed of the device in Hz.
>
> Already has a type and description, just need:
>
> spi-max-frequency: true
>
> (Or a range of values if you know the maximum).
>

I have the max, will use that instead.

> > +
> > +  clocks:
> > +    items:
> > +      - description: PLL2 reference clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: oscin
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  ti,spi-4wire-rdbk:
> > +    description: |
> > +      Select SPI 4wire readback pin configuration.
> > +      Available readback pins are,
> > +        CLKin_SEL0 0
> > +        CLKin_SEL1 1
> > +        RESET 2
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 1
> > +
> > +  ti,vco-hz:
> > +    description: Optional to set VCO frequency of the PLL in Hertz.
> > +
> > +  ti,sysref-ddly:
> > +    description: SYSREF digital delay value.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 8
> > +    maximum: 8191
> > +    default: 8
> > +
> > +  ti,sysref-mux:
> > +    description: |
> > +      SYSREF Mux configuration.
> > +      Available options are,
> > +        Normal SYNC 0
> > +        Re-clocked 1
> > +        SYSREF Pulser 2
> > +        SYSREF Continuous 3
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +    default: 3
> > +
> > +  ti,sync-mode:
> > +    description: SYNC pin configuration.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 1
> > +
> > +  ti,sysref-pulse-count:
> > +    description:
> > +      Number of SYSREF pulses to send when SYSREF is not in continuous=
 mode.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8]
> > +    default: 4
> > +
> > +patternProperties:
> > +  "@[0-9a-d]+$":
> > +    type: object
> > +    description:
> > +      Child nodes used to configure output clocks.
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          clock output identifier.
> > +        minimum: 0
> > +        maximum: 13
> > +
> > +      ti,clkout-fmt:
> > +        description:
> > +          Clock output format.
> > +          Available options are,
> > +            Powerdown 0x00
> > +            LVDS 0x01
> > +            HSDS 6 mA 0x02
> > +            HSDS 8 mA 0x03
> > +            LVPECL 1600 mV 0x04
> > +            LVPECL 2000 mV 0x05
> > +            LCPECL 0x06
> > +            CML 16 mA 0x07
> > +            CML 24 mA 0x08
> > +            CML 32 mA 0x09
> > +            CMOS (Off/Inverted) 0x0a
> > +            CMOS (Normal/Off) 0x0b
> > +            CMOS (Inverted/Inverted) 0x0c
> > +            CMOS (Inverted/Normal) 0x0d
> > +            CMOS (Normal/Inverted) 0x0e
> > +            CMOS (Normal/Normal) 0x0f
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0
> > +        maximum: 15
> > +
> > +      ti,clkout-sysref:
> > +        description:
> > +          Select SYSREF clock path for output clock.
> > +        type: boolean
> > +
> > +    required:
> > +      - reg
>
> additionalProperties: false
>

additionalProperties is defined just below required.
Should I move it here?

Thanks,
Liam

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clocks {
> > +        lmk04832_oscin: oscin {
> > +            compatible =3D "fixed-clock";
> > +
> > +            #clock-cells =3D <0>;
> > +            clock-frequency =3D <122880000>;
> > +            clock-output-names =3D "lmk04832-oscin";
> > +        };
> > +    };
> > +
> > +    spi0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        lmk04832: clock-controller@0 {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            reg =3D <0>;
> > +
> > +            compatible =3D "ti,lmk04832";
> > +            spi-max-frequency =3D <781250>;
> > +
> > +            reset-gpios =3D <&gpio_lmk 0 0 0>;
> > +
> > +            #clock-cells =3D <1>;
> > +            clocks =3D <&lmk04832_oscin>;
> > +            clock-names =3D "oscin";
> > +
> > +            ti,spi-4wire-rdbk =3D <0>;
> > +            ti,vco-hz =3D <2457600000>;
> > +
> > +            assigned-clocks =3D
> > +                <&lmk04832 0>, <&lmk04832 1>,
> > +                <&lmk04832 2>, <&lmk04832 3>,
> > +                <&lmk04832 4>,
> > +                <&lmk04832 6>, <&lmk04832 7>,
> > +                <&lmk04832 10>, <&lmk04832 11>;
> > +            assigned-clock-rates =3D
> > +                <122880000>, <384000>,
> > +                <122880000>, <384000>,
> > +                <122880000>,
> > +                <153600000>, <384000>,
> > +                <614400000>, <384000>;
> > +
> > +            clkout0@0 {
> > +                reg =3D <0>;
> > +                ti,clkout-fmt =3D <0x01>; // LVDS
> > +            };
> > +
> > +            clkout1@1 {
> > +                reg =3D <1>;
> > +                ti,clkout-fmt =3D <0x01>; // LVDS
> > +                ti,clkout-sysref;
> > +            };
> > +        };
> > +    };
> > --=20
> > 2.30.1.489.g328c10930387
> >=20

