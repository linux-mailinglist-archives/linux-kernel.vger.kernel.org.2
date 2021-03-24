Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8111347863
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhCXMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:23:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33824 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhCXMWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:22:42 -0400
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lP2X1-00009P-4g; Wed, 24 Mar 2021 13:22:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     jagan@amarulasolutions.com, jbx6244@gmail.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/7] ARM: dts: rockchip: move rv1108 mmcx aliases to board dts files
Date:   Wed, 24 Mar 2021 13:22:30 +0100
Message-Id: <20210324122235.1059292-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210324122235.1059292-1-heiko@sntech.de>
References: <20210324122235.1059292-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

As suggested by Arnd Bergmann, mmc-aliases are supposed to be
board-specific, so move the newly added general aliases to
the board-level on rv1108-based boards.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm/boot/dts/rv1108-elgin-r1.dts | 4 ++++
 arch/arm/boot/dts/rv1108-evb.dts      | 4 ++++
 arch/arm/boot/dts/rv1108.dtsi         | 3 ---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index b1db924710c8..f62c9f7af79d 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -12,6 +12,10 @@ / {
 	model = "Elgin RV1108 R1 board";
 	compatible = "elgin,rv1108-r1", "rockchip,rv1108";
 
+	aliases {
+		mmc0 = &emmc;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x08000000>;
diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 30f3d0470ad9..fe5fc9bf75c9 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -8,6 +8,10 @@ / {
 	model = "Rockchip RV1108 Evaluation board";
 	compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
 
+	aliases {
+		mmc0 = &sdmmc;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x08000000>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 7319a2473b80..15fa25585ea4 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -19,9 +19,6 @@ aliases {
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
-		mmc0 = &emmc;
-		mmc1 = &sdio;
-		mmc2 = &sdmmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.29.2

