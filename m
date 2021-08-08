Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82CA3E3A41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhHHMkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 08:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhHHMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 08:40:12 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078EEC0613CF;
        Sun,  8 Aug 2021 05:39:52 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GjJh65nz2zQk9y;
        Sun,  8 Aug 2021 14:39:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628426389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTDEWTY6DFnkW7Rjxxj/CcZyJlPojb5t/pJtInOE9bs=;
        b=njzXrk+pIxdCL4wWJkaLLZ7UkjSIqw58a948hlA7vJXsx1fXdyYfPuYfqA3A5fOwUMsudv
        2/SXoW2Ao3FLxzoMnzk1+pHyO9NaGObsnmKMQ8r4RPK9LC75FLqu37MBBvem9cMeFQqq6c
        P7P3miV9eFghBfBmQ/DefIfX7fHd0hNimdAogouTxbcrI4OYPXG865iOYhbQ1SCUaWGO/l
        hbZA+LalU5vkTtPaLi8D7+QTQ7fp5zEcfZna0g3ABEEw3Hr8ZKWDWyrCelP/dl3+ZlM1sc
        A+CJtlQlA73sYSJ8JZ/rtIQYoVgpNglmygYDmW2yDid5JFxivu7HLN4ncqahdw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id uGsJQJGVLIxf; Sun,  8 Aug 2021 14:39:47 +0200 (CEST)
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
Subject: [PATCH v2 2/2] arm: dts: mt7623: add musb device nodes
Date:   Sun,  8 Aug 2021 21:38:40 +0900
Message-Id: <20210808123840.176738-3-mans0n@gorani.run>
In-Reply-To: <20210808123840.176738-1-mans0n@gorani.run>
References: <20210803151320.71531-1-mans0n@gorani.run>
 <20210808123840.176738-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECECD189C
X-Rspamd-UID: 492da4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7623 has an musb controller that is compatible with the one from MT2701.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
---
v2:
* rename usb3 label to usb0
* move usb0 & u2phy1 nodes to the right sorted place
* disable u2phy1 by default
* correct u2port2 node name to match its reg address
---
 arch/arm/boot/dts/mt7623.dtsi  | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 3c11f7cfcc40..790d74439cc6 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -585,6 +585,40 @@ spi2: spi@11017000 {
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
+			status = "okay";
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
2.32.0

