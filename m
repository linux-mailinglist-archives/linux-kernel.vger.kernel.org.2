Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4AF346260
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhCWPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhCWPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:08:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1EDC061574;
        Tue, 23 Mar 2021 08:08:06 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2DED422234;
        Tue, 23 Mar 2021 16:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616512082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mQv2eUlCFp1YMKXl18DrM9D8t/dhYArvTOgcJf+ABt4=;
        b=GfwiA+slBvuAFHE4nlLigsMCCLhPo63I/J81AHYhr6zTK2EZj8rJNqjZHJ3jWav5zgIKBY
        maAuZgqtPrReDukRxCHzIaXyPjXqZCJ1xTJDNJglV/Xz+xhbpyjafmomRJxp9K29tSmuj/
        InVbMbPmyuWMPZCMBuB7AlpAer5r5Aw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: dts: ls1028a: move rtc alias to individual boards
Date:   Tue, 23 Mar 2021 16:07:56 +0100
Message-Id: <20210323150757.3771-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aliases are board-specific and shouldn't be included in the common
SoC dtsi. Move them over to the boards.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts          | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts          | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi             | 4 ----
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 576fc04cbce4..09f0b11d5705 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -25,6 +25,7 @@
 		spi1 = &dspi2;
 		mmc0 = &esdhc1;
 		mmc1 = &esdhc;
+		rtc1 = &ftm_alarm0;
 	};
 
 	buttons0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index fbcba9cb8503..bfd14b64567e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -25,6 +25,7 @@
 		serial1 = &duart1;
 		mmc0 = &esdhc;
 		mmc1 = &esdhc1;
+		rtc1 = &ftm_alarm0;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 41ae6e7675ba..9322c6ad8e4a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -21,6 +21,7 @@
 		serial1 = &duart1;
 		mmc0 = &esdhc;
 		mmc1 = &esdhc1;
+		rtc1 = &ftm_alarm0;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index c1b33ac7d887..9506f0669ead 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -18,10 +18,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		rtc1 = &ftm_alarm0;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.20.1

