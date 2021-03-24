Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFF347860
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhCXMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:23:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33834 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231727AbhCXMWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:22:43 -0400
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lP2X2-00009P-Cv; Wed, 24 Mar 2021 13:22:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     jagan@amarulasolutions.com, jbx6244@gmail.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 6/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3368
Date:   Wed, 24 Mar 2021 13:22:34 +0100
Message-Id: <20210324122235.1059292-6-heiko@sntech.de>
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
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts        | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts    | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi          | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts        | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts            | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi               | 3 ---
 8 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 87fabc64cc39..15d1fc541c38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -8,6 +8,10 @@
 #include "rk3368.dtsi"
 
 / {
+	aliases {
+		mmc0 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index 46357d1d77cd..62aa97a0b8c9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -11,6 +11,10 @@ / {
 	model = "GeekBox";
 	compatible = "geekbuying,geekbox", "rockchip,rk3368";
 
+	aliases {
+		mmc0 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index f3a397b7eba0..b508b16657d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -10,6 +10,10 @@ / {
 	model = "Theobroma Systems RK3368-uQ7 Baseboard";
 	compatible = "tsd,rk3368-lion-haikou", "rockchip,rk3368";
 
+	aliases {
+		mmc1 = &sdmmc;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 2ae5fb4c8516..51da69cfcdde 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -7,6 +7,10 @@
 #include "rk3368.dtsi"
 
 / {
+	aliases {
+		mmc0 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index ecce16ecc9c3..3ebe15e03cf4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -11,6 +11,11 @@ / {
 	model = "Rockchip Orion R68";
 	compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
index 5ffd7b4d3036..5ccaa5f7a370 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
@@ -11,6 +11,11 @@ / {
 	model = "Rockchip PX5 EVB";
 	compatible = "rockchip,px5-evb", "rockchip,px5", "rockchip,rk3368";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial4:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 2582fa4b90e2..959d3cc801f2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -11,6 +11,11 @@ / {
 	model = "Rockchip R88";
 	compatible = "rockchip,r88", "rockchip,rk3368";
 
+	aliases {
+		mmc0 = &sdio0;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 789b1197fe28..d85242a6a40c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -26,9 +26,6 @@ aliases {
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mmc0 = &sdmmc;
-		mmc1 = &sdio0;
-		mmc2 = &emmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.29.2

