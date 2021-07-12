Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115FD3C5DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhGLOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhGLOCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:02:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D27A761003;
        Mon, 12 Jul 2021 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626098364;
        bh=CVa9mOdD4iVXL47LeMVBbUqVDOCPCuh6G06o/IBjVAA=;
        h=From:To:Cc:Subject:Date:From;
        b=eJHp1t8b22M7dLCIWLFl17xaWR15lVo7pZYTSPilqbsKK3p20ZKV5cZOpNiFrE8EA
         dJvqwhFEHtJOti1SFV/srwm7dqfSTSTnsnadZaj20J7dAyxsb84Cthp2dTLPutvSub
         09q5U1ZT0VrlVrGqUwOInsQGubij6R/78hVJxjzeOTpEqHMtyVqGTzskdEAUFJqxR4
         jVX/yLUzQfszVTV2eRpCfxRnSaSeLBhhZ/u2dlP9VQmzsywn9aecO0Iqx49AxBIfGR
         h9vvcK6IM+SsRQUi1zH5jyXbvRsUQpReIcv9YYx6YDZlxVrUuK9cdX/Z6+FOxLtF/E
         rYPfjJa3EKWzQ==
Received: by wens.tw (Postfix, from userid 1000)
        id B0BF15FBF5; Mon, 12 Jul 2021 21:59:21 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
Date:   Mon, 12 Jul 2021 21:59:19 +0800
Message-Id: <20210712135919.32059-1-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The NanoPi K2 has a AP6212 WiFi+BT combo module. The WiFi portion is
already enabled. The BT part is connected via UART and I2S.

Enable the UART and add a device node describing the Bluetooth portion
of the module.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2:
  - dropped alias for uart_A
  - added Martin's reviewed-by

Changes since v1:
  - added uart-has-rtscts property
  - added alias for uart_A
---
 .../arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7273eed5292c..7d94160f5802 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -385,9 +385,20 @@ &uart_AO {
 
 /* Bluetooth on AP6212 */
 &uart_A {
-	status = "disabled";
+	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&wifi_32k>;
+		clock-names = "lpo";
+		vbat-supply = <&vddio_ao3v3>;
+		vddio-supply = <&vddio_ao18>;
+		host-wakeup-gpios = <&gpio GPIOX_21 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 /* 40-pin CON1 */
-- 
2.31.1

