Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A335063E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhCaSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:23:57 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:15066 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234641AbhCaSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:23:45 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 31 Mar 2021 11:23:41 -0700
Received: from vertex.vmware.com (unknown [10.16.120.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id C10DF20458;
        Wed, 31 Mar 2021 11:23:44 -0700 (PDT)
From:   Zack Rusin <zackr@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64/mm: Fix mapping_dirty_helpers with arm64
Date:   Wed, 31 Mar 2021 14:23:44 -0400
Message-ID: <20210331182344.47987-1-zackr@vmware.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: zackr@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pagetable walk callbacks in mm/mapping_dirty_helpers.c depend
on a set of helpers from which pud_dirty(pud) was missing. I'm
assuming mapping_dirty_helpers weren't used on ARM64 before
because the missing pud_dirty is causing a compilation error.

The drivers/gpu/drm/vmwgfx code uses mapping_dirty_helpers and
has been ported to ARM64 but it depends on this code getting in
first in order to compile/work.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Zack Rusin <zackr@vmware.com>
---
 arch/arm64/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 47027796c2f9..ecd80f87a996 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -451,6 +451,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
+#define pud_dirty(pud)		pte_dirty(pud_pte(pud))
 #define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
-- 
2.27.0

