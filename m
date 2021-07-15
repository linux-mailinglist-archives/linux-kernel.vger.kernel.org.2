Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808343CADB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbhGOUT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239629AbhGOUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J821CEDH1gjfs0CBrZTj21MlvfuuPmBJQg+S3giuJZs=;
        b=O4xf2LK+kdqBMJ6+NdfSIKto0o2XVLTj2cabUO2laRGmrEtEyf1wCy5IlgTIGUplFSuJ5q
        L5iEqnv8gzyiDo0extnMXEd+9KAYpkUZjwLlS/57uucM3Q+IRE4D+a/wQms2TqmmL7pxhX
        aAObc+5t7AgokvUp6RF/NM67SkKci3A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-otd4gUyHOZCn7QdQygD49A-1; Thu, 15 Jul 2021 16:16:27 -0400
X-MC-Unique: otd4gUyHOZCn7QdQygD49A-1
Received: by mail-qv1-f72.google.com with SMTP id kj25-20020a0562145299b02902fbda5d4988so1640239qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J821CEDH1gjfs0CBrZTj21MlvfuuPmBJQg+S3giuJZs=;
        b=ZIuYianEpoQIZZnVZKkOBkxk+0dCl6CDz96wcwRW/i9R5wsNnvhRYa5/kiHJtho7/M
         6RTqU6w3Y5ZkVJEGRjYL1XIP9yfZNKMjtJtebXIgIYYRHxezJyoY5TH8RCsN3Lf5c552
         DGTKFz4BaZ3pBIK8RokZk9bHHALmmVLr5fJdX7mBCwEM55zHbvWMT7xNKjbDWYKNaxjY
         VDEc5DhoTC6pAjGN629dN/NBB0IxwKgL3pCQ57MDL07KB7vtpE3HZSjE7TyP94/ZoWtl
         4Znse/xesdOTG/6LWYt95Ma0SZD86NQdRD8mu4qGH+g+iUGZIkvtNTX7Th+gowAqm1NU
         WZow==
X-Gm-Message-State: AOAM531UQPwjs/MSTtKzitM5THR1y5VkOgcaVMvw6Mw1OYrxrGGcaApq
        2EZq52+sWn2OJtAIA0jUUWM04N8auxE9Mt1TRhTXTJLT/eU3pIj4nY53NwiCa1uLiER6yJ0nWmQ
        XArB8LaSCor57plSOfi1vd+cjChuJ2AXliYvzNT2qBK/fU89jyDlrEd5P8pC3DGPhBxvjlSL1WA
        ==
X-Received: by 2002:ac8:7a98:: with SMTP id x24mr5652702qtr.42.1626380186500;
        Thu, 15 Jul 2021 13:16:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqx/JKx983VIK40kL+tOEfKDUFx+QG/B/b/7cM+8atn/7wXP3AG7MvbKd5YDYnZ2YGLzaxaQ==
X-Received: by 2002:ac8:7a98:: with SMTP id x24mr5652668qtr.42.1626380186235;
        Thu, 15 Jul 2021 13:16:26 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id d2sm2385704qto.91.2021.07.15.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:25 -0700 (PDT)
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
Subject: [PATCH v5 17/26] hugetlb/userfaultfd: Hook page faults for uffd write protection
Date:   Thu, 15 Jul 2021 16:16:22 -0400
Message-Id: <20210715201622.211762-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.

We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
extra locks that we definitely don't need.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdd637b0c29..d34636085eaf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5059,6 +5059,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
+	/* Handle userfault-wp first, before trying to lock more pages */
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = haddr,
+			.flags = flags,
+		};
+
+		spin_unlock(ptl);
+		if (pagecache_page) {
+			unlock_page(pagecache_page);
+			put_page(pagecache_page);
+		}
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
+		return handle_userfault(&vmf, VM_UFFD_WP);
+	}
+
 	/*
 	 * hugetlb_cow() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
-- 
2.31.1

