Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5835C34785F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCXMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:23:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33836 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhCXMWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:22:43 -0400
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lP2X1-00009P-Oj; Wed, 24 Mar 2021 13:22:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     jagan@amarulasolutions.com, jbx6244@gmail.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 4/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3308
Date:   Wed, 24 Mar 2021 13:22:32 +0100
Message-Id: <20210324122235.1059292-4-heiko@sntech.de>
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
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 6 ++++++
 arch/arm64/boot/dts/rockchip/rk3308.dtsi       | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index 7a96be10eaf0..3dddd4742c3a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -9,6 +9,12 @@
 / {
 	model = "Firefly ROC-RK3308-CC board";
 	compatible = "firefly,roc-rk3308-cc", "rockchip,rk3308";
+
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 3a035a189450..4ea32e8f33d2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -24,9 +24,6 @@ aliases {
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
-		mmc0 = &sdmmc;
-		mmc1 = &emmc;
-		mmc2 = &sdio;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.29.2

