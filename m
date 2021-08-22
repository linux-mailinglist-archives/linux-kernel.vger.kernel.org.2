Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B93F3D81
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhHVEPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 00:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhHVEPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 00:15:09 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07229C061575;
        Sat, 21 Aug 2021 21:14:29 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4GshpV61kKzQjym;
        Sun, 22 Aug 2021 06:14:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1629605661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+31EPRPMGVEy2Xpxt+EjtmwliDHXxQYcaVfkvS007Qw=;
        b=DxVAmhKTlqpkCYhwvRNC1T6FD3PfK/WNroEzQ8y17kyNsyLQGvW0kRBU2JuqDJCGO9Ym1l
        CTVyFArt3SkbDYkqpT6kh1TL+ucYNezRyURc9Zjaukrc3mn6kT2LgcvFOk2kaE2iMm50tb
        LsoJuIQmWKWcnWAESytJ8sWwFpP49eOMTyW3/EQ42NBIlrN7SGgnkgd7MvwxHI0XEOkY67
        4rEK1OgKDDXRjtf13wCFHMknU0OBGSBbpidX6+2dWocaarKsKDjxXFboCmUlseM/FeybbR
        hV/4bfnFlsmehk0qRFhjmnjYe01a+gxbDxziiSCeI6CfEBgLv0ksKEuH8Ojrew==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id bGQP5vXKQSRq; Sun, 22 Aug 2021 06:14:19 +0200 (CEST)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-mediatek@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v3 1/1] arm: dts: mt7623: add musb device nodes
Date:   Sun, 22 Aug 2021 13:13:33 +0900
Message-Id: <20210822041333.5264-2-mans0n@gorani.run>
In-Reply-To: <20210822041333.5264-1-mans0n@gorani.run>
References: <20210808123840.176738-1-mans0n@gorani.run>
 <20210822041333.5264-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E13A81887
X-Rspamd-UID: 89d88d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7623 has an musb controller that is compatible with the one from MT2701.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
---
v3:
* remove unnecessary status=okay from u2port2

v2:
* rename usb3 label to usb0
* move usb0 & u2phy1 nodes to the right sorted place
* disable u2phy1 by default
* correct u2port2 node name to match its reg address
---
 arch/arm/boot/dts/mt7623.dtsi  | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 3c11f7cfcc40..21c8a291b74e 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -585,6 +585,39 @@ spi2: spi@11017000 {
 		status = "disabled";
 	};
 
+	usb0: usb@11200000 {
+		compatible = "mediatek,mt7623-musb",
+			     "mediatek,mtk-musb";
+		reg = <0 0x11200000 0 0x1000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "mc";
+		phys = <&u2port2 PHY_TYPE_USB2>;
+		dr_mode = "otg";
+		clocks = <&pericfg CLK_PERI_USB0>,
+			 <&pericfg CLK_PERI_USB0_MCU>,
+			 <&pericfg CLK_PERI_USB_SLV>;
+		clock-names = "main","mcu","univpll";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+		status = "disabled";
+	};
+
+	u2phy1: t-phy@11210000 {
+		compatible = "mediatek,mt7623-tphy",
+			     "mediatek,generic-tphy-v1";
+		reg = <0 0x11210000 0 0x0800>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port2: usb-phy@11210800 {
+			reg = <0 0x11210800 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+		};
+	};
+
 	audsys: clock-controller@11220000 {
 		compatible = "mediatek,mt7623-audsys",
 			     "mediatek,mt2701-audsys",
diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index 0735a1fb8ad9..d304b62d24b5 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -35,6 +35,10 @@ &scpsys {
 	clock-names = "ethif";
 };
 
+&usb0 {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
+};
+
 &usb1 {
 	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
 };
-- 
2.33.0

