Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7031731CEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBPRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:10:05 -0500
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Feb 2021 09:09:24 PST
Received: from pmg01-out3.zxcs.nl (pmg01-out3.zxcs.nl [IPv6:2a06:2ec0:1:b::ffeb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88741C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:09:24 -0800 (PST)
Received: from pmg01.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg01.zxcs.nl (ZXCS) with ESMTP id 85FF41050B0;
        Tue, 16 Feb 2021 18:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/nzoXPgNpHEJFa/783R0A9Zj4Ah96iT9FA3pOVcGaak=; b=ylkBMSgwijX1RHeWnzIXsT4fjd
        8e8FMPcLQWdFzFvVa2iFQMieh3ouTIOo2EtDTp+SJuFxObpAUHk+7CciSfUGcJNAOcQUlPkfZwGsK
        rHNk/7IrRnDQXImV/HziBuu/QB1I7aAGL0EBaY9WRHxOakFrV+baz3QA+fGq3MXZjbEaEUibb0NbY
        SeASTgBR6yTp2vqVdIsyxBCWr4L15ARbpHJj7YXq1TiiQVQJopphgY0PU5TdAgmtxsQL98cRELyII
        ZwLzcWpsQvkWr5szb2tMl3cojgcStnOclgJBYv3H4/DF3UFHEVCYElZlETRtev9hm6mMIDbzQCYxs
        88Pfl/qw==;
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Martin Cerveny <m.cerveny@computer.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH RESEND v3 2/2] ARM: dts: sun4i: Add support for Topwise A721 tablet
Date:   Tue, 16 Feb 2021 17:59:54 +0100
Message-Id: <20210216165954.43135-3-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210216165954.43135-1-dev@pascalroeleven.nl>
References: <20210216165954.43135-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dev@pascalroeleven.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Topwise A721/LY-F1 tablet is a tablet sold around 2012 under
different brands. The mainboard mentions A721 clearly, so this tablet
is best known under this name.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 arch/arm/boot/dts/Makefile                   |   3 +-
 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts | 242 +++++++++++++++++++
 2 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3d1ea0b251..ba25b4235a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1103,7 +1103,8 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-olinuxino-lime.dtb \
 	sun4i-a10-pcduino.dtb \
 	sun4i-a10-pcduino2.dtb \
-	sun4i-a10-pov-protab2-ips9.dtb
+	sun4i-a10-pov-protab2-ips9.dtb \
+	sun4i-a10-topwise-a721.dtb
 dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-auxtek-t003.dtb \
 	sun5i-a10s-auxtek-t004.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-topwise-a721.dts b/arch/arm/boot/dts/sun4i-a10-topwise-a721.dts
new file mode 100644
index 0000000000..936171d30b
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-topwise-a721.dts
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 Pascal Roeleven <dev@pascalroeleven.nl>
+ */
+
+/dts-v1/;
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Topwise A721";
+	compatible = "topwise,a721", "allwinner,sun4i-a10";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 100000 PWM_POLARITY_INVERTED>;
+		power-supply = <&reg_vbat>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		brightness-levels = <0 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	panel: panel {
+		compatible = "starry,kr070pe2t";
+		backlight = <&backlight>;
+		power-supply = <&reg_lcd_power>;
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+
+	reg_lcd_power: reg-lcd-power {
+		compatible = "regulator-fixed";
+		regulator-name = "reg-lcd-power";
+		gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+		enable-active-high;
+	};
+
+	reg_vbat: reg-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupts = <0>;
+	};
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	mma7660: accelerometer@4c {
+		compatible = "fsl,mma7660";
+		reg = <0x4c>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	ft5406ee8: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button-vol-down {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <761904>;
+	};
+
+	button-vol-up {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <571428>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH01 */
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_vcc3v3>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-ph-supply = <&reg_vcc3v3>;
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pin>;
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <1250000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb0_vbus {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.27.0


