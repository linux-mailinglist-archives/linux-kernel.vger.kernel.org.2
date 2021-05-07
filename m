Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22741375F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhEGDWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 23:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhEGDWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 23:22:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C888C061574;
        Thu,  6 May 2021 20:21:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o16so9775630ljp.3;
        Thu, 06 May 2021 20:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y9756nd5AyGXv8C3o7UNJfOIIlsWfIQutzgpjYzThc0=;
        b=njtkQeiGl25A1xOEHhzF+1ldHeylX8kadBrAz7tUHul/4gK5VDZxeWZCV0j7Bnhads
         eFJzyb4DNceulLSgLsar30iJbHWkwac0H5ZPQF4wdAZ2XUCD3FBTVHJqx8dup3WlkKeY
         NsFPCeqRYnjjpuyJmDYKHiWq78zsNLyCzVkoG4tDxXL51By41oLvKpduUWqp0Nz5AyCL
         1q4Nx5ZJytrQZvrGErnWxAHmCudA9Sze4IiPN1zac9bUWfa9yLsFOTIvQ4d7xGBVGbm6
         cdG8Mw0K4wLwCUr55KeqRE180FujwfbbTii1s2323d3aa0cP/iAs+h0jzPqMVpDtkYi5
         7sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y9756nd5AyGXv8C3o7UNJfOIIlsWfIQutzgpjYzThc0=;
        b=pYPDj+k/wEGeYxgqoyfVuqfjOtVdZi82fEPwHxTJHJlOiwGqzGtH62EA2Ol6BITxP0
         ZXPdvdwzYDWwXqzIgaCvdjTXWugqxbZ5zO4nHU6g6aROFipjqpinQ13ca/rc935epZqm
         ery8vkMXZTAUifFy/K7Ii3usEvkCckyHATXocgIKNieB7pR5HKvrXW2nz3AyqYzATkJd
         ph1oUcNsJqQXOL6dgV1RiD90pf/gDhulYUmnxNhz0R5PRYcHeV1hhbEZQGpWkyn/FbzK
         YJHMDkPNBmtmxu6+DEsX3GvuPpaAoqOSjHtqwdzde5ZWjcJ7VT6FyFxZm7QGggCfoeCY
         ElRw==
X-Gm-Message-State: AOAM533eYfTd3SV7Z9pc65UxfX9FfikixzBOOy1fL2Z6uY7XRFTlW5T8
        zLicxsDdv/FNcPVW7vbV0MZCvkX62cxhPau8V1LgE77j
X-Google-Smtp-Source: ABdhPJxdRf7izyhim65GzBJeGKRQ/owBKBatO736eZ+ikWYqBRUCO5vvWgQF48OR4HAD9odcewkC7b/5rURwNjyYzfY=
X-Received: by 2002:a05:651c:2125:: with SMTP id a37mr6083898ljq.153.1620357662740;
 Thu, 06 May 2021 20:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <1620036917-19040-1-git-send-email-u0084500@gmail.com> <20210506152731.GA352070@robh.at.kernel.org>
In-Reply-To: <20210506152731.GA352070@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 7 May 2021 11:20:51 +0800
Message-ID: <CADiBU39ZH0vkf0i2ZjzxV5SYoVn94O03nE+eR5n34j8DiJL++w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] regulator: rt6160: Add DT binding documet for
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

HI,

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=886=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, May 03, 2021 at 06:15:16PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
>
> Typo in the subject.
>
Will be fixed in next.
> >
> > Add the DT binding document for Richtek RT6160 voltage regulator.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../regulator/richtek,rt6160-regulator.yaml        | 68 ++++++++++++++=
++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rt6160-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt616=
0-regulator.yaml
> > new file mode 100644
> > index 00000000..fe7b168
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regula=
tor.yaml
> > @@ -0,0 +1,68 @@
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
> > +    description: |
> > +      Used to indicate the 'vsel' pin active level. if not specified, =
use
> > +      high active level as the default.
> > +    type: boolean
> > +
> > +patternProperties:
> > +  buckboost:
>
> foo-buckboost-bar is valid name?
>
> It's not a pattern, so move to 'properties'.
>
Sorry, maybe I misunderstand the meaning of patternProperty.
I'll move it into the properties, Thanks.
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
