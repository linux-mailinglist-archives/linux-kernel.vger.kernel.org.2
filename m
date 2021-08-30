Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535EF3FBA68
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhH3QwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbhH3QwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:52:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14E3C061575;
        Mon, 30 Aug 2021 09:51:23 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810c:c200:2e91:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 064AB2222E;
        Mon, 30 Aug 2021 18:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630342281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s7FBoujQg3kVA4BmPGpYvHkhVu18Qs2dpi7QKew8788=;
        b=VSHipgrNulbGk3HtKKzZJYBk9xH45pCbIQDl7tsartInrHAylIzuj1YKoVam1yQf4d/Ipm
        Q2u9vSO/pC8cvQ6quY5EQ8c0wCtt4HANRUVBHKpQAhqDi+k3h+xAb9dEWpN8erBYjn9srX
        lhCegqe9ykqoTPG6onqBX+xPfqItMCE=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: hisilicon: fix arm,sp805 compatible string
Date:   Mon, 30 Aug 2021 18:51:13 +0200
Message-Id: <20210830165113.222867-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
the compatible is:
  compatible = "arm,sp805", "arm,primecell";

The current compatible string doesn't exist at all. Fix it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
There are also the layerscape SoC which are using these compatible
strings. I'm on it to change these, too.

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 2d5c1a348716..6eabec2602e2 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1087,7 +1087,7 @@ dwmmc2: dwmmc2@ff3ff000 {
 		};
 
 		watchdog0: watchdog@e8a06000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xe8a06000 0x0 0x1000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_OSC32K>,
@@ -1096,7 +1096,7 @@ watchdog0: watchdog@e8a06000 {
 		};
 
 		watchdog1: watchdog@e8a07000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xe8a07000 0x0 0x1000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_OSC32K>,
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index dde9371dc545..e4860b8a638e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -840,7 +840,7 @@ dwmmc_2: dwmmc2@f723f000 {
 		};
 
 		watchdog0: watchdog@f8005000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xf8005000 0x0 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ao_ctrl HI6220_WDT0_PCLK>,
-- 
2.30.2

