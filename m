Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D626402AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhIGOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235028AbhIGOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D721610F8;
        Tue,  7 Sep 2021 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631025897;
        bh=pb6uQnkJOj7jZan0UZ5W50IT54400yv6W78lHUUCqDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GuVHmRa9F+YxsE7/VqZYKEPDBHgnctH14+lDJxav5wg4mIWlsd4XSaT0FeBdXyY2E
         Mqty3aIwOvW9OIjveu64e2UvY3NILsfErPO0daYvljrNmkPls+cmqnm+LzDIUSARCI
         vz5RS0+z+Rk9fAwc85Q7JzaC+oPYJJ9N5QckUU+HzkGBY3zpFl/UrFcQvkYsQVhZDj
         KQ7aczAbXcRK8GoMUgmaofQYXHnxTM3YaI95CoxIw+20VV6f/iq/+vtje+rvaKLNS9
         yYx70IBlL6juOSsJSg/UYadyELkCfKl9pKE93kavxUbf3PSG4KT0WRhKHBnCcHsgbO
         4cT0Y1d+YXqxw==
Received: by mail-ed1-f46.google.com with SMTP id z19so14245098edi.9;
        Tue, 07 Sep 2021 07:44:57 -0700 (PDT)
X-Gm-Message-State: AOAM53393YKW31UvSuC2XXZCpV6IbRTWCfksOTL8gVaqkYcza7FgOGcu
        SXwAb9Ua96BusGZYCXAQuKfrsH/nBZ838dmcpg==
X-Google-Smtp-Source: ABdhPJz35+eT13PtjAMyE1Cn8up0MviN8dZ3s6bQ7mHM7z/iu5075VVR/KfUXFoatJy0IhBX3jK0MFw2F/aL12TBWMA=
X-Received: by 2002:a50:ed09:: with SMTP id j9mr19082569eds.164.1631025895705;
 Tue, 07 Sep 2021 07:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210901053951.60952-1-samuel@sholland.org> <20210901053951.60952-2-samuel@sholland.org>
 <YTDtelCx5If3J5cM@robh.at.kernel.org> <53d6d018-93bf-9bfc-e296-a232105306de@sholland.org>
In-Reply-To: <53d6d018-93bf-9bfc-e296-a232105306de@sholland.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Sep 2021 09:44:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQ-9EWLPah2+q0=Y9viES1FSMS2_Mq6Kw-dMkN=rAhyQ@mail.gmail.com>
Message-ID: <CAL_JsqKQ-9EWLPah2+q0=Y9viES1FSMS2_Mq6Kw-dMkN=rAhyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] dt-bindings: rtc: sun6i: Add H616 and R329 compatibles
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 10:36 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 9/2/21 10:27 AM, Rob Herring wrote:
> > On Wed, Sep 01, 2021 at 12:39:45AM -0500, Samuel Holland wrote:
> >> For these new SoCs, start requiring a complete list of input clocks.
> >>
> >> For H616, this means bus, hosc, and pll-32k. For R329, this means ahb,
> >> bus, and hosc; and optionally ext-osc32k.
> >>
> >> I'm not sure how to best represent this in the binding...
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 55 +++++++++++++++++--
> >>  include/dt-bindings/clock/sun50i-rtc.h        | 12 ++++
> >>  2 files changed, 61 insertions(+), 6 deletions(-)
> >>  create mode 100644 include/dt-bindings/clock/sun50i-rtc.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> >> index beeb90e55727..3e085db1294f 100644
> >> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> >> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> >> @@ -26,6 +26,8 @@ properties:
> >>            - const: allwinner,sun50i-a64-rtc
> >>            - const: allwinner,sun8i-h3-rtc
> >>        - const: allwinner,sun50i-h6-rtc
> >> +      - const: allwinner,sun50i-h616-rtc
> >> +      - const: allwinner,sun50i-r329-rtc
> >
> > Can you please make all the single entry cases a single 'enum'.
> >
> >>
> >>    reg:
> >>      maxItems: 1
> >> @@ -37,7 +39,24 @@ properties:
> >>        - description: RTC Alarm 1
> >>
> >>    clocks:
> >> -    maxItems: 1
> >> +    minItems: 1
> >> +    maxItems: 4
> >> +
> >> +  clock-names:
> >> +    minItems: 1
> >> +    maxItems: 4
> >> +    items:
> >> +      - anyOf:
> >
> > This says the first entry is any of these. What about the rest of them?
>
> Oh, right. The list below is the list of all possible clocks.
>
> >> +          - const: ahb
> >> +            description: AHB parent for SPI bus clock
> >
> > The description should go in 'clocks'.
>
> Will do for v2.
>
> > The order should be defined as well with the first clock being the
> > one that existed previously.
>
> The only way I know how to further refine the list is with
> minItems/maxItems. My problem is that 1) some clocks are only valid for
> certain SoCs, and 2) some clocks are optional, depending on how the
> board is wired. So there is no single order where the "valid"
> combinations are prefixes of the "possible" combinations of clocks.
>
> Or in other words, how can I say "clocks #1 and #2 from this list are
> required, and #4 is optional, but #3 is not allowed"?

This says you have up to 4 clocks, but only defines the 1st 2:

maxItems: 4
items:
  - description: 1st clock
  - description: 2nd clock

But I think you will be better off with just defining the range
(minItems/maxItems) at the top level and then use if/then schemas.

>
> Some concrete examples, with the always-required clocks moved to the
> beginning:
>
> H6:
>  - bus: required
>  - hosc: required
>  - ahb: not allowed
>  - ext-osc32k: optional
>  - pll-32k: not allowed

Is this really 2 different 32k clock inputs to the h/w block? Doesn't
seem like it given both are never valid.

>
> H616:
>  - bus: required
>  - hosc: required
>  - ahb: not allowed
>  - ext-osc32k: not allowed
>  - pll-32k: required
>
> R329:
>  - bus: required
>  - hosc: required
>  - ahb: required
>  - ext-osc32k: optional
>  - pll-32k: not allowed
>
> Should I just move the entire clocks/clock-items properties to if/then
> blocks based on the compatible?

Probably so.

Rob
