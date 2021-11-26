Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC745EC7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhKZLZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbhKZLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:23:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7DC08EC23;
        Fri, 26 Nov 2021 02:36:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 15A131F467C2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637923005; bh=p544riZzn0zdZeLNWHq9SL3/SLvcyH1A0FpJe0Rsn+0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hjtQtps9kXNuPLBmlY2WeaWZATca4V3B6fIKceWVsKTCWNsruDy5Oysk3SGd0tIMq
         G1/tIKNrUy1kjGdscl7zaxgTsHv/1JCQkkZn2/oBFnSpaiIVHpJQE0Xog/vbubM6mi
         +b2548o880QSYR+qBBGicZT0dAoFxfKe6VoXASBgCQPJG2MMVWEfTnda53DDkrAB6s
         h3IMCa41Asvauoym98hreN7JIr2go+Ip7BFaWIDHyC9yN78J9W7sejMNRZ4hF7V9OF
         H4/e1y+6pHJ8vKAS8zESl1TLlyn1UTlCxoupKazp/sfTtk8Zl3oEjKG4b0pMWfETNI
         DijXYTGWQ/bCg==
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: Add USB xHCI controller for
 mt8195
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
 <20211102060049.1843-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9db3cb96-ac67-151d-5674-b56c5abbe348@collabora.com>
Date:   Fri, 26 Nov 2021 11:36:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102060049.1843-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/21 07:00, Chunfeng Yun ha scritto:
> Add all four USB xHCI controllers for MT8195
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 79 ++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 

Hello!
Thanks for the patch! However, there is something to improve...

> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index a59c0e9d1fc2..263eebfd2ea1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/mt8195-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8195-power.h>
>   
>   / {
> @@ -823,6 +824,26 @@
>   			status = "disabled";
>   		};
>   
> +		xhci0: usb@11200000 {
> +			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +			reg = <0 0x11200000 0 0x1000>, <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;

Here, and on the other xhci nodes (from what I know, xhci{0,1,3}), you should use
interrupts-extended and declare the wakeup interrupt on pio.

			interrupts-extended = <&gic GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>,

					      <&pio 219 IRQ_TYPE_LEVEL_LOW>;

			interrupt-names = "host", "wakeup";


> +			phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_REF>,
> +				 <&apmixedsys CLK_APMIXED_USB1PLL>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
> +			wakeup-source;
> +			status = "disabled";
> +		};
> +
>   		mmc0: mmc@11230000 {
>   			compatible = "mediatek,mt8195-mmc", "mediatek,mt8192-mmc";
>   			reg = <0 0x11230000 0 0x10000>,
> @@ -843,6 +864,64 @@
>   			status = "disabled";
>   		};
>   
> +		xhci1: usb@11290000 {
> +			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +			reg = <0 0x11290000 0 0x1000>, <0 0x11293e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;

			interrupts-extended = <&gic GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>,

					      <&pio 218 IRQ_TYPE_LEVEL_LOW>;

> +			phys = <&u2port1 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_1P_BUS>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_P1_REF>,
> +				 <&apmixedsys CLK_APMIXED_USB1PLL>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
> +			wakeup-source;
> +			status = "disabled";
> +		};
> +
> +		xhci2: usb@112a0000 {
> +			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +			reg = <0 0x112a0000 0 0x1000>, <0 0x112a3e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port2 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_P2_REF>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
> +			status = "disabled";
> +		};
> +
> +		xhci3: usb@112b0000 {
> +			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +			reg = <0 0x112b0000 0 0x1000>, <0 0x112b3e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;

			interrupts-extended = <&gic GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>,

					      <&pio 221 IRQ_TYPE_LEVEL_LOW>;

			interrupts-names = "host", "wakeup";

> +			phys = <&u2port3 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_P3_REF>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
> +			wakeup-source;
> +			usb2-lpm-disable;
> +			status = "disabled";
> +		};
> +
>   		nor_flash: nor@1132c000 {
>   			compatible = "mediatek,mt8195-nor", "mediatek,mt8173-nor";
>   			reg = <0 0x1132c000 0 0x1000>;
> 

Regards,
- Angelo
