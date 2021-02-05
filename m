Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC93117CE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBFAaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhBELlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:14 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1071CC06178B;
        Fri,  5 Feb 2021 03:40:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w2so11379050ejk.13;
        Fri, 05 Feb 2021 03:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QE1vhiNECc3E9Z0FtimepS69tVAk52/C7Hu/jBioBnQ=;
        b=CfaW4E5Ovj+rbk50rHTtlAk4uCM6wqJJZ2fva+RZ4RC8+Y0youUDv9qvJSDwduCij/
         uCzc29QABw0GYr19ojIS3Vz88GDo64I2uMP9K9EfQLc0+Frd7c5vtUtKD8M5ikHPPcX2
         Nvn0jKfvpC4Viyci/M12X8iMc6CJK7/eYZDhDdWaxl5pttCOjM7QXrJOvI5HvRQhOjeI
         21l00M6EWE0c8B4bib76hAT5DUFky6YmpBKLEd0IP/O77t5lzrdAX4i3fKxrlG11lNcN
         QX1y4OuiJwvt13HUNd512BpuOKcPRxj6LqYzz181xVSIh6r2AGeQ3z0Ip/oZsHG4RJun
         v/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QE1vhiNECc3E9Z0FtimepS69tVAk52/C7Hu/jBioBnQ=;
        b=qk1n6XenMd1McovOFbRqaqyUVJF2ULtLomgACV0s9+Lx98Yvg+v9QgP5PQdyAy/X2+
         BpGVjoh2iQrPt6qWLSUqp/EKwlFhqyK00nqVdWre0JoyhKWC3tEswTsVI93RXp+C4DvJ
         pLwaZMMovYz/wuAGa+QYpNQ7EE825QM99wcY5phJnEvPJIeR5224WRi7hLnGFKimVIqM
         KlGp4Nat9GvrrPyLmeVQEZMFU4AuHZdMg7lv3XIOP0BB2eRo+XuzvFEAczG0E96regbG
         Ti+mbVTH7DADZyK+RMQ5R012DD1m+l0aE1oqwFATZV5YzN6XrCrfPIVe0mellPDeUu37
         p5bQ==
X-Gm-Message-State: AOAM531d2R9UJK6UdMY3fD+ViEJmKu3VDKnmi0WpEjitMq5kbNAwRf92
        ULYi+B3VUWmDOLX8eVw0Fi4=
X-Google-Smtp-Source: ABdhPJyM6yXuWlowynO8xpiihwju5MQ1QX4j4i7hr2IL5KErKG6gKLzs+61wLoFaIIyZT0nD73jdLg==
X-Received: by 2002:a17:906:d937:: with SMTP id rn23mr3604705ejb.57.1612525232784;
        Fri, 05 Feb 2021 03:40:32 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:32 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] arm64: dts: rockchip: restyle rk3399 usbdrd3_0 node
Date:   Fri,  5 Feb 2021 12:40:06 +0100
Message-Id: <20210205114011.10381-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205114011.10381-1-jbx6244@gmail.com>
References: <20210205114011.10381-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rk3399 dwc3 usb the wrapper node for only clocks makes no sense,
so restyle the rk3399 usbdrd3_0 node before more new SoC types are
added with the same IP.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
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
index b125cac89..cfde6cc64 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -394,37 +394,26 @@
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

