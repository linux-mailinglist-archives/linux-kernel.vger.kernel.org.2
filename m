Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CB41465E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhIVKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:33:58 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:38347 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbhIVKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:33:45 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB9Ko012569;
        Wed, 22 Sep 2021 18:11:09 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 18:31:27 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <adrian.hunter@intel.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <andrew@aj.id.au>
CC:     <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 07/10] arm: dts: aspeed: Adjust clock phase parameter
Date:   Wed, 22 Sep 2021 18:31:13 +0800
Message-ID: <20210922103116.30652-8-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB9Ko012569
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change clock phase degree for AST2600 EVB.
These parameter has been verified with 100MHz
clock frequency for eMMC and SD controllers.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 8 ++++++++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts    | 9 ++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
index dd7148060c4a..2d83617dc436 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
@@ -13,3 +13,11 @@
 };
 
 /delete-node/ &sdc;
+
+&emmc_controller {
+	max-tap-delay = <706>;
+};
+
+&emmc {
+	clk-phase-mmc-hs200 = <0 13>, <1 103>;
+};
diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 4551dba499c2..f728b9d9b4cf 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -143,13 +143,15 @@
 
 &emmc_controller {
 	status = "okay";
+	/* Measured value with *handwave* environmentals and static loading */
+	max-tap-delay = <736>;
 };
 
 &emmc {
 	non-removable;
 	bus-width = <4>;
 	max-frequency = <100000000>;
-	clk-phase-mmc-hs200 = <9>, <225>;
+	clk-phase-mmc-hs200 = <0 27>, <1 95>;
 };
 
 &rtc {
@@ -260,6 +262,7 @@
 
 &sdc {
 	status = "okay";
+	max-tap-delay = <9000>;
 };
 
 /*
@@ -287,7 +290,7 @@
 	sdhci,wp-inverted;
 	vmmc-supply = <&vcc_sdhci0>;
 	vqmmc-supply = <&vccq_sdhci0>;
-	clk-phase-sd-hs = <7>, <200>;
+	clk-phase-uhs-sdr50 = <0 130>, <0 238>;
 };
 
 &sdhci1 {
@@ -300,5 +303,5 @@
 	sdhci,wp-inverted;
 	vmmc-supply = <&vcc_sdhci1>;
 	vqmmc-supply = <&vccq_sdhci1>;
-	clk-phase-sd-hs = <7>, <200>;
+	clk-phase-uhs-sdr50 = <0 130>, <0 130>;
 };
-- 
2.17.1

