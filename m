Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B7839370C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhE0UYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235899AbhE0UYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPzjkZSYUZ+9ChSaHHQDBWB6stQ1ZKRzO1smrJVYP5w=;
        b=JGVPUsHaOGWvXEGxZcZIy2BjpRBwMgAL1pOnr2B5ZCjDBEUon/kjKrfOLTWQ6NEfwMGpv/
        UPnQeO50hknfIwvhH1MhRh5ed9ATyTiII36rxNyylRBe2A2Imzowot5XO9KU+Bsqk5tYrX
        EP9I2m6GMbd7w+LuAtipgxV+CpHXGFE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-CEkDmCTzOFe5aE_Eozj-Gg-1; Thu, 27 May 2021 16:23:03 -0400
X-MC-Unique: CEkDmCTzOFe5aE_Eozj-Gg-1
Received: by mail-qt1-f197.google.com with SMTP id u3-20020a05622a0103b02902274c59d552so836191qtw.23
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPzjkZSYUZ+9ChSaHHQDBWB6stQ1ZKRzO1smrJVYP5w=;
        b=pPjrkmW2MHURBFQgXm1XrzcFx3lh3/+iLWA27yBgby0/G6STW4TvZdKYd60vFPGl/P
         svGM29VxA8dAgxWbkA+YiIiJjrKh8Vq0jP8P/JlO2Abn2m1alFUiJSUCrWngLrLBOvNP
         8RVK2wxm8Oc6f85P/uwsBI4ekSttgvlj5ZHBaSHWTTD1ogHj+Y98sZS382fS3Aij00rH
         SJGjboAgithm9UO/aWKGu8MkNkexhQ4ue1oMJME+UticcW200If9g6Aooo3r0AfWwmBg
         eylL04wCh74zqKDaNlD7xLJzYTgESz6gzjNUiKe6A3TL4EhXJdJtkZ30ie3GHiHclMyk
         XBuA==
X-Gm-Message-State: AOAM533uqO5t8hKLadFuySgT7brxbyuOLUFLYViKaCE4SI/shp22cTjV
        ZakQB/PORbiHr1jBOrUEN+t+dFl5yi+7zuNoNN9pr2gs1dwqENj+cqMJ43m+FcLu69Zj77qQRSN
        NUhe/OIGZha1Azz2vd7Wyoe9+8Upic6nCP4fMWF0E/M08G4kl8IPxZXe1lq/8RL3fnh7eRyB9CQ
        ==
X-Received: by 2002:ac8:758a:: with SMTP id s10mr335574qtq.31.1622146978767;
        Thu, 27 May 2021 13:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8kaYOKObAD+x3/GT0ewDBGBt60RVnJQo86yzj8GxZwEzdHtJ0I2hFBzBcRwaJqMd8+fukTg==
X-Received: by 2002:ac8:758a:: with SMTP id s10mr335533qtq.31.1622146978391;
        Thu, 27 May 2021 13:22:58 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id e12sm1355961qtj.48.2021.05.27.13.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:22:57 -0700 (PDT)
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
Subject: [PATCH v3 14/27] shmem/userfaultfd: Handle the left-overed special swap ptes
Date:   Thu, 27 May 2021 16:22:55 -0400
Message-Id: <20210527202255.31716-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index 19ebae443ade..15031d6f1f17 100644
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
index 3636f5be6390..147e86095070 100644
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

