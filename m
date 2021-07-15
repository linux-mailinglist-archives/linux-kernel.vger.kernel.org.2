Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8BC3CADC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbhGOUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239464AbhGOUTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFcYHlyDKbLlgbIUnPtt3LhncHUQTe/w3qvUe3g6dgM=;
        b=YOrYhR/WdapuSJRIZrvhMOQiKuUgqNfd2cmu/RAoyHIlvg3QPs7qn1w880agZp1OrR/sW0
        GUvSsW/O1NdnxOIuCQ5oNW5EGuNAEiWkzds8Mpo4NfKooDVTP/HZ7RLiYqevEaDD2t860B
        CAdzPHG98li9UqcVpWucWbSsUNDepGs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Jc-0fa3kNMO_Q75xZ-kqfg-1; Thu, 15 Jul 2021 16:16:10 -0400
X-MC-Unique: Jc-0fa3kNMO_Q75xZ-kqfg-1
Received: by mail-qk1-f200.google.com with SMTP id h12-20020a05620a400cb02903b8e915ccceso1329743qko.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFcYHlyDKbLlgbIUnPtt3LhncHUQTe/w3qvUe3g6dgM=;
        b=pz/3EEgxAgqdaGnFkM8I8JBMdLUj83MY3sekJZPhLF43fFZ9KSZsIgiDRKN9vucpVz
         j6iUvwr8jf5fK25J4/b7uYgQhHw253vIM8HxVo8tRPyDFKtr1y/U4Xh8TFmlYqvTIbgm
         yhSgVAkvCMovBKirS28K1U4MOd0U7E+ckDbg5v3CaMyScLezdaRbc1DoMEvGz5kMB81k
         GSiSUXhbBDgpPQzYe9qqmHh8fyB3/8fFuRpPXskYGZrLB5abFsjIF07p0IucWZJGOYgl
         Q8pS6qkxjE8ZP2I8AUyimGmVQhFpEZKgdzHjHMlfdDrNQUFbUjenuYkc/AB3jApyEC8b
         GUNA==
X-Gm-Message-State: AOAM530afAPnL44ITTEIFF4uXbx6OSiQK9IpzUk7Srb8p5tg8PZW3/yK
        2umet05aDdQ+6IIiU89VAG12qOH7s+qm2D99MOIiBemcnsj+oOLDfN72INUp3lAz2/MlihjYrxV
        DkNqonsC2BZRAKQOeyG5qh0U6ffv8u2sWqwVFwdMoeDLS5TmJZASQNzbB3xX/M5tQt7dKE/pVUg
        ==
X-Received: by 2002:ac8:110c:: with SMTP id c12mr5780301qtj.201.1626380169835;
        Thu, 15 Jul 2021 13:16:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDAI/RGFVMXseRIsiXI0+GYwkXgmr6GBcXlMnsNgdtorEkJR8QBSr81kv2GUt4rMDqMXJibQ==
X-Received: by 2002:ac8:110c:: with SMTP id c12mr5780264qtj.201.1626380169556;
        Thu, 15 Jul 2021 13:16:09 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id j3sm2894807qka.96.2021.07.15.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:09 -0700 (PDT)
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
Subject: [PATCH v5 13/26] shmem/userfaultfd: Handle the left-overed special swap ptes
Date:   Thu, 15 Jul 2021 16:16:06 -0400
Message-Id: <20210715201606.211559-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

