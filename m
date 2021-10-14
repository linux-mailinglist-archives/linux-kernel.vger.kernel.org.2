Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798DC42D49D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhJNIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:16:55 -0400
Received: from smtp2.axis.com ([195.60.68.18]:22820 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhJNIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1634199290;
  x=1665735290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jqzWJagmMka35I1jTQxy69b1ENpxS5l5bPm2vf4qNJE=;
  b=G8ZE4aZvnW6ONE/nyV5KWYbkqIiXxcrCER6edv9hez5ftTqCUyX1JrF+
   BTr9QWAVzmETyY+gIyIyJzyZK0LTTbnnXDwDIM/pLL3PzHDkuUQR+9j29
   MMDTP9gA1IK/g/WGnqdfA/298Q5LwXreg9ocUOaKozbF5A1tO8Ml7LuB5
   rJwkHRPTwZ+mVrUKGOooH52mTk2YMpYMnttpoQKqlSyRL3OqQ3bmpQX7c
   0M6ClNM8I0pkPY+sEsbCT4b/e/VW3dka7pKIm72ZmufGpHu9LTmNX9t4U
   6mpTzAGYEu5J8qsQdNPZNqr6dQpdWrraCT231R/ns+S9p+2EXmvvziiXF
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: ptdump: Support userspace page tables
Date:   Thu, 14 Oct 2021 10:14:41 +0200
Message-ID: <20211014081441.7982-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel_page_tables debugfs file can be used to examine the page
table entries for mappings in kernel space but there is currently no
easy way to check userspace mappings.  /proc/*/pagemap provides some
information but it does not include architecture-specific details such
as the memory type (Normal, Device etc).

Add a user_page_tables debugfs file to dump out the userspace page
tables for the current process.  This is enabled by the same config
options as kernel_page_tables.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2: Reworded commit message.

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

