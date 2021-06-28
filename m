Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4E3B5D28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhF1LdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:33:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39530 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhF1LdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:33:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 6B3381F42102
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     jack@radxa.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] arm64: dts: rockchip: add rock-pi-4 analog audio
Date:   Mon, 28 Jun 2021 14:30:33 +0300
Message-Id: <20210628113033.9145-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary pinctrl and nodes to enable the
analog audio on rk3399 rock-pi-4 SBCs using the es8316
codec and the audio-graph-card driver.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index b28888ea9262..77781d9150ac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -128,6 +128,12 @@ vdd_log: vdd-log {
 		regulator-max-microvolt = <1400000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3399";
+		dais = <&i2s0_p0>;
+	};
 };
 
 &cpu_l0 {
@@ -422,6 +428,24 @@ &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
+
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_det_pin>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_p0_0>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -441,6 +465,14 @@ &i2s0 {
 	rockchip,capture-channels = <2>;
 	rockchip,playback-channels = <2>;
 	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
 };
 
 &i2s1 {
@@ -556,6 +588,12 @@ wifi_host_wake_l: wifi-host-wake-l {
 			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	es8316 {
+		hp_det_pin: hp-det-pin {
+			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
 };
 
 &pwm2 {
-- 
2.32.0

