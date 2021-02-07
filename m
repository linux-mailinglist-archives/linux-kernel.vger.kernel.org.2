Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4EE3122FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGJIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:08:34 -0500
Received: from mout01.posteo.de ([185.67.36.65]:43094 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhBGJIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:08:32 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DE4C0160082
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 10:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1612688854; bh=Js1CjgCGp5b+NYqWsGIKUPUOQ2MwnfljPOmrW7P0wcg=;
        h=Date:From:To:Cc:Subject:From;
        b=ZcynWUaitAgBzF+Eo+rF8nC7U/MIf4K2d05e0zaBORv7gQ+6fKl8x2R1CDvOFEcbP
         E1IyRstsOXMr6lcTlbdnYJREaloxIMBreQYACkDQgmOjRq19ZmJMhuSAD9gRrc3obE
         sZLdOu4Ayl7HKAfYnv7I48AnGa/Kn59j8JWoK3lNIozdsJMP67lwPs1F2MZsjlNV5T
         Z2aNu9QXvhoMHAtObOvyFnlVO1NG3l2azH3+ohnWQPTqdod5nTYZVXR9ZNURL+nbhG
         oYcbWCsrgQ5pn4MAYU6sPF7/rA4HNFYR5Zr8fdrweUOFYhm/QDNfke61kRjdmaaOAg
         IB5Ueq+r86Hlw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DYNb83sYZz9rxW;
        Sun,  7 Feb 2021 10:07:32 +0100 (CET)
Date:   Sun, 7 Feb 2021 10:07:31 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210207100731.58f1c621@monster.powergraphx.local>
In-Reply-To: <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
        <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
        <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 15:49:19 -0700
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Dec 23, 2020 at 4:34 AM Wilken Gottwalt
> <wilken.gottwalt@posteo.net> wrote:
> >
> > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > compatible SoCs.
> 
> Please resend to DT list so that automated checks run and it's in my
> queue (PW). You need to run 'make dt_binding_check' as there are
> several issues.

Mentioning somewhere, that yamllint is required would have helped here a lot.
Without it I always ended up with that, what was quite misleading:

ERROR: dtschema minimum version is v2020.8.1
make[1]: *** [Documentation/devicetree/bindings/Makefile:12: check_dtschema_version] Error 1
make: *** [Makefile:1370: dt_binding_check] Error 2

> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> > Changes in v5:
> >   - changed binding to earliest known supported SoC sun6i-a31
> >   - dropped unnecessary entries
> >
> > Changes in v4:
> >   - changed binding to sun8i-a33-hwpinlock
> >   - added changes suggested by Maxime Ripard
> >
> > Changes in v3:
> >   - changed symbols from sunxi to sun8i
> >
> > Changes in v2:
> >   - fixed memory ranges
> > ---
> >  .../bindings/hwlock/sun6i-a31-hwspinlock.yaml | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> > b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml new file mode 100644
> > index 000000000000..481c5c995ad7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwlock/sun6i-hwspinlock.yaml#
> 
> This will fail checks. Wrong filename.
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SUN6I hardware spinlock driver for Allwinner sun6i compatible SoCs
> > +
> > +maintainers:
> > +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > +
> > +description:
> > +  The hardware unit provides semaphores between the ARM cores and the embedded
> > +  companion core on the SoC.
> > +
> > +properties:
> > +  compatible:
> > +    const: allwinner,sun6i-a31-hwspinlock
> > +
> > +    reg:
> > +      maxItems: 1
> > +
> > +    clocks:
> > +      maxItems: 1
> > +
> > +    resets:
> > +      maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    hwspinlock@1c18000 {
> 
> hwlock@...

sprd, stm32 and omap using hwspinlock. Why is it okay there and not okay in
my version?

> > +      compatible = "allwinner,sun6i-a31-hwspinlock";
> > +      reg = <0x01c18000 0x1000>;
> > +      clocks = <&ccu CLK_BUS_SPINLOCK>;
> > +      resets = <&ccu RST_BUS_SPINLOCK>;
> 
> You need an include for these defines.

So I guess it is needed because I the clocks/resets are used, right? But why
is it not the case for the sprd example, which also uses clocks?

> > +    };
> > --
> > 2.29.2
> >

