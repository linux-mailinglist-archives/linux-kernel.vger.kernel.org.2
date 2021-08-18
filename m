Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618E73F08CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHRQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:15:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55262 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhHRQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:14:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17IGEFxs029216;
        Wed, 18 Aug 2021 11:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629303255;
        bh=pIHkKwKRYP6Fm0X184xOR3M71pNpdyeZDnIpmcnnGMA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UzuPK1bQx/duceqr7DDM+F1crWKFOvdWtDWuIg5sBIU1EgSkiw9KHwabmiKpyStmh
         oD7NQr0br4VHLmiiciP76WlJhCfjX+O9qigx0O2mvFmH245ytyOav+dZJq7hlIbPfD
         MJWq4UggynloAhqiFprGSDN4Gv6O93932I5fZbIw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17IGEFMC123132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 11:14:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 11:14:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 18 Aug 2021 11:14:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17IGEFSr004673;
        Wed, 18 Aug 2021 11:14:15 -0500
Date:   Wed, 18 Aug 2021 11:14:15 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dave Gerlach <d-gerlach@ti.com>
CC:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-mcu: Add pinctrl
Message-ID: <20210818161415.fmj5cufon3zvrvjs@dyslexic>
References: <20210818111747.88569-1-christian.gmeiner@gmail.com>
 <13974a27-a90d-639d-d050-c97570fdf369@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13974a27-a90d-639d-d050-c97570fdf369@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:13-20210818, Dave Gerlach wrote:
> Hi,
> 
> On 8/18/21 6:17 AM, Christian Gmeiner wrote:
> > Add the definition of the pinctrl for the MCU domain.
> > 
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> > index 59cc58f7d0c8..2bb5c9ff172c 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> > @@ -97,4 +97,12 @@ mcu_gpio0: gpio@4201000 {
> >  		clocks = <&k3_clks 79 0>;
> >  		clock-names = "gpio";
> >  	};
> > +
> > +	mcu_pmx0: pinctrl@4084000 {
> > +		compatible = "pinctrl-single";
> > +		reg = <0x00 0x4084000 0x00 0x84>;
> > +		#pinctrl-cells = <1>;
> > +		pinctrl-single,register-width = <32>;
> > +		pinctrl-single,function-mask = <0xffffffff>;
> > +	};
> >  };
> > 
> 
> Reviewed-by: Dave Gerlach <d-gerlach@ti.com>


Sigh.. Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt is
still not converted to yaml .. but otherwise, it is a bit late for 5.15
window.. I can stage it for 5.16 once rc1 is tagged (and need to figure
out pinctrl-single situation..)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
