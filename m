Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC9327ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhCAJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhCAJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:34:42 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00818C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 01:33:51 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:a919:815c:214e:7a7a])
        by albert.telenet-ops.be with bizsmtp
        id axZo240051uxGh006xZooL; Mon, 01 Mar 2021 10:33:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lGevz-002vmt-Om; Mon, 01 Mar 2021 10:33:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lGevz-00BF6Y-7Y; Mon, 01 Mar 2021 10:33:47 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.12-rc1
Date:   Mon,  1 Mar 2021 10:33:46 +0100
Message-Id: <20210301093346.2679625-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Drop CONFIG_CRYPTO_RMD128=m (removed in commit b21b9a5e0aef025a
    ("crypto: rmd128 - remove RIPE-MD 128 hash algorithm")),
  - Drop CONFIG_CRYPTO_RMD256=m (removed in commit c15d4167f0b0465b
    ("crypto: rmd256 - remove RIPE-MD 256 hash algorithm")),
  - Drop CONFIG_CRYPTO_RMD320=m (removed in commit 93f64202926f606d
    ("crypto: rmd320 - remove RIPE-MD 320 hash algorithm")),
  - Drop CONFIG_CRYPTO_TGR192=m (removed in commit 87cd723f8978c59b
    ("crypto: tgr192 - remove Tiger 128/160/192 hash algorithms")),
  - Drop CONFIG_CRYPTO_SALSA20=m (removed in commit 663f63ee6d9cdc68
    ("crypto: salsa20 - remove Salsa20 stream cipher algorithm")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued for v5.13.

 arch/m68k/configs/amiga_defconfig    | 5 -----
 arch/m68k/configs/apollo_defconfig   | 5 -----
 arch/m68k/configs/atari_defconfig    | 5 -----
 arch/m68k/configs/bvme6000_defconfig | 5 -----
 arch/m68k/configs/hp300_defconfig    | 5 -----
 arch/m68k/configs/mac_defconfig      | 5 -----
 arch/m68k/configs/multi_defconfig    | 5 -----
 arch/m68k/configs/mvme147_defconfig  | 5 -----
 arch/m68k/configs/mvme16x_defconfig  | 5 -----
 arch/m68k/configs/q40_defconfig      | 5 -----
 arch/m68k/configs/sun3_defconfig     | 5 -----
 arch/m68k/configs/sun3x_defconfig    | 5 -----
 12 files changed, 60 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 786656090c502956..59b727b693575eb3 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -580,12 +580,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -598,7 +594,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 9bb12be4a38e8a36..8d4ddcebe7b8d2e5 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -536,12 +536,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -554,7 +550,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 47b911cca9a39ad6..b0afb5a4270a230d 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -568,12 +568,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -586,7 +582,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 819cc70b06d8663d..c3f3f462e6ce6fa5 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -529,12 +529,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -547,7 +543,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 8f8d5968713bfe2d..8c908fc5c1910aa0 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -538,12 +538,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -556,7 +552,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index bf15e6c1c939bb30..4e68b72d9c50f15b 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -561,12 +561,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -579,7 +575,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 5466d48fcd9d51c9..d31896293c394c21 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -647,12 +647,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -665,7 +661,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 93c3059188389742..c7442f9dd469a19e 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -528,12 +528,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -546,7 +542,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index cacd6c617f6951ee..233b82ea103a448b 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -529,12 +529,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -547,7 +543,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 3ae421cb24a43986..664025a0f6a4173e 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -547,12 +547,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -565,7 +561,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 6da97e28c48ef66e..73293a0b3dc86e58 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -531,12 +531,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -549,7 +545,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index f54481bb789aecb8..bca8a6f3e92f55a8 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -530,12 +530,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -548,7 +544,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
-- 
2.25.1

