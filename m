Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8971330E02C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhBCQxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhBCQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED3C061786;
        Wed,  3 Feb 2021 08:52:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l12so417166edt.3;
        Wed, 03 Feb 2021 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ys/VQGPiREa+h0MAtH2I4XvmYWibwwkYiM5czLMJuJk=;
        b=kLczZU+fIKxCtDITXrU9NjPYFNAmqVmmvR/jj+cM8geQgo+lXHwtNjMTb16KlQnHIu
         pU0+ZZT9rFufIohTq1Qaf+qIUUyvKUKLnBVIHpbKbRPbFM44z/iQ8faQH0URgMrvY+yZ
         h1j82bXv2krygtiMxoZ6ZPE6+lgrvUOyhpN37JpMJVCnWv0SEnxIwj8NIiBW1nv4KKE3
         pkbToYnvWt/L0g5G5neuQPIXRqIF5N9g3JkwZZvin5VDWR1LwEfM3pKncmJa9xktaHtK
         V18Yo+6NxxZc/9m/igs5oQIgt8aM/zMbDtM/ZzdHubxFO6X4CPZHTNyiu2Z++6N96XvR
         evJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ys/VQGPiREa+h0MAtH2I4XvmYWibwwkYiM5czLMJuJk=;
        b=BRGVb0p76/L+Ggb0uX3A6HjhZU6YDuEbL3mComXMX6+tP9nvnXxLz0W5cQSRc4Kb5B
         xWd5aNpn6iCWA+2MGGWx4TXsXP1HC44Qx3QqRE2yaSeVVAIpgFExplKq5KOEK1JTRXQm
         7zKzU04dgIfNvlZpbHZL29Ir+wM5bd0iogO8oWU/8UfujetaR0fbWxCHfmgN7lT/2Sfz
         yO0BPQeaDaLTQal7npmn+y4ci2/MpxB8ImMYMWjARPB2XbkPiUu9/1slu3c2o3Io/+kR
         FBwibWEMdJoI0v+mfwUQlqIQRyZ8Gft/TPFcOOVQ2HvjjlzXM5wioQrpJSl9FiHaftg7
         nl4w==
X-Gm-Message-State: AOAM531+6ffJwiJOgtvL4qasHQjoFUM0RZgRz/uoFWiyQ+sfYgvLv6Fn
        k/LBTwQjBBUDv1aekTEqECU=
X-Google-Smtp-Source: ABdhPJyAJHrejCaAmgSXJCqUoPQPrKTjd2/8fLX5UD5nb+2dN1A+dLM2ocKQn36u+tvSV5aDeCIMgQ==
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr3920660edw.14.1612371163223;
        Wed, 03 Feb 2021 08:52:43 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:42 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] arm64: dts: rockchip: restyle rk3399 usbdrd3_0 node
Date:   Wed,  3 Feb 2021 17:52:28 +0100
Message-Id: <20210203165233.22177-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rk3399 dwc3 usb the wrapper node for only clocks makes no sense,
so restyle the rk3399 usbdrd3_0 node before more new SoC types are
added with the same IP.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |  6 +---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |  6 +---
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  |  6 +---
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
 18 files changed, 24 insertions(+), 95 deletions(-)

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
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 76a8b40a9..90a6ea1d7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -715,10 +715,6 @@
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
index b20774081..20c3ef9fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -164,7 +164,7 @@
 	};
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
index 580972459..564b56810 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -817,12 +817,8 @@
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
index db75c7e85..5045e002a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -394,39 +394,28 @@
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
 			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
 			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
 			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
 			      "aclk_usb3", "grf_clk";
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

