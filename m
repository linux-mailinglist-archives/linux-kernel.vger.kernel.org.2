Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29903C93C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhGNW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhGNW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFcYHlyDKbLlgbIUnPtt3LhncHUQTe/w3qvUe3g6dgM=;
        b=jQSbhM1pT+GtI5EMq6ZL4DxUjgSvaQkzlJPaWwQz29hsOppMaKEljmkskr4Qa8SfhzAhFE
        10JTIgmt1af6TJmhkQQgRtH+owb13E6ivCeDxl7kLE1VdxVPrKP5EQLj7Nfkj2udXhertG
        3M+ib7JttmEn/KCnrlp4trt4GXl6KFY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-XqV_jSG_OEq-LURs3ddGPA-1; Wed, 14 Jul 2021 18:24:46 -0400
X-MC-Unique: XqV_jSG_OEq-LURs3ddGPA-1
Received: by mail-qv1-f70.google.com with SMTP id l4-20020a0ce0840000b02902cec39ab618so2711653qvk.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFcYHlyDKbLlgbIUnPtt3LhncHUQTe/w3qvUe3g6dgM=;
        b=cSjOZdAU125mS5hAL11uin6E2lGiKboD/OXISHR5KfNajfMH5ID+rkGoT1Zy8NSI8A
         8X51Ag2ESSrweR/K+v/v5C0xrVRxHAoVvewbVe8EF1YvvbkHgSHBdYLR0Ht66eI7hCws
         XlIeKRlWeZ7hlo/1oBQV50s6HyYOeyx5tZuLFXWlrJ5vKrnew1CxvFrCDX9sUN2LnF7N
         uwntQiQesszo3S8G51O1ExEXjSP3jpXNZVnfX67G9IN9ijIdsG4diH4hWph1iriYweOD
         lsoGbea/xw9RP9JKNVCNFqcZ71nrP9dy5YqpbHQchDDNNIwvYtKQwy0/xrxJXjFVaDrc
         V2wQ==
X-Gm-Message-State: AOAM532JeUNIYjG9oj4IBcaJKTHkQ+3dThG/tJGO48XUjg21q1dIk+sQ
        ZVESysTcVIadt8+EPTd6wdZTpMja8Pqovu0I3KaghUdqtWdG2EivsuwEjKFqQVyDZYFKqN/lY2V
        2B2GOUA1IW3ozRof6lG+Uz8h0
X-Received: by 2002:ac8:5853:: with SMTP id h19mr363302qth.66.1626301485888;
        Wed, 14 Jul 2021 15:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBfKAWFYo/mOF5P/V0APrbl+7RO7yIBtyeG/gjJiUvpZs7s3HU04/TQ0OhCIH6sjSAsXdp8Q==
X-Received: by 2002:ac8:5853:: with SMTP id h19mr363274qth.66.1626301485652;
        Wed, 14 Jul 2021 15:24:45 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id t125sm1645141qkf.41.2021.07.14.15.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:24:45 -0700 (PDT)
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
Subject: [PATCH v4 13/26] shmem/userfaultfd: Handle the left-overed special swap ptes
Date:   Wed, 14 Jul 2021 18:24:41 -0400
Message-Id: <20210714222441.48737-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the special uffd-wp swap pte can be left over even if the page under
the pte got evicted.  Normally when evict a page, we will unmap the ptes by
walking through the reverse mapping.  However we never tracked such information
for the special swap ptes because they're not real mappings but just markers.
So we need to take care of that when we see a marker but when it's actually
meaningless (the page behind it got evicted).

We have already taken care of that in e.g. alloc_set_pte() where we'll treat
the special swap pte as pte_none() when necessary.  However we need to also
teach userfaultfd itself on either UFFDIO_COPY or handling page faults, so that
everything will still work as expected.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 15 +++++++++++++++
 mm/userfaultfd.c | 13 ++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f6e0f0c0d0e5..e1c1cbc7bcc8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -329,6 +329,21 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (pte_none(*pte))
 		ret = true;
+	/*
+	 * We also treat the swap special uffd-wp pte as the pte_none() here.
+	 * This should in most cases be a missing event, as we never handle
+	 * wr-protect upon a special uffd-wp swap pte - it should first be
+	 * converted into a normal read request before handling wp.  It just
+	 * means the page/swap cache that backing this pte is gone, so this
+	 * special pte is leftover.
+	 *
+	 * We can't simply replace it with a none pte because we're not with
+	 * the pgtable lock here.  Instead of taking it and clearing the pte,
+	 * the easy way is to let UFFDIO_COPY understand this pte too when
+	 * trying to install a new page onto it.
+	 */
+	if (pte_swp_uffd_wp_special(*pte))
+		ret = true;
 	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2a9c9e6eb876..0c7212dfb95d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -100,7 +100,18 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	}
 
 	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
+	/*
+	 * Besides the none pte, we also allow UFFDIO_COPY to install a pte
+	 * onto the uffd-wp swap special pte, because that pte should be the
+	 * same as a pte_none() just in that it contains wr-protect information
+	 * (which could only be dropped when unmap the memory).
+	 *
+	 * It's safe to drop that marker because we know this is part of a
+	 * MISSING fault, and the caller is very clear about this page missing
+	 * rather than wr-protected.  Then we're sure the wr-protect bit is
+	 * just a leftover so it's useless already and is the same as none pte.
+	 */
+	if (!pte_none(*dst_pte) && !pte_swp_uffd_wp_special(*dst_pte))
 		goto out_unlock;
 
 	if (page_in_cache)
-- 
2.31.1

