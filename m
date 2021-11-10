Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF63644C8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhKJT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhKJT1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:27:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AFC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:24:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 133so3193279wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkI4GyDCSIwmbXr9V/MQ9+7DcTXEuCd0g4gBgL+0EyA=;
        b=i7Z1Pn8QdFKfxUDCIMDU7Nl9er7l71NiK2V1C90wAjvXBpTR0hSMvTNt2R+6QFxiZc
         B9NzrWeTGyq9I1dGtU6DW9LmHuWZaQ8YqHkROyvYY5z6D9YUHiDs+bfg/nCilHhvZE+H
         8v0G7m8bOqLOhSUx3RG/nR6sxnmclH1TjGzbxs158ez2Ig5k22E/oRoz1V4HsYBz+L65
         B51Q0GyZ8VwUtJY3k9R4oHTgz/oVV3fjU5Ib1UeoQasvv4dO7KvguV77bIO6Kg8Rv5W9
         ALMO+d9fLuS3+Z5ddKtCfzLjKSeiSyu7CXvW+9ZBdzkHLQBSNrJ3UCrEn230+xVjreqB
         qdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkI4GyDCSIwmbXr9V/MQ9+7DcTXEuCd0g4gBgL+0EyA=;
        b=t7+ZOPxTzLO92vUL0j3TKDJFIgHbjjaGXn/NPiEd09rkmsFBG2WcixYjc3w8YeBzVl
         g0DnUB2m4A0M4PXS9fCTeBGA/NSD/WZcTq6rnMMjvN+ms3ZLvZ5B2K0nmmeOhA9L1Nlw
         NAh4isV+Rp1dWxdGnnG6JXczj8CZkEQkL+uA4Os5V2/o2s090pz3aKs3jTJziFCbHQ/r
         qJAZAEt/tygPfuRFulqrJoHazdm+5jNUqpe8d8Xs8QyRK7DOpvUvPFNVZ8xYA6U2YgzY
         Q3b6ISu5LqMT3KjYAxHpzb5MdnJcO23Yv2Ad0RrVhxhbmP92umS3+B3Pwsa4PFWcT323
         6JbA==
X-Gm-Message-State: AOAM530IBQBNbrQyKv7gKd+SGinXgtxQlHymHcZnIrU+LlPyNaiVMSva
        SqxWnj1vvb8SyF3kZ5v8Y9FPEg==
X-Google-Smtp-Source: ABdhPJzRUmYbyJGZmJg6Yqk42aKpyaRMUXbxlNPTEK2WhaJfvzp/Rwxnr7av9EPW/dLsGsYFs6jjjQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr19188607wmc.31.1636572275780;
        Wed, 10 Nov 2021 11:24:35 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id d16sm6250113wmb.37.2021.11.10.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:24:35 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8183-pumpkin: add HDMI support
Date:   Wed, 10 Nov 2021 20:24:16 +0100
Message-Id: <20211110192417.4177741-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110192417.4177741-1-fparent@baylibre.com>
References: <20211110192417.4177741-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
provided by an IT66121 DPI <-> HDMI bridge.

This commit enables DPI and add the node for the IT66121 bridge.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index ee912825cfc6..d5a6628e9c5b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -62,6 +62,18 @@ ntc {
 		pulldown-ohm = <0>;
 		io-channels = <&auxadc 0>;
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
 };
 
 &auxadc {
@@ -120,6 +132,41 @@ &i2c6 {
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
 	clock-frequency = <100000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	it66121hdmitx: hdmitx@4c {
+		compatible = "ite,it66121";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ite_pins>;
+		vcn33-supply = <&mt6358_vcn33_wifi_reg>;
+		vcn18-supply = <&mt6358_vcn18_reg>;
+		vrf12-supply = <&mt6358_vrf12_reg>;
+		reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x4c>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				it66121_in: endpoint {
+					bus-width = <12>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				hdmi_connector_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &mmc0 {
@@ -332,6 +379,61 @@ pins_clk {
 			input-enable;
 		};
 	};
+
+	ite_pins: ite-pins {
+		pins_rst {
+			pinmux = <PINMUX_GPIO160__FUNC_GPIO160>;
+			output-high;
+		};
+	};
+
+	dpi_pins_func: dpi-pins-func {
+		pins_dpi {
+			pinmux = <PINMUX_GPIO12__FUNC_I2S5_BCK>,
+				 <PINMUX_GPIO46__FUNC_I2S5_LRCK>,
+				 <PINMUX_GPIO47__FUNC_I2S5_DO>,
+				 <PINMUX_GPIO13__FUNC_DBPI_D0>,
+				 <PINMUX_GPIO14__FUNC_DBPI_D1>,
+				 <PINMUX_GPIO15__FUNC_DBPI_D2>,
+				 <PINMUX_GPIO16__FUNC_DBPI_D3>,
+				 <PINMUX_GPIO17__FUNC_DBPI_D4>,
+				 <PINMUX_GPIO18__FUNC_DBPI_D5>,
+				 <PINMUX_GPIO19__FUNC_DBPI_D6>,
+				 <PINMUX_GPIO20__FUNC_DBPI_D7>,
+				 <PINMUX_GPIO21__FUNC_DBPI_D8>,
+				 <PINMUX_GPIO22__FUNC_DBPI_D9>,
+				 <PINMUX_GPIO23__FUNC_DBPI_D10>,
+				 <PINMUX_GPIO24__FUNC_DBPI_D11>,
+				 <PINMUX_GPIO25__FUNC_DBPI_HSYNC>,
+				 <PINMUX_GPIO26__FUNC_DBPI_VSYNC>,
+				 <PINMUX_GPIO27__FUNC_DBPI_DE>,
+				 <PINMUX_GPIO28__FUNC_DBPI_CK>;
+		};
+	};
+
+	dpi_pins_idle: dpi-pins-idle {
+		pins_gpio {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO46__FUNC_GPIO46>,
+				 <PINMUX_GPIO47__FUNC_GPIO47>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>,
+				 <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>,
+				 <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>,
+				 <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO28__FUNC_GPIO28>;
+		};
+	};
 };
 
 &mfg {
@@ -381,3 +483,16 @@ &scp {
 &dsi0 {
 	status = "disabled";
 };
+
+&dpi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dpi_pins_func>;
+	pinctrl-1 = <&dpi_pins_idle>;
+	status = "okay";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
-- 
2.33.1

