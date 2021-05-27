Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8636539371F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhE0U0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236857AbhE0UZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+qr2gkGCf8UGCRyFBArhsHy6tP5+E2Jys4dwvbHGGg=;
        b=bSztObxKzLXaPaEHuhc1RPOsViNJyZ0XJtvcJ7XLhTrcV/tfHrnEZuyuHLIovZnXD5T92N
        DN4PmN8qpBy2AR6xhj9XiKiSIHHSdrdmTz63aJL5sLnKxBR0r5m6PAbJUGV0CCDs3Creks
        rwnbnOsHWYxRN/ZBE6M3tGQuyHJn/Q8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-NorkQZoLOkKM_qnmRncaUA-1; Thu, 27 May 2021 16:23:45 -0400
X-MC-Unique: NorkQZoLOkKM_qnmRncaUA-1
Received: by mail-qt1-f198.google.com with SMTP id f17-20020ac87f110000b02901e117339ea7so856680qtk.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+qr2gkGCf8UGCRyFBArhsHy6tP5+E2Jys4dwvbHGGg=;
        b=pdU8Zz0Mg/VXHk1Idok+GxDm3DQ92L88WSQ06aJuqyMeIWV0V7bY/I9o5oMx5oyYXv
         9PPukXfu+EXe8zSQiirl+xMX8rxpXMy20RxqjQTWAPBYbLfhRBagQ4rpOczt8H4qsuk+
         B2febLCQeqEfwmEA1XM56xt75CfhD39DEReC1JRrcPj3Nu8G/SfiOMHYcm/wW/9b0IZ0
         xiOcuOV9n8bgrSjjJ9kttnpFsbUOlUUNwb6dI3u1P6D2ygbRjBj+4HWriVPTqa8bkop0
         XY1IGPHHND6RVp9QjHP4dGHCZHfk+cIqrxldtKW9igCSWRBzotI3AfFpEJvJbX3ZQf3K
         CvxA==
X-Gm-Message-State: AOAM5301HsVXWg9KVaur9vbI91atVqVesaCaAQ26cAfyOkYKpJlv36XI
        OtocFkS4Y8lPZF0HXHFA9c4N0HB7g8aWqIHd4ngkqujtPfHlhcKkAlJADTI/MyXYEg/6CN8Tz8D
        8QCu3OvPMGozD9ouAG6n+0kZrPEFJNKniGq4CMyuYWXSUYIa8kIuOWdy1vhCk4KEZxgUSwpYJSA
        ==
X-Received: by 2002:a05:620a:751:: with SMTP id i17mr322487qki.87.1622147024884;
        Thu, 27 May 2021 13:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZVwpfNFKbYL8so0SPHDLq2pNae/ct+JgV8mbINE0J29tIc1QVdSRi+fw1P99ktJh8UsVEWg==
X-Received: by 2002:a05:620a:751:: with SMTP id i17mr322450qki.87.1622147024615;
        Thu, 27 May 2021 13:23:44 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 2sm2237729qtr.64.2021.05.27.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:44 -0700 (PDT)
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
Subject: [PATCH v3 25/27] mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
Date:   Thu, 27 May 2021 16:23:40 -0400
Message-Id: <20210527202340.32306-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires the pagemap code to be able to recognize the newly introduced
swap special pte for uffd-wp, meanwhile the general case for hugetlb that we
recently start to support.  It should make pagemap uffd-wp support complete.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9c5af77b5290..988e29fa1f00 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1389,6 +1389,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
+	} else if (pte_swp_uffd_wp_special(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	if (page && !PageAnon(page))
@@ -1522,10 +1524,15 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
+		if (huge_pte_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
+
 		flags |= PM_PRESENT;
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
+	} else if (pte_swp_uffd_wp_special(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	for (; addr != end; addr += PAGE_SIZE) {
-- 
2.31.1

