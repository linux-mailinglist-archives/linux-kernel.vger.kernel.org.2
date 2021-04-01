Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C003521BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhDAVhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhDAVhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:37:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C3C0613E6;
        Thu,  1 Apr 2021 14:37:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so4931460ejo.13;
        Thu, 01 Apr 2021 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHpx++F9qxXFAoyX+lLV8P5ugzLRk8jhk2+JIF6szec=;
        b=bnHIS5Is5F7kGSXPOrjFOAo2vn6bXz2zBAlLpKFAGcCtlOrHL/1QNAuZ5GLNuKdrtS
         AXa2Y9A9BEF9vSXXP4hiE4qJPbdD/ZvP3k17bg19iIxocKUhJKORJo3aXVVDUPF8/3X+
         dEl6hignoTQeCu6la6I7sOky0KBg87OsonxHf2GveFq/Z+lfHO9iazFX8Juu4JknTHGZ
         atC+adc4FAK3O8jQ+T1fXLsUowI9e3zafCD65jOlyBCHlkpEuJpXkAirpfTCitZRNPlJ
         PYCB8/TWjDGhSMBvu5cAztSwMIxtFq5Tp22uLNhQsbYh+44hIVygjof74uQVEDh/IpCt
         zPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHpx++F9qxXFAoyX+lLV8P5ugzLRk8jhk2+JIF6szec=;
        b=l30n27Ejd+gQbMdN+R27SAaWwdOQ7HYrG81brE5XxjEQRsT4AC/qoA14TJGimBLYZU
         GTipjQSaXMsVWlP7j3Ug5glJoFKKPbLS0MQ6Z8Cf7ZiSqXqNYSOeeMMiIIXSn5vAfSrD
         +aYexTkgZNJPKBzFTQg3MbIuBg7qbK1vY6hXeYI/9nKY1kc0aMrUIfKVguM1PoviyDEK
         LpmwGnsFEMizFhM0262Vxk1LrkDYCs78wBu0ojBByxcm+nkGxDDZrjRek7cEyN4XibQ9
         BOGt2ZnR0DFm+ZcPtAHqd+OSXE6B8uEqIzwkMWu4XUg18k7u8AZOW7pgeFm0xNPcVMqA
         i+/w==
X-Gm-Message-State: AOAM531JgEg6SFSP30mh8ACAoXOAkxh9kvvQi8A6k3EL0HhzTCxvRDad
        Khe/iSFD4THcgUQOyaclwbo=
X-Google-Smtp-Source: ABdhPJwyQoZc7cv1vBccoldfMHICbKw9x2p5By7ZGWRdh851ke3aQdNtMTZzi/2q7JU3T8Xw2mgJbA==
X-Received: by 2002:a17:907:20c7:: with SMTP id qq7mr10872885ejb.528.1617313022923;
        Thu, 01 Apr 2021 14:37:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f9sm4237006edq.43.2021.04.01.14.37.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 14:37:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v6 3/4] arm64: dts: rockchip: restyle rk3399 usbdrd3_0 node
Date:   Thu,  1 Apr 2021 23:36:51 +0200
Message-Id: <20210401213652.14676-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210401213652.14676-1-jbx6244@gmail.com>
References: <20210401213652.14676-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rk3399 dwc3 usb the wrapper node for only clocks makes no sense,
so restyle the rk3399 usbdrd3_0 node before more new SoC types are
added with the same IP.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V6:
  rebase

Changed V3:
  remove aclk_usb3_rksoc_axi_perf
  remove aclk_usb3
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |  6 +---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |  6 +---
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  4 ---
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |  4 ---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 37 ++++++++--------------
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |  4 ---
 19 files changed, 25 insertions(+), 96 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 1ce85a581..95110d065 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -153,7 +153,7 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
+&usbdrd3_0 {
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 6db18808b..4017b0e8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -773,12 +773,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "otg";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 32dcaf210..e42783cb7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -618,13 +618,9 @@ ap_i2c_audio: &i2c8 {
 };
 
 &usbdrd3_0 {
-	status = "okay";
+	dr_mode = "host";
 	extcon = <&usbc_extcon0>;
-};
-
-&usbdrd_dwc3_0 {
 	status = "okay";
-	dr_mode = "host";
 };
 
 &vopb {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index 341d074ed..daf14f732 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -731,12 +731,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index 635afdd99..d028285fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -797,12 +797,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "otg";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index 1fa80ac15..1c0b48a71 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -611,12 +611,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "otg";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fa5809887..33730b3c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -124,7 +124,7 @@
 	status = "disabled";
 };
 
-&usbdrd_dwc3_0 {
+&usbdrd3_0 {
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 48ed4aaa3..01c15c833 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -714,10 +714,6 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
-	status = "okay";
-};
-
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index ad7c4d008..7b633622c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -854,12 +854,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 219b7507a..f00e11075 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -1086,10 +1086,6 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
 	dr_mode = "host";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index a8d363568..35780506c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -223,10 +223,6 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
 	dr_mode = "otg";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 20309076d..4d30c1b32 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -792,10 +792,6 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
-	status = "okay";
-};
-
 &usbdrd3_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index fb7599f07..69c067dd1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -668,12 +668,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 1a23e8f3c..df4119441 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -139,7 +139,7 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
+&usbdrd3_0 {
 	dr_mode = "otg";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 5e3ac589b..3920dcbd1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -635,10 +635,6 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
-	status = "okay";
-};
-
 &usbdrd3_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index d42c75c6d..f119fc41f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -830,12 +830,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 701a567d7..2e76f178e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -614,12 +614,8 @@
 };
 
 &usbdrd3_0 {
-	status = "okay";
-};
-
-&usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "host";
+	status = "okay";
 };
 
 &usbdrd3_1 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 186a7c483..deac8f8e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -365,37 +365,26 @@
 	};
 
 	usbdrd3_0: usb@fe800000 {
-		compatible = "rockchip,rk3399-dwc3";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
+		reg = <0x0 0xfe800000 0x0 0x100000>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
 			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
 			      "bus_clk", "grf_clk";
+		dr_mode = "otg";
+		phys = <&u2phy0_otg>, <&tcphy0_usb3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3399_PD_USB3>;
 		resets = <&cru SRST_A_USB3_OTG0>;
 		reset-names = "usb3-otg";
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis_enblslpm_quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis_u2_susphy_quirk;
 		status = "disabled";
-
-		usbdrd_dwc3_0: usb@fe800000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xfe800000 0x0 0x100000>;
-			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,
-				 <&cru SCLK_USB3OTG0_SUSPEND>;
-			clock-names = "ref", "bus_early", "suspend";
-			dr_mode = "otg";
-			phys = <&u2phy0_otg>, <&tcphy0_usb3>;
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
 
 	usbdrd3_1: usb@fe900000 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 7257494d2..810fb7880 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -454,10 +454,6 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
-	status = "okay";
-};
-
 &vbus_host {
 	enable-active-high;
 	gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>; /* USB1_EN_OC# */
-- 
2.11.0

