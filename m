Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7527D37AFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEKT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:57:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35480 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:57:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BJuKZ5075190;
        Tue, 11 May 2021 14:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620762980;
        bh=jREPqUlN56tfJbDslJ/VrtzVWHMHHbKEqFIHjonThXM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LROmAtLrK37NG62O0LZ1N91kJ5Ikf01+SUAi9QRRAZscnqAVyG6XmG7B7jUs1nmEc
         jDZ1n4+6Gb/0ZtvFGfKQbVpMG0HV2ejgBoS9VsSuG8kjQ1+8gN8y7Sucp5fMGAUje6
         uwNRNHYm6oCJAObuaLKQqI3EKCBSJfKU0q+fgnNI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BJuKC8100270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 14:56:20 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 14:56:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 14:56:20 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BJuJac083008;
        Tue, 11 May 2021 14:56:19 -0500
Date:   Tue, 11 May 2021 14:56:19 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, <grygorii.strashko@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3*: Introduce reg definition for
 interrupt routers
Message-ID: <20210511195619.ezzzzxfvjqxszfv3@surfacing>
References: <20210510145508.8994-1-nm@ti.com>
 <45c92c1d-1d58-4711-ac07-68406492b86b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45c92c1d-1d58-4711-ac07-68406492b86b@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:53-20210511, Lokesh Vutla wrote:
> 
> 
> On 10/05/21 8:25 pm, Nishanth Menon wrote:
> > Interrupt routers are memory mapped peripherals, that are organized
> > in our dts bus hierarchy to closely represents the actual hardware
> > behavior.
> > 
> > However, without explicitly calling out the reg property, using
> > 2021.03+ dt-schema package, this exposes the following problem with
> > dtbs_check:
> > 
> > /arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000:
> > interrupt-controller0: {'type': 'object'} is not allowed for
> > {'compatible': ['ti,sci-intr'], .....
> > 
> > Even though we don't use interrupt router directly via memory mapped
> > registers and have to use it via the system controller, the hardware
> > block is memory mapped, so describe the base address in device tree.
> > 
> > This is a valid, comprehensive description of hardware and permitted
> > by the existing ti,sci-intr schema.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > 
> > if possible, I'd like to pick this fixup for 5.13 window..
> > 
> >  arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 3 ++-
> >  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi         | 3 ++-
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 6 ++++--
> >  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 3 ++-
> >  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 6 ++++--
> >  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 ++-
> >  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 6 ++++--
> >  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 3 ++-
> >  8 files changed, 22 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> > index b2bcbf23eefd..a49e41021573 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> > @@ -373,8 +373,9 @@ main_spi4: spi@20140000 {
> >  		clocks = <&k3_clks 145 0>;
> >  	};
> >  
> > -	main_gpio_intr: interrupt-controller0 {
> > +	main_gpio_intr: interrupt-controller@a00000 {
> >  		compatible = "ti,sci-intr";
> > +		reg = <0x00 0xa00000 0x00 0x800>;
> 
> IIRC, we are going with 0x00a00000 (0x%8x) for all regs. With that fixed for all
> regs:
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks for the catch.. Picked your reviews and posted v2
https://lore.kernel.org/linux-arm-kernel/20210511194821.13919-1-nm@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
