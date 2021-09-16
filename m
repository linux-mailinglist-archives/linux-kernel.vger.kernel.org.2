Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921640ECAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbhIPV3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240571AbhIPV3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631827700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KwOcye6xrd0c2npUbIp4jFSKybstikwSzxh/d2AxRGI=;
        b=OPN4P1ffPCPp57fO5RxbR+jJfkHuqSkOKWQ/DlGq7a5vJDVfUmmd9VrKPU8FSMnBbDHOnU
        ElI5PURslIWLKpql7OHmgFX+eSyuDcU2Njiu+MOGAV1lX1pfbqFJxAIK8W85mdu4jOj+HY
        TxooQXM2/3uyZhTACzVQmSXcCEfinME=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-AryWSZt4NZ-xF49SWH0dHQ-1; Thu, 16 Sep 2021 17:28:19 -0400
X-MC-Unique: AryWSZt4NZ-xF49SWH0dHQ-1
Received: by mail-qt1-f200.google.com with SMTP id x28-20020ac8701c000000b0029f4b940566so72513683qtm.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwOcye6xrd0c2npUbIp4jFSKybstikwSzxh/d2AxRGI=;
        b=VcWuNkKss60Fy5zp5W6RcdY3HrX3JJ5f7BH6HX08ZZ6YygkSE+UlP+F8JUueE1MGht
         r1Ti+WxQ81hXfiCjpauLSN5+EedK4pUstaAvmJwSxBCiT7OIt7JFxtgmAWa3xM4vvw5W
         1mZQwdCbmwF/PfzjUhCZHnIaDS5wAqYf8SfuZkeBclf630+7rYbi7nN3vUmlTFnab9yr
         BSvlVIRvtwfWSHh9JlArkYbwyrtGTBFC52R2g5oUQd+Rz3+IcZrYLBf6XkPGmMtg9RuI
         17ZjFm1dYRdPFZimjpodmaXH3yxt98VbpZuqPUM62SD4a5eDoXhPbMlLTd+oIbkzHPAL
         gEyQ==
X-Gm-Message-State: AOAM531V/Bm7cYNfInaYmHmh7t95LNfZptVX4ipvXaRjnBtS3CTAWWqx
        VSHM9qHaJg1acw6fr3qdEvkJTRoi0mDDqXwXiWYOESpWvGV3D2O2m4j1IyZhR8tSLAB07gcILcc
        Srd47nfbaCQpfUmR5OCXOT0f6qBpWB7iLtNW7BQLwufs7yoYo4V1uuaNxntrm2fpvGHDi+hIN+Q
        ==
X-Received: by 2002:a05:620a:1474:: with SMTP id j20mr7273205qkl.305.1631827698897;
        Thu, 16 Sep 2021 14:28:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ49jI9h4n7NI+wShjsr09zEjaWktqmpBsEFP7CE4EAHNoYjJwQsKgyzXWvhgMN2My1dy2eg==
X-Received: by 2002:a05:620a:1474:: with SMTP id j20mr7273168qkl.305.1631827698421;
        Thu, 16 Sep 2021 14:28:18 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id w185sm3413567qkd.30.2021.09.16.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:28:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
Date:   Thu, 16 Sep 2021 17:28:16 -0400
Message-Id: <20210916212816.86838-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop it in the header since it's only used in hugetlb.c.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 10 ----------
 mm/hugetlb.c            |  6 +++---
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..3cbf60464398 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -143,9 +143,6 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
 			  struct page *ref_page);
-void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				unsigned long start, unsigned long end,
-				struct page *ref_page);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
@@ -385,13 +382,6 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	BUG();
 }
 
-static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
-			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
-{
-	BUG();
-}
-
 static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned int flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95dc7b83381f..d394d9545c4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4426,9 +4426,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	return ret;
 }
 
-void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			    unsigned long start, unsigned long end,
-			    struct page *ref_page)
+static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end,
+				   struct page *ref_page)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-- 
2.31.1

