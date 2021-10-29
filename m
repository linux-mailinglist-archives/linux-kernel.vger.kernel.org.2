Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10C43F464
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhJ2Bie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhJ2Bid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428D161156;
        Fri, 29 Oct 2021 01:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635471365;
        bh=T6GOjxRPDeunaWfoQlIqxwtH/ryHC6tgJEYN67Sc7TM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FF2p68gfMnV1hn2o67ha1jWFcjeW9bWEZI+2Hd1OeMeXQffd4l9NYjjSLUnzJj8c2
         wydhclTsM0DWihnXg+hNglseL38vDZAogkMgrVxbo6QHStuNwnFrVOd6h8vLxlCeil
         +WjsrSoMGe0XG7fG+pAuQXOZDyv5BflW+5UkZAbzYNvJcZ3xzk6FGp+rUWmgyJyWJ2
         QGqZNrH9q1cM3s1rR89JPbRtJQ1Y0EOJqQUTzMvanqKBrYG2iF7BlQNmjuHfzua0cr
         d5CuraVprdBUkVMbaWxXY8EFAL2WwOZyDsIUoUY9t/aqiubkwSzZ5YIy3UVcQz3LbW
         SA0CH41adayyQ==
Received: by mail-ed1-f50.google.com with SMTP id g10so32238281edj.1;
        Thu, 28 Oct 2021 18:36:05 -0700 (PDT)
X-Gm-Message-State: AOAM530FvnpbQHfK7uqRw/iASMUzbiWIQ5vrdZ3i8g5l4KaKP4ep7wMX
        rUqyZj9mw2oYMUArZgJBRq621BbKBYKWDSIRDw==
X-Google-Smtp-Source: ABdhPJxakIdbFZtjjDoY5WYj+rMrkwV5zFP3b/YfXdeu6lFutkJmex9WYAJ5Gj0hy0AQd0VijtznXGSoGv7HTeRqN80=
X-Received: by 2002:a50:da06:: with SMTP id z6mr10927175edj.355.1635471363711;
 Thu, 28 Oct 2021 18:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211018234923.1769028-1-sean.anderson@seco.com>
 <YXi5CUCEi7YmNxXM@robh.at.kernel.org> <47d4c3d3-d6ab-3888-1cde-937551537e3f@seco.com>
In-Reply-To: <47d4c3d3-d6ab-3888-1cde-937551537e3f@seco.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Oct 2021 20:35:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3oZXJJ5_i4BRGpvWu1X8QFB7OGG=D+zLvvWb=UR1mWg@mail.gmail.com>
Message-ID: <CAL_JsqL3oZXJJ5_i4BRGpvWu1X8QFB7OGG=D+zLvvWb=UR1mWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add generic GPIO reset binding
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:19 AM Sean Anderson <sean.anderson@seco.com> wrote:
>
> Hi Rob,
>
> On 10/26/21 10:27 PM, Rob Herring wrote:
> > On Mon, Oct 18, 2021 at 07:49:21PM -0400, Sean Anderson wrote:
> >> This adds a binding for a generic GPIO reset driver. This driver is
> >> designed to easily add a GPIO-based reset to a driver which expected a
> >> reset controller. It offers greater flexibility than a reset-gpios
> >> property, and allows for one code path to be shared for GPIO resets and
> >> MMIO-based resets.
> >
> > I would like to do this last part, but not requiring a binding change.
> > IOW, be able to register any 'reset-gpios' property as a reset provider
> > directly without this added level of indirection.
>
> That would be nice, but it seems like someone would have to go through
> every driver with a reset-gpios property and convert them. Since the
> reset GPIOs are

All that has to happen is when a driver requests a reset, the reset
subsystem can check for a 'reset-gpios' when there is not a 'resets'
property. If it finds one, then it can either instantiate a reset
provider or add that GPIO to an existing provider. Then you can
convert drivers one by one, or not.

> >>
> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> ---
> >>
> >>  .../devicetree/bindings/reset/gpio-reset.yaml | 93 +++++++++++++++++++
> >>  1 file changed, 93 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.yaml b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
> >> new file mode 100644
> >> index 000000000000..de2ab074cea3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
> >> @@ -0,0 +1,93 @@
> >> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> >
> > GPL-2.0-only not GPL-2.0+
>
> GPL-2.0+ is a strict superset. And bindings are required to be BSD
> anyway. I don't see the issue.

