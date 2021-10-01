Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859C741F01D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354689AbhJAO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:58:05 -0400
Received: from smtp1.axis.com ([195.60.68.17]:46771 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhJAO6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633100180;
  x=1664636180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nneyMtZGtx34ePHZsYIxkoE60h6gX36qpZm5kXUIvxQ=;
  b=bDpQDw+TyxB8GKFw9xOG+Ns7QA3oKbR7ooNQmkq20lLMDzvdCWA94StH
   fTc30btirfSuRjECMNN7aibXxOE/Uw5kTBMrmJ+10IFQrqLB1QcGzT8Lc
   +c1K9pevwV0qgpb7+PQgXisH+MVsZfcphSUYEbHZDD6QSWbemixl+UiSc
   KnucmuDZ4IIgmuNE3SGqVHGR6QJjEeJkv8+MPbfH30aWeQRbxGQ/iwNWR
   /3jY6hFuChKyyDddgRimfcdygAgaLpZxWd/I9mmRiUxOa5QwrE/TmDOD0
   zcCP94F0WCJDN8jr2duWOJg2GWFGdtI1iYqSLyZvzY/A6N+eBY+hnQ+MM
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: ptdump: Allow dumping user page tables
Date:   Fri, 1 Oct 2021 16:56:03 +0200
Message-ID: <20211001145603.22024-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user_page_tables debugfs file (similar to kernel_page_tables) to
dump out the userspace page tables for the current process.  This
provides details which are not available via pagemap (such as the memory
type) and is useful when, for example, debugging ->mmap()
implementations.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/arm64/mm/ptdump.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 1c403536c9bb..91a62f07eae2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -309,6 +309,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 {
+	struct mm_struct *mm = info->mm ?: current->mm;
 	unsigned long end = ~0UL;
 	struct pg_state st;
 
@@ -328,7 +329,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
+	ptdump_walk_pgd(&st.ptdump, mm, NULL);
 }
 
 static void __init ptdump_initialize(void)
@@ -347,6 +348,16 @@ static struct ptdump_info kernel_ptdump_info = {
 	.base_addr	= PAGE_OFFSET,
 };
 
+static struct addr_marker user_address_markers[] = {
+	{ 0,				"Userspace memory start" },
+	{ 0 /* TASK_SIZE_64 */,		"Userspace memory end" },
+	{ -1,				NULL },
+};
+
+static struct ptdump_info user_ptdump_info = {
+	.markers	= user_address_markers,
+};
+
 void ptdump_check_wx(void)
 {
 	struct pg_state st = {
@@ -381,8 +392,10 @@ static int __init ptdump_init(void)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
 #endif
+	user_address_markers[1].start_address = TASK_SIZE_64;
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	ptdump_debugfs_register(&user_ptdump_info, "user_page_tables");
 	return 0;
 }
 device_initcall(ptdump_init);
-- 
2.28.0

