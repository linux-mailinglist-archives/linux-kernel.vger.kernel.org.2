Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47737ED1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbhELULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:11:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38536 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359392AbhELSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:53:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CIpvs7080736;
        Wed, 12 May 2021 13:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620845517;
        bh=tWCMQzEXhGWDWI00VNLAIexogbcia7fJbpiQJ2NdxYA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GyAr6tdWCAYbrF4i7+J4PF8J4XnATZMTizktPdZVCLhXN7uvpdRdl6F1DpLkkrcJc
         Ja7TRDGh00azZWjfC4zROkpDlfX7B7aHAbaIT6rOtvhNTiVs+pbJ/H7b9cROJZpedJ
         d8ty919AhgcN5pmUQBv8RQEqh8SfBkasbAplkK70=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CIpvJo128998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 13:51:57 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 13:51:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 13:51:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CIpvWA036988;
        Wed, 12 May 2021 13:51:57 -0500
Date:   Wed, 12 May 2021 13:51:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j721e-main: Fix external refclk
 input to SERDES
Message-ID: <20210512185157.q5sr2xqf3w5igfte@imagines>
References: <20210512151209.27560-1-kishon@ti.com>
 <20210512151209.27560-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210512151209.27560-2-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:42-20210512, Kishon Vijay Abraham I wrote:
> Rename the external refclk inputs to the SERDES from
> dummy_cmn_refclk/dummy_cmn_refclk1 to cmn_refclk/cmn_refclk1
> respectively. Also move the external refclk DT nodes outside the
> cbass_main DT node. Since in j721e common processor board, only the
> cmn_refclk1 is connected to 100MHz clock, fix the clock frequency.
> 
> Fixes: afd094ebe69f ("arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes")

