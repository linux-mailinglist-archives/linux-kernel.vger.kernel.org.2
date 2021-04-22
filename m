Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2036822B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhDVOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:10:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54476 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhDVOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:10:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13ME9adJ069314;
        Thu, 22 Apr 2021 09:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619100576;
        bh=6vtsHCiE+UhV1jEh9jWHoCYucvxbpDiXX+TJ66u1Jlw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pyNONRIlt5oHfMqBuBKAkQ29DULpNbQCNhTh5l6Bbktxc5jyvHnYznc76EqUnUt1T
         goQ/IclTyHw7XZWoFargojo9GgxnTkm4GMVQmmGdZnOxf/Bt39GWBCuBeGUhYPmVy8
         Jh+0k6ijf7TmWSxqOxjtcBdK2gfeDJ6Urliw2WBo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13ME9ZXA053552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 09:09:36 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 22
 Apr 2021 09:09:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 22 Apr 2021 09:09:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13ME9ZwN033089;
        Thu, 22 Apr 2021 09:09:35 -0500
Date:   Thu, 22 Apr 2021 09:09:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] dt-bindings: clock: Convert ti,sci-clk to json schema
Message-ID: <20210422140935.lzsp6s2ugyvi2icu@iodize>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-3-nm@ti.com>
 <161861731160.46595.786611690053722257@swboyd.mtv.corp.google.com>
 <20210417125127.vigq23mdoodje6b5@velcro>
 <20210421223145.GB1705110@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421223145.GB1705110@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:31-20210421, Rob Herring wrote:
[...]

> > > > +allOf:
> > > > +  - $ref: /schemas/clock/clock.yaml#
> > > 
> > > Is this needed?
> 
> No. It is already applied to every node.
> 
> > https://github.com/devicetree-org/dt-schema/blob/master/schemas/clock/clock.yaml
> > This standardizes provider properties like '#clock-cells' etc, allowing
> > you to add more stricter checks or controls in the future if necessary.
> > 
> > while:
> > 
> > https://github.com/devicetree-org/dt-schema/blob/master/meta-schemas/clocks.yaml
> > is more a consumer node description.
> 
> No, the meta-schema is what checks the schemas just as the schemas check 
> dts files.


I will drop and respin. thanks for explaining.

> 
> > Should I have picked a different yaml as base for a standard clock-controller
> > base?
> > 
> > > 
> > > > +
> > > > +description: |
> > > > +  Some TI SoCs contain a system controller (like the Power Management Micro
> > > > +  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
> > > > +  the state of the various hardware modules present on the SoC. Communication
> > > > +  between the host processor running an OS and the system controller happens
> > > > +  through a protocol called TI System Control Interface (TI-SCI protocol).
> > > > +
> > > > +  This clock controller node uses the TI SCI protocol to perform various clock
> > > > +  management of various hardware modules (devices) present on the SoC. This
> > > > +  node must be a child node of the associated TI-SCI system controller node.
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^clock-controller$"
> > > 
> > > Is this nodename pattern check required?
> > 
> > I'd like the definition on rails and not subject to interpretation, and
> > restrict the kind of subnodes under TISCI controller node.
> 
> If this schema was standalone and not defined as part of another, then 
> yes it would be required. In your case, you can enforce the node name 
> from the parent schema. For consistency though, it would be better to 
> just always require $nodename. 
> 
> Actually, this schema will be applied twice. On it's own matching the 
> compatible string and by the parent schema. You can prevent that with 
> 'select: false'. I don't mind the double validation as if the parent 
> node had a compatible typo you'd get zero validation.

Sure. I will keep nodename.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
