Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F7337436
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhCKNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:41:39 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50898 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCKNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:41:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BDfCaq108524;
        Thu, 11 Mar 2021 07:41:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615470072;
        bh=vYLdQbvqwMSqb9Nc4Kl09M1XlI2NhnGkj2qZH+9v8j8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OBbm3t30O4VZAsUnIreBTI/XsavIqsW+FaJrebHc7IpZmU121Z5j6SYtfghbclZxZ
         zfSBj0o9zFchOkAq5sdFxNod8LmZzUWdHPOFjHK8zeuwDiIth2yRId2jsbce7Ghsl6
         XHIvKbL6Ah6v9RtcBbGI3GQxKkiPid/UwlDDHv7w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BDfCPk032166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 07:41:12 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 07:41:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 07:41:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BDfBiK001084;
        Thu, 11 Mar 2021 07:41:12 -0600
Date:   Thu, 11 Mar 2021 19:11:11 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-j7200-som-p0: Add nodes for
 OSPI0
Message-ID: <20210311134109.pbqsq3l5v2h5ivlx@ti.com>
References: <20210305153926.3479-1-p.yadav@ti.com>
 <20210305153926.3479-4-p.yadav@ti.com>
 <cbc23906-68cd-d885-2a81-c6088c402caf@ti.com>
 <20210311132250.6kwrgo75emyoglzo@pauper>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210311132250.6kwrgo75emyoglzo@pauper>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/21 07:22AM, Nishanth Menon wrote:
> On 21:43-20210305, Vignesh Raghavendra wrote:
> > 
> > 
> > On 3/5/21 9:09 PM, Pratyush Yadav wrote:
> > > TI J7200 has the Cadence OSPI controller for interfacing with OSPI
> > > flashes. Add its node to allow using SPI flashes.
> > > 
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > ---
> > 
> > Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > 
> > 
> > > 
> > > Notes:
> > >     Changes in v2:
> > >     - Do not force a pulldown on the DQS line because it already has a
> > >       pulldown resistor.
> > > 
> > >  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 17 +++++++++
> > >  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 36 +++++++++++++++++++
> > >  2 files changed, 53 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > > index 359e3e8a8cd0..5408ec815d58 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > > @@ -269,6 +269,23 @@ hbmc: hyperbus@47034000 {
> > >  			#size-cells = <1>;
> > >  			mux-controls = <&hbmc_mux 0>;
> > >  		};
> > > +
> > > +		ospi0: spi@47040000 {
> > > +			compatible = "ti,am654-ospi";
> > > +			reg = <0x0 0x47040000 0x0 0x100>,
> > > +			      <0x5 0x00000000 0x1 0x0000000>;
> > > +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> > > +			cdns,fifo-depth = <256>;
> > > +			cdns,fifo-width = <4>;
> > > +			cdns,trigger-address = <0x0>;
> > > +			clocks = <&k3_clks 103 0>;
> > > +			assigned-clocks = <&k3_clks 103 0>;
> > > +			assigned-clock-parents = <&k3_clks 103 2>;
> > > +			assigned-clock-rates = <166666666>;
> > > +			power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +		};
> > >  	};
> > >  
> > >  	tscadc0: tscadc@40200000 {
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> > > index a988e2ab2ba1..34724440171a 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> > > @@ -100,6 +100,22 @@ J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
> > >  			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
> > >  		>;
> > >  	};
> > > +
> > > +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
> > > +		pinctrl-single,pins = <
> > > +			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
> > > +			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
> > > +			J721E_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* MCU_OSPI0_D0 */
> > > +			J721E_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* MCU_OSPI0_D1 */
> > > +			J721E_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* MCU_OSPI0_D2 */
> > > +			J721E_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* MCU_OSPI0_D3 */
> > > +			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* MCU_OSPI0_D4 */
> > > +			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* MCU_OSPI0_D5 */
> > > +			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
> > > +			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
> > > +			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
> > > +		>;
> > > +	};
> > >  };
> > >  
> > >  &main_pmx0 {
> > > @@ -235,3 +251,23 @@ exp_som: gpio@21 {
> > >  				  "GPIO_LIN_EN", "CAN_STB";
> > >  	};
> > >  };
> > > +
> > > +&ospi0 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> > > +
> > > +	flash@0{
> > > +		compatible = "jedec,spi-nor";
> > > +		reg = <0x0>;
> > > +		spi-tx-bus-width = <8>;
> > > +		spi-rx-bus-width = <8>;
> > > +		spi-max-frequency = <25000000>;
> > > +		cdns,tshsl-ns = <60>;
> > > +		cdns,tsd2d-ns = <60>;
> > > +		cdns,tchsh-ns = <60>;
> > > +		cdns,tslch-ns = <60>;
> > > +		cdns,read-delay = <4>;
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +	};
> I see this:
> +/workdir/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dt.yaml: flash@0: 'cdns,read-delay', 'cdns,tchsh-ns', 'cdns,tsd2d-ns', 'cdns,tshsl-ns', 'cdns,tslch-ns' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
> 
> 
> And that is because
> Documentation/devicetree/bindings/spi/cadence-quadspi.txt is not
> converted to yaml. Following the new stringent rules, yaml please?

Ok. I am working on the conversion. Will send it soon.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
