Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D24502FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhKOLED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbhKOLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:02:34 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C40C06120A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:59:34 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9ddb:b7d5:eb58:4276])
        by michel.telenet-ops.be with bizsmtp
        id JazW2600Q3F42dW06azWN8; Mon, 15 Nov 2021 11:59:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mmZhy-00Cewj-FP; Mon, 15 Nov 2021 11:59:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mmZYj-008kAB-EX; Mon, 15 Nov 2021 11:49:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.16-rc1
Date:   Mon, 15 Nov 2021 11:49:56 +0100
Message-Id: <20211115104956.2084032-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Drop CONFIG_MCTP=m (can no longer be modular since commit
    78476d315e190533 ("mctp: Add flow extension to skb")),
  - Drop CONFIG_BLK_DEV_CRYPTOLOOP=m (removed in commit 47e9624616c80c98
    ("block: remove support for cryptoloop and the xor transfer")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v5.17 branch.

 arch/m68k/configs/amiga_defconfig    | 2 --
 arch/m68k/configs/apollo_defconfig   | 2 --
 arch/m68k/configs/atari_defconfig    | 2 --
 arch/m68k/configs/bvme6000_defconfig | 2 --
 arch/m68k/configs/hp300_defconfig    | 2 --
 arch/m68k/configs/mac_defconfig      | 2 --
 arch/m68k/configs/multi_defconfig    | 2 --
 arch/m68k/configs/mvme147_defconfig  | 2 --
 arch/m68k/configs/mvme16x_defconfig  | 2 --
 arch/m68k/configs/q40_defconfig      | 2 --
 arch/m68k/configs/sun3_defconfig     | 2 --
 arch/m68k/configs/sun3x_defconfig    | 2 --
 12 files changed, 24 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index e2b14ea9934236ed..a4b6c7108465796b 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -302,7 +302,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -317,7 +316,6 @@ CONFIG_PARPORT_1284=y
 CONFIG_AMIGA_FLOPPY=y
 CONFIG_AMIGA_Z2RAM=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 41f3f3b738b3e042..2db721965520252b 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -298,7 +298,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -307,7 +306,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index b06038d3d7bd7c3b..1097a617fc686b00 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -305,7 +305,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -318,7 +317,6 @@ CONFIG_PARPORT_ATARI=m
 CONFIG_PARPORT_1284=y
 CONFIG_ATARI_FLOPPY=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 11a19f87e5864bec..f644f08dd6ed886a 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -295,7 +295,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -304,7 +303,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index ee981271476a8ed3..e4924650b6875441 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -297,7 +297,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -306,7 +305,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index a48656d328dd10ce..24113871ea769888 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -299,7 +299,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -309,7 +308,6 @@ CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_SWIM=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b9b7a5cc6a1e6652..6a7e4be70eea9a3f 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -319,7 +319,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -338,7 +337,6 @@ CONFIG_ATARI_FLOPPY=y
 CONFIG_BLK_DEV_SWIM=m
 CONFIG_AMIGA_Z2RAM=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 3887b1c9c5fdca7b..1d223247aff08feb 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -294,7 +294,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -303,7 +302,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 19e5992bba6caa94..961f789f96c9470a 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -295,7 +295,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -304,7 +303,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index af25efaa32967722..ff4b5e469390b577 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -296,7 +296,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -308,7 +307,6 @@ CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
 CONFIG_PARPORT_1284=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 14dd96d3f5efde48..5f228621d0ccbb0f 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -292,7 +292,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -301,7 +300,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 8ac2402ac334ad3f..a600cb9e68c2567a 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -292,7 +292,6 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_NSH=m
 CONFIG_AF_KCM=m
-CONFIG_MCTP=m
 # CONFIG_WIRELESS is not set
 CONFIG_PSAMPLE=m
 CONFIG_NET_IFE=m
@@ -301,7 +300,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-- 
2.25.1

