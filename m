Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204839370E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhE0UY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236282AbhE0UYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoKsIz4q4xSpRNm9hs0BrG9ToefGgP2GtNCOUn+H6ys=;
        b=StCwmoe/U9yb1ZPiYPRb0UWIleBxM8AqFC6Cah0dnZCMxqw7v28kp0NB/I0l7l02ipmiFX
        s8ErSPg0tMQOmOCgE3btmgBiNDwgVHHHAPM9G3tkT/ZbtN/BZ/gEUFdfa6GZoF0WPeTEyZ
        37TsOJnZFd2xPO35QvRiGZ1OvBDanVs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-iozb4MsDMMaUI3q0h_XATw-1; Thu, 27 May 2021 16:23:08 -0400
X-MC-Unique: iozb4MsDMMaUI3q0h_XATw-1
Received: by mail-qv1-f69.google.com with SMTP id j14-20020a0cf30e0000b02902142ba51ef2so1021864qvl.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoKsIz4q4xSpRNm9hs0BrG9ToefGgP2GtNCOUn+H6ys=;
        b=PgDy2pgjQZr952O/yiVoitT6nRFkuEyetdyryrxqmPeOE4sgNjK2+19tPk0oLFxMtN
         RUb2Z70s3Bdcl3vzUHiWbrcQXPHMy5NnIHVb9WQeqXtT9D6+Xmx4oN27wfa7KDGoNCoE
         2hon8Zve+3FO/8/gjbCxltq37kLL9KO0MTx/6uzNi/06ThvzBhvpx0khqOjB5EwgPAmC
         1ut8fXQ8Ovthj29knvi5KLpiBCvlnvgdsImBcS2twJ33J2cso973sHRI49o1m6ucxSNH
         hh7e+iXHcgAl6WrRG66mDDeNHln7BSjgvsaLekn9tmCxl+hppoh2GouD33kLLBVnt8by
         CyaA==
X-Gm-Message-State: AOAM5332F/gcWWFkUVi79lU9yz5cLWlRAhnwyJH78ClNDt+E5/Xo7Q2R
        0i7q+Ty4yByXidTXlvWVZz/fUBDtn81dboXUtHx8WXe+Z3uv7iCqm9QPUMdb/Pd2yewB0Rjdq6O
        1j4H8deXsHWLiWz8W9M4BtgSI6crxfTVRRR18kJVgD+LvkbD62+2KmAHvABusQ13PIqhtGlqoeg
        ==
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr356030qko.282.1622146987454;
        Thu, 27 May 2021 13:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPBMzsCNUZPXEhKlaRCORWI9CkBI4AzSpTEO2+Zm/kawOiakFSPgTl6iyiNKbrAzVRR5rK5g==
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr355999qko.282.1622146987200;
        Thu, 27 May 2021 13:23:07 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id y20sm2076116qkm.5.2021.05.27.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 16/27] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
Date:   Thu, 27 May 2021 16:23:03 -0400
Message-Id: <20210527202303.31817-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index d944aa0202f0..7ef2b8c2ff41 100644
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
@@ -381,13 +378,6 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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

