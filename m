Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5464114F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhITMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhITMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:54:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713AC061762
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:53:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so21227163wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EhNQJduhIIpt0g9bBw1gJAdUiO0vbmeH1OITalz0ek=;
        b=u7B1IpxjjytDA+htBK/6iD5yIbgYKK7ExlI8p1uLLX4xqVmszSL3rL5nXP1DnKm4Gw
         UMRuYNgHrVjl8ogu8MkmXFc+66RoVrAR12dE1NS+l3BLRfEU+nrunzqgUhLId+s38KPt
         WJ4rsv8q03s0su6YzkJbBX8bgCnAefBEgmo+pUY5HZNqVjXLswedYlTiK1NcZK8FeriW
         G8D0q8mL4eISAYrzfietBe+WWR3qki6YjYTPhhjsEqTU9oBrh/gv9asfuklQJoQXC25z
         2LvkQOGBByRelCv636NWzS0yV06GLDwHmL+k+ducgEJ+GHuPFMRTKXkS7NB62/tZAAj4
         7EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EhNQJduhIIpt0g9bBw1gJAdUiO0vbmeH1OITalz0ek=;
        b=oOXpXcrYJWtMsKHS6dcj+WTZ5K8PdLVgR4J0LEf+ZbYnE54f7/Ff3MBknpaB1yru2p
         TqVHdce8VOPWg96/pVSE7jfcEhc5V7rSj6BF6Vlla+BjNzMZF0X0uQddGL52DGc6CBpY
         qGjRiVipFXxGIhrb5ukqBSdL7uT7VFAsEoGY8Q1MAZjqqO0C4qFnzx+N6vxWELG5Uqea
         3zMF7mwBSpWObESynmDSOeO5PmqnueHIjLN6vG4zMQYZ/h+DBmUdpN2tu/v1BUil0BMD
         JYhZbeiLkTFIMBXIl85cSjjVpgeBymZh4FeIRyz5Ifr9bNZJ6Qi7gP28gq32XqM1YOkC
         QsVw==
X-Gm-Message-State: AOAM533e4dU4CzBgyIOp7Q8DDIwXGLiRoIdza7xOV7pyBogayuSjq+JM
        4Xvq/Dah086BXyHOutaj/dyIgg==
X-Google-Smtp-Source: ABdhPJx68KEaF5ggIZnnJ43U+q30rj8y309b7yqfTezWSOWT8G78/S+ydkvbB7XbfPYhOcCj7Tc3Fg==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr28735797wrs.265.1632142389790;
        Mon, 20 Sep 2021 05:53:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:aa8a:ef22:59c5:1bf3])
        by smtp.gmail.com with ESMTPSA id j21sm15791643wrd.48.2021.09.20.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:53:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gowtham Tammana <g-tammana@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] ARM: dts: dra7: add entry for bb2d module
Date:   Mon, 20 Sep 2021 14:53:03 +0200
Message-Id: <20210920125306.12347-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920125306.12347-1-narmstrong@baylibre.com>
References: <20210920125306.12347-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gowtham Tammana <g-tammana@ti.com>

BB2D is a Vivante GC 2D Accelerator.
This adds the node to the dts file within a target module node.
Crossbar index number is used for interrupt mapping.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dra7.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index dfc1ef8ef6ae..8a9df5ed5439 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -965,6 +965,26 @@ hdmi: encoder@0 {
 			};
 		};
 
+		target-module@59000000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x59000020 0x4>;
+			reg-names = "rev";
+			clocks = <&dss_clkctrl DRA7_DSS_BB2D_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x59000000 0x1000>;
+
+			bb2d: gpu@0 {
+				compatible = "vivante,gc";
+				reg = <0x0 0x0700>;
+				interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&dss_clkctrl DRA7_BB2D_CLKCTRL 0>;
+				clock-names = "core";
+				status = "disabled";
+			};
+		};
+
 		aes1_target: target-module@4b500000 {
 			compatible = "ti,sysc-omap2", "ti,sysc";
 			reg = <0x4b500080 0x4>,
-- 
2.25.1

