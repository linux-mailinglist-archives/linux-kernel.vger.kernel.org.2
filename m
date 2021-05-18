Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC93387FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbhERSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351688AbhERSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:55:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C6C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:54:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t206so6002009wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjYQHeqKS2kjIoIBl/OQt2CgrSmm0dChlmcHt1OGoqM=;
        b=RtxaK3BQVVFrc7xm2rzL24PV1U/NtA9hcAmFKeBTZWYGjDGvtodm6xsjAHQ8KzWoKk
         pniOdOxrEF3Y5L3hbJT5F9fqclMb2e7ae7aXwojdmGGzTgepx4J0mKsboIg3bqBdrNEA
         6h6xHi5GuGclR192HnaAVvkz1rqBsU9Mxhzz33Lg1Tp44m9rUoo+U0cVrBmzd+BR2W53
         SLPkWZ2yB74eWnjSzo46BCTHxiCrDIJPnz7VYdeUOxIkx1LqirWA+5Hdc59NZSZTD3JC
         it39wQgVJRjLgUKFp0CpiRwOt+FpPJgYipOaeh3uNUJKANKi+lDcqlGzUZZGofYiYBlk
         GmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjYQHeqKS2kjIoIBl/OQt2CgrSmm0dChlmcHt1OGoqM=;
        b=HRrXVqXdUoCR6p9hVXn1Aad5Pm3M/1tL/JDchlWirWF++ZIYG/o8dPICsitlIklXkc
         izMTBg8HBJ4aQb+TorEBTaeypuKT3gEwZECF6+ZfWzAFy8+IlSa9uXxSIqWDOLOwlFvS
         m5VKB3/XtOS5FVYbogm+Q3u5oCAvjAgl4Ykm205DxriwPOhOgmBP+5SbTEISaYvcsXdj
         PJrPBOzqX/FgGl/Rm+JKMYsL4u0c00qA1h6u4mSbCUaf7v8W7vjsHDiOrJpjq7DzrYSS
         STRQDhGnBLph9sdjt1BQJtjhWJ+S4ooD7Vhd9WcKWiNhLjJfXBpyhMLbbL/UK1Fc/th9
         odlQ==
X-Gm-Message-State: AOAM533D5JYAG2qA0GU6BOvuwEQ1A+ErX3WzjltGnux64au2WFAjNGcG
        4XObm+FuLWBPez2Mpj2/qcJFaw==
X-Google-Smtp-Source: ABdhPJx5Nj1zwTvJgyWbYtWlJntgoIzHrk0UajcMq3DRCjRN21cLJ+WXz/kgqtu0jmRg5ReV170ang==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr6497446wmk.97.1621364039581;
        Tue, 18 May 2021 11:53:59 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j10sm22498405wrt.32.2021.05.18.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:53:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: gemini: convert obsolete SPI properties
Date:   Tue, 18 May 2021 18:53:53 +0000
Message-Id: <20210518185353.3802437-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-xxx are obsoletes properties, convert them to xxx-gpios.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 6 +++---
 arch/arm/boot/dts/gemini-sl93512r.dts      | 6 +++---
 arch/arm/boot/dts/gemini-sq201.dts         | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index cc39289e99dd..b2a0f3b1441e 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -61,9 +61,9 @@ spi {
 		#size-cells = <0>;
 
 		/* Collides with IDE pins, that's cool (we do not use them) */
-		gpio-sck = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio1 8 GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
 		num-chipselects = <1>;
 
diff --git a/arch/arm/boot/dts/gemini-sl93512r.dts b/arch/arm/boot/dts/gemini-sl93512r.dts
index a0916d3c1059..c78e55fd2562 100644
--- a/arch/arm/boot/dts/gemini-sl93512r.dts
+++ b/arch/arm/boot/dts/gemini-sl93512r.dts
@@ -87,9 +87,9 @@ spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		/* Check pin collisions */
-		gpio-sck = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio1 30 GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 4aa17393f8a9..3104af698cd6 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -72,9 +72,9 @@ spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		/* Check pin collisions */
-		gpio-sck = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio1 30 GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
-- 
2.26.3

