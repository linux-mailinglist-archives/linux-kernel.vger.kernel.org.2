Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA73344720F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhKGHo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhKGHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:44:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04505C061570;
        Sun,  7 Nov 2021 00:42:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 71so10491992wma.4;
        Sun, 07 Nov 2021 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0RL45OoJsxDqII6WqqJzrCBAIvt4D77cElanpVHtTc=;
        b=o+SJ2uQNb6R49PlN3XZlTNrdacUUdm9fB+QUqt0TQa0lX4CZwkP/8tSLAi/H/E9vl0
         D5BTM2j4hvp5vmlnprPAm5yrgWv7TQj3pFe1wW04v06GWyZkqbMvSy0BuxbsOu+FMxDC
         j9VxWIp27rwllfJn4KpmLAdBR2sayVuyXMBdswWNHGbVKSwaUb0USLLfxQw37rp5n0uV
         aITT9VxexeqCJWUoPU0fedcP3wGpefmkuF+BmBjKQkZL5VDQTyD9YI5ElrlzmRne+r4Y
         vDZl/HYBIoPt/Bq2u4tHefVgP4Ij11G+u+Cx1TCEoIL9pGUWW4ajtSt5DeX38wLizr3g
         d8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0RL45OoJsxDqII6WqqJzrCBAIvt4D77cElanpVHtTc=;
        b=1c96Z/0Q6JUGXoQMn74cbnA5oOA6DM+Cm1iDXEl3WI29BD89QhwYZBpj9e9WUAsCKD
         YPMeemkjJbB5GhiCHbkTU5/HV97U+X06thYvcCoT++Q2XAro5p1ZBtdyKOIFyl53P3eT
         SGnduYwckxPgcr8X+t7Kfpwt32MiHaWseTcYUoK+HNHkRCIxBZZ1gM2GBYEjCe4ZJ/qM
         dgkCFH5j7dcsEdEzTj2ofKLgCABtHRG3CSHgGB/M+E1QQp60BL9EVV12n5wFGQ/Ww6xx
         KXo0nqxLOM6xFNuuPlI39tWsxAfh2xNXlOfXuJW8+o7RmqCZSB2Rx58VE3YdPbgI8Nj3
         rXBQ==
X-Gm-Message-State: AOAM532DvkHAVV4jsfvHtyZRe3kPwmYjBXKy2b6qpeeq6aPaNAV2+I/+
        od1uMPP9VSDn4atxg4zKYCTRznMizfpV8A==
X-Google-Smtp-Source: ABdhPJyDr1ieFUcrkcAPbYNbKaizPUV5S+avKsnfAnsTm6DaNe4mL0R6F/qq6CCybEByS6vR0DyEOw==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr43823871wmd.137.1636270926343;
        Sun, 07 Nov 2021 00:42:06 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e12sm15353352wrq.20.2021.11.07.00.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 00:42:05 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name
Subject: [PATCH v5 4/4] staging: mt7621-dts: align resets with binding documentation
Date:   Sun,  7 Nov 2021 08:42:00 +0100
Message-Id: <20211107074200.18911-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
to be used as a reset provider. Align reset related bits and system controller
node with binding documentation along the dtsi file.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 6d158e4f4b8c..2bf74468d495 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/mt7621-clk.h>
+#include <dt-bindings/reset/mt7621-reset.h>
 
 / {
 	#address-cells = <1>;
@@ -67,6 +68,7 @@ sysc: syscon@0 {
 			compatible = "mediatek,mt7621-sysc", "syscon";
 			reg = <0x0 0x100>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			ralink,memctl = <&memc>;
 			clock-output-names = "xtal", "cpu", "bus",
 					     "50m", "125m", "150m",
@@ -96,7 +98,7 @@ i2c: i2c@900 {
 
 			clocks = <&sysc MT7621_CLK_I2C>;
 			clock-names = "i2c";
-			resets = <&rstctrl 16>;
+			resets = <&sysc MT7621_RST_I2C>;
 			reset-names = "i2c";
 
 			#address-cells = <1>;
@@ -137,7 +139,7 @@ spi0: spi@b00 {
 			clocks = <&sysc MT7621_CLK_SPI>;
 			clock-names = "spi";
 
-			resets = <&rstctrl 18>;
+			resets = <&sysc MT7621_RST_SPI>;
 			reset-names = "spi";
 
 			#address-cells = <1>;
@@ -153,7 +155,7 @@ gdma: gdma@2800 {
 
 			clocks = <&sysc MT7621_CLK_GDMA>;
 			clock-names = "gdma";
-			resets = <&rstctrl 14>;
+			resets = <&sysc MT7621_RST_GDMA>;
 			reset-names = "dma";
 
 			interrupt-parent = <&gic>;
@@ -172,7 +174,7 @@ hsdma: hsdma@7000 {
 
 			clocks = <&sysc MT7621_CLK_HSDMA>;
 			clock-names = "hsdma";
-			resets = <&rstctrl 5>;
+			resets = <&sysc MT7621_RST_HSDMA>;
 			reset-names = "hsdma";
 
 			interrupt-parent = <&gic>;
@@ -272,11 +274,6 @@ pinmux {
 		};
 	};
 
-	rstctrl: rstctrl {
-		compatible = "ralink,rt2880-reset";
-		#reset-cells = <1>;
-	};
-
 	sdhci: sdhci@1e130000 {
 		status = "disabled";
 
@@ -355,7 +352,7 @@ ethernet: ethernet@1e100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		resets = <&rstctrl 6 &rstctrl 23>;
+		resets = <&sysc MT7621_CLK_FE &sysc MT7621_CLK_ETH>;
 		reset-names = "fe", "eth";
 
 		interrupt-parent = <&gic>;
@@ -400,7 +397,7 @@ switch0: switch0@0 {
 				#size-cells = <0>;
 				reg = <0>;
 				mediatek,mcm;
-				resets = <&rstctrl 2>;
+				resets = <&sysc MT7621_RST_MCM>;
 				reset-names = "mcm";
 				interrupt-controller;
 				#interrupt-cells = <1>;
@@ -486,7 +483,7 @@ pcie@0,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 24>;
+			resets = <&sysc MT7621_RST_PCIE0>;
 			clocks = <&sysc MT7621_CLK_PCIE0>;
 			phys = <&pcie0_phy 1>;
 			phy-names = "pcie-phy0";
@@ -501,7 +498,7 @@ pcie@1,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 25>;
+			resets = <&sysc MT7621_RST_PCIE1>;
 			clocks = <&sysc MT7621_CLK_PCIE1>;
 			phys = <&pcie0_phy 1>;
 			phy-names = "pcie-phy1";
@@ -516,7 +513,7 @@ pcie@2,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 26>;
+			resets = <&sysc MT7621_RST_PCIE2>;
 			clocks = <&sysc MT7621_CLK_PCIE2>;
 			phys = <&pcie2_phy 0>;
 			phy-names = "pcie-phy2";
-- 
2.33.0

