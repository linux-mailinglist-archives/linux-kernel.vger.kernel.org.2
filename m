Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6125539C651
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFEGh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:37:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4362 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:37:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FxqYZ5P6qz68VF;
        Sat,  5 Jun 2021 14:32:18 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:36:06 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:36:05 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] x86/mm: fix doc warnings in pgtable.c
Date:   Sat, 5 Jun 2021 14:45:19 +0800
Message-ID: <20210605064519.692571-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 arch/x86/mm/pgtable.c:621: warning: Function parameter or 
  member 'reserve' not described in 'reserve_top_address'
 arch/x86/mm/pgtable.c:670: warning:
  Function parameter or member 'p4d' not described in 'p4d_set_huge'
 arch/x86/mm/pgtable.c:670: warning:
  Function parameter or member 'addr' not described in 'p4d_set_huge'
 arch/x86/mm/pgtable.c:670: warning:
  Function parameter or member 'prot' not described in 'p4d_set_huge'
 arch/x86/mm/pgtable.c:680: warning:
  Function parameter or member 'p4d' not described in 'p4d_clear_huge'
 arch/x86/mm/pgtable.c:705: warning:
  Function parameter or member 'pud' not described in 'pud_set_huge'
 arch/x86/mm/pgtable.c:705: warning:
  Function parameter or member 'addr' not described in 'pud_set_huge'
 arch/x86/mm/pgtable.c:705: warning:
  Function parameter or member 'prot' not described in 'pud_set_huge'
 arch/x86/mm/pgtable.c:730: warning:
  Function parameter or member 'pud' not described in 'pud_clear_huge'
 arch/x86/mm/pgtable.c:749: warning:
  Function parameter or member 'pmd' not described in 'pmd_set_huge'
 arch/x86/mm/pgtable.c:749: warning:
  Function parameter or member 'addr' not described in 'pmd_set_huge'
 arch/x86/mm/pgtable.c:749: warning:
  Function parameter or member 'prot' not described in 'pmd_set_huge'
 arch/x86/mm/pgtable.c:777: warning:
  Function parameter or member 'pmd' not described in 'pmd_clear_huge'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/x86/mm/pgtable.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1303ff6ef7be..2d01a5d8ad85 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -612,7 +612,7 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
- * @reserve - size of hole to reserve
+ * @reserve: size of hole to reserve
  *
  * Can be used to relocate the fixmap area and poke a hole in the top
  * of kernel address space to make room for a hypervisor.
@@ -663,7 +663,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 #ifdef CONFIG_X86_5LEVEL
 /**
  * p4d_set_huge - setup kernel P4D mapping
- *
+ * @p4d: Pointer to a P4D.
+ * @addr: Virtual address associated with p4d.
+ * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE.
  * No 512GB pages yet -- always return 0
  */
 int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
@@ -673,7 +675,7 @@ int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 
 /**
  * p4d_clear_huge - clear kernel P4D mapping when it is set
- *
+ * @p4d: Pointer to a P4D.
  * No 512GB pages yet -- always return 0
  */
 int p4d_clear_huge(p4d_t *p4d)
@@ -685,7 +687,9 @@ int p4d_clear_huge(p4d_t *p4d)
 #if CONFIG_PGTABLE_LEVELS > 3
 /**
  * pud_set_huge - setup kernel PUD mapping
- *
+ * @pud: Pointer to a PUD.
+ * @addr: Virtual address associated with pud.
+ * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE.
  * MTRRs can override PAT memory types with 4KiB granularity. Therefore, this
  * function sets up a huge page only if any of the following conditions are met:
  *
@@ -723,7 +727,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 
 /**
  * pud_clear_huge - clear kernel PUD mapping when it is set
- *
+ * @pud: Pointer to a PUD.
  * Returns 1 on success and 0 on failure (no PUD map is found).
  */
 int pud_clear_huge(pud_t *pud)
@@ -740,7 +744,9 @@ int pud_clear_huge(pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 2
 /**
  * pmd_set_huge - setup kernel PMD mapping
- *
+ * @pmd: Pointer to a PMD.
+ * @addr: Virtual address associated with pmd.
+ * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE.
  * See text over pud_set_huge() above.
  *
  * Returns 1 on success and 0 on failure.
@@ -770,7 +776,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 
 /**
  * pmd_clear_huge - clear kernel PMD mapping when it is set
- *
+ * @pmd: Pointer to a PMD.
  * Returns 1 on success and 0 on failure (no PMD map is found).
  */
 int pmd_clear_huge(pmd_t *pmd)
-- 
2.31.1

