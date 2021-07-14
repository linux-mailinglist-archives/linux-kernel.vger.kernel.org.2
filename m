Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCC3C93C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhGNW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhGNW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/r2tEksA7iAG8svGDApMzfpTe7AXzjcSqF0fovWgO0=;
        b=M7uqAWHn5olJzLmW+baQf/SdgPVoZt3bO/dAgmKJuxiP05gDMggbvhZNa3ZuyWS8ripEMS
        ohnyTNRvM/pHZkVSEyxjepOYEo80DE3kPHb8LYF1OwWQj/GBRKEwvKFuxHKCoNz+EbxNs8
        Gh7U9ONzZkvh0qeEnJQ0+KbhJeBbhpE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-_3Fiyr_XPsuLAvjafO9eFg-1; Wed, 14 Jul 2021 18:24:50 -0400
X-MC-Unique: _3Fiyr_XPsuLAvjafO9eFg-1
Received: by mail-qk1-f197.google.com with SMTP id q6-20020a05620a05a6b02903b8bd8b612eso1712480qkq.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/r2tEksA7iAG8svGDApMzfpTe7AXzjcSqF0fovWgO0=;
        b=o/3eVZSGkdVTWgsEry0eBuaNcSYw8OqBCgvr3A2bDM3+1W7DTLRPixZq+AtujugxvE
         Sg+oxCiGPiP9+/h3wsuFbTlTiuu6rVcHD8MvdywM6597bXy/YtrGiGgp699se3ibw7v7
         WPYtsdAW0lFQVvKsW+EpIMC66JVXybJ+8QQAmBFVLfS+0Na7X8qcWCNCEjMe7WOPMklv
         fTTMl6OWlBsHy8zm386LaznSLlW7o4Pk+xWM3vPRDcCvjhXr4ypKH4brv7g45ilI0vvj
         Q9ppol8LuD9pWexQ9dD9zYrcALxXGHUeUPD3XklUjIerabCm86dX05rVE+cWNPG0ex7I
         9Mkg==
X-Gm-Message-State: AOAM530CsbJ4VTqRx0gJgiUfYz+/Jbgzjmg29tDLkd2DXJgJlerLfjTf
        VXc8nn2DiuCnYqFE4mN01OZlAfbNgUHLIIllUQ2eFOPwefpSL4banaUgR47Kxo5qcrWydcLWNhw
        eAj8b3adTeSKVZoVzaG+a28oy
X-Received: by 2002:ac8:764e:: with SMTP id i14mr320329qtr.247.1626301490063;
        Wed, 14 Jul 2021 15:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxke+1R9jvCzeFeO4Xhy524xOIxKblC2IZ31epDh9hl1os1ZvwizYxkPAeMEaZbjJZGzGEjNQ==
X-Received: by 2002:ac8:764e:: with SMTP id i14mr320312qtr.247.1626301489853;
        Wed, 14 Jul 2021 15:24:49 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id u184sm1655517qkd.53.2021.07.14.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:24:49 -0700 (PDT)
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
Subject: [PATCH v4 14/26] shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
Date:   Wed, 14 Jul 2021 18:24:46 -0400
Message-Id: <20210714222446.48788-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be handled similarly like other uffd-wp wr-protected ptes: we should
pass it over when the dst_vma has VM_UFFD_WP armed, otherwise drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 223781f115e9..af91bee934c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -776,8 +776,21 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	swp_entry_t entry;
+
+	if (unlikely(is_swap_special_pte(pte))) {
+		/*
+		 * uffd-wp special swap pte is the only possibility for now.
+		 * If dst vma is registered with uffd-wp, copy it over.
+		 * Otherwise, ignore this pte as if it's a none pte would work.
+		 */
+		WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+		if (userfaultfd_wp(dst_vma))
+			set_pte_at(dst_mm, addr, dst_pte, pte);
+		return 0;
+	}
 
+	entry = pte_to_swp_entry(pte);
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
-- 
2.31.1

