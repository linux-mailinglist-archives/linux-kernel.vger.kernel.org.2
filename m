Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1136E4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhD2GJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2GJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5FF261434;
        Thu, 29 Apr 2021 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619676524;
        bh=9dFSVbrkwUxIsVzVumyBgih3vCXCrFXuL4F7lB86YGk=;
        h=From:To:Cc:Subject:Date:From;
        b=Ix5mLXnNpkc19hshwNUZ+Il5Sd+D9IPVhzhUmSfY9R7tim4tl9dV7fd0rnh5pOXoT
         NLoKwJxcZCgXmgQcusLd6OKQ+UZcysyXzvcdl+KefM7dVDVeZdUwOX0zLhsdG/aqcq
         ngn2mHoyhOJiQd4g4kCPTVKL71byo5g2eXhT8/HuChYeVm0Ctr/oKnRtlu0Tujc8N2
         XkH/GqU4Qs2MGiIYVJ5T2Bi1WlMH7ZVLq0FSC5MkPAIuW445G/jZ/nFGEPTBs0pQLG
         W4jl1PQKdsNwmxSdY/1X/xDYWBM2kOyy5Qptb3l+tV+ZsUGLP9LECfzum+ioYfiOzK
         8y+8Q0wA4xlrA==
Received: by wens.tw (Postfix, from userid 1000)
        id 18AD15FBA4; Thu, 29 Apr 2021 14:08:41 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
Date:   Thu, 29 Apr 2021 14:08:30 +0800
Message-Id: <20210429060830.6266-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7273eed5292c..10f48fb1af61 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -385,9 +385,19 @@ &uart_AO {
 
 /* Bluetooth on AP6212 */
 &uart_A {
-	status = "disabled";
+	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
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

