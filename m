Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24918324C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhBYJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:16:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46538 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236196AbhBYJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:13:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPXPpzL_1614244379;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPXPpzL_1614244379)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 17:13:00 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] powerpc: Replace DEFINE_SIMPLE_ATTRIBUTE with  DEFINE_DEBUGFS_ATTRIBUTE
Date:   Thu, 25 Feb 2021 17:12:58 +0800
Message-Id: <1614244378-63152-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./arch/powerpc/kernel/setup_64.c:1143:0-23: WARNING: fops_rfi_flush
should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/kernel/setup_64.c:1169:0-23: WARNING: fops_entry_flush
should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/kernel/setup_64.c:1195:0-23: WARNING: fops_uaccess_flush
should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/platforms/powernv/memtrace.c:311:0-23: WARNING:
memtrace_init_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/xmon/xmon.c:3997:0-23: WARNING: xmon_dbgfs_ops should be
defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/kernel/setup_64.c            | 6 +++---
 arch/powerpc/platforms/powernv/memtrace.c | 4 ++--
 arch/powerpc/xmon/xmon.c                  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 560ed8b..6a030b0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -1140,7 +1140,7 @@ static int rfi_flush_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
 
 static int entry_flush_set(void *data, u64 val)
 {
@@ -1166,7 +1166,7 @@ static int entry_flush_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_entry_flush, entry_flush_get, entry_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_entry_flush, entry_flush_get, entry_flush_set, "%llu\n");
 
 static int uaccess_flush_set(void *data, u64 val)
 {
@@ -1192,7 +1192,7 @@ static int uaccess_flush_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_uaccess_flush, uaccess_flush_get, uaccess_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_uaccess_flush, uaccess_flush_get, uaccess_flush_set, "%llu\n");
 
 static __init int rfi_flush_debugfs_init(void)
 {
diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 019669e..731be02 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -308,8 +308,8 @@ static int memtrace_enable_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(memtrace_init_fops, memtrace_enable_get,
-					memtrace_enable_set, "0x%016llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(memtrace_init_fops, memtrace_enable_get,
+			 memtrace_enable_set, "0x%016llx\n");
 
 static int memtrace_init(void)
 {
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3fe3749..6d54767 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3994,7 +3994,7 @@ static int xmon_dbgfs_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(xmon_dbgfs_ops, xmon_dbgfs_get,
+DEFINE_DEBUGFS_ATTRIBUTE(xmon_dbgfs_ops, xmon_dbgfs_get,
 			xmon_dbgfs_set, "%llu\n");
 
 static int __init setup_xmon_dbgfs(void)
-- 
1.8.3.1

