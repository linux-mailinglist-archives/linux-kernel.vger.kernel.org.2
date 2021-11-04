Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDB4453C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhKDN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:26:23 -0400
Received: from comms.puri.sm ([159.203.221.185]:42118 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhKDN0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:26:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6CE91DFE40;
        Thu,  4 Nov 2021 06:23:43 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jczG3ziMWlEL; Thu,  4 Nov 2021 06:23:42 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v1 3/4] arm64: dts: imx8mq-librem5: describe the selfie cam
Date:   Thu,  4 Nov 2021 14:22:12 +0100
Message-Id: <20211104132213.470498-4-martin.kepplinger@puri.sm>
In-Reply-To: <20211104132213.470498-1-martin.kepplinger@puri.sm>
References: <20211104132213.470498-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the CSI1 MIPI RX controller and CSI1 bridge on the SoC. Describe
the Librem 5 front-facing camera, connected to the CSI1 MIPI.

the following sets formats, streams 10 frames and saves one:

	#!/bin/bash
	WIDTH=1632
	HEIGHT=1224
	SKIP=10

	media-ctl -d "platform:30a90000.csi" --set-v4l2 "'csi':0 [fmt:SGBRG10/${WIDTH}x${HEIGHT} colorspace:raw]"
	media-ctl -d "platform:30a90000.csi" --set-v4l2 "'imx8mq-mipi-csi2 30a70000.csi':0 [fmt:SGBRG10/${WIDTH}x${HEIGHT} colorspace:raw]"
	media-ctl -d "platform:30a90000.csi" --set-v4l2 "'hi846 2-0020':0 [fmt:SGBRG10/${WIDTH}x${HEIGHT} colorspace:raw]"
	media-ctl -d "platform:30a90000.csi" -l "'hi846 2-0020':0 -> 'imx8mq-mipi-csi2 30a70000.csi':0 [1]"
	v4l2-ctl -d "/dev/v4l/by-path/platform-30a90000.csi-video-index0" --set-fmt-video=width=${WIDTH},height=${HEIGHT},pixelformat=GB16 --stream-mmap --stream-to=$WIDTH.raw --stream-skip=$SKIP --stream-count=1

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 5541e1d2ec6f..b3f165822e56 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -271,6 +271,10 @@ &A53_3 {
 	cpu-supply = <&buck2_reg>;
 };
 
+&csi1 {
+	status = "okay";
+};
+
 &ddrc {
 	operating-points-v2 = <&ddrc_opp_table>;
 
@@ -1006,6 +1010,31 @@ codec: audio-codec@1a {
 		>;
 	};
 
+	camera_front: camera@20 {
+		compatible = "hynix,hi846";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_csi1>;
+		clocks = <&clk IMX8MQ_CLK_CLKO2>;
+		assigned-clocks = <&clk IMX8MQ_CLK_CLKO2>;
+		assigned-clock-rates = <25000000>;
+		reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+		vdda-supply = <&reg_vcam_2v8>;
+		vddd-supply = <&reg_vcam_1v2>;
+		vddio-supply = <&reg_csi_1v8>;
+		rotation = <90>;
+		orientation = <0>;
+
+		port {
+			camera1_ep: endpoint {
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64
+					<80000000 200000000 300000000>;
+				remote-endpoint = <&mipi1_sensor_ep>;
+			};
+		};
+	};
+
 	backlight@36 {
 		compatible = "ti,lm36922";
 		reg = <0x36>;
@@ -1079,6 +1108,23 @@ &lcdif {
 	status = "okay";
 };
 
+&mipi_csi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mipi1_sensor_ep: endpoint {
+				remote-endpoint = <&camera1_ep>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
 &mipi_dsi {
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.30.2

