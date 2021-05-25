Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141EE38FE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhEYJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbhEYJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:48:40 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC331C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:47:06 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l15so15982888ilh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUGBb9Nuz8Xoj3kAXm6SJkXHbdtiAWLMyMVIUPF0e+k=;
        b=tXAvy2rUjaA/yn2VqRzlngFafRWSBYXcxK53bHo58H6bHXIA3nGuphf4P6mPdCzJv6
         /EuvaHAjoxuuDALYzs2MT6Hc8eoaoOfO4Z3uNpJSXuXXD7/hY6p7MWkdiWr7MXIQi1Ut
         LFe3+jMw/IjbTFoyU3SyY/PWkSpsRYt/hmGz0y9kfV1tYxeBDF55RGngF5sZNBrWi/Ue
         +dWlH0cxxXBocSQRioYMPbR2kaLW7rf5LqDqNRsP8NFdIowmxVYjIEQqJTrMYS4KHbbf
         3cdZJJszHbASCsoImlWrQSCmAMWaWpTzKrxHxGmYErfYwuGXmrqbciC8QRpCRYfoQHtU
         kMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUGBb9Nuz8Xoj3kAXm6SJkXHbdtiAWLMyMVIUPF0e+k=;
        b=DVuZ3P1gKbKtayc7pIyUeLhSrJaruIA/DvGJGhjwUtWOAEopSQVnLBKBzUu5CrMXut
         RypUborFBx+dFBKJHnmCdKJzWyYMrLewgVRZ38HgHbxbLkGpgqGoV/bcaW54Wb4EsTGd
         ZFSNFwepfVm9I0twSHQge1nVKoU0kiiuqjgtO3UjQucoYDl+7D6j0hKrj7ifoG48aDQY
         jT+oD7e2JcO6nnYv3M0cPnqFRjxdPQfT+EALDGtdqQ5DxTLwMJukNi24ByZ2feL31MDW
         RRxn1T/OtTd5DkhRBIffFqLDurIKwc7vqg+t1Lysu0faUkvkNkdtkW0sjo04PBAz8y0s
         2bBw==
X-Gm-Message-State: AOAM530QBfsm3mLiHkH8CHpIfoleLYeDfnuHmsQ1G1SENyx5L3Jy3aTP
        flMQ3dUSroNk8pq3l+3++a1hKunyQabLXd6KG6h8fw==
X-Google-Smtp-Source: ABdhPJweMWKKIG7qU+vbGo3+7fkyn0w8YHmgKBta9CywoRVWNa290QSgR1wPx3+oPWCxslVvZCuraQ2NImCsR4PL/00=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr21928713ilr.182.1621936026090;
 Tue, 25 May 2021 02:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210524120539.3267145-1-robert.marko@sartura.hr>
 <20210524120539.3267145-3-robert.marko@sartura.hr> <20210524230940.GA1350504@robh.at.kernel.org>
In-Reply-To: <20210524230940.GA1350504@robh.at.kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 25 May 2021 11:46:55 +0200
Message-ID: <CA+HBbNHb71n7GPCPWMivOV5U0RGQnwT054y6U0grQ8Hr=d9geQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, Lee Jones <lee.jones@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        jmp@epiphyte.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 1:09 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 24, 2021 at 02:05:38PM +0200, Robert Marko wrote:
> > Add binding documents for the Delta TN48M CPLD drivers.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> > Changes in v2:
> > * Implement MFD as a simple I2C MFD
> > * Add GPIO bindings as separate
>
> I don't understand why this changed. This doesn't look like an MFD to
> me. Make your binding complete if there are missing functions.
> Otherwise, stick with what I already ok'ed.

It changed because the custom driver was dropped at Lee Jones-es request,
and simple-mfd-i2c is now used.

>
> >
> >  .../bindings/gpio/delta,tn48m-gpio.yaml       | 42 ++++++++++
> >  .../bindings/mfd/delta,tn48m-cpld.yaml        | 81 +++++++++++++++++++
> >  2 files changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
> > new file mode 100644
> > index 000000000000..aca646aecb12
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/delta,tn48m-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Delta Networks TN48M CPLD GPIO controller
> > +
> > +maintainers:
> > +  - Robert Marko <robert.marko@sartura.hr>
> > +
> > +description: |
> > +  This module is part of the Delta TN48M multi-function device. For more
> > +  details see ../mfd/delta,tn48m-cpld.yaml.
> > +
> > +  GPIO controller module provides GPIO-s for the SFP slots.
> > +  It is split into 3 controllers, one output only for the SFP TX disable
> > +  pins, one input only for the SFP present pins and one input only for
> > +  the SFP LOS pins.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - delta,tn48m-gpio-sfp-tx-disable
> > +      - delta,tn48m-gpio-sfp-present
> > +      - delta,tn48m-gpio-sfp-los
>
> The function of the 'general purpose' IO should not be encoded into the
> compatible name. Is each instance.

They are not general-purpose, they are hard-wired pins.
This is how the driver knows whether its output or input only,
and it's been reviewed by Andy Shevchenko.
It was weird for me as well, but that is how GPIO regmap works.

It was modeled by the sl28cpld GPIO driver as well as the rest of the docs
as that CPLD has similar features supported to what this initial support does.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#gpio-cells"
> > +  - gpio-controller
> > +
> > +additionalProperties: false
> > diff --git a/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
> > new file mode 100644
> > index 000000000000..055e09129f86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/delta,tn48m-cpld.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Delta Networks TN48M CPLD controller
> > +
> > +maintainers:
> > +  - Robert Marko <robert.marko@sartura.hr>
> > +
> > +description: |
> > +  Lattice CPLD onboard the TN48M switches is used for system
> > +  management.
> > +
> > +  It provides information about the hardware model, revision,
> > +  PSU status etc.
> > +
> > +  It is also being used as a GPIO expander for the SFP slots.
> > +
> > +properties:
> > +  compatible:
> > +    const: delta,tn48m-cpld
> > +
> > +  reg:
> > +    description:
> > +      I2C device address.
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +patternProperties:
> > +  "^gpio(@[0-9a-f]+)?$":
> > +    $ref: ../gpio/delta,tn48m-gpio.yaml
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        cpld@41 {
> > +            compatible = "delta,tn48m-cpld";
> > +            reg = <0x41>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            gpio@31 {
> > +                compatible = "delta,tn48m-gpio-sfp-tx-disable";
> > +                reg = <0x31>;
>
> Encode the register address into the gpio cells.
Do you have an example of that?
I have modeled this on sl28cpld GPIO driver which does the same thing
as it's the easiest way and simply reusing standard properties.
>
> > +                gpio-controller;
> > +                #gpio-cells = <2>;
> > +            };
> > +
> > +            gpio@3a {
> > +                compatible = "delta,tn48m-gpio-sfp-present";
> > +                reg = <0x3a>;
> > +                gpio-controller;
> > +                #gpio-cells = <2>;
> > +            };
> > +
> > +            gpio@40 {
> > +                compatible = "delta,tn48m-gpio-sfp-los";
> > +                reg = <0x40>;
> > +                gpio-controller;
> > +                #gpio-cells = <2>;
> > +            };
> > +        };
> > +    };
> > --
> > 2.31.1
> >



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
