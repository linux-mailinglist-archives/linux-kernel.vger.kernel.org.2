Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19F36E1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhD1WnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:43:20 -0400
Received: from elvis.franken.de ([193.175.24.41]:50467 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhD1WnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:43:19 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lbst6-00028h-00; Thu, 29 Apr 2021 00:42:32 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0326BC0D06; Thu, 29 Apr 2021 00:41:53 +0200 (CEST)
Date:   Thu, 29 Apr 2021 00:41:53 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-binding: interrupt-controller: Add missing interrupts
 property
Message-ID: <20210428224153.GA15709@alpha.franken.de>
References: <20210427224201.32285-1-tsbogend@alpha.franken.de>
 <1619648109.762240.4061025.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619648109.762240.4061025.nullmailer@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 05:15:09PM -0500, Rob Herring wrote:
> On Wed, 28 Apr 2021 00:42:00 +0200, Thomas Bogendoerfer wrote:
> > Interrupts property is required, so add it.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > ---
> >  .../bindings/interrupt-controller/idt,32434-pic.yaml          | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.example.dt.yaml: interrupt-controller@1c20400: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.yaml

now I'm confused... is this a problem of your test ? make dt_binding_check
was ok with that change...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
