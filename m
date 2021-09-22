Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C9414664
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhIVKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:34:01 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:47722 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhIVKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:33:45 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB9Cp012570;
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
Subject: [PATCH 08/10] arm: dts: ibm: Adjust clock phase parameter
Date:   Wed, 22 Sep 2021 18:31:14 +0800
Message-ID: <20210922103116.30652-9-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB9Cp012570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add max-tap-delay property for eMMC controller.
- Change clock phase degree for AST2600 on IBM platforms.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 3 ++-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 3 ++-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 2efd70666738..eccb4749755a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -2824,6 +2824,7 @@
 
 &emmc_controller {
 	status = "okay";
+	max-tap-delay = <1253>;
 };
 
 &pinctrl_emmc_default {
@@ -2832,7 +2833,7 @@
 
 &emmc {
 	status = "okay";
-	clk-phase-mmc-hs200 = <210>, <228>;
+	clk-phase-mmc-hs200 = <1 124>, <1 141>;
 };
 
 &fsim0 {
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 6419c9762c0b..2138a8a10d6e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -299,6 +299,7 @@
 
 &emmc_controller {
 	status = "okay";
+	max-tap-delay = <1253>;
 };
 
 &pinctrl_emmc_default {
@@ -307,7 +308,7 @@
 
 &emmc {
 	status = "okay";
-	clk-phase-mmc-hs200 = <180>, <180>;
+	clk-phase-mmc-hs200 = <1 90>, <1 90>;
 };
 
 &fsim0 {
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index e39f310d55eb..7427809354cc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -182,11 +182,12 @@
 
 &emmc_controller {
 	status = "okay";
+	max-tap-delay = <1253>;
 };
 
 &emmc {
 	status = "okay";
-	clk-phase-mmc-hs200 = <36>, <270>;
+	clk-phase-mmc-hs200 = <0 40>, <1 181>;
 };
 
 &fsim0 {
-- 
2.17.1

