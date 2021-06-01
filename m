Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0395F397538
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhFAOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:18:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2830 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:18:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvYy20VLhzWqd1;
        Tue,  1 Jun 2021 22:12:10 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 22:16:51 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 22:16:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <axelrasmussen@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] userfaultfd: Remove set but not used variable 'vm_alloc_shared'
Date:   Tue, 1 Jun 2021 22:16:10 +0800
Message-ID: <20210601141610.28332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/userfaultfd.c: In function ‘__mcopy_atomic_hugetlb’:
mm/userfaultfd.c:284:6: warning: variable ‘vm_alloc_shared’ set but not used [-Wunused-but-set-variable]
  int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
      ^~~~~~~~~~~~~~~

commit 1786d0012620 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/userfaultfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 33fb405219e9..0e2132834bc7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -281,7 +281,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long len,
 					      enum mcopy_atomic_mode mode)
 {
-	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
 	pte_t *dst_pte;
@@ -380,7 +379,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
-		vm_alloc_shared = vm_shared;
 
 		cond_resched();
 
-- 
2.17.1

