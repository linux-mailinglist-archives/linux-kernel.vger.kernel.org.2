Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4190D393712
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhE0UZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236484AbhE0UYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2AIp+Ymbm/rO+WssUczToBWrAYbIWlMSeka5+35yLo=;
        b=aLEuVoVLhXQeGU1a9TpA4R12ewkcU9Y1p9U5AZF07QlwRQz1JL0CNpsieTKX386R2Wg/u4
        f5GjChQFhJxMlkHiuz/zFll8ZIkl+G1amAPQQKIpueCYyqjNQK4g93ajVcocAYXpKjsmxI
        KislQmN5RBQv2c0c8BCo43hDJ0I8ObU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Bp3hUsPaPumRGupDBfHsBA-1; Thu, 27 May 2021 16:23:16 -0400
X-MC-Unique: Bp3hUsPaPumRGupDBfHsBA-1
Received: by mail-qk1-f198.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso1315915qka.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2AIp+Ymbm/rO+WssUczToBWrAYbIWlMSeka5+35yLo=;
        b=AD4D4rxJzLJBmikYXUtX7f969QlGCbpoCUc2jc5z3SljPR82/4U3omf5vKGdVVfl6l
         DhTo1aI8zKdnjaz7pCORPMVUHEwg3psOax8WobMJFJevLVSb58awNpUd1n4s8zfhEe22
         hwKiq08zMeKBivbFGc3VMsq75AnU4GyK26yna8XrOPbBJ3DCVK/keeRheTtdeHKt0/PK
         r+qjBFgMlC+5PE6yRPON51BXh3hAD3IMvuCJppVQ59uxm2+liDQ9Y8EYBnRxPcD2Yc69
         0qTGrdEbXGvNON0jY90A02p1KTG0avu94O26XTYUpsNq7e1knZSskRL7jTBF2odP/6I2
         NVkA==
X-Gm-Message-State: AOAM532/1xmsRw3VJy9Sq8JhY+n7sLNBpA4cFxdRgbFEIVcnzHkyYkEH
        zihAeP7QKhgNRnMipzEBomToe3vq2R3ChTaXngqUjI0tn3W8P3dreUCKGkPBYA4gYPPNnFm7Evi
        yyQCJCynhgkGQ1n5mNWrvONbnOP8Y1yK3jm2eX4qvqlNE8SdxrpYtNdTHEYvZ+UTYF021rxaklw
        ==
X-Received: by 2002:ac8:6c4d:: with SMTP id z13mr362302qtu.70.1622146995435;
        Thu, 27 May 2021 13:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxoISek+Gk6rvKj0UcX69Zu2O92OlUW8NlblGfi2ZCDVyoeOnKbowkA5n1gTlEZ3HdJTxJVg==
X-Received: by 2002:ac8:6c4d:: with SMTP id z13mr362267qtu.70.1622146995147;
        Thu, 27 May 2021 13:23:15 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id m15sm2005366qtn.47.2021.05.27.13.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:14 -0700 (PDT)
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
Subject: [PATCH v3 18/27] hugetlb/userfaultfd: Hook page faults for uffd write protection
Date:   Thu, 27 May 2021 16:23:11 -0400
Message-Id: <20210527202311.31937-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index 69a4b551c157..4cbbffd50080 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4980,6 +4980,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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

