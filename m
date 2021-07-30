Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181E13DB46B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhG3HVW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jul 2021 03:21:22 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44859 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbhG3HVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:21:21 -0400
X-Greylist: delayed 164101 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 03:21:21 EDT
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D5C9FC0008;
        Fri, 30 Jul 2021 07:21:14 +0000 (UTC)
Date:   Fri, 30 Jul 2021 09:21:13 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: add "syscon-smc" YAML description
Message-ID: <20210730092113.25ce7f7c@fixe.home>
In-Reply-To: <YQMbV3elkU0yp92D@robh.at.kernel.org>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
        <20210723135239.388325-4-clement.leger@bootlin.com>
        <YQMbV3elkU0yp92D@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 29 Jul 2021 15:19:19 -0600,
Rob Herring <robh@kernel.org> a écrit :

> On Fri, Jul 23, 2021 at 03:52:39PM +0200, Clément Léger wrote:
> > This patch adds documentation for the "syscon-smc" compatible which
> > describes a syscon using a SMC regmap instead of a MMIO one. This
> > allows accessing system controllers that are set as secure by using
> > SMC handled by the secure monitor.
> > 
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > ---
> >  .../devicetree/bindings/mfd/syscon-smc.yaml   | 57
> > +++++++++++++++++++ 1 file changed, 57 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/syscon-smc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon-smc.yaml
> > b/Documentation/devicetree/bindings/mfd/syscon-smc.yaml new file
> > mode 100644 index 000000000000..6ce1392c5e7f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/syscon-smc.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/syscon-smc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: System Controller Registers R/W via SMC Device Tree Bindings
> > +
> > +description: |
> > +  System controller SMC node represents a register region
> > containing a set
> > +  of miscellaneous registers accessed through a secure monitor.
> > +  The typical use-case is the same as the syscon one but when
> > running with a
> > +  secure monitor.
> > +
> > +maintainers:
> > +  - Lee Jones <lee.jones@linaro.org>
> > +
> > +properties:
> > +  compatible:
> > +    anyOf:
> > +      - items:
> > +          - enum:
> > +              - atmel,sama5d2-sfr
> > +
> > +          - const: syscon-smc  
> 
> I regret having 'syscon' as a compatible, so nak on a 2nd flavor of
> it. It's only purpose is a hint to Linux to automagically create a
> regmap for you.

Indeed.

> 
> All you need is the specific compatible, atmel,sama5d2-sfr, and you
> can imply the rest of this from it. That's assuming the conclusion is
> a register read/write interface on SMC is a good idea, but I don't
> think it is.

Ok noted, I'll try to find something else to implement that.

Clément

> 
> Rob

