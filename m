Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17B423203
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhJEUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:31:13 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:56930 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236267AbhJEUbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:31:11 -0400
Received: from localhost.localdomain (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 86371C9169;
        Tue,  5 Oct 2021 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1633465759; bh=caiZgo8/843g5GxiEcUJXyvFHNkUlh+M/VUHezDs/U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=sK8ycAW1lzqo8789qgSWNTfbDXo0yMpkDtlxfrLloMHJi0CasZYUw7jDIXqr1i8G+
         oFxb4zncyeWOD7O+l+JoFzNJGhYXmsxY1gFIjOV+CwTE5bnmnT+x9QMSkKB619qAPN
         1aBzkZm8E7VDQ55u07pF8blp6JZl4poROxKFarps=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-mediatek@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH 2/2] arm: dts: mt6589: Add device tree for Fairphone 1
Date:   Tue,  5 Oct 2021 22:28:31 +0200
Message-Id: <20211005202833.96526-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005202833.96526-1-luca@z3ntu.xyz>
References: <20211005202833.96526-1-luca@z3ntu.xyz>
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
 2 files changed, 31 insertions(+)
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
index 000000000000..32c14ecf2244
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
+	cpus {
+		/* SMP is not stable on this board, makes the kernel panic */
+		/delete-property/ enable-method;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
-- 
2.33.0

