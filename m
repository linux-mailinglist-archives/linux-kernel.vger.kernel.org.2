Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138BC30E043
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBCQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhBCQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BADC061573;
        Wed,  3 Feb 2021 08:52:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b9so48466ejy.12;
        Wed, 03 Feb 2021 08:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JEnnwLcGF9q0mKcU8PSsDi0DOzulD4VTN4umh3Ha6H0=;
        b=hMjux1sF5PWPjqiK46a8OvJrnZ+Bkp+oppdNTlsK3sRvKqdEUs8HywxAz77DA5+toq
         4ZF9JOUwT9xvXjUqCT54eXJ1aqqUlAIBurtBYhhq89P8MFoNx4/yjRDHAGA+twP+VpQM
         eumhPUjjif5ae88+dHEpIjqKtsf4KTFYzU0/23UGFA+GDbmJmoPQJa+KBndYlxhk6eIn
         tMSiqUBbBALugNVNjv5aCKId1aebi+b528D3Ov/3xyl0+6/dQ/k1elrK/EITX7DMX07w
         Fb33cGPTeiGBCXrtI/W6qIzKmqVc70vWBdtvY+n4eXh+jFip/Ut9kIcfRDPd6Z6sWOKj
         i81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JEnnwLcGF9q0mKcU8PSsDi0DOzulD4VTN4umh3Ha6H0=;
        b=LVqGsVeZkLMGDDgqBhq1nDh6muHKye+ANNSfWj9rXlM3B660bfyChfJyGxOhGyYYIs
         6RXEP+/SGPtVj2funWoXvHD9G+UaD0Q11atq91fz9KND7jckD+HZCJqWZcPoRzWetAFK
         boYgtySzQU41tk8WeQmGoxwozUKdo2qIcsxBaIRnzGgcClRx75P1paRLEHpMP4tzZgzv
         SfABL+MjSg9/09+Ucz7NLfap1/NdpS1FzcnDeSCcTQWct4MdGDqsJuooUpyQ0dOVUn6u
         e8jZ4JLoipTrINcnwygv92kSYHyqHPgUdKvtch4Yx+pMZvO8qxnrTHyAeXWOmro7t3x6
         bRkw==
X-Gm-Message-State: AOAM533CjsYYuqjImPkXYfCOd89WDnTLCuWeSPYolbJyIvkRB4QfZnIP
        PYItVlcz4yQ2npFrHkhYTk0=
X-Google-Smtp-Source: ABdhPJxebgZx4b2w32NKPo24eGuxnQ2VZZtAmg5kR7l2wa6AqeZVUDH6rXKX4m2gXYRQ6C3yXpJOig==
X-Received: by 2002:a17:906:3401:: with SMTP id c1mr4209371ejb.156.1612371164163;
        Wed, 03 Feb 2021 08:52:44 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:43 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] arm64: dts: rockchip: restyle rk3399 usbdrd3_1 node
Date:   Wed,  3 Feb 2021 17:52:29 +0100
Message-Id: <20210203165233.22177-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rk3399 dwc3 usb the wrapper node for only clocks makes no sense,
so restyle the rk3399 usbdrd3_1 node before more new SoC types are
added with the same IP.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |  6 +---
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |  6 +---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |  6 +---
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 37 ++++++++--------------
 17 files changed, 26 insertions(+), 93 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 95110d065..4392780db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -157,7 +157,7 @@
 	dr_mode = "host";
 };
 
-&usbdrd_dwc3_1 {
+&usbdrd3_1 {
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 4017b0e8c..28e5895de 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -778,12 +778,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 1384dabbd..c996c688d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -351,13 +351,9 @@ ap_i2c_tp: &i2c5 {
 };
 
 &usbdrd3_1 {
-	status = "okay";
+	dr_mode = "host";
 	extcon = <&usbc_extcon1>;
-};
-
-&usbdrd_dwc3_1 {
 	status = "okay";
-	dr_mode = "host";
 };
 
 &pinctrl {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index daf14f732..397050703 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -736,12 +736,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index d028285fb..30e6e3e41 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -802,12 +802,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index 1c0b48a71..a7092fda3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -616,12 +616,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 90a6ea1d7..1e835a682 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -712,10 +712,6 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
 	dr_mode = "host";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 7b633622c..fdc027ff3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -859,12 +859,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index f00e11075..80ac8ab6a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -1091,10 +1091,6 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
 	dr_mode = "host";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 4660416c8..2f12e4a7d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -517,12 +517,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usb_host1_ehci {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 4d30c1b32..f15f85162 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -793,12 +793,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 69c067dd1..f07f49f45 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -673,12 +673,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 20c3ef9fc..e22995c8e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -168,7 +168,7 @@
 	dr_mode = "otg";
 };
 
-&usbdrd_dwc3_1 {
+&usbdrd3_1 {
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 3920dcbd1..b5f23661e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -639,10 +639,6 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_1 {
-	status = "okay";
-};
-
 &vopb {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 564b56810..be5b1c7e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -822,12 +822,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 2e76f178e..fe9d4b2f8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -619,12 +619,8 @@
 };
 
 &usbdrd3_1 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 5045e002a..cde221c88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -419,39 +419,28 @@
 	};
 
 	usbdrd3_1: usb@fe900000 {
-		compatible = "rockchip,rk3399-dwc3";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
+		reg = <0x0 0xfe900000 0x0 0x100000>;
+		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
 			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
 			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
 			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
 			      "aclk_usb3", "grf_clk";
+		dr_mode = "otg";
+		phys = <&u2phy1_otg>, <&tcphy1_usb3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3399_PD_USB3>;
 		resets = <&cru SRST_A_USB3_OTG1>;
 		reset-names = "usb3-otg";
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis_enblslpm_quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis_u2_susphy_quirk;
 		status = "disabled";
-
-		usbdrd_dwc3_1: usb@fe900000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xfe900000 0x0 0x100000>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&cru SCLK_USB3OTG1_REF>, <&cru ACLK_USB3OTG1>,
-				 <&cru SCLK_USB3OTG1_SUSPEND>;
-			clock-names = "ref", "bus_early", "suspend";
-			dr_mode = "otg";
-			phys = <&u2phy1_otg>, <&tcphy1_usb3>;
-			phy-names = "usb2-phy", "usb3-phy";
-			phy_type = "utmi_wide";
-			snps,dis_enblslpm_quirk;
-			snps,dis-u2-freeclk-exists-quirk;
-			snps,dis_u2_susphy_quirk;
-			snps,dis-del-phy-power-chg-quirk;
-			snps,dis-tx-ipgap-linecheck-quirk;
-			power-domains = <&power RK3399_PD_USB3>;
-			status = "disabled";
-		};
 	};
 
 	cdn_dp: dp@fec00000 {
-- 
2.11.0

