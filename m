Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA032CEB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhCDIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:46:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40442 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbhCDIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:45:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1248iTrn065629;
        Thu, 4 Mar 2021 02:44:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614847469;
        bh=X7WVajiilZwT20Vssv+HGu1wdi5InlNHQ+n5NfjV1ts=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kS+beaIsNm/ClNNRlf0DqER3yJWmx/6BmWjOPjb9EGHHGD0lfuNKw4o5nofGeaPNm
         Sm5iMi78ud0x3IzsHbogkoYusayEIzbq3mgA+z06wp+7rxL0OxNqrBMVrMtflvqyX3
         ayMPbTgrHOHu2V60TiP+AGvvUw1/gzcIJscuIlHQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1248iTwQ064981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 02:44:29 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 02:44:29 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 02:44:28 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1248iPar101493;
        Thu, 4 Mar 2021 02:44:26 -0600
Subject: Re: [PATCH 1/4] arm64: dts: ti: am64-main: Add CPSW DT node
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>
References: <20210303192114.12292-1-grygorii.strashko@ti.com>
 <20210303192114.12292-2-grygorii.strashko@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <a2526aef-ed2e-c33b-0afb-b5363fb17969@ti.com>
Date:   Thu, 4 Mar 2021 14:14:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303192114.12292-2-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/21 12:51 am, Grygorii Strashko wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add CPSW3g DT node with two external ports, MDIO and CPTS support. For
> CPSW3g DMA channels the ASEL is set to 15 (AM642x per DMA channel coherency
> feature), so that CPSW DMA channel participates in Coherency and thus avoid
> need to cache maintenance for SKBs. This improves bidirectional TCP
> performance by up to 100Mbps (on 1G link).
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

nit pick. In $subject : k3-am64-main.

Thanks and regards,
Lokesh

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 74 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 5f85950daef7..80443dbf272c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -178,6 +178,12 @@
>  			compatible = "ti,am654-chipid";
>  			reg = <0x00000014 0x4>;
>  		};
> +
> +		phy_gmii_sel: phy@4044 {
> +			compatible = "ti,am654-phy-gmii-sel";
> +			reg = <0x4044 0x8>;
> +			#phy-cells = <1>;
> +		};
>  	};
>  
>  	main_uart0: serial@2800000 {
> @@ -402,4 +408,72 @@
>  		ti,otap-del-sel-ddr50 = <0x9>;
>  		ti,clkbuf-sel = <0x7>;
>  	};
> +
> +	cpsw3g: ethernet@8000000 {
> +		compatible = "ti,am642-cpsw-nuss";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <0x0 0x8000000 0x0 0x200000>;
> +		reg-names = "cpsw_nuss";
> +		ranges = <0x0 0x0 0x0 0x8000000 0x0 0x200000>;
> +		clocks = <&k3_clks 13 0>;
> +		assigned-clocks = <&k3_clks 13 1>;
> +		assigned-clock-parents = <&k3_clks 13 9>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
> +
> +		dmas = <&main_pktdma 0xC500 15>,
> +		       <&main_pktdma 0xC501 15>,
> +		       <&main_pktdma 0xC502 15>,
> +		       <&main_pktdma 0xC503 15>,
> +		       <&main_pktdma 0xC504 15>,
> +		       <&main_pktdma 0xC505 15>,
> +		       <&main_pktdma 0xC506 15>,
> +		       <&main_pktdma 0xC507 15>,
> +		       <&main_pktdma 0x4500 15>;
> +		dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6",
> +			    "tx7", "rx";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cpsw_port1: port@1 {
> +				reg = <1>;
> +				ti,mac-only;
> +				label = "port1";
> +				phys = <&phy_gmii_sel 1>;
> +				mac-address = [00 00 de ad be ef];
> +			};
> +
> +			cpsw_port2: port@2 {
> +				reg = <2>;
> +				ti,mac-only;
> +				label = "port2";
> +				phys = <&phy_gmii_sel 2>;
> +				mac-address = [00 01 de ad be ef];
> +			};
> +		};
> +
> +		cpsw3g_mdio: mdio@f00 {
> +			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> +			reg = <0x0 0xf00 0x0 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&k3_clks 13 0>;
> +			clock-names = "fck";
> +			bus_freq = <1000000>;
> +		};
> +
> +		cpts@3d000 {
> +			compatible = "ti,j721e-cpts";
> +			reg = <0x0 0x3d000 0x0 0x400>;
> +			clocks = <&k3_clks 13 1>;
> +			clock-names = "cpts";
> +			interrupts-extended = <&gic500 GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "cpts";
> +			ti,cpts-ext-ts-inputs = <4>;
> +			ti,cpts-periodic-outputs = <2>;
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index 0ae8c844c482..de6805b0c72c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -28,6 +28,8 @@
>  		serial6 = &main_uart4;
>  		serial7 = &main_uart5;
>  		serial8 = &main_uart6;
> +		ethernet0 = &cpsw_port1;
> +		ethernet1 = &cpsw_port2;
>  	};
>  
>  	chosen { };
> 
