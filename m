Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E43332946
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCIOyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:54:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59596 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhCIOyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:54:33 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129EsQLf049762;
        Tue, 9 Mar 2021 08:54:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615301666;
        bh=kQ/eWyaryUE+S4nDbbrdLRvi9zvSrVP9ous5AGwvMCI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WbObOUGNe6IgfpIPtTqeCKRJhpKnlD3q9dGuK1+Zs5Nwc3poNZXAIF3UTn+YhwfN5
         313wx66wdJV2G0bXRitf7mGEIemS4Tu/SAfmnJiLkbU5JcHb9klVzrSjiTppOvm14H
         oPGaG+fwJMc6EWPm2mGLC13iHrRTKcczFWgh0ccs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129EsQ7a048039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 08:54:26 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 08:54:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Mar 2021 08:54:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129EsQ8V015039;
        Tue, 9 Mar 2021 08:54:26 -0600
Date:   Tue, 9 Mar 2021 08:54:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add support for SPI EEPROM
Message-ID: <20210309145426.tgt7ltlh22slygfm@santa>
References: <20210301060518.19550-1-a-govindraju@ti.com>
 <c06a39c5-88eb-1e6d-4ae2-796981db1e71@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c06a39c5-88eb-1e6d-4ae2-796981db1e71@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:18-20210309, Vignesh Raghavendra wrote:
> 
> 
> On 3/1/21 11:35 AM, Aswath Govindraju wrote:
> > Add pinmux details and device tree node for the EEPROM attached to SPI0
> > module in main domain.
> > 
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> 
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Regards
> Vignesh
> 
> > 
> > This patch depends on,
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210301055109.17626-3-a-govindraju@ti.com/


Can you drop this dependency and rebase on top of my -next branch or
linux-next ? I am not able to apply the patch directly and would like to
avoid hand modifying the patch.

> > 
> >  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> > index bfd849a29655..bc5bd7f896ab 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> > @@ -139,6 +139,15 @@
> >  			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
> >  		>;
> >  	};
> > +
> > +	main_spi0_pins_default: main-spi0-pins-default {
> > +		pinctrl-single,pins = <
> > +			AM64X_IOPAD(0x0210, PIN_INPUT, 0) /* (D13) SPI0_CLK */
> > +			AM64X_IOPAD(0x0208, PIN_OUTPUT, 0) /* (D12) SPI0_CS0 */
> > +			AM64X_IOPAD(0x0214, PIN_OUTPUT, 0) /* (A13) SPI0_D0 */
> > +			AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
> > +		>;
> > +	};
> >  };
> >  
> >  &main_uart0 {
> > @@ -245,6 +254,19 @@
> >  	pinctrl-0 = <&main_usb0_pins_default>;
> >  };
> >  
> > +&main_spi0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&main_spi0_pins_default>;
> > +	ti,pindir-d0-out-d1-in = <1>;
> > +	eeprom@0 {
> > +		compatible = "microchip,93lc46b";
> > +		reg = <0>;
> > +		spi-max-frequency = <1000000>;
> > +		spi-cs-high;
> > +		data-size = <16>;
> > +	};
> > +};
> > +
> >  &sdhci0 {
> >  	/* emmc */
> >  	bus-width = <8>;
> > 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
