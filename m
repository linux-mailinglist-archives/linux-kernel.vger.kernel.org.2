Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF036C948
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhD0QYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237562AbhD0QO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQo3igXQ2ZrlT78vmfcbMjgqdCn30eweEx4RKB8geEQ=;
        b=SfOnpNQjcuIMzOa6KTva2Ax7JbBgRu0J0xk0yBddKUOWZhokt/EO8VTY62w2G+yuM2gpVS
        I6oE/ZdQpT5x3Na0HcIxB0fQMlH+Caeog0yGCgxfTnZttj8NbYHsAmu6FuIfumisrvP68C
        GlR+LlMZn3/xbajolcaT1o7MZlZxTaU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-X9VY7EhqP7mP81EFxnMLNg-1; Tue, 27 Apr 2021 12:13:44 -0400
X-MC-Unique: X9VY7EhqP7mP81EFxnMLNg-1
Received: by mail-qt1-f199.google.com with SMTP id b8-20020a05622a0208b02901b5b18f4f91so20772771qtx.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQo3igXQ2ZrlT78vmfcbMjgqdCn30eweEx4RKB8geEQ=;
        b=QL6TXMkzlDe1Q/TTTaYr+3538HByeSXqAWwwq8Kbf3cx+YmFvZR+J2A2TD1x7exjjS
         TfR326gtKFicGn1CCSnB6B+rzIBQn6dLSoAXd7Wn4d902MOxjRu6phGJYw7I2WDNQHXs
         GT/UwSx+pHTi5r/7vgGmJPh5lUl63Q/8oFxBbm5kB70ERQGemrPbpfUHIb6JzJxVGaF4
         4CgY/QbfiW2slTblw1Xh84+HzIBmVUyUKziKrnsy7WbZnFovCcnRcbNaScG9Y+sG6b9c
         0lcWIEgUMhXVWZ2T/MtrBJB9eOVtl0rUXV2MY1ooely2+HzbeRu4H9n67OcWsCevYEUi
         SN4Q==
X-Gm-Message-State: AOAM533hZZEhPOxxdbY/GlGH3qa86hl2baUlzW91dqhqMkEE0eGGff47
        FjLmBYQ2yLNzVZnBJxhUFQ5qyHwzd9byXWYXN/8Zl3O52FnEurT1lA96AK9zxMZC8OzyfxQe4dS
        JzAiUSykUbeiOg0X2LJQpXoJn
X-Received: by 2002:a37:ae85:: with SMTP id x127mr23480367qke.436.1619540023548;
        Tue, 27 Apr 2021 09:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBvftm878KrfXNKO7yJY30UGBZnCImne2Q/icuY+oWvYS3f5pjudN4L4FNOQSPKT1Zf9Wuiw==
X-Received: by 2002:a37:ae85:: with SMTP id x127mr23480325qke.436.1619540023259;
        Tue, 27 Apr 2021 09:13:43 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 13/24] shmem/userfaultfd: Handle the left-overed special swap ptes
Date:   Tue, 27 Apr 2021 12:13:06 -0400
Message-Id: <20210427161317.50682-14-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
 mm/shmem.c       | 13 ++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5dd78238cc156..b34486a88b5f3 100644
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
diff --git a/mm/shmem.c b/mm/shmem.c
index 8fbf7680f044c..a1f21736ad68e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2453,7 +2453,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
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
+	 * just a leftover so it's useless already.
+	 */
+	if (!pte_none(*dst_pte) && !pte_swp_uffd_wp_special(*dst_pte))
 		goto out_release_unlock;
 
 	lru_cache_add(page);
-- 
2.26.2

