Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C94387B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJXIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 04:48:34 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:39728 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXIsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 04:48:33 -0400
Received: from localhost.localdomain (ip-213-127-63-241.ip.prioritytelecom.net [213.127.63.241])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 20B91C6C78;
        Sun, 24 Oct 2021 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1635065172; bh=MNGJb5x5e9bvi6TMYXpldSbHD+QFVn7vCYvD1jNOx5g=;
        h=From:To:Cc:Subject:Date;
        b=ZFpGK+m/ztWbYs29/omZeQw80VQNdOgfuyQJl4AqCJN+wG0CbLP0ULFVtYqLFnlw/
         hXbbJZoyzgL/mbDKEMvAXbYf0HoFizw8QUiJsoLev500RU8V7weB/9wwJ0HtZi1duP
         K1zu+G+WuMg5pFK/lQhWMK0HaiR2cdIhE8w3Jlug=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-mediatek@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: dts: mt6589: Add device tree for Fairphone 1
Date:   Sun, 24 Oct 2021 10:45:35 +0200
Message-Id: <20211024084535.30959-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rudimentary support for the Fairphone 1, based on MT6589 to boot to
UART console.

The recently added SMP support needs to be disabled for this board as
the kernel panics executing /init with it, even though the CPUs seem to
start up fine - maybe a stability issue.

[    0.072010] smp: Bringing up secondary CPUs ...
[    0.131888] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.191889] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.251890] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.251982] smp: Brought up 1 node, 4 CPUs
[    0.254745] SMP: Total of 4 processors activated (7982.28 BogoMIPS).
[    0.255582] CPU: All CPU(s) started in SVC mode.

[    0.472039] Run /init as init process
[    0.473317] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/mt6589-fairphone-fp1.dts | 30 ++++++++++++++++++++++
 arch/arm/boot/dts/mt6589.dtsi              |  2 +-
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mt6589-fairphone-fp1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..24f402db2613 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1437,6 +1437,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt2701-evb.dtb \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
+	mt6589-fairphone-fp1.dtb \
 	mt6592-evb.dtb \
 	mt7623a-rfb-emmc.dtb \
 	mt7623a-rfb-nand.dtb \
diff --git a/arch/arm/boot/dts/mt6589-fairphone-fp1.dts b/arch/arm/boot/dts/mt6589-fairphone-fp1.dts
new file mode 100644
index 000000000000..c952347981de
--- /dev/null
+++ b/arch/arm/boot/dts/mt6589-fairphone-fp1.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Luca Weiss <luca@z3ntu.xyz>
+ */
+
+/dts-v1/;
+#include "mt6589.dtsi"
+
+/ {
+	model = "Fairphone 1";
+	compatible = "fairphone,fp1", "mediatek,mt6589";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&cpus {
+	/* SMP is not stable on this board, makes the kernel panic */
+	/delete-property/ enable-method;
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index 70df00a7bb26..c6babc8ad2ba 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -14,7 +14,7 @@ / {
 	compatible = "mediatek,mt6589";
 	interrupt-parent = <&sysirq>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		enable-method = "mediatek,mt6589-smp";
-- 
2.33.1

