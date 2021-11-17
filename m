Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5349E454A26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhKQPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhKQPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:43:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC982C061570;
        Wed, 17 Nov 2021 07:40:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso5162219wml.1;
        Wed, 17 Nov 2021 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1e4r35yakqYJ2n3GquiIT5LlL4bu2sXRURIH3oUS4mQ=;
        b=WVAAwuveo4V2/T3wWMSlA3KMi800D62/2hhAHe7apfG3JlSpCrDIQfQvIzqbLpozAi
         n2rHwra/qYW+XsqtwO9ta9/JLGi8EsI+uXlfIKcZ5MW/BU4itgWQ5c5GE+8OJRmW1mQX
         7ANMrdC/wX5UNcG0/nBzBa9uC1WCExVs88ieSatLFNJgVNbatW9miYhqdRJhufmTpwIM
         jx+GxW6b/t1IzGPoY6gefZ62gmuEFzLxPzbmIHJcCL4MagTsqxVXYzwCjtpVO7EV2EJv
         JRv8PriNhvCud7egvn0EsovqWaj+RoorvAcGrmLrXa0B2N9UoEbFzFDumYyvxZnKPSJ/
         s5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1e4r35yakqYJ2n3GquiIT5LlL4bu2sXRURIH3oUS4mQ=;
        b=HAFy1OFlP910odECS2tHKLxp8A5vkroP555CAocyhJ4hsZEK0OENsMjAa/c8FLk/pX
         KG8/Zdf+kA2QDlEUvkrx/Rx8a+ZE6RQTdeu9G7CXlGugawhxdw0W3z2d1ZWYBsSjXBBw
         9sA9kKlqyL/tyoWQXIRHfELv6oNZpe+fBOjHBX7lHB7oCtR8pIbMO2j7GRvOujjOFyGP
         xUQ0/34+Zih0F9b5SDSRYLsNwes4sVEFQVvrkaaqWyU2DHAArrhwl7kaz+3uF0/dSM9q
         RLX18WtJBOYSa4vGdf3v4nRHHRFy9d5MJ27/+yRKjU9bS1RcfYP/BXhl9J3uj2OOsbAy
         xpDw==
X-Gm-Message-State: AOAM530Vy/6U67gkqdr2Xx5WMXV429LTL44r4XiQwPsSk4OWJgdOR895
        EyBX9pWK8Vkw1ePLcystjeY=
X-Google-Smtp-Source: ABdhPJytjeCYk7JW3WTLZmWodsJn1KrCwCciuY8wezt5sSJT+X/FdsjwSIunHmifRcndZq8qpZU73w==
X-Received: by 2002:a05:600c:500a:: with SMTP id n10mr763185wmr.136.1637163610353;
        Wed, 17 Nov 2021 07:40:10 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id i17sm41888wmq.48.2021.11.17.07.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:40:09 -0800 (PST)
Message-ID: <9d969ccd-1713-acb5-73ac-655c11086738@gmail.com>
Date:   Wed, 17 Nov 2021 16:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: Add USB xHCI controller for
 mt8195
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
 <20211102060049.1843-3-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211102060049.1843-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2021 07:00, Chunfeng Yun wrote:
> Add all four USB xHCI controllers for MT8195
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Patch lookes good, I'll take it as soon as 1/3 and 2/3 is accepted.

Regards,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 79 ++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 
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
