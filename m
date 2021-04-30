Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92536F6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhD3H52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:57:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17827 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhD3H5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:57:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FWl4T18j5zBtLk;
        Fri, 30 Apr 2021 15:54:01 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 30 Apr 2021
 15:56:22 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH -next 3/4] riscv: mm: add param stride for __sbi_tlb_flush_range
Date:   Fri, 30 Apr 2021 16:28:49 +0800
Message-ID: <20210430082850.462609-4-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430082850.462609-1-sunnanyong@huawei.com>
References: <20210430082850.462609-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a parameter: stride for __sbi_tlb_flush_range(),
represent the page stride between the address of start and end.
Normally, the stride is PAGE_SIZE, and when flush huge page
address, the stride can be the huge page size such as:PMD_SIZE,
then it only need to flush one tlb entry if the address range
within PMD_SIZE.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/mm/tlbflush.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 720b443c4..382781abf 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -15,7 +15,7 @@ void flush_tlb_all(void)
  * Kernel may panic if cmask is NULL.
  */
 static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
-				  unsigned long size)
+				  unsigned long size, unsigned long stride)
 {
 	struct cpumask hmask;
 	unsigned int cpuid;
@@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 
 	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
 		/* local cpu is the only cpu present in cpumask */
-		if (size <= PAGE_SIZE)
+		if (size <= stride)
 			local_flush_tlb_page(start);
 		else
 			local_flush_tlb_all();
@@ -41,16 +41,16 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
+	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1, PAGE_SIZE);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
+	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
+	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start, PAGE_SIZE);
 }
-- 
2.25.1

