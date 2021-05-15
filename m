Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAF3819F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhEOQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhEOQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:53:44 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093CC061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
        :To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=txLWCZZrHrmoTpUKWr+ONbqFMLWQFqWiEKzvfzqHv7s=; b=G26qH6KW3uTYeR+Y6tOYRUFndg
        xBG9R+sMHvuG/lXTbho8fEGmFKM/WhNmYuyJiRByRqAVyWXAQwflo73JsrDcK+Be3ZDaemQt3kxOX
        +HIhilKVsPwCFVSFXWPyDtGdtm8XFGc+DZ5HAzSSI9bxYeWnMe0BWR+wea8ZSkHWTpZ0wmovPmlhs
        IpIGNzO+zV+JlUzSNawlgDs24zgrz6lt1QV80O32F36prxVfnbPqfkXkkXQbU+OdcX6+EnbwBz8zT
        Z5sLDY07IAn9yMMhgi1P40DcBYQZNgV9FcTgOXYN6TPaDjyAZj3I/wr1lshp00LqIJ8aVSBU3KRH0
        KmxUhEtQ==;
Received: from [2001:4d48:ad59:1409:4::2] (helo=youmian.o362.us)
        by the.earth.li with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1lhxWd-0004Rc-PH; Sat, 15 May 2021 17:52:27 +0100
Date:   Sat, 15 May 2021 17:52:21 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: qcom: Add ADM DMA + NAND definitions to ipq806x
Message-ID: <fb8b3df3a25120cb1ae9adfd25c754334e8eaf4e.1621097174.git.noodles@earth.li>
References: <cover.1621097174.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621097174.git.noodles@earth.li>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the ADM driver is in mainline add the appropriate definitions for it
and the NAND controller to get NAND working on IPQ806x platforms,

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 67 +++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 98995ead4413..aaab3820ab0b 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -185,6 +185,31 @@
 					bias-pull-up;
 				};
 			};
+
+			nand_pins: nand_pins {
+				mux {
+					pins = "gpio34", "gpio35", "gpio36",
+					       "gpio37", "gpio38", "gpio39",
+					       "gpio40", "gpio41", "gpio42",
+					       "gpio43", "gpio44", "gpio45",
+					       "gpio46", "gpio47";
+					function = "nand";
+					drive-strength = <10>;
+					bias-disable;
+				};
+
+				pullups {
+					pins = "gpio39";
+					bias-pull-up;
+				};
+
+				hold {
+					pins = "gpio40", "gpio41", "gpio42",
+					       "gpio43", "gpio44", "gpio45",
+					       "gpio46", "gpio47";
+					bias-bus-hold;
+				};
+			};
 		};
 
 		intc: interrupt-controller@2000000 {
@@ -226,6 +251,26 @@
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
 		};
 
+		adm_dma: dma@18300000 {
+			compatible = "qcom,adm";
+			reg = <0x18300000 0x100000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+
+			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
+			clock-names = "core", "iface";
+
+			resets = <&gcc ADM0_RESET>,
+				 <&gcc ADM0_PBUS_RESET>,
+				 <&gcc ADM0_C0_RESET>,
+				 <&gcc ADM0_C1_RESET>,
+				 <&gcc ADM0_C2_RESET>;
+			reset-names = "clk", "pbus", "c0", "c1", "c2";
+			qcom,ee = <0>;
+
+			status = "disabled";
+		};
+
 		saw0: regulator@2089000 {
 			compatible = "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
@@ -403,6 +448,28 @@
 			status = "disabled";
 		};
 
+		nand: nand-controller@1ac00000 {
+			compatible = "qcom,ipq806x-nand";
+			reg = <0x1ac00000 0x800>;
+
+			pinctrl-0 = <&nand_pins>;
+			pinctrl-names = "default";
+
+			clocks = <&gcc EBI2_CLK>,
+				 <&gcc EBI2_AON_CLK>;
+			clock-names = "core", "aon";
+
+			dmas = <&adm_dma 3>;
+			dma-names = "rxtx";
+			qcom,cmd-crci = <15>;
+			qcom,data-crci = <3>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		sata: sata@29000000 {
 			compatible = "qcom,ipq806x-ahci", "generic-ahci";
 			reg = <0x29000000 0x180>;
-- 
2.20.1

