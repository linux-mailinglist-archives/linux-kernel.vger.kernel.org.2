Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6F31222C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 08:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBGHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 02:09:09 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60466 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:09:00 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 03FB62A7EE; Sun,  7 Feb 2021 02:08:18 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <baa95d7235921dff23bed6320518f3fa90396603.1612681353.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k: Drop -fno-strength-reduce from KBUILD_CFLAGS
Date:   Sun, 07 Feb 2021 18:02:33 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This workaround became redundant either when the driver in question was
removed (in Linux v2.6.23) or when the compiler flag became a no-op
(in GCC v4.2). Linux has required GCC v4.6 or later since v4.19.

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=efa1cdf01850b28c2f6f7035ebd4420259494615
References: commit 565bae6a4a8f ("[SCSI] 53c7xx: kill driver")
References: commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index ea14f2046fb4..5be4efec173a 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -66,8 +66,7 @@ KBUILD_CFLAGS += $(cpuflags-y)
 KBUILD_CFLAGS += -pipe -ffreestanding
 
 ifdef CONFIG_MMU
-# without -fno-strength-reduce the 53c7xx.c driver fails ;-(
-KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2
+KBUILD_CFLAGS += -ffixed-a2
 else
 # we can use a m68k-linux-gcc toolchain with these in place
 KBUILD_CPPFLAGS += -DUTS_SYSNAME=\"uClinux\"
-- 
2.26.2

