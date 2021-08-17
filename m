Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0763EE4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHQC7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:59:13 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:33084 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhHQC7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:59:12 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17H2eV6e035575;
        Tue, 17 Aug 2021 10:40:31 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Aug
 2021 10:58:39 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <cyrilbur@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add mailbox to device tree
Date:   Tue, 17 Aug 2021 10:58:48 +0800
Message-ID: <20210817025848.19914-3-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
References: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17H2eV6e035575
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mailbox to the device tree for Aspeed AST24xx/AST25xx/AST26xx SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 8 +++++++-
 arch/arm/boot/dts/aspeed-g6.dtsi | 7 +++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c5aeb3cf3a09..6298d69df415 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -383,6 +383,13 @@
 					interrupts = <8>;
 					status = "disabled";
 				};
+
+				mbox: mbox@200 {
+					compatible = "aspeed,ast2500-mbox";
+					reg = <0x200 0x30>;
+					interrupts = <46>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial@1e78d000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 329eaeef66fb..ab9453d7803c 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -497,13 +497,19 @@
 					reg = <0xa0 0x24 0xc8 0x8>;
 				};
 
-
 				ibt: ibt@140 {
 					compatible = "aspeed,ast2500-ibt-bmc";
 					reg = <0x140 0x18>;
 					interrupts = <8>;
 					status = "disabled";
 				};
+
+				mbox: mbox@200 {
+					compatible = "aspeed,ast2500-mbox";
+					reg = <0x200 0x30>;
+					interrupts = <46>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial@1e78d000 {
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..09b286f2ece2 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -529,6 +529,13 @@
 					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
 				};
+
+				mbox: mbox@200 {
+					compatible = "aspeed,ast2600-mbox";
+					reg = <0x200 0xc0>;
+					interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
 			};
 
 			sdc: sdc@1e740000 {
-- 
2.17.1

