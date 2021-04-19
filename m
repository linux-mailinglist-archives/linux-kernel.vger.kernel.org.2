Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBF364524
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhDSNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:41:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53406 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbhDSNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:36:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13JDZhIo110437;
        Mon, 19 Apr 2021 08:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618839343;
        bh=qeZcN+h8qnPRTBufAOnY5cwD/Q0Lqcs0+bre14HwovE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ENexWrbeYpj1oR7s5ZNzjDgFGxdy9V5O5I+UoZJrHh+oyikFGpjm2EC1r5PkdOExF
         YxrIJjWVnpq4YdeaqGu0T2i5G6p+Nq15aoOR/DwnUgNzQKYCMLGI7g9EYJYsSAe7W+
         NeyvnQbpUEuUUsh9Xei/vmLpjIyd1hvq3MPj04GQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13JDZhtI129553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Apr 2021 08:35:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Apr 2021 08:35:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Apr 2021 08:35:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13JDZgj9049023;
        Mon, 19 Apr 2021 08:35:42 -0500
Date:   Mon, 19 Apr 2021 08:35:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] dt-bindings: clock: Convert ti,sci-clk to json schema
Message-ID: <20210419133542.ndgkmf7eq4oqse34@ladies>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-3-nm@ti.com>
 <161861731160.46595.786611690053722257@swboyd.mtv.corp.google.com>
 <20210417125127.vigq23mdoodje6b5@velcro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210417125127.vigq23mdoodje6b5@velcro>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On 07:51-20210417, Nishanth Menon wrote:
> On 16:55-20210416, Stephen Boyd wrote:
> > Quoting Nishanth Menon (2021-04-15 23:37:19)
> > > diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
> > > new file mode 100644
> > > index 000000000000..72633651f0c7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/ti,sci-clk.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI-SCI clock controller node bindings
> > > +
> > > +maintainers:
> > > +  - Nishanth Menon <nm@ti.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/clock/clock.yaml#
> > 
> > Is this needed?
> 
> https://github.com/devicetree-org/dt-schema/blob/master/schemas/clock/clock.yaml
> This standardizes provider properties like '#clock-cells' etc, allowing
> you to add more stricter checks or controls in the future if necessary.
> 
> while:
> 
> https://github.com/devicetree-org/dt-schema/blob/master/meta-schemas/clocks.yaml
> is more a consumer node description.
> 
> Should I have picked a different yaml as base for a standard clock-controller
> base?
> 

Thinking again, I think your comment was to drop the clock.yaml
inclusion, and, as a result this schema can become more stringent..

Could you clarify?


> > 
> > > +
> > > +description: |
> > > +  Some TI SoCs contain a system controller (like the Power Management Micro
> > > +  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
> > > +  the state of the various hardware modules present on the SoC. Communication
> > > +  between the host processor running an OS and the system controller happens
> > > +  through a protocol called TI System Control Interface (TI-SCI protocol).
> > > +
> > > +  This clock controller node uses the TI SCI protocol to perform various clock
> > > +  management of various hardware modules (devices) present on the SoC. This
> > > +  node must be a child node of the associated TI-SCI system controller node.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^clock-controller$"
> > 
> > Is this nodename pattern check required?
> 
> I'd like the definition on rails and not subject to interpretation, and
> restrict the kind of subnodes under TISCI controller node.
> 
> > 
> > > +
> > > +  compatible:
> > > +    const: ti,k2g-sci-clk
> > 
> > I thought most things keyed off the compatible string.
> 
> Yes, they are. I am not sure I understand your question here. Did you
> mean to indicate that having $nodename and compatible both are
> redundant?
> 
> Redundancy was'nt the intent of this schema definition, rather, I'd like
> to make sure that it is not upto interpretation or debate as to what the
> node name should be: I believe clock-controller is the correct nodename
> (without @0x... since this does'nt use reg property) instead of using
> clocks, tisci-clock as the node names.
> 
> 
> Do you suggest something  different?
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
