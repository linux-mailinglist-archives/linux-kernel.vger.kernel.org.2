Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7798A4153B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhIVXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:06:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53530 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238350AbhIVXGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:06:06 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mTBI2-0002xp-JY; Thu, 23 Sep 2021 01:04:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: define iodomains for rk3368-lion
Date:   Thu, 23 Sep 2021 01:04:28 +0200
Message-Id: <20210922230429.2162535-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922230429.2162535-1-heiko@sntech.de>
References: <20210922230429.2162535-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

This is not strictly needed, as 3.3V is the default,
but good to have for descriptive purposes nevertheless.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
[fixed ordering]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 6622f11a169f..8e82ca3f1c6f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -273,6 +273,18 @@ &i2c2 {
 	status = "okay";
 };
 
+/* The RK3368-uQ7 "Lion" has most IO voltages hardwired to 3.3V. */
+&io_domains {
+	audio-supply = <&vcc33_io>;
+	dvp-supply = <&vcc33_io>;
+	flash0-supply = <&vcc_18>;
+	gpio30-supply = <&vcc33_io>;
+	gpio1830-supply = <&vcc33_io>;
+	sdcard-supply = <&vcc33_io>;
+	wifi-supply = <&vcc33_io>;
+	status = "okay";
+};
+
 &pinctrl {
 	leds {
 		module_led_pins: module-led-pins {
@@ -292,6 +304,12 @@ pmic_sleep: pmic-sleep {
 	};
 };
 
+&pmu_io_domains {
+	pmu-supply = <&vcc33_io>;
+	vop-supply = <&vcc33_io>;
+	status = "okay";
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.29.2