Assume we want this part of 5.13 fixes?

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     |  4 ++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 58 ++++++++++---------
>  2 files changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 60764366e22b..86f7ab511ee8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -635,6 +635,10 @@
>  	status = "disabled";
>  };
>  
> +&cmn_refclk1 {
> +	clock-frequency = <100000000>;
> +};
> +
>  &serdes0 {
>  	serdes0_pcie_link: link@0 {
>  		reg = <0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index c2aa45a3ac79..002a0c1520ee 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -8,6 +8,20 @@
>  #include <dt-bindings/mux/mux.h>
>  #include <dt-bindings/mux/ti-serdes.h>
>  
> +/ {
> +	cmn_refclk: cmn-refclk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <0>;
> +	};
> +
> +	cmn_refclk1: cmn-refclk1 {

Just curious: why cant we use the standard nodenames with clock?
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <0>;
> +	};
> +};
> +
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -336,24 +350,12 @@
>  		pinctrl-single,function-mask = <0xffffffff>;
>  	};
>  
> -	dummy_cmn_refclk: dummy-cmn-refclk {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <100000000>;
> -	};
> -
> -	dummy_cmn_refclk1: dummy-cmn-refclk1 {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <100000000>;
> -	};
> -
>  	serdes_wiz0: wiz@5000000 {
>  		compatible = "ti,j721e-wiz-16g";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
> +		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&cmn_refclk>;
>  		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>  		assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
>  		assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
> @@ -362,21 +364,21 @@
>  		ranges = <0x5000000 0x0 0x5000000 0x10000>;
>  
>  		wiz0_pll0_refclk: pll0-refclk {
> -			clocks = <&k3_clks 292 11>, <&dummy_cmn_refclk>;
> +			clocks = <&k3_clks 292 11>, <&cmn_refclk>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz0_pll0_refclk>;
>  			assigned-clock-parents = <&k3_clks 292 11>;
>  		};
>  
>  		wiz0_pll1_refclk: pll1-refclk {
> -			clocks = <&k3_clks 292 0>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 292 0>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz0_pll1_refclk>;
>  			assigned-clock-parents = <&k3_clks 292 0>;
>  		};
>  
>  		wiz0_refclk_dig: refclk-dig {
> -			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&cmn_refclk>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz0_refclk_dig>;
>  			assigned-clock-parents = <&k3_clks 292 11>;
> @@ -410,7 +412,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&dummy_cmn_refclk>;
> +		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&cmn_refclk>;
>  		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>  		assigned-clocks = <&k3_clks 293 13>, <&k3_clks 293 0>;
>  		assigned-clock-parents = <&k3_clks 293 17>, <&k3_clks 293 4>;
> @@ -419,21 +421,21 @@
>  		ranges = <0x5010000 0x0 0x5010000 0x10000>;
>  
>  		wiz1_pll0_refclk: pll0-refclk {
> -			clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
> +			clocks = <&k3_clks 293 13>, <&cmn_refclk>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz1_pll0_refclk>;
>  			assigned-clock-parents = <&k3_clks 293 13>;
>  		};
>  
>  		wiz1_pll1_refclk: pll1-refclk {
> -			clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 293 0>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz1_pll1_refclk>;
>  			assigned-clock-parents = <&k3_clks 293 0>;
>  		};
>  
>  		wiz1_refclk_dig: refclk-dig {
> -			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&cmn_refclk>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz1_refclk_dig>;
>  			assigned-clock-parents = <&k3_clks 293 13>;
> @@ -467,7 +469,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		power-domains = <&k3_pds 294 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&dummy_cmn_refclk>;
> +		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&cmn_refclk>;
>  		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>  		assigned-clocks = <&k3_clks 294 11>, <&k3_clks 294 0>;
>  		assigned-clock-parents = <&k3_clks 294 15>, <&k3_clks 294 4>;
> @@ -476,21 +478,21 @@
>  		ranges = <0x5020000 0x0 0x5020000 0x10000>;
>  
>  		wiz2_pll0_refclk: pll0-refclk {
> -			clocks = <&k3_clks 294 11>, <&dummy_cmn_refclk>;
> +			clocks = <&k3_clks 294 11>, <&cmn_refclk>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz2_pll0_refclk>;
>  			assigned-clock-parents = <&k3_clks 294 11>;
>  		};
>  
>  		wiz2_pll1_refclk: pll1-refclk {
> -			clocks = <&k3_clks 294 0>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 294 0>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz2_pll1_refclk>;
>  			assigned-clock-parents = <&k3_clks 294 0>;
>  		};
>  
>  		wiz2_refclk_dig: refclk-dig {
> -			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&cmn_refclk>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz2_refclk_dig>;
>  			assigned-clock-parents = <&k3_clks 294 11>;
> @@ -524,7 +526,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		power-domains = <&k3_pds 295 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&dummy_cmn_refclk>;
> +		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&cmn_refclk>;
>  		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>  		assigned-clocks = <&k3_clks 295 9>, <&k3_clks 295 0>;
>  		assigned-clock-parents = <&k3_clks 295 13>, <&k3_clks 295 4>;
> @@ -533,21 +535,21 @@
>  		ranges = <0x5030000 0x0 0x5030000 0x10000>;
>  
>  		wiz3_pll0_refclk: pll0-refclk {
> -			clocks = <&k3_clks 295 9>, <&dummy_cmn_refclk>;
> +			clocks = <&k3_clks 295 9>, <&cmn_refclk>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz3_pll0_refclk>;
>  			assigned-clock-parents = <&k3_clks 295 9>;
>  		};
>  
>  		wiz3_pll1_refclk: pll1-refclk {
> -			clocks = <&k3_clks 295 0>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 295 0>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz3_pll1_refclk>;
>  			assigned-clock-parents = <&k3_clks 295 0>;
>  		};
>  
>  		wiz3_refclk_dig: refclk-dig {
> -			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> +			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&cmn_refclk>, <&cmn_refclk1>;
>  			#clock-cells = <0>;
>  			assigned-clocks = <&wiz3_refclk_dig>;
>  			assigned-clock-parents = <&k3_clks 295 9>;
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
