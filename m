Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD436DEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhD1Rz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbhD1Rz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:55:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330ADC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:55:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t18so6408043wry.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccJ5CKh5Fm2jcqyeUGgDKmg/mfobdGyfWxQa0j/XJgY=;
        b=jo3w+WThsU+itLe68rxjwmCfIa0oZ5elmUOfF/KpYZ8pmbrIsshEpkCEaShcIa0B+L
         pTwkM08whlEM5I4QLNGvdjx6szEhmWKInp6WjfTDyD2eNQSVh74u1SiPjLotpvgkJJKy
         /l7a7uFlKzdKW1mTxXnHcF5o0gHh+B8oQ/hNrQCOybtxgvTFDxT50IUrMZDZjmXsO6PB
         eaPhbfliU5QNlcmnLPLmFWm4KDOp3fjiw/o0VlyzStrKbs4BWdY9UNrC9rBPf9nuObPO
         pM/J1iolzYdHrJpkUY4wn/6kJM99tRSVWOOGpihvgtEDFckEwVdS04/jHjMPGuQzo8ac
         z6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccJ5CKh5Fm2jcqyeUGgDKmg/mfobdGyfWxQa0j/XJgY=;
        b=iv8F7vRJ//MgBbaW8OnDoIhGyev0V6okzno9HEglaz7CprCrSGoZtFFdm9teDd2HLm
         LDM5k1o6CMoyYjDL1uV1bOfVZA8e5M7TpOkqvZphDjmBXtduPxQ8lU2DUBP/M2NS3hCe
         g06GLXkbSsVdxHhCu2s/2juRDfmF+/sABWoZA3Elz1avayiYrTmP8O1gyE4EjKe0nS/X
         f/hu/Ia5je6LhAeFl+1aQ1WgZXHiWGrprJqXKzuPtCrZMahsaGi0+t9IzAfCQJV/wjkU
         MnronnpKWdIUA4eW7F+UQWzGrLsuYtI5bbD/dEYQEIHSP5IfXH7sfhpolxsmNil0DXEe
         ddTg==
X-Gm-Message-State: AOAM5327GXRz9mgTCGKd4hr2upWGttaRVDOop0LBwBA51BQM6mXoNdtb
        qeKr7qeQUrfO7dM7szydxFQEWg==
X-Google-Smtp-Source: ABdhPJyStKAHRYiMqqdwTQdM6FHQZW5EDJ82J7Avnp9VngvDTL9jiKJU0CHc4/9XO8r0jjBx6v1s2Q==
X-Received: by 2002:a5d:590b:: with SMTP id v11mr28163078wrd.415.1619632509812;
        Wed, 28 Apr 2021 10:55:09 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o10sm616526wrx.35.2021.04.28.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:55:09 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: gemini: rename to nand-controller
Date:   Wed, 28 Apr 2021 17:55:03 +0000
Message-Id: <20210428175503.3692090-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must use nand-controller instead of flash.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts      | 2 +-
 arch/arm/boot/dts/gemini-rut1xx.dts        | 3 +--
 arch/arm/boot/dts/gemini-sl93512r.dts      | 2 +-
 arch/arm/boot/dts/gemini-sq201.dts         | 2 +-
 arch/arm/boot/dts/gemini-wbd111.dts        | 2 +-
 arch/arm/boot/dts/gemini-wbd222.dts        | 2 +-
 arch/arm/boot/dts/gemini.dtsi              | 2 +-
 8 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index cc39289e99dd..5e205bb53e5a 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -281,7 +281,7 @@ phy4: phy@4 {
 	};
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			/*
 			 * Flash access collides with the Chip Enable signal for
 			 * the display panel, that reuse the parallel flash Chip
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 43c45f7e1e0a..1e2d3162d9c1 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -76,7 +76,7 @@ phy0: ethernet-phy@1 {
 	};
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			status = "okay";
 			/* 16MB of flash */
 			reg = <0x30000000 0x01000000>;
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index 08091d2a64e1..f8826a3b774f 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -70,7 +70,7 @@ phy0: ethernet-phy@1 {
 	};
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			status = "okay";
 			/* 8MB of flash */
 			reg = <0x30000000 0x00800000>;
@@ -124,7 +124,6 @@ ethernet-port@1 {
 				/* Not used in this platform */
 			};
 		};
-
 		usb@68000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/gemini-sl93512r.dts b/arch/arm/boot/dts/gemini-sl93512r.dts
index a0916d3c1059..995be04425b7 100644
--- a/arch/arm/boot/dts/gemini-sl93512r.dts
+++ b/arch/arm/boot/dts/gemini-sl93512r.dts
@@ -138,7 +138,7 @@ fixed-link {
 
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			status = "okay";
 			/* 16MB of flash */
 			reg = <0x30000000 0x01000000>;
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 0c6e6d35bfaa..df6146aaff4b 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -123,7 +123,7 @@ fixed-link {
 
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			status = "okay";
 			pinctrl-names = "enabled", "disabled";
 			pinctrl-0 = <&pflash_default_pins>;
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index 0c47b2b9811c..f253743b1c55 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -82,7 +82,7 @@ phy0: ethernet-phy@1 {
 	};
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			status = "okay";
 			/* 8MB of flash */
 			reg = <0x30000000 0x00800000>;
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index 52b4dbc0c072..76b6faaf806e 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -86,7 +86,7 @@ phy1: ethernet-phy@3 {
 	};
 
 	soc {
-		flash@30000000 {
+		nand-controller@30000000 {
 			status = "okay";
 			/* 8MB of flash */
 			reg = <0x30000000 0x00800000>;
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 38671523dec5..5c8c5179c944 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -16,7 +16,7 @@ soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&intcon>;
 
-		flash@30000000 {
+		nand: nand-controller@30000000 {
 			compatible = "cortina,gemini-flash", "cfi-flash";
 			syscon = <&syscon>;
 			pinctrl-names = "default";
-- 
2.26.3

