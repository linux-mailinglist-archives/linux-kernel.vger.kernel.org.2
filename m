Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9D38E1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhEXHl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:41:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhEXHl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:41:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0633FED1;
        Mon, 24 May 2021 00:39:57 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.81.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3DB63F73B;
        Mon, 24 May 2021 00:39:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Make vmemmap_free() available only with CONFIG_MEMORY_HOTPLUG
Date:   Mon, 24 May 2021 13:10:30 +0530
Message-Id: <1621842030-23256-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmemmap_free() callsites (mm/sparse.c) and declaration (include/linux/mm.h)
are protected with CONFIG_MEMORY_HOTPLUG. This function is not required if
CONFIG_MEMORY_HOTPLUG is not enabled. Hence move the config wrapper outside
the function definition.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc3

 arch/arm64/mm/mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e3b639e2461d..207d5f26c004 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1167,16 +1167,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return 0;
 }
 #endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
+
+#ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
-#ifdef CONFIG_MEMORY_HOTPLUG
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
 	unmap_hotplug_range(start, end, true, altmap);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
-#endif
 }
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 static inline pud_t *fixmap_pud(unsigned long addr)
 {
-- 
2.20.1

