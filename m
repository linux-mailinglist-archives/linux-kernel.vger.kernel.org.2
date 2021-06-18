Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A013AD3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhFRU5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhFRU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:57:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8021C061760
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n7so12127135wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTMrkLH33QcTYAmCmYzm6ZHr2W5AOWeg+lqcFyiCyr0=;
        b=O3dGmcXCtw9lYBqWTYYWBPbQzzstHy0LKNyQBUOmq3wzI5TxW0FvlMhvSWqyn64iCg
         RVLmEil0rlpF411jvMMfrn1ZcScnhIqmBUhszkSy21FREulFqltV0pTgeQ3p9SQvJKmR
         cI6JKwuXDqwfnSkZ/Iy4eFHCmW03phedmjxXAgyV+r7ygBmxpy27cEjA1XdHCzoc5/Fj
         XAjBpOVgoCgwzG4ZDKYS+S/6EyMAfw/jvxJHumD+Hea33wxCjDsCgAupd4sUoKfv8qXE
         BhUXMu1ij9xcaCUmHRk1Ygyqup9LZJV9Uxn9mQQ73nA0yKEPTDCg5m1oEkufuuZwTK3K
         HYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTMrkLH33QcTYAmCmYzm6ZHr2W5AOWeg+lqcFyiCyr0=;
        b=ddujJW9f0vaZ81pfBNUM5G0bwcHBwkMwvXUgFrh/UAuEOUrmo0ljZO1GS18X6eemel
         TGRBadqWEfTfSbW08wCLlfZWI9oA9XbrJvRGglNUMDOfLe3L5mf0di/86r9d/5+aaB9s
         8JUEPsuLZzSnxl3Fha/MKXA+boSVLbQxOnUcd6Y8myFfgmeMG6/5N4fc6Z/BGRfxO7Vo
         I3LTxw+VnYjQwajBQyYLv48/TNuZYxLpJ/eS7Ujg9/Jcz9AU1yo9SOyQx8EdWx47eia9
         Ry+gNfeLLvaolVPv+VeD27aakYXlQnwSaHcGCEVWD4MKTMEGYiHxIMBDCIYecHrskIaZ
         EYag==
X-Gm-Message-State: AOAM5327RYnLnWZLcofwfCua/ElbyKzTP/HsUGabQss6t4S3soQ/MIuF
        GFY9M7goxtYwQJdcLVmfa2yLFw==
X-Google-Smtp-Source: ABdhPJzecFQwRn7K69AaWw6n1KwseQmQ6firgw6Oi59mrVcis9F+GSZhd+3uZB86CVKZ5AW+ggmAhw==
X-Received: by 2002:a5d:698a:: with SMTP id g10mr13319533wru.129.1624049741534;
        Fri, 18 Jun 2021 13:55:41 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm9745476wrt.69.2021.06.18.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:55:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/5] ARM: dts: gemini: add labels for USB, IDE, flash and ethernet
Date:   Fri, 18 Jun 2021 20:55:29 +0000
Message-Id: <20210618205533.1527384-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618205533.1527384-1-clabbe@baylibre.com>
References: <20210618205533.1527384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding label will help simplify boards's dts.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index cc053af3c347..9fe0fd93ac9e 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -16,7 +16,7 @@ soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&intcon>;
 
-		flash@30000000 {
+		flash: flash@30000000 {
 			compatible = "cortina,gemini-flash", "cfi-flash";
 			syscon = <&syscon>;
 			pinctrl-names = "default";
@@ -322,7 +322,7 @@ pci_intc: interrupt-controller {
 			};
 		};
 
-		ethernet@60000000 {
+		ethernet: ethernet@60000000 {
 			compatible = "cortina,gemini-ethernet";
 			reg = <0x60000000 0x4000>, /* Global registers, queue */
 			      <0x60004000 0x2000>, /* V-bit */
@@ -365,7 +365,7 @@ crypto: crypto@62000000 {
 			clocks = <&syscon GEMINI_CLK_GATE_SECURITY>;
 		};
 
-		ide@63000000 {
+		ide0: ide@63000000 {
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63000000 0x1000>;
 			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
@@ -378,7 +378,7 @@ ide@63000000 {
 			#size-cells = <0>;
 		};
 
-		ide@63400000 {
+		ide1: ide@63400000 {
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63400000 0x1000>;
 			interrupts = <5 IRQ_TYPE_EDGE_RISING>;
@@ -421,7 +421,7 @@ display-controller@6a000000 {
 			status = "disabled";
 		};
 
-		usb@68000000 {
+		usb0: usb@68000000 {
 			compatible = "cortina,gemini-usb", "faraday,fotg210";
 			reg = <0x68000000 0x1000>;
 			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
@@ -442,7 +442,7 @@ usb@68000000 {
 			status = "disabled";
 		};
 
-		usb@69000000 {
+		usb1: usb@69000000 {
 			compatible = "cortina,gemini-usb", "faraday,fotg210";
 			reg = <0x69000000 0x1000>;
 			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.31.1

