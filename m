Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060FB4153B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhIVXGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:06:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53534 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238372AbhIVXGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:06:06 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mTBI2-0002xp-Ce; Thu, 23 Sep 2021 01:04:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH 1/3] arm64: dts: rockchip: fix LDO_REG4 / LDO_REG7 confusion on rk3368-lion
Date:   Thu, 23 Sep 2021 01:04:27 +0200
Message-Id: <20210922230429.2162535-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

LDO_REG7 is used for generating VCC_18.
LDO_REG4 is not connected to anything - delete it.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index bcd7977fb0f8..6622f11a169f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -144,7 +144,7 @@ &emmc {
 	mmc-hs200-1_8v;
 	non-removable;
 	vmmc-supply = <&vcc33_io>;
-	vqmmc-supply = <&vcc18_io>;
+	vqmmc-supply = <&vcc_18>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
 	status = "okay";
@@ -238,13 +238,6 @@ vdd10_pll: LDO_REG3 {
 				regulator-boot-on;
 			};
 
-			vcc18_io: LDO_REG4 {
-				regulator-name = "vcc18_io";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-			};
-
 			vdd10_video: LDO_REG6 {
 				regulator-name = "vdd10_video";
 				regulator-min-microvolt = <1000000>;
@@ -253,6 +246,14 @@ vdd10_video: LDO_REG6 {
 				regulator-boot-on;
 			};
 
+			vcc_18: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_18";
+			};
+
 			vcc18_video: LDO_REG8 {
 				regulator-name = "vcc18_video";
 				regulator-min-microvolt = <1800000>;
-- 
2.29.2

