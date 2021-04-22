Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BAD368254
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhDVOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:18:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhDVOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:18:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13MEHihS073442;
        Thu, 22 Apr 2021 09:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619101064;
        bh=+QeFwgSZcZvSnHvwP9NbzZ+9fb3TLz4c9lcf8n/o5+k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=x1FobscePt3LhRtFpyS7l2/hNpjxoOuSm1MNj+kKlrZFIHyGokye5Esc2+CzV1Ytv
         VBcrsql3vk8E+kclPFCp0bCcUoS+A/Ad+04OQkwQdRmVv69AIB9cJytm4S9JFSe+uN
         SPcwBAFuMZ3XnwioR5Xm2WlCCpehtEeYf+B7qym8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13MEHiqo064493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 09:17:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 22
 Apr 2021 09:17:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 22 Apr 2021 09:17:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13MEHi9N099695;
        Thu, 22 Apr 2021 09:17:44 -0500
Date:   Thu, 22 Apr 2021 09:17:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] dt-bindings: arm: keystone: Convert ti,sci to json
 schema
Message-ID: <20210422141744.2imrochbzzt26wx4@slush>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-5-nm@ti.com>
 <20210421224041.GA1740292@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421224041.GA1740292@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:40-20210421, Rob Herring wrote:

[..]

> > +allOf:
> > +  - $ref: /schemas/mbox/mbox-consumer.yaml#
> 
> Drop.
> 

OK.

> > +  reg-names:
> > +    description: |
> > +      Specifies the debug messages memory mapped region that is optionally
> > +      made available from TI-SCI controller.
> > +      - const: debug_messages
> 
> Drop the '-' and fix the indent so it's an actual schema.

OK.

[..]
> > +patternProperties:
> > +  # All other properties should be a power, clock or reset controller
> > +  "^(power-controller|clock-controller|reset-controller)$":
> > +    type: object
> > +    oneOf:
> > +      - $ref: /schemas/soc/ti/sci-pm-domain.yaml#
> > +      - $ref: /schemas/clock/ti,sci-clk.yaml#
> > +      - $ref: /schemas/reset/ti,sci-reset.yaml#
> 
> I'd prefer you separate these with a property for each node.

Hmm... I am not sure I completely understand your comment here.
I assume we dont want to duplicate each of those node yamls, so,
did you mean something like:

ti,sci-clk as a bool property in the tisci node and if present, then
expect the node ti,sci-clk node?

Can you give me a hint of similar yaml usage elsewhere that I can refer
to?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
