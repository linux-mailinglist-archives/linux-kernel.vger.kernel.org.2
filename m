Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5400A351447
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhDALLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 07:11:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15573 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhDALLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:11:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FB0mD68hfz1BFTB;
        Thu,  1 Apr 2021 19:08:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 19:10:26 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>
Subject: [PATCH -next] hugetlb: Fix the loss of exclamation point in comment
Date:   Thu, 1 Apr 2021 11:18:15 +0000
Message-ID: <20210401111815.997878-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "else" and "endif" comment, it loses the exclamation point.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 include/linux/hugetlb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a7f7d5f328dc..c5fb0035c13a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -873,7 +873,7 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
-#else	/* CONFIG_HUGETLB_PAGE */
+#else	/* !CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
@@ -1026,7 +1026,7 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
-#endif	/* CONFIG_HUGETLB_PAGE */
+#endif	/* !CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
-- 
2.25.1