Not everyone agrees with GPLv3. What about GPLv4, v5, etc.? You're
okay with them no matter what they say?

The issue is many people pay no attention. Just copy whatever they
started from, or put whatever they want. The dts files are a mess. The
binding docs all defaulted to GPL2. So I'm fixing the mess with
bindings and that means dictating the license.

> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/reset/gpio-reset.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Generic GPIO reset driver
> >> +
> >> +maintainers:
> >> +  - Sean Anderson <seanga2@gmail.com>
> >> +
> >> +description: |
> >> +  This is a generic GPIO reset driver which can provide a reset-controller
> >> +  interface for GPIO-based reset lines. This driver always operates with
> >> +  logical GPIO values; to invert the polarity, specify GPIO_ACTIVE_LOW in the
> >> +  GPIO's flags.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: gpio-reset
> >> +
> >> +  '#reset-cells':
> >> +    const: 1
> >> +
> >> +  reset-gpios:
> >> +    description: |
> >> +      GPIOs to assert when asserting a reset. There is a one-to-one mapping
> >> +      between the reset specifier and the index of the GPIO in this list to
> >> +      assert.
> >> +
> >> +  done-gpios:
> >> +    description: |
> >> +      GPIOs which indicate that the device controlled by the GPIO has exited
> >> +      reset. There must be one done GPIO for each reset GPIO, or no done GPIOs
> >> +      at all. The driver will wait for up to done-timeout-us for the
> >> +      corresponding done GPIO to assert before returning.
> >
> > This is odd. Do you have some examples of h/w needing this done signal?
> > It certainly doesn't seem like something we have a generic need for.
>
> Yes [1]. This device has a "reset done" signal, but no reset timings
> specified in the datasheet. I don't know if this is truly needed,
> because we can read the ID register, but it is nice when bringing up the
> device. I left it in because I was using it.

Okay, but done-gpios belongs in the device node that has a done
signal. Your binding pretty assumes you always have one because you
need equal numbers of reset and done gpios.

Anyways, I don't think this binding is going anywhere.

>
> [1] https://lore.kernel.org/netdev/20211004191527.1610759-16-sean.anderson@seco.com/
>
> >> +
> >> +  pre-assert-us:
> >> +    default: 0
> >> +    description: |
> >> +      Microseconds to delay between when the reset was requested to be
> >> +      asserted, and asserting the reset GPIO
> >> +
> >> +  post-assert-us:
> >> +    default: 0
> >> +    description: |
> >> +      Microseconds to delay after asserting the reset GPIO and before returning
> >> +      to the caller.
> >> +
> >> +  pre-deassert-us:
> >> +    default: 0
> >> +    description: |
> >> +      Microseconds to delay between when the reset was requested to be
> >> +      deasserted, and asserting the reset GPIO
> >> +
> >> +  post-deassert-us:
> >> +    default: 0
> >> +    description: |
> >> +      Microseconds to delay after deasserting the reset GPIO and before
> >> +      returning to the caller. This delay is always present, even if the done
> >> +      GPIO goes high earlier.
> >> +
> >> +  done-timeout-us:
> >> +    default: 1000
> >> +    description:
> >> +      Microseconds to wait for the done GPIO to assert after deasserting the
> >> +      reset GPIO. If post-deassert-us is present, this property defaults to 10
> >> +      times that delay. The timeout starts after waiting for the post deassert
> >> +      delay.
> >
> > There's a reason we don't have all these timing values in DT. The timing
> > requirements are defined by each device (being reset) and implied by
> > their compatible strings. If we wanted a macro language for power
> > sequence timings of regulators, clocks, resets, enables, etc., then we
> > would have designed such a thing already.
>
> Well, there are already things like reset-assert-us and
> reset-deassert-us in [2, 3, 4] (with different names(!)).

Yes, things evolve poorly. What's just one more property added at a time.

> Part of what I
> want to address with this device is that there are several existing
> properties which specify various aspects of the above timings. I think
> it would be good to standardize on these. Maybe this should be a
> property which applies to the reset consumer? Analogously, we also
> have assigned-clocks so that not every driver has to know what the
> correct frequency/parent is (especially when they can vary among
> different hardware variations).

Yes, there are some examples, but you won't find many new examples.
The rule is power sequencing requirements/timing is implied by the
device's compatible string.

You are looking at just reset. What about timing WRT regulators and
clocks for starters?

Rob
