Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810DB3C93C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhGNW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235401AbhGNW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HoJrf5XHMT1foDa7QiH7gGocyne+rxUVzp3LYIPfb1I=;
        b=Qn27Fz/9T7L+QgDH1aaKV3X5NWZD3zDJVrEjyVT7crMVktWw9iK8VKh8SRhINwd92l/BlF
        RWVS47M5IMdphVPuAe17hhTDyRRynQ/flpp7oKdzoxtXZsCqVOtWZqaYWNzSlZ4mQp0Hvb
        Y+i4lm3RMmyDZd78r3g2I4/ziDk5b7w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-dq4QlsTZOySns4DXRmgKFg-1; Wed, 14 Jul 2021 18:24:54 -0400
X-MC-Unique: dq4QlsTZOySns4DXRmgKFg-1
Received: by mail-qv1-f71.google.com with SMTP id e19-20020ad442b30000b02902dc988b8675so2722740qvr.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoJrf5XHMT1foDa7QiH7gGocyne+rxUVzp3LYIPfb1I=;
        b=FsX8nBobgpwTDlN18iLGLgulPfMHqkJTM+wEV6Vm5unI9N1gcmnTY83y8kiZeWW0Ho
         o0OldGmEdWpDS9rGTNyERapsICgKnGh9wNNvYTE8y9Y9DAQ5tjf+yl7l0pHTEjrRY8Zu
         JzStsUXG1tO5z1+YOEnXNsHjhH6N12GJnCnjMvCnAIXotcwhpWxKu4f1/41jk9/WhVxh
         VXwE5/JlU67volzJrwwc2YxIkTa2eTJoHwoaGj8bzb8l5+015PgQ2JUwhgwmj7Im7oWf
         KW48SydXCTzqRSGiD3pj01vkgc5KpgUI3EJCVbHn1cQYet7g87KwT5OX47PTnUZPCyxb
         geqQ==
X-Gm-Message-State: AOAM532OEe5PaHgmX6pbAt+FTW04PGXRjSLwfGW4NW/AJgJdIh9mqgJ0
        Gu9GbxDgAyZQdv7WjDpjBei2UBXLgZQLyrZPBPVJ+zEMGJlcU7TLtwqrz3ZAJP7ClIp0h6qZBDh
        BayKvFa2/KofYW0fRTzqKjmu7
X-Received: by 2002:a05:620a:99b:: with SMTP id x27mr241778qkx.226.1626301494360;
        Wed, 14 Jul 2021 15:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOW00e58jO9AZD7fw0CnPfeLPUWJrjUqdtrilL2qz6WVvPrJUbhPG7ghrnW4FLQUsYSIj/ew==
X-Received: by 2002:a05:620a:99b:: with SMTP id x27mr241746qkx.226.1626301494149;
        Wed, 14 Jul 2021 15:24:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id f36sm1288702qtb.40.2021.07.14.15.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:24:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 15/26] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
Date:   Wed, 14 Jul 2021 18:24:50 -0400
Message-Id: <20210714222450.48840-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
 1 file changed, 10 deletions(-)

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
-- 
2.31.1

