Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB3327D27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhCAL0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:26:51 -0500
Received: from foss.arm.com ([217.140.110.172]:55054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233029AbhCALZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:25:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB6701FB;
        Mon,  1 Mar 2021 03:24:47 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0FF23F73C;
        Mon,  1 Mar 2021 03:24:45 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop THP conditionality from FORCE_MAX_ZONEORDER
Date:   Mon,  1 Mar 2021 16:55:14 +0530
Message-Id: <1614597914-28565-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently without THP being enabled, MAX_ORDER via FORCE_MAX_ZONEORDER gets
reduced to 11, which falls below HUGETLB_PAGE_ORDER for certain 16K and 64K
page size configurations. This is problematic which throws up the following
warning during boot as pageblock_order via HUGETLB_PAGE_ORDER order exceeds
MAX_ORDER.

WARNING: CPU: 7 PID: 127 at mm/vmstat.c:1092 __fragmentation_index+0x58/0x70
Modules linked in:
CPU: 7 PID: 127 Comm: kswapd0 Not tainted 5.12.0-rc1-00005-g0221e3101a1 #237
Hardware name: linux,dummy-virt (DT)
pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
pc : __fragmentation_index+0x58/0x70
lr : fragmentation_index+0x88/0xa8
sp : ffff800016ccfc00
x29: ffff800016ccfc00 x28: 0000000000000000 
x27: ffff800011fd4000 x26: 0000000000000002 
x25: ffff800016ccfda0 x24: 0000000000000002 
x23: 0000000000000640 x22: ffff0005ffcb5b18 
x21: 0000000000000002 x20: 000000000000000d 
x19: ffff0005ffcb3980 x18: 0000000000000004 
x17: 0000000000000001 x16: 0000000000000019 
x15: ffff800011ca7fb8 x14: 00000000000002b3 
x13: 0000000000000000 x12: 00000000000005e0 
x11: 0000000000000003 x10: 0000000000000080 
x9 : ffff800011c93948 x8 : 0000000000000000 
x7 : 0000000000000000 x6 : 0000000000007000 
x5 : 0000000000007944 x4 : 0000000000000032 
x3 : 000000000000001c x2 : 000000000000000b 
x1 : ffff800016ccfc10 x0 : 000000000000000d 
Call trace:
__fragmentation_index+0x58/0x70
compaction_suitable+0x58/0x78
wakeup_kcompactd+0x8c/0xd8
balance_pgdat+0x570/0x5d0
kswapd+0x1e0/0x388
kthread+0x154/0x158
ret_from_fork+0x10/0x30

This solves the problem via keeping FORCE_MAX_ZONEORDER unchanged with or
without THP on 16K and 64K page size configurations, making sure that the
HUGETLB_PAGE_ORDER (and pageblock_order) would never exceed MAX_ORDER.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.12-rc1 and does not seem to have any obvious problem
on 16K and 64K page size configurations. This is a simpler alternate to
a previous series [1] which tried to solve the very same problem but in
a different way.

https://patchwork.kernel.org/project/linux-mm/list/?series=431973

 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9cd33c7be429..d4690326274a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1156,8 +1156,8 @@ config XEN
 
 config FORCE_MAX_ZONEORDER
 	int
-	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
-	default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
+	default "14" if ARM64_64K_PAGES
+	default "12" if ARM64_16K_PAGES
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
2.20.1

