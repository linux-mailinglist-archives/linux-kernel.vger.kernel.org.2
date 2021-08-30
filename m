Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267A3FB7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhH3OO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:14:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33884 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236877AbhH3OOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:14:25 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mKi2T-0008I3-Q8; Mon, 30 Aug 2021 16:13:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jacopo@jmondi.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: hook up camera on px30-evb
Date:   Mon, 30 Aug 2021 16:13:18 +0200
Message-Id: <20210830141318.66744-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210830141318.66744-1-heiko@sntech.de>
References: <20210830141318.66744-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index c1ce9c295e5b..848bc39cf86a 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -114,6 +114,10 @@ &cpu3 {
 	cpu-supply = <&vdd_arm>;
 };
 
+&csi_dphy {
+	status = "okay";
+};
+
 &display_subsystem {
 	status = "okay";
 };
@@ -428,6 +432,36 @@ sensor@4c {
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	clock-frequency = <100000>;
+
+	/* These are relatively safe rise/fall times; TODO: measure */
+	i2c-scl-falling-time-ns = <50>;
+	i2c-scl-rising-time-ns = <300>;
+
+	ov5695: ov5695@36 {
+		compatible = "ovti,ov5695";
+		reg = <0x36>;
+		avdd-supply = <&vcc2v8_dvp>;
+		clocks = <&cru SCLK_CIF_OUT>;
+		clock-names = "xvclk";
+		dvdd-supply = <&vcc1v5_dvp>;
+		dovdd-supply = <&vcc1v8_dvp>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cif_clkout_m0>;
+		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+
+		port {
+			ucam_out: endpoint {
+				remote-endpoint = <&mipi_in_ucam>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
 &i2s1_2ch {
 	status = "okay";
 };
@@ -443,6 +477,24 @@ &io_domains {
 	vccio6-supply = <&vccio_flash>;
 };
 
+&isp {
+	status = "okay";
+
+	ports {
+		port@0 {
+			mipi_in_ucam: endpoint@0 {
+				reg = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&ucam_out>;
+			};
+		};
+	};
+};
+
+&isp_mmu {
+	status = "okay";
+};
+
 &pinctrl {
 	headphone {
 		hp_det: hp-det {
-- 
2.29.2

