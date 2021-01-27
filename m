Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9430502D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhA0DtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389645AbhA0AGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:06:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD3C061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:04:40 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w18so16765pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vy4fxFjc+ojePEGm9S0MBi0jipTSfFhAgAo+uoqFzI=;
        b=u/AqHyIpj76efLaeJLaQUIRyHE7+DJYLiusS7rShze9raXz0FM/d2HcGifBojAQhG7
         Cb7RtDf4B59yOaYi6KGVhTJd3vcW8dxzcB8nqKT4MvsN/GUOr0ekIxo4qvHEmjPMtGgH
         sff4lRxxRUByV0LhtjZxVOEvzMPqB6ZILutJ80aYjtCG0MDK9ddLYB11TFMZ7511nfwF
         iHRvIYYxJHrh/ToP9Lu8VRi3rS7pV88CKvR25AyqwT+Tnw9Y4VBAnnM1HypOJk4rCiP9
         Gw2AYzOZbCLuJWmjy6GoANye5qaHoVmz8dmF5Mgxmt1UNNi0SQJU9mO/dft6hlX//Am4
         Nb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vy4fxFjc+ojePEGm9S0MBi0jipTSfFhAgAo+uoqFzI=;
        b=KnlKmTVcZKQzYAa2RXU7+5l9Q3wfcMtWz2ClsUkCnLQPkAamLVT2ba0IXlTgkei8Lm
         vXskpd0up91hj4UL9lI9Lu4RzEvJqgBy/9OYYSn6qofxF9Co7fEMGPRigESKUfCXVwuD
         4QdHwM679AGxJOKqtK0EdilzFToxzMyN9IXzMaqDIP0bJo/Xo+gFrKfdTninLPK4avnr
         PwL7JQyhOA3NdBdrNj1gXOmBU67/6IHSwXba/6VQr1/+wAnFfcL5KMz41nvgqusZJvJU
         kW6ZpowGXsx5EbB78g4hDUGCNdbp2N1eEZb9qY069oa9Bl2KRKUQXKVrDfTCtOLi2v9c
         z79Q==
X-Gm-Message-State: AOAM532urdvek+9Kacwwe0+bDjMMT4fpTHHRCRJU6H9YCmDPxjzw1JsU
        hx8RZcOA22iZ9wliceM5eQhing==
X-Google-Smtp-Source: ABdhPJz7UFVIoVecPqAF2EAVnuw1EjqKtzt7Gh+4EwyTCwPaV7ovulOBqCooWTC9qHPVV6TZZCBp1A==
X-Received: by 2002:a05:6a00:8d0:b029:1b6:3581:4f41 with SMTP id s16-20020a056a0008d0b02901b635814f41mr7482093pfu.56.1611705879609;
        Tue, 26 Jan 2021 16:04:39 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:515f:b0ad:6302:bbc2])
        by smtp.gmail.com with ESMTPSA id y5sm213536pfq.96.2021.01.26.16.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 16:04:38 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH 1/2] ARM: dts: am335x-pocketbeagle: unique gpio-line-names
Date:   Tue, 26 Jan 2021 16:03:03 -0800
Message-Id: <20210127000303.436595-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on linux-gpio discussion [1], it is best practice to make the
gpio-line-names unique. Generic names like "[ethernet]" are replaced
with the name of the unique signal on the AM3358 SoC ball corresponding
to the gpio line. "[NC]" is also renamed to the standard "NC" name to
represent "not connected".

[1] https://lore.kernel.org/linux-gpio/20201216195357.GA2583366@x1/

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 arch/arm/boot/dts/am335x-pocketbeagle.dts | 140 +++++++++++-----------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pocketbeagle.dts b/arch/arm/boot/dts/am335x-pocketbeagle.dts
index d526c5941c9b..209cdd17dc1e 100644
--- a/arch/arm/boot/dts/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/am335x-pocketbeagle.dts
@@ -61,51 +61,51 @@ vmmcsd_fixed: fixedregulator0 {
 
 &gpio0 {
 	gpio-line-names =
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
 		"P1.08 [SPI0_CLK]",
 		"P1.10 [SPI0_MISO]",
 		"P1.12 [SPI0_MOSI]",
 		"P1.06 [SPI0_CS]",
 		"[MMC0_CD]",
 		"P2.29 [SPI1_CLK]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
+		"[SYSBOOT 12]",
+		"[SYSBOOT 13]",
+		"[SYSBOOT 14]",
+		"[SYSBOOT 15]",
 		"P1.26 [I2C2_SDA]",
 		"P1.28 [I2C2_SCL]",
 		"P2.11 [I2C1_SDA]",
 		"P2.09 [I2C1_SCL]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
+		"NC",
 		"P2.31 [SPI1_CS]",
 		"P1.20 [PRU0.16]",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
 		"P2.03",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
 		"P1.34",
 		"P2.19",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
 		"P2.05 [UART4_RX]",
 		"P2.07 [UART4_TX]";
 };
 
 &gpio1 {
 	gpio-line-names =
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
 		"P2.25 [SPI1_MOSI]",
 		"P1.32 [UART0_RX]",
 		"P1.30 [UART0_TX]",
@@ -113,10 +113,10 @@ &gpio1 {
 		"P2.33",
 		"P2.22",
 		"P2.18",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
 		"P2.01 [PWM1A]",
-		"[NC]",
+		"NC",
 		"P2.10",
 		"[USR LED 0]",
 		"[USR LED 1]",
@@ -126,35 +126,35 @@ &gpio1 {
 		"P2.04",
 		"P2.02",
 		"P2.08",
-		"[NC]",
-		"[NC]",
-		"[NC]";
+		"NC",
+		"NC",
+		"NC";
 };
 
 &gpio2 {
 	gpio-line-names =
 		"P2.20",
 		"P2.17",
-		"[NC]",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
+		"NC",
 		"[EEPROM_WP]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[SYSBOOT]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
+		"[SYSBOOT 0]",
+		"[SYSBOOT 1]",
+		"[SYSBOOT 2]",
+		"[SYSBOOT 3]",
+		"[SYSBOOT 4]",
+		"[SYSBOOT 5]",
+		"[SYSBOOT 6]",
+		"[SYSBOOT 7]",
+		"[SYSBOOT 8]",
+		"[SYSBOOT 9]",
+		"[SYSBOOT 10]",
+		"[SYSBOOT 11]",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
 		"P2.35 [AIN5]",
 		"P1.02 [AIN6]",
 		"P1.35 [PRU1.10]",
@@ -169,19 +169,19 @@ &gpio2 {
 
 &gpio3 {
 	gpio-line-names =
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
 		"[I2C0_SDA]",
 		"[I2C0_SCL]",
-		"[JTAG]",
-		"[JTAG]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
+		"[JTAG EMU0]",
+		"[JTAG EMU1]",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
 		"P1.03 [USB1]",
 		"P1.36 [PWM0A]",
 		"P1.33 [PRU0.1]",
@@ -191,16 +191,16 @@ &gpio3 {
 		"P2.34 [PRU0.5]",
 		"P2.28 [PRU0.6]",
 		"P1.29 [PRU0.7]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]",
-		"[NC]";
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC";
 };
 
 &am33xx_pinmux {
-- 
2.25.1

