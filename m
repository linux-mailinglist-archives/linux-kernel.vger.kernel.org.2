Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9F33D087
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhCPJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:22:28 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:25824 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhCPJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:21:55 -0400
X-Greylist: delayed 1264 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 05:21:55 EDT
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 12G8q8H0007629
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 16:52:08 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 12G8oqqZ007507;
        Tue, 16 Mar 2021 16:50:52 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar
 2021 16:59:37 +0800
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     <wangzhiqiang.bj@bytedance.com>, <yulei.sh@bytedance.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <leetroy@gmail.com>
Subject: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash layout and aspeed-ast2600-evb.dts
Date:   Tue, 16 Mar 2021 08:59:32 +0000
Message-ID: <20210316085932.2601-1-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 12G8oqqZ007507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
openbmc-flash-layout-64.dtsi requires to resize the flash partition.

The updated flash layout as follows:
- u-boot: 896 KiB
- u-boot-env: 128 KiB
- kernel: 9MiB
- rofs: 32 MiB
- rwfs: 22 MiB

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 32 +------------------
 .../arm/boot/dts/openbmc-flash-layout-64.dtsi | 18 +++++------
 2 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 89be13197780..2cfae9cfed3a 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -121,37 +121,7 @@ flash@0 {
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			u-boot@0 {
-				reg = <0x0 0xe0000>; // 896KB
-				label = "u-boot";
-			};
-
-			u-boot-env@e0000 {
-				reg = <0xe0000 0x20000>; // 128KB
-				label = "u-boot-env";
-			};
-
-			kernel@100000 {
-				reg = <0x100000 0x900000>; // 9MB
-				label = "kernel";
-			};
-
-			rofs@a00000 {
-				reg = <0xa00000 0x2000000>; // 32MB
-				label = "rofs";
-			};
-
-			rwfs@6000000 {
-				reg = <0x2a00000 0x1600000>; // 22MB
-				label = "rwfs";
-			};
-		};
+#include "openbmc-flash-layout-64.dtsi"
 	};
 };
 
diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
index 91163867be34..31f59de5190b 100644
--- a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
+++ b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
@@ -9,27 +9,27 @@ partitions {
 	#size-cells = <1>;
 
 	u-boot@0 {
-		reg = <0x0 0x60000>; // 384KB
+		reg = <0x0 0xe0000>; // 896KB
 		label = "u-boot";
 	};
 
-	u-boot-env@60000 {
-		reg = <0x60000 0x20000>; // 128KB
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x20000>; // 128KB
 		label = "u-boot-env";
 	};
 
-	kernel@80000 {
-		reg = <0x80000 0x500000>; // 5MB
+	kernel@100000 {
+		reg = <0x100000 0x900000>; // 9MB
 		label = "kernel";
 	};
 
-	rofs@580000 {
-		reg = <0x580000 0x2a80000>; // 42.5MB
+	rofs@a00000 {
+		reg = <0xa00000 0x2000000>; // 32MB
 		label = "rofs";
 	};
 
-	rwfs@3000000 {
-		reg = <0x3000000 0x1000000>; // 16MB
+	rwfs@6000000 {
+		reg = <0x2a00000 0x1600000>; // 22MB
 		label = "rwfs";
 	};
 };
-- 
2.25.1

