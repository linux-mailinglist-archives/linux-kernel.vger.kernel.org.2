Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497A3724D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhEDER6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhEDER5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3980E61186;
        Tue,  4 May 2021 04:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620101823;
        bh=o6bzGyR/7bsRfnO0+aNVpGB5YWfLgC/3PIVf/41nDM0=;
        h=From:To:Cc:Subject:Date:From;
        b=Q+1PwRv70pQbWWpiebMnyXuxFP4Rl6TJAj0zZR4swW8eTU7D+e03Zu5RhRU8Ooq2C
         HZhviqCvI3JNE48XdbT1ZE1kAdn8/iLwPhjvzhLm1PfPwsuRhXKE4Vu6UcaHYza97N
         0LlhOZR0w6goBXHP7zDa+L47wIEwbYhQwdPREt3myftotS3h0DqLxlWF967sooTRPd
         r7OMRZoSCX9q3xnX8VMHlRFaDE+tHwArqvT1lDZtQiciP0KlnPSBkXtyAVRCFkgclZ
         Lt4IzEwUAWSGtmwqefHaeryKPywJYHqz3IzI1mZI7ExRdi+HBDevZQos/h5pQW1SkP
         iNbzJRD0Nvc3A==
Received: by wens.tw (Postfix, from userid 1000)
        id 4B92D5FBFA; Tue,  4 May 2021 12:17:00 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
Date:   Tue,  4 May 2021 12:16:59 +0800
Message-Id: <20210504041659.22495-1-wens@kernel.org>
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
Changes since v1:
  - added uart-has-rtscts property
  - added alias for uart_A

Hi Neil, Martin,

I dropped your review-bys since I added the UART alias and I'm not sure
what the policy for those are.

ChenYu
---
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7273eed5292c..f017a263784f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 		ethernet0 = &ethmac;
 	};
 
@@ -385,9 +386,20 @@ &uart_AO {
 
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

