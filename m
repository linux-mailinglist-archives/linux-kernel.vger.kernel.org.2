Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5644D3D5341
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhGZF4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:56:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231916AbhGZF4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:56:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 148B6139F;
        Sun, 25 Jul 2021 23:36:53 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED64B3F66F;
        Sun, 25 Jul 2021 23:36:48 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 01/10] mm/mmap: Dynamically initialize protection_map[]
Date:   Mon, 26 Jul 2021 12:07:16 +0530
Message-Id: <1627281445-12445-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protection_map[] elements (__PXXX and __SXXX) might sometimes contain
runtime variables in certain platforms like arm64 preventing a successful
build because of the current static initialization. So it just defers the
initialization until mmmap_init() via a new helper init_protection_map().

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ca54d36..a95b078 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -100,10 +100,7 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-pgprot_t protection_map[16] __ro_after_init = {
-	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
-	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
-};
+pgprot_t protection_map[16] __ro_after_init;
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
@@ -3708,6 +3705,26 @@ void mm_drop_all_locks(struct mm_struct *mm)
 	mutex_unlock(&mm_all_locks_mutex);
 }
 
+static void init_protection_map(void)
+{
+	protection_map[0] = __P000;
+	protection_map[1] = __P001;
+	protection_map[2] = __P010;
+	protection_map[3] = __P011;
+	protection_map[4] = __P100;
+	protection_map[5] = __P101;
+	protection_map[6] = __P110;
+	protection_map[7] = __P111;
+	protection_map[8] = __S000;
+	protection_map[9] = __S001;
+	protection_map[10] = __S010;
+	protection_map[11] = __S011;
+	protection_map[12] = __S100;
+	protection_map[13] = __S101;
+	protection_map[14] = __S110;
+	protection_map[15] = __S111;
+}
+
 /*
  * initialise the percpu counter for VM
  */
@@ -3715,6 +3732,7 @@ void __init mmap_init(void)
 {
 	int ret;
 
+	init_protection_map();
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
 }
-- 
2.7.4

