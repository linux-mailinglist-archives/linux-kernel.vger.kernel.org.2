Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9E3884E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhESCmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhESCmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:42:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFEAC06175F;
        Tue, 18 May 2021 19:41:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e11so13734145ljn.13;
        Tue, 18 May 2021 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ds2nQNSf53rLNzgnwSK+XlfEIpaMEY5kLWYEJdqYKso=;
        b=CuAez1KXsXCvwOJ6J1xGJayTx861OxXEEKRVEPulnXf4I2PmgIbWWZUnuiaNpDYIiT
         FcWUNDd05jv4VRqiFlpEQ6xuud4Q4rUm+f22Noo8BKfJZ/u+yXJ+1haBYmfZ507pdLQN
         CpLrmZoZ6/4aeCAv7uTYqb6y6pQeqEwqyvdC89ysY2iMAb8lWtCDnerY8H4mmiEJzTG6
         b/Z8kwfg0a+MayK+phvubSH01jR0HZZZvT47wlsjq2xearXJ8WwlL378AcjfRC/LXno+
         TStAYg+QUZ17bQ2EcB+uSO6MZ01o0xOyTToqPDnTaPUR9kyzTr8KToAE1OVqluDK5Q57
         G9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ds2nQNSf53rLNzgnwSK+XlfEIpaMEY5kLWYEJdqYKso=;
        b=T1mJYLVaScI+129nc+Mz8xhP2I0vkrtpWzwrYxCF6z3lu7bwN3e74HOO2TBnaRhkPG
         XOTIqGC4lQowtilsOhnyI/6l+003d+bmHVbT0SixrZ+3MklXEyfifeE8umnldbWmmVSO
         OtWlGD+wLUwxxaDxw3G5HYMUTHQktqU51ywpvTBrFq2lWOsLSv6nvzLevixEOOCHTrjz
         CKpeO0FXHZA0FhAGODzVXTX4AenF5UOz/icjoPuqzzDQwIy/bCBrBmK+iy83t72+WiaD
         i39h9dwvrhfWJYq0wSKOJPWXkMJRSJS3Vzm++d0u5RRbuVa6ZaJkPgPyIma9oMbglGd8
         8ILQ==
X-Gm-Message-State: AOAM533mNUUp2tbwDLkGPrngtoCU7Y4noF6YgXM7n/sJxGWEbM9G6MnV
        FpvCpO5J56ip/XV9u2RYLnaJRm3FRz3hJ3wHi3E=
X-Google-Smtp-Source: ABdhPJwHUzYZopD4c/trdGmu3nVVYnnUdOeGztC3RPJdA1kpiZQ/B4a4xBNG2RkSYWIFzV3YgflNjjP7D4/SpouYRA0=
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr309970ljv.168.1621392082230;
 Tue, 18 May 2021 19:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <1621183560-6668-1-git-send-email-u0084500@gmail.com> <20210518133831.GA543149@robh.at.kernel.org>
In-Reply-To: <20210518133831.GA543149@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 19 May 2021 10:41:10 +0800
Message-ID: <CADiBU3_E1+S0WGQZVy3hN9U+7bdMVSai4+w+zshhucELN6iuCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: rt6160: Add DT binding document for
 Richtek RT6160
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, May 17, 2021 at 12:45:59AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add DT binding document for Richtek RT6160 voltage regulator.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > since v2
> > - Move buckboost node from patternProperties to Properties.
> > ---
> >  .../regulator/richtek,rt6160-regulator.yaml        | 67 ++++++++++++++=
++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rt6160-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt616=
0-regulator.yaml
> > new file mode 100644
> > index 00000000..4ce1f7c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regula=
tor.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rt6160-regulator.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT6160 BuckBoost converter
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RT6160 is a high-efficiency buck-boost converter that can provid=
e
> > +  up to 3A output current from 2025mV to 5200mV. And it support the wi=
de
> > +  input voltage range from 2200mV to 5500mV.
> > +
> > +  Datasheet is available at
> > +  https://www.richtek.com/assets/product_file/RT6160A/DS6160A-00.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - richtek,rt6160
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: A connection of the 'enable' gpio line.
> > +    maxItems: 1
> > +
> > +  richtek,vsel_active_low:
>
> richtek,vsel-active-low
>
Ack in next v3.
> > +    description: |
> > +      Used to indicate the 'vsel' pin active level. if not specified, =
use
> > +      high active level as the default.
> > +    type: boolean
> > +
> > +  buckboost:
>
> If this is the only regulator, you don't really need a child node here.
> Just move everything up.
>
OK, the original thinking is to separate the node to make the
regulator property more clear.
To put the regulator property up is also good.

I'll refine it and resend the v3 patch series, Thanks.
> > +    description: BuckBoost converter regulator description.
> > +    type: object
> > +    $ref: regulator.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      rt6160@75 {
> > +        compatible =3D "richtek,rt6160";
> > +        reg =3D <0x75>;
> > +        enable-gpios =3D <&gpio26 2 0>;
> > +
> > +        buckboost {
> > +          regulator-name =3D "rt6160-buckboost";
> > +          regulator-min-microvolt =3D <2025000>;
> > +          regulator-max-microvolt =3D <5200000>;
> > +          regulator-allowed-modes =3D <0 1>;
> > +        };
> > +      };
> > +    };
> > --
> > 2.7.4
> >
