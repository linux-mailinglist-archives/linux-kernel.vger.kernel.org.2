Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC1354A96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbhDFBsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:48:37 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50132 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239470AbhDFBsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:48:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUdsESP_1617673697;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UUdsESP_1617673697)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Apr 2021 09:48:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] csky: remove unused including <linux/version.h>
Date:   Tue,  6 Apr 2021 09:48:15 +0800
Message-Id: <1617673695-102193-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following versioncheck warnings:
./arch/csky/include/asm/io.h: 8 linux/version.h not needed.
./arch/csky/include/asm/uaccess.h: 14 linux/version.h not needed.
./arch/csky/kernel/process.c: 5 linux/version.h not needed.
./arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/csky/include/asm/io.h      | 1 -
 arch/csky/include/asm/uaccess.h | 1 -
 arch/csky/kernel/process.c      | 1 -
 arch/csky/mm/dma-mapping.c      | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index f826540..ed53f0b 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -5,7 +5,6 @@
 
 #include <linux/pgtable.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 /*
  * I/O memory access primitives. Reads are ordered relative to any
diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index 3dec272..841e421 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/string.h>
-#include <linux/version.h>
 #include <asm/segment.h>
 
 static inline int access_ok(const void *addr, unsigned long size)
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22..5de0470 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/debug.h>
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index c3a775a..8244702 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <asm/cache.h>
 
 static inline void cache_op(phys_addr_t paddr, size_t size,
-- 
1.8.3.1

