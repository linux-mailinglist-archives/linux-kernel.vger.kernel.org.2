Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70893C93D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhGNW2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237066AbhGNW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+qr2gkGCf8UGCRyFBArhsHy6tP5+E2Jys4dwvbHGGg=;
        b=O93pmzS8zyyT1sIF8x8+uSNh7iICaGDOVntgcrE5OMrg/rrI5As4YLiGe9sBdKAYvLZTUn
        93A4VOIM4EIsEex7EB4u3d8xI+Z07RS0ckVyrabahe63t7szQI0m3yEuGWVlRUye/dzASz
        MZfn9FO4ALHdRsoIKf5vamM1NwCUfQE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-0hxdoYsBNRGVFsCQdYEpmw-1; Wed, 14 Jul 2021 18:25:32 -0400
X-MC-Unique: 0hxdoYsBNRGVFsCQdYEpmw-1
Received: by mail-qt1-f199.google.com with SMTP id i9-20020ac871c90000b0290252173fe79cso2870525qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+qr2gkGCf8UGCRyFBArhsHy6tP5+E2Jys4dwvbHGGg=;
        b=i+pEWpdn+vuThLzePjsu8PJn3iTmSpuruGCT9JkNFXj/5tVJz3SqmL0vlqBSfbmbGd
         m+HqFlDAjQ7CYV5CSm/EMK4FXXZpVaIkXKuiVtHjpoi6IoJbhrK16OfQiUx7wbJG6blF
         SqxJM0saz1orV6YpLSoGlN1hqa48yRu7b70SQfR6DSZxrd5dzVhLNS13bY96fcji+WwV
         PnIXGQQsIhky36bttH39xpJPZWjyaBS3ytmfrSZ3QfXY6207hyo+VtEeEaVGFlQlVUGA
         VaplXMghW3uoBUNS+MKNA4dqp+XW1nFCRCI1anmsPJqqGlTimtCEUqo7BXFbiXcpOoMA
         jQTw==
X-Gm-Message-State: AOAM5321JgXrLBZl16hbug4MubFKuSQarMwoRrpN0rQEDHIscCF/zS8X
        klupjvH8+wHay/fjm76ROwDnD8oK3fmQUk8FcIswNgKFZcWzvNsnwD7roDoTXhUF9AUmoahSAK2
        Bc5XdXYrLu5tnYCkKSW+fDjd2
X-Received: by 2002:a0c:f850:: with SMTP id g16mr231018qvo.5.1626301531972;
        Wed, 14 Jul 2021 15:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMAg8OaJDdVqZ7CGPKyUVwq/ziIAcVf370Zekn0zY8Li1Qe9olZ37NU65OmsJDzDU/U84feA==
X-Received: by 2002:a0c:f850:: with SMTP id g16mr230995qvo.5.1626301531801;
        Wed, 14 Jul 2021 15:25:31 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id e123sm1658706qkf.103.2021.07.14.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:31 -0700 (PDT)
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
Subject: [PATCH v4 24/26] mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
Date:   Wed, 14 Jul 2021 18:25:28 -0400
Message-Id: <20210714222528.49296-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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

