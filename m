Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71C36F464
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhD3DUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:20:15 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55133 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhD3DUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:20:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4CCBF5809AD;
        Thu, 29 Apr 2021 23:19:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 29 Apr 2021 23:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=VXIbR1ry8WLfh
        y43tYYX2p8Llxlb9hpdzyvr64/aVUo=; b=dx48OMNRWwFhVjWYR8UcbB5sys6h7
        LyfZXFTtdB7byglQ3AYZiRz6NxeEdo0/bBKGsDGnBjVy3HzE0cV7lopExcfRuAzq
        OjAD1V6lxpuDuQ9srwdiku7NJMdmxRStk+ZIpbnliRPxPlVLh1kFSZOz5bK53qqC
        EaDSRRQEKQfHuKqqVCG6L2dJeeheLV3WcfobagOC7TFgG/vIdzWIiZNZXaOSf9yX
        dcS/zL4w88JUGUrnBytCUIh1S+r6U3IkczjxwqsLlot85AsQagCYUypQmy3eS7gb
        8/Dxqdrhbi1ntejJv7YnuHmpczIeDDb/s+L6N9tS531XwlRXpRO9GFuHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=VXIbR1ry8WLfhy43tYYX2p8Llxlb9hpdzyvr64/aVUo=; b=Qc09DASQ
        rSOoMf0Jws+cXzKITuyx36U6s/wSdBLg9LkYdcyUJ6ql1EgHgV02hMQEhkhBKQDH
        7Swa9DJCOHQuqgHTwAjtk0obt7NsCU4ZVJ9bS/LeE3PHSX2o4qRrAODvIFmIKtPK
        OmnB72ZH3EIUd5uEJSPKa1LP0gxedHb7HZkL6tL+HJ2gTAH4rqjgMUUYQ0mEfz1w
        8+0jSXwVwyJy2NT0mpY+L66ZoBWgn1PmINH8c6a+UxajD0hwqKmXAwSNbGFxhg2e
        eTTgrm9rqmVmGrxefZvUuUtmOwrvjbZbZJrkGKZyKsvY6suWjbFoCqplCLautdaW
        NnbezGxUr44HEw==
X-ME-Sender: <xms:NHeLYH0QvJPT7wU1pa2CTpnSKu1NC9R9rJXe8-JNd4moXzloLIj9BA>
    <xme:NHeLYGFvFb9QM-_CbXcjW0WCUobPta_VpoD_H-tShBv9cr5KzKNITapynUqkE6Fza
    AGySSwV-Ym09T7DUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:NHeLYH7q_WB2X8dikdzPk9NACwwKFPqBGVsGY_1x_AdCuUSZMjue7g>
    <xmx:NHeLYM131SGyE0R7KR91qeL-EleHo62QioMeVTmEBCOpHP0QNvdFZA>
    <xmx:NHeLYKH0xaSjhyGBa2cTnfmkpX-y6KyxQmQEJd8iUrVl9Lsntr3NOw>
    <xmx:NHeLYNAlHIgjIXqp4izlQSmuIU_0JcPTR4PibPuKkh7udUhOi17F4g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 23:19:15 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: h6: Wrap DWC3 and PHY in glue layer
Date:   Thu, 29 Apr 2021 22:19:12 -0500
Message-Id: <20210430031912.42252-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430031912.42252-1-samuel@sholland.org>
References: <20210430031912.42252-1-samuel@sholland.org>
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
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  6 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 60 ++++++++++---------
 4 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index b5808047d6e4..5f6292db808c 100644
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
@@ -309,6 +305,6 @@ &usb2phy {
 	status = "okay";
 };
 
-&usb3phy {
+&usb3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 7e83f6146f8a..ae3c24584f65 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -101,10 +101,6 @@ &de {
 	status = "okay";
 };
 
-&dwc3 {
-	status = "okay";
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -340,6 +336,6 @@ &usb2phy {
 	status = "okay";
 };
 
-&usb3phy {
+&usb3 {
 	status = "okay";
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
index af8b7d0ef750..b4ce5eff2822 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -700,36 +700,42 @@ ohci0: usb@5101400 {
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

