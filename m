Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9304189AD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 16:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhIZPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhIZPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:01:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A349DC061570;
        Sun, 26 Sep 2021 07:59:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g16so44067388wrb.3;
        Sun, 26 Sep 2021 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bLfPo+6vcisWGnYzmBvI09cspQC7hfSw6Rhhq6cjTo=;
        b=PePjQoSa01OlQ96AWA/orzxJQqzXdutb+FvgH5KrtNrKmN0aH/HZcifX/YagB2Rw9h
         EQgUhVmZATFyn90N/uGOHnS6U9JhGLhlJOrKf20mHuDfOorYfKhgxrcIP2LA+676hZgk
         jJorZdy3Eq+cTbcBskfOj/2dScJuaJB+mlRX+4NGnkfq0+fWw4QeAymismVmucarayY0
         3KcPjEUvDy/KV3F/2oWAijGNLNYmyQKDrDzYVBrene3Fb/wPZfXACwkkUrmsszK0xFRP
         EXGDSeYqVEU3BsJcxy4X9TOksh/35b3Ovs+QN2CyJHeloRVrIo039aUE/Eeh/U+m8EUb
         acGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bLfPo+6vcisWGnYzmBvI09cspQC7hfSw6Rhhq6cjTo=;
        b=0YNqnIDoZ/Ko0U0UshNHFQuH+zlKaFrmepLbdGPkiFgEGDP9og5Hx0gAMEjrGNdZtP
         frCeqbXSIh47BcFrhQelOPGcTer/yJRei05lojXc2i9ne0v7kXO+oRmnrvQ3eASGOcjz
         KQnHhWwaRqSNyJ/sWaUAwGOci7inRfJqDSWl7edSPNF2jwJ7zcVsrn0Si8l+c7bCeVoC
         tsGxhKMPqZmQhclAtuaYLxcfUh43qD77HmkOIWGh9j3aw19uZj2NSuajypURo9xQX00T
         J/0kYmvN//jj5pxoidtQ3Z4qQ0Um77E3dSyNhSxlHEK9+qW/GwCRRg45QkZMbmm4QJle
         KUpA==
X-Gm-Message-State: AOAM533GicNPW5ZTX/M1GuZ6P1vifO0dmsLc4vYaH920IYsNKHPMt1Du
        d/PNpe3zq0J8aNK07Niq/sg=
X-Google-Smtp-Source: ABdhPJy5bPyODx5d1z62z+SF81W2qEXcwl05JtDwqzLKIw7WwErPGerhCgcMICFhXKtda2sgDLINrQ==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr11928930wmq.91.1632668376262;
        Sun, 26 Sep 2021 07:59:36 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id n7sm14143840wra.37.2021.09.26.07.59.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 07:59:35 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     robh@kernel.org, john@phrozen.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: mt7621-dts: align resets with binding documentation
Date:   Sun, 26 Sep 2021 16:59:31 +0200
Message-Id: <20210926145931.14603-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding documentation for compatible 'ralink,rt2880-reset' is now available.
Align reset related bits with binding documentation along the dtsi file.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index eeabe9c0f4fb..40c594fdad5f 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/mt7621-clk.h>
+#include <dt-bindings/reset/ralink-rt2880.h>
 
 / {
 	#address-cells = <1>;
@@ -88,7 +89,7 @@ i2c: i2c@900 {
 
 			clocks = <&sysc MT7621_CLK_I2C>;
 			clock-names = "i2c";
-			resets = <&rstctrl 16>;
+			resets = <&rstctrl RALINK_RT2880_I2C>;
 			reset-names = "i2c";
 
 			#address-cells = <1>;
@@ -106,7 +107,7 @@ i2s: i2s@a00 {
 
 			clocks = <&sysc MT7621_CLK_I2S>;
 			clock-names = "i2s";
-			resets = <&rstctrl 17>;
+			resets = <&rstctrl RALINK_RT2880_I2S>;
 			reset-names = "i2s";
 
 			interrupt-parent = <&gic>;
@@ -161,7 +162,7 @@ spi0: spi@b00 {
 			clocks = <&sysc MT7621_CLK_SPI>;
 			clock-names = "spi";
 
-			resets = <&rstctrl 18>;
+			resets = <&rstctrl RALINK_RT2880_SPI>;
 			reset-names = "spi";
 
 			#address-cells = <1>;
@@ -177,7 +178,7 @@ gdma: gdma@2800 {
 
 			clocks = <&sysc MT7621_CLK_GDMA>;
 			clock-names = "gdma";
-			resets = <&rstctrl 14>;
+			resets = <&rstctrl RALINK_RT2880_GDMA>;
 			reset-names = "dma";
 
 			interrupt-parent = <&gic>;
@@ -196,7 +197,7 @@ hsdma: hsdma@7000 {
 
 			clocks = <&sysc MT7621_CLK_HSDMA>;
 			clock-names = "hsdma";
-			resets = <&rstctrl 5>;
+			resets = <&rstctrl RALINK_RT2880_HSDMA>;
 			reset-names = "hsdma";
 
 			interrupt-parent = <&gic>;
@@ -296,7 +297,7 @@ pinmux {
 		};
 	};
 
-	rstctrl: rstctrl {
+	rstctrl: reset-controller {
 		compatible = "ralink,rt2880-reset";
 		#reset-cells = <1>;
 	};
@@ -383,7 +384,7 @@ ethernet: ethernet@1e100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		resets = <&rstctrl 6 &rstctrl 23>;
+		resets = <&rstctrl RALINK_RT2880_FE &rstctrl RALINK_RT2880_ETH>;
 		reset-names = "fe", "eth";
 
 		interrupt-parent = <&gic>;
@@ -428,7 +429,7 @@ switch0: switch0@0 {
 				#size-cells = <0>;
 				reg = <0>;
 				mediatek,mcm;
-				resets = <&rstctrl 2>;
+				resets = <&rstctrl RALINK_RT2880_MCM>;
 				reset-names = "mcm";
 				interrupt-controller;
 				#interrupt-cells = <1>;
@@ -514,7 +515,7 @@ pcie@0,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 24>;
+			resets = <&rstctrl RALINK_RT2880_PCIE0>;
 			clocks = <&sysc MT7621_CLK_PCIE0>;
 			phys = <&pcie0_phy 1>;
 			phy-names = "pcie-phy0";
@@ -529,7 +530,7 @@ pcie@1,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 25>;
+			resets = <&rstctrl RALINK_RT2880_PCIE1>;
 			clocks = <&sysc MT7621_CLK_PCIE1>;
 			phys = <&pcie0_phy 1>;
 			phy-names = "pcie-phy1";
@@ -544,7 +545,7 @@ pcie@2,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 26>;
+			resets = <&rstctrl RALINK_RT2880_PCIE2>;
 			clocks = <&sysc MT7621_CLK_PCIE2>;
 			phys = <&pcie2_phy 0>;
 			phy-names = "pcie-phy2";
-- 
2.25.1

