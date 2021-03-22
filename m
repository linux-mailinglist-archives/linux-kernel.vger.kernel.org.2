Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF334467C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCVOCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCVOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:02:37 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9263C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:02:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n11so8669049pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PyXoPHaQZ1cNX+mAGKi6igLdckQBFbOfNFJ/cXEULis=;
        b=h854o4L9XSmTnayqqxTV4Aul4fBKdBR+eMB3+813lGBViwceMkC48f43cB3db1QVkc
         SHELrkl6z4+HCN7TCdHzvc0v4ygzwVHmSR0QvEMnzEVi51uvAWYUMqU1EzqE++umys8k
         C+ZRTT5XnM3kITbEn4A/ygE6PSl725gFH2UJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PyXoPHaQZ1cNX+mAGKi6igLdckQBFbOfNFJ/cXEULis=;
        b=X9wkpnmmn4fArtIl0xMQotJhQYL5CUN1TZT7AsEdvF3zfe/I2CBUzsbBBFIdpB63YG
         kXpbbttKc0x0OGs8magk15S7tnjU06FshEa/Qz1cygSh1ndWp9OPSj+c7wzpxlI9R+Lu
         rhKVS4B7bPsZVPR70WRvrTxm2hUrz/o6SmGwUl8zT48Yo3O6olGU5e2Yst5zic73bGw0
         698TCNjxce30s2k+mt9RwBqOkjYgO7BaC43sy9T+7JeRKHJh/tIa7Khm1qLxfIXM1gyq
         2JQxz/9XzzFyaeQeE2fakD4FU/34tuqoArzv66Mg0f6K1KxVfZDhfM36vpFOPge4m+iX
         esqg==
X-Gm-Message-State: AOAM530CjzQhCgs1giYBGaT/CWvVOgVV6jbitdz+3B0OpyheBV+cuvO1
        93Lkl2WAnRQYnVxery7t8c83Zg==
X-Google-Smtp-Source: ABdhPJxCHtBytcibfl/HoEBrbHbmElFOCBhhpiiM8IOnXqGhoWB8lC+ZkS2OYUCDViZ1IY++k8ecwQ==
X-Received: by 2002:a63:e203:: with SMTP id q3mr23160172pgh.325.1616421756376;
        Mon, 22 Mar 2021 07:02:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:15c1:9a30:414f:d84b])
        by smtp.gmail.com with ESMTPSA id gg22sm14112997pjb.20.2021.03.22.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:02:35 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v4 4/4] ARM: dts: sun8i: bananapi-m2m: Enable S070WV20-CT16 panel
Date:   Mon, 22 Mar 2021 19:31:52 +0530
Message-Id: <20210322140152.101709-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322140152.101709-1-jagan@amarulasolutions.com>
References: <20210322140152.101709-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 panel to
BPI-M2M board.

Bananapi S070WV20-CT16 is a pure RGB output panel with ICN6211 DSI/RGB
converter bridge, so enable bridge along with associated panel.

DSI panel connected via board DSI port with,
- DCDC1 as VCC-DSI supply
- PL5 gpio for bridge enable gpio pin
- PB7 gpio for lcd enable gpio pin
- PL4 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- replace reset with enable-gpios
Changes for v3:
- none 

 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 85 ++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index 293016d081cd..6f33e1ae8ffc 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -44,6 +44,7 @@
 #include "sun8i-a33.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi M2 Magic";
@@ -55,12 +56,21 @@ aliases {
 		i2c2 = &i2c2;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		mmc0 = &mmc0;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <8>;
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PL4 */
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -81,6 +91,18 @@ led-2 {
 		};
 	};
 
+	panel {
+		compatible = "bananapi,s070wv20-ct16";
+		enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
+		backlight = <&backlight>;
+
+		port {
+			panel_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_panel>;
+			};
+		};
+	};
+
 	reg_vcc5v0: vcc5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0";
@@ -122,6 +144,59 @@ &dai {
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dcdc1>;		/* VCC-DSI */
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dsi_out: port@0 {
+			reg = <0>;
+
+			dsi_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_dsi>;
+			};
+		};
+	};
+
+	bridge@0 {
+		compatible = "chipone,icn6211";
+		reg = <0>;
+		enable-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge_in: port@0 {
+				reg = <0>;
+
+				bridge_out_dsi: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+				};
+			};
+
+			bridge_out: port@1 {
+				reg = <1>;
+
+				bridge_out_panel: endpoint {
+					remote-endpoint = <&panel_out_bridge>;
+				};
+			};
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -157,6 +232,12 @@ &ohci0 {
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -269,6 +350,10 @@ &sound {
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.25.1

