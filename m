Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673243CF952
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhGTLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:24:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47976 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhGTLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:24:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KC5ASX033557;
        Tue, 20 Jul 2021 07:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626782710;
        bh=vGcbRp6Et5F1/Ir8my4y8ecXi3l/Hj6jaPl/8mqqhaM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Q/t8EJVZBsHTmZ7FrDm4VSwk5H0CSOHWRG68UwJhhKttvQnuR2ZgFd54KvWTxii1z
         8hSveajZt1AbTmk267rPdbVxeKtzHoWkzqZnRZ244hZ4712sm6nxR1uqGTTGmyhDoD
         YUebhf2uyooHYp80L8PpuOSX/IZ0sTgoVF1wO+hQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KC5AjK077089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 07:05:10 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 07:05:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 07:05:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KC591D068071;
        Tue, 20 Jul 2021 07:05:09 -0500
Date:   Tue, 20 Jul 2021 07:05:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     <kristo@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am642-sk: Add ecap0 node
Message-ID: <20210720120509.66igh3goqoopkinv@extinct>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
 <20210719085402.28569-4-lokeshvutla@ti.com>
 <20210719152326.op7ii76nvk5sve2a@fringe>
 <d5d614f4-339b-59a1-bd29-6c78d09f2d89@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5d614f4-339b-59a1-bd29-6c78d09f2d89@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:46-20210720, Lokesh Vutla wrote:
> 
> 
> On 19/07/21 8:53 pm, Nishanth Menon wrote:
> > On 14:24-20210719, Lokesh Vutla wrote:
> >> ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
> >> signal connected to Pin 1 of J3. Add support for adding this pinmux so
> >> that pwm can be observed on pin 1 of Header J3
> >>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> >> index d3aa2901e6fd..eb0d10e6e787 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> >> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> >> @@ -210,6 +210,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
> >>  			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
> >>  		>;
> >>  	};
> >> +
> >> +	main_ecap0_pins_default: main-ecap0-pins-default {
> >> +		pinctrl-single,pins = <
> >> +			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
> >> +		>;
> >> +	};
> >>  };
> >>  
> >>  &mcu_uart0 {
> >> @@ -453,3 +459,9 @@ &pcie0_rc {
> >>  &pcie0_ep {
> >>  	status = "disabled";
> >>  };
> >> +
> >> +&ecap0 {
> >> +	/* PWM is available on Pin 1 of header J3 */
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&main_ecap0_pins_default>;
> >> +};
> >> -- 
> >> 2.30.0
> >>
> > 
> > 
> > Do the other ecap and pwm nodes need to be disabled since they may not
> > be pinned out?
> 
> Sure, Ill mark other ecap and epwm nodes as disabled. After looking at
> schematics, epwm4 and 5 is pinned out on RPI header. But the header will most
> likely be used for other use-cases. Shall I mark epwm4 and epwm5 disabled as
> well with a comment with this information?


Yes, please. Thanks.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
