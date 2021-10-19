Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52FA432CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 06:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhJSEnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 00:43:22 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:45374 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229649AbhJSEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 00:43:21 -0400
X-UUID: 7f27188ceb7a40e3a084bc92d413ae66-20211019
X-UUID: 7f27188ceb7a40e3a084bc92d413ae66-20211019
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 361193371; Tue, 19 Oct 2021 12:41:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 19 Oct 2021 12:41:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 12:41:03 +0800
Message-ID: <5d2a803943ace606d356af2ec0a75bd42aaf7fb5.camel@mediatek.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: mediatek: add clock support for
 mt7986b
From:   Miles Chen <miles.chen@mediatek.com>
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Date:   Tue, 19 Oct 2021 12:41:03 +0800
In-Reply-To: <20211018114701.13984-6-sam.shih@mediatek.com>
References: <20211018114701.13984-1-sam.shih@mediatek.com>
         <20211018114701.13984-6-sam.shih@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

@@ -99,6 +101,18 @@ gic: interrupt-controller@c000000 {
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		infracfg: infracfg@10001000 {
> +			compatible = "mediatek,mt7986-infracfg",
> "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		topckgen: topckgen@1001b000 {
> +			compatible = "mediatek,mt7986-topckgen",
> "syscon";
> +			reg = <0 0x1001B000 0 0x1000>;

please use lowercase hex values (e.g, 0x1001b000)

> +			#clock-cells = <1>;
> +		};
> +
>  		watchdog: watchdog@1001c000 {
>  			compatible = "mediatek,mt7986-wdt",
>  				     "mediatek,mt6589-wdt";
> @@ -108,11 +122,31 @@ watchdog: watchdog@1001c000 {
>  			status = "disabled";
>  		};
>  
> +		apmixedsys: apmixedsys@1001e000 {
> +			compatible = "mediatek,mt7986-apmixedsys";
> +			reg = <0 0x1001E000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};

Ditto

> +
> +		sgmiisys0: syscon@10060000 {
> +			compatible = "mediatek,mt7986-sgmiisys_0",
> +				     "syscon";
> +			reg = <0 0x10060000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sgmiisys1: syscon@10070000 {
> +			compatible = "mediatek,mt7986-sgmiisys_1",
> +				     "syscon";
> +			reg = <0 0x10070000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		trng: trng@1020f000 {
>  			compatible = "mediatek,mt7986-rng",
>  				     "mediatek,mt7623-rng";
>  			reg = <0 0x1020f000 0 0x100>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_TRNG_CK>;
>  			clock-names = "rng";
>  			status = "disabled";
>  		};
> @@ -122,7 +156,13 @@ uart0: serial@11002000 {
>  				     "mediatek,mt6577-uart";
>  			reg = <0 0x11002000 0 0x400>;
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_UART0_SEL>,
> +				 <&infracfg CLK_INFRA_UART0_CK>;
> +			clock-names = "baud", "bus";
> +			assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
> +					  <&infracfg
> CLK_INFRA_UART0_SEL>;
> +			assigned-clock-parents = <&topckgen
> CLK_TOP_XTAL>,
> +						 <&topckgen
> CLK_TOP_UART_SEL>;
>  			status = "disabled";
>  		};
>  
> @@ -131,7 +171,11 @@ uart1: serial@11003000 {
>  				     "mediatek,mt6577-uart";
>  			reg = <0 0x11003000 0 0x400>;
>  			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_UART1_SEL>,
> +				 <&infracfg CLK_INFRA_UART1_CK>;
> +			clock-names = "baud", "bus";
> +			assigned-clocks = <&infracfg
> CLK_INFRA_UART1_SEL>;
> +			assigned-clock-parents = <&topckgen
> CLK_TOP_F26M_SEL>;
>  			status = "disabled";
>  		};
>  
> @@ -140,10 +184,24 @@ uart2: serial@11004000 {
>  				     "mediatek,mt6577-uart";
>  			reg = <0 0x11004000 0 0x400>;
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_UART2_SEL>,
> +				 <&infracfg CLK_INFRA_UART2_CK>;
> +			clock-names = "baud", "bus";
> +			assigned-clocks = <&infracfg
> CLK_INFRA_UART2_SEL>;
> +			assigned-clock-parents = <&topckgen
> CLK_TOP_F26M_SEL>;
>  			status = "disabled";
>  		};
>  
> +		ethsys: syscon@15000000 {
> +			 #address-cells = <1>;
> +			 #size-cells = <1>;
> +			 compatible = "mediatek,mt7986-ethsys",
> +				      "syscon";
> +			 reg = <0 0x15000000 0 0x1000>;
> +			 #clock-cells = <1>;
> +			 #reset-cells = <1>;
> +		};
> +
>  	};
>  
>  };

