Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70A347865
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhCXMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:23:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33826 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhCXMWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:22:42 -0400
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lP2X2-00009P-2c; Wed, 24 Mar 2021 13:22:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     jagan@amarulasolutions.com, jbx6244@gmail.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 5/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3328
Date:   Wed, 24 Mar 2021 13:22:33 +0100
Message-Id: <20210324122235.1059292-5-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210324122235.1059292-1-heiko@sntech.de>
References: <20210324122235.1059292-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

As suggested by Arnd Bergmann, the newly added mmc aliases
should be board specific, so move them from the general dtsi
to the individual boards.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    | 6 ++++++
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts         | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        | 6 ++++++
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts  | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 3 ---
 8 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25370..4e47d995b8d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -8,6 +8,12 @@ / {
 	model = "A95X Z2";
 	compatible = "zkmagic,a95x-z2", "rockchip,rk3318";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &sdio;
+		mmc2 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index 37f307cfa4cc..de2d3e88e27f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -8,6 +8,11 @@ / {
 	model = "Beelink A1";
 	compatible = "azw,beelink-a1", "rockchip,rk3328";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	/*
 	 * UART pins, as viewed with bottom of case removed:
 	 *
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index a48767931af6..ff6b466e0e07 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -10,6 +10,12 @@ / {
 	model = "Rockchip RK3328 EVB";
 	compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &sdio;
+		mmc2 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index faf496d789cf..f807bc066ccb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -13,6 +13,10 @@ / {
 	model = "FriendlyElec NanoPi R2S";
 	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
 
+	aliases {
+		mmc0 = &sdmmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 19959bfba451..a05732b59f38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -10,6 +10,11 @@ / {
 	model = "Firefly roc-rk3328-cc";
 	compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 2d71ca7e429c..c7e31efdd2e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -20,6 +20,11 @@ / {
 	model = "Radxa ROCK Pi E";
 	compatible = "radxa,rockpi-e", "rockchip,rk3328";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index c984662043da..3bef1f39bc6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -10,6 +10,11 @@ / {
 	model = "Pine64 Rock64";
 	compatible = "pine64,rock64", "rockchip,rk3328";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 063ed0adbec4..708d82bdfd6c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -27,9 +27,6 @@ aliases {
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
-		mmc0 = &sdmmc;
-		mmc1 = &sdio;
-		mmc2 = &emmc;
 		ethernet0 = &gmac2io;
 		ethernet1 = &gmac2phy;
 	};
-- 
2.29.2

