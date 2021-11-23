Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB445AF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhKWWwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:52:53 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:58864 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240045AbhKWWwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:52:43 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 3D9C6261B58;
        Tue, 23 Nov 2021 23:49:33 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] arm64: dts: apple: t8103: Add cd321x nodes
Date:   Tue, 23 Nov 2021 23:49:25 +0100
Message-Id: <20211123224926.7722-5-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123224926.7722-1-j@jannau.net>
References: <20211123224926.7722-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All M1 Mac devices have 2 SoC connected USB-C ports and use cd321x USB
type C port switch and power deliver controllers. I2c bus and addresses
configuration are for all devices equal.
The iMac (24-inch, 2021) has a configuration with 2 additional USB-C
ports (j456) using two addiotional cd321x controllers.

Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
---
 - fixed typo in commit message
 - renamed cd321x nodes to "usb-pd"
 - added Reviewed-by tag

 arch/arm64/boot/dts/apple/t8103-j456.dts  | 18 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-j456.dts b/arch/arm64/boot/dts/apple/t8103-j456.dts
index 7267e069355b..884fddf7d363 100644
--- a/arch/arm64/boot/dts/apple/t8103-j456.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j456.dts
@@ -21,6 +21,24 @@ aliases {
 	};
 };
 
+&i2c0 {
+	hpm2: usb-pd@3b {
+		compatible = "apple,cd321x";
+		reg = <0x3b>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm3: usb-pd@3c {
+		compatible = "apple,cd321x";
+		reg = <0x3c>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
 /*
  * Force the bus number assignments so that we can declare some of the
  * on-board devices and properties that are populated by the bootloader
diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index 53d22b434d76..876278fe0afe 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -39,6 +39,24 @@ &serial0 {
 	status = "okay";
 };
 
+&i2c0 {
+	hpm0: usb-pd@38 {
+		compatible = "apple,cd321x";
+		reg = <0x38>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm1: usb-pd@3f {
+		compatible = "apple,cd321x";
+		reg = <0x3f>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
 /*
  * Force the bus number assignments so that we can declare some of the
  * on-board devices and properties that are populated by the bootloader
-- 
2.34.0

