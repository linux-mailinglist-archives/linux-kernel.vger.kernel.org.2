Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DC9387EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351395AbhERRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbhERRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:51:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67544C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:49:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so11216706wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gl8VJYhAQI3TRwRQ35D+w8dJpAM3ONFhp8A1OmnXSMo=;
        b=AUr8zBIIePIoFqg6DpFsMwpGhzG/9Cvzt08MmeLDH1cBeySEuFQsikNKFiUxOeAvlK
         +ni5gM9njkAcFTtetDG7+q8EBh6ERotNyyf8olQnXc+dsYfJZNNMqd7fNScyXDpU87MJ
         BRPGhT0Nk77eyFJfAo8ba9TL6HP3hBZUvHvWwW+Qx1dUyHvZ4DF1LjVt4oqpDevw8BgX
         rgYpXbrqU7kV4p1gCHXNx0HgN6QafJa1cN9JmVYJgReTk+viRpQdpS229la+utsIbUYb
         qdD2NRRT/qkEQpOQGHgeYYxrPz3pc5a96tRaS4fVBHk0+z8eseezhXSayKY5kagRc4Of
         XXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gl8VJYhAQI3TRwRQ35D+w8dJpAM3ONFhp8A1OmnXSMo=;
        b=Z2A5KGoMjV0XYRA9UBXbRq1IUfd2gXvVe4pQZXJUClVA/w8Sv/1t87JPR1gK2Cn4k+
         HE0uV/zB5iKME3UYTgrN+P56uuucNJS7GwABgl5R0Sb/n90n3E3vjif5YHEy66YJ/CJN
         F/xYZRL0aVuVu0XZbjKFs3xlLAXqDXDB33k8b2iOY+INdBBLtCpeRh3hn1YRs9z0BjON
         HEDqP+FYtkCDkFMJ1P1mintFSKErp8D7hv162ZnDpa5GrQz75K/JT0xD/FMSV0ktKt3j
         5vtFv7s2INF2R0XCNyCXEVQoMYOYyne2KW3lQEFN5PnFAqgQvDRQvkapWkob14rJjhg5
         MzFQ==
X-Gm-Message-State: AOAM532Cr7keBUPx4UlTGp/IBgc18Q1LBSAVhc1DPo1o59x2n23t1fQR
        A8n5MMBb+ZgBrU+6bUskoyLzlQ==
X-Google-Smtp-Source: ABdhPJxcKvaemzBTl73kbrRDUgwxoDNdc1YVk6iTA3PvkBjZBgHGlW/VsDW6/2iGMRJEBKgbCJFRbQ==
X-Received: by 2002:a05:6000:1445:: with SMTP id v5mr6930370wrx.412.1621360196158;
        Tue, 18 May 2021 10:49:56 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id h14sm27991329wrq.45.2021.05.18.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:49:55 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8516: remove 2 invalid i2c clocks
Date:   Tue, 18 May 2021 19:49:40 +0200
Message-Id: <20210518174940.2672318-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two clocks "main-source" and "main-sel" are not present in the
driver and not defined in the binding documentation. Remove them
as they are not used and not described in the documentation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 27 ++++++------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index bbe5a1419eff..d1b67c82d761 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -345,14 +345,9 @@ i2c0: i2c@11009000 {
 			reg = <0 0x11009000 0 0x90>,
 			      <0 0x11000180 0 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
-				 <&infracfg CLK_IFR_I2C0_SEL>,
-				 <&topckgen CLK_TOP_I2C0>,
+			clocks = <&topckgen CLK_TOP_I2C0>,
 				 <&topckgen CLK_TOP_APDMA>;
-			clock-names = "main-source",
-				      "main-sel",
-				      "main",
-				      "dma";
+			clock-names = "main", "dma";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -364,14 +359,9 @@ i2c1: i2c@1100a000 {
 			reg = <0 0x1100a000 0 0x90>,
 			      <0 0x11000200 0 0x80>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
-				 <&infracfg CLK_IFR_I2C1_SEL>,
-				 <&topckgen CLK_TOP_I2C1>,
+			clocks = <&topckgen CLK_TOP_I2C1>,
 				 <&topckgen CLK_TOP_APDMA>;
-			clock-names = "main-source",
-				      "main-sel",
-				      "main",
-				      "dma";
+			clock-names = "main", "dma";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -383,14 +373,9 @@ i2c2: i2c@1100b000 {
 			reg = <0 0x1100b000 0 0x90>,
 			      <0 0x11000280 0 0x80>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
-				 <&infracfg CLK_IFR_I2C2_SEL>,
-				 <&topckgen CLK_TOP_I2C2>,
+			clocks = <&topckgen CLK_TOP_I2C2>,
 				 <&topckgen CLK_TOP_APDMA>;
-			clock-names = "main-source",
-				      "main-sel",
-				      "main",
-				      "dma";
+			clock-names = "main", "dma";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.31.1

