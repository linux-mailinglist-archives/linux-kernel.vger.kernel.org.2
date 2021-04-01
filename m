Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C07350CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhDACXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:23:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14980 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhDACXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:23:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9n4J4350zyNmV;
        Thu,  1 Apr 2021 10:21:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 10:23:33 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 3/3] mm/debug_vm_pgtable: Remove useless pfn_pmd()
Date:   Thu, 1 Apr 2021 10:23:15 +0800
Message-ID: <20210401022315.2911967-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401022315.2911967-1-liushixin2@huawei.com>
References: <20210401022315.2911967-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to pfn_pmd() here is redundant.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 mm/debug_vm_pgtable.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c379bbe42c2a..9f4c4a114229 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -196,7 +196,6 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 
 	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
 
-	pmd = pfn_pmd(pfn, prot);
 	set_pmd_at(mm, vaddr, pmdp, pmd);
 	pmdp_set_wrprotect(mm, vaddr, pmdp);
 	pmd = READ_ONCE(*pmdp);
-- 
2.25.1

