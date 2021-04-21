Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5B36648F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 06:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhDUE3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 00:29:20 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56291 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231575AbhDUE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 00:29:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1F65C580E32;
        Wed, 21 Apr 2021 00:28:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 21 Apr 2021 00:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fzJUD2qGibX3T
        c+nSeqt20oBjnAxswijfmk5lfSvqdE=; b=PAlWGuyjfTPm5XghulgfXJEVSgVDi
        sL/Lta7mLPkuNY6C1tmaOEf+J9rtDeyRBkcAyoNyw1BCfnbsvTDqnehvMKgPaH0B
        phyPlkUNFkkDp12xFubgemFoTfkKHFhgCHLT5hfz9zvveoM7PUQp0qum28j2ivAo
        1mmGvAnwabHa6gr5iK9G9wxYf7tYmmmW2YkLD4XVBT7KHZMqGN61zyiaf+kN7jQW
        7ChncrGKq7GASa5BAkq4EvMY2H1olCMDHvyWWl/r520UAFWbw1+GSTrHBSYxPBJK
        s0sjwql2dKpNCBGXKfJB1VjOLjrVnYolzx7X5HJQLfX5LjAP6zsCVMXSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=fzJUD2qGibX3Tc+nSeqt20oBjnAxswijfmk5lfSvqdE=; b=Z2wccEBK
        q6mdN1sC8RiySwRaBxWps2kZjp3suvDkFT3uR1KdKe6LHzdDD5JH5YJAuGp5y3BF
        CW+DhJYIobZueR56cTPmGguHgxPG+g8h6J01FOlyvuE1O5rwzLW8UBVdD0oLzFba
        tqJhWW4HkTVaBQWenTNLqolMO8hXJ7YVbxwIHcPPUwToL1RKK6ADOY5hukDt7jdY
        cQohPBHamno59yRpSa/lvqcmzfBviIn1QZ9AFyQGEfVuJirYM3ekzRXeq1vqb3Cl
        bi5JMUJhM3lTyQ6+Plsz6ij5DVW9oOhu8v/kbZlaR8RmJs9p2d2rGOtrtH3sd6Z7
        47R2k9lu7+43Jg==
X-ME-Sender: <xms:9Kl_YGD2LO0kM3G3qontjzHvBqiyoi8BobuKr-IfXCeVGKeMZz3IaQ>
    <xme:9Kl_YCiSIT6Z77auylXw9PBoGndw0WKE1pDr0yYmIIbyMYnvMCKOD_L-9QAShl967
    SaqwC9z1HmYhAxdAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:9al_YC-s8HLHMRgdGfgbHnBBb5U4TxW3AeBZGykRHeB3l8_aeY1xjg>
    <xmx:9al_YG9_pEmFwcRMI-gAXQEjiuSWZ1BJaA2gNTCCRnzs8RbLW_eD0A>
    <xmx:9al_YDDphqOsRbRcYQJj6ttUMCsX2r5hRqbdrNw8-YrY8tIJHnbWpQ>
    <xmx:9ql_YGFltBcHZ4C1P4IvVzcbq4yEBjE1jTJ5oq5imX-600eigQGA8w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E273240067;
        Wed, 21 Apr 2021 00:28:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Wrap DWC3 and PHY in glue layer
Date:   Tue, 20 Apr 2021 23:28:34 -0500
Message-Id: <20210421042834.27309-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421042834.27309-1-samuel@sholland.org>
References: <20210421042834.27309-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB3 IP in the H6 is organized such that the reset line affects both
the DWC3 core and the PHY. To model that, following the example of
several other platforms, wrap those nodes in a glue layer node.

The inner nodes no longer need to be disabled, since the glue layer is
disabled by default to keep it in reset.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 +-
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  9 ++-
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  6 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 60 ++++++++++---------
 5 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dde972324e7..5bab12d81468 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -86,10 +86,6 @@ &de {
 	status = "okay";
 };
 
-&dwc3 {
-	status = "okay";
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -333,6 +329,6 @@ &usb2phy {
 	status = "okay";
 };
 
-&usb3phy {
+&usb3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 38c48130f079..baff16caedb5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -111,10 +111,6 @@ &de {
 	status = "okay";
 };
 
-&dwc3 {
-	status = "okay";
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -388,6 +384,6 @@ &usb2phy {
 	status = "okay";
 };
 
-&usb3phy {
+&usb3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 647669511381..fe4d74ade6e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -94,10 +94,6 @@ &de {
 	status = "okay";
 };
 
-&dwc3 {
-	status = "okay";
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -362,7 +358,10 @@ &usb2phy {
 	status = "okay";
 };
 
+&usb3 {
+	status = "okay";
+};
+
 &usb3phy {
 	phy-supply = <&reg_usb_vbus>;
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index be81330db14f..8cb06df231ab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -55,10 +55,6 @@ &de {
 	status = "okay";
 };
 
-&dwc3 {
-	status = "okay";
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -119,6 +115,6 @@ &usb2phy {
 	status = "okay";
 };
 
-&usb3phy {
+&usb3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 15b14ed566dc..c5eea8b50ef8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -797,36 +797,42 @@ ohci0: usb@5101400 {
 			status = "disabled";
 		};
 
-		dwc3: usb@5200000 {
-			compatible = "snps,dwc3";
-			reg = <0x05200000 0x10000>;
-			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_XHCI>,
-				 <&ccu CLK_BUS_XHCI>,
-				 <&rtc 0>;
-			clock-names = "ref", "bus_early", "suspend";
+		usb3: usb@5200000 {
+			compatible = "allwinner,sun50i-h6-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 			resets = <&ccu RST_BUS_XHCI>;
-			/*
-			 * The datasheet of the chip doesn't declare the
-			 * peripheral function, and there's no boards known
-			 * to have a USB Type-B port routed to the port.
-			 * In addition, no one has tested the peripheral
-			 * function yet.
-			 * So set the dr_mode to "host" in the DTSI file.
-			 */
-			dr_mode = "host";
-			phys = <&usb3phy>;
-			phy-names = "usb3-phy";
 			status = "disabled";
-		};
 
-		usb3phy: phy@5210000 {
-			compatible = "allwinner,sun50i-h6-usb3-phy";
-			reg = <0x5210000 0x10000>;
-			clocks = <&ccu CLK_USB_PHY1>;
-			resets = <&ccu RST_USB_PHY1>;
-			#phy-cells = <0>;
-			status = "disabled";
+			dwc3: usb@5200000 {
+				compatible = "snps,dwc3";
+				reg = <0x05200000 0x10000>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ccu CLK_BUS_XHCI>,
+					 <&ccu CLK_BUS_XHCI>,
+					 <&rtc 0>;
+				clock-names = "ref", "bus_early", "suspend";
+				/*
+				 * The datasheet of the chip doesn't declare the
+				 * peripheral function, and there's no boards known
+				 * to have a USB Type-B port routed to the port.
+				 * In addition, no one has tested the peripheral
+				 * function yet.
+				 * So set the dr_mode to "host" in the DTSI file.
+				 */
+				dr_mode = "host";
+				phys = <&usb3phy>;
+				phy-names = "usb3-phy";
+			};
+
+			usb3phy: phy@5210000 {
+				compatible = "allwinner,sun50i-h6-usb3-phy";
+				reg = <0x5210000 0x10000>;
+				clocks = <&ccu CLK_USB_PHY1>;
+				resets = <&ccu RST_USB_PHY1>;
+				#phy-cells = <0>;
+			};
 		};
 
 		ehci3: usb@5311000 {
-- 
2.26.3

