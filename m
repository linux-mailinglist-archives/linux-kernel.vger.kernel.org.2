Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24803CADB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbhGOUTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245153AbhGOUTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlkC2X960t2EN/CZQ9J+R9eQf4JoaOaAVaibAmcHcE8=;
        b=FePoKYOVBcK5pQ3mrMzKnipatn3I5AYCkMPdt7AGOxnbjBOJfXqfPkvo5THW++wIUSU81m
        8Cg/ukui2GIZ/pAAqaTHgWknIlMWfGyx395U23uQi8bRGOPzU3I2aWVtQmieiYnXMfidfY
        OXwLPRTi8VKYwThfhYtQXdoUrqCAuQA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-jNYB_cd2MNekqFJvDosmpw-1; Thu, 15 Jul 2021 16:16:18 -0400
X-MC-Unique: jNYB_cd2MNekqFJvDosmpw-1
Received: by mail-qk1-f199.google.com with SMTP id u9-20020a05620a0229b02903b8eff05707so647879qkm.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TlkC2X960t2EN/CZQ9J+R9eQf4JoaOaAVaibAmcHcE8=;
        b=CboPxT79RSUVd7IAlhELFoLcQc4X+kZUARGOZyRV7nHH0kHxL3y5qt7CmpXI5VtRGG
         InfZLMnbXvf2w1SA4CQt1vcT8s5kyr+eeUBmxXFdINLt/81k6c2nKYt9CEdnSO2uwBDU
         IKn6ZtbhJC2s+vaoLrmKjty2PeZQ42kaIvSr7vlUMUxpIiuPAq59c/rMTVvZ8orRnQqn
         BR/ur28nmf1AvEvc9e5murbUwWKTbrv5dEievvqDCzilGVNFymqU/j0ykwq9TvygBlHs
         5uEH7q3NB/uuukflJAuPwOWPaEU5uNe1q2PKJC0cKB3wdwhk51ayzY+SSU4jAauIsA81
         aS+g==
X-Gm-Message-State: AOAM533jQDg6SBlrJ/32kyOemzqftkb6zkytH9wYIwOqa0AH/2RaVqQP
        8OBfLxbguhDrMmI+9kKHdpSQiuBKlneUo7qEvdZG03l7lJXHAIwDbERJKJWCIOOemT7xgZ4N/IO
        fsMhiBdpWHsW/VweYD4XpWNChRm4IFoswCNIqlq+1Obu+cIyj76PDlzEw30TCzATeHmP8QQ44BQ
        ==
X-Received: by 2002:a05:620a:1a08:: with SMTP id bk8mr5868653qkb.158.1626380177828;
        Thu, 15 Jul 2021 13:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Mh8bqfMRmlD7VtuT3BfvCjnYBOcmGPKPMJX4as9wjPV1emUfAXJm6miIcoMPleVO1W14yg==
X-Received: by 2002:a05:620a:1a08:: with SMTP id bk8mr5868618qkb.158.1626380177566;
        Thu, 15 Jul 2021 13:16:17 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id i21sm2980326qkl.20.2021.07.15.13.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 15/26] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
Date:   Thu, 15 Jul 2021 16:16:14 -0400
Message-Id: <20210715201614.211661-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index f7ca1a3870ea..c30f39815e13 100644
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
index 924553aa8f78..4bdd637b0c29 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4331,9 +4331,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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

