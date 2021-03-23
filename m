Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04377345433
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhCWAup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhCWAtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eo6GR1szVdaE50+5HSQqPNu3QULjjOofe28eTN5phnY=;
        b=Mx2Pcmw/rGxb9PVB1OUUpry1/RO/5Ow3UpFvZqhMrFLQShcpDubjsHgeKzcYhNn3GiTpjD
        1znFBOnFr281T43mT/cQsAJ92u+D06bRZ3eokKBxcTBefVRzSyFgxCUPQSbCjhkC14Hc+6
        kyKzalEboIVVBQVGiJFTunJBUe7aVAk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-TZeX2dS3MFWgxn2XOvlLNg-1; Mon, 22 Mar 2021 20:49:38 -0400
X-MC-Unique: TZeX2dS3MFWgxn2XOvlLNg-1
Received: by mail-qv1-f72.google.com with SMTP id x20so538895qvd.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eo6GR1szVdaE50+5HSQqPNu3QULjjOofe28eTN5phnY=;
        b=himfifamfEO2N6i02jXCWiYffHY4/mn2B5cnPUAzbWRqwJqaHgPE3KOsv3HlkF6L9p
         xtxCNrPvWDMh1LsTq5X5klTm9lKKp9hSZRRlcGATkM9+AICAwmEyn83MYeLh5n00iwIM
         YX3rz/6TZAnTzI7AS94teB4b6I/9a1H4E1Ctre9gOG9xazsHCRcveQPaZNMoEfI3wLfD
         deFUARgEJaUwDCAjlA+1LgEAd6zRt1D25CYhUBPUhBAa66noFcSEww5PA4k9DyEcJnsQ
         T4vf9hzb6WBGpDxyl+ETAhcmpQIGUrfutOHdm+5W3zcYTZLOgs31ToPvnD4VPYmTMs/u
         QPcg==
X-Gm-Message-State: AOAM533KrMgLvWWQka9k0AziIhnIF2W6D5gzy0hr0gzHxLUUKWT2Wbu/
        13JSitKau3U8c6pbzi+Vch7C31tuEIztmkPEfypCYg8/H7rYHLab/DQGgbyFu7AXReRHaMSFKka
        R4sYCjWnv7jXuSqoKcjJ/y02uIlcfLMqtFVujbS1Bt3ENozomY6Mp9ZD1zj+S9VdsmbCLb50aEw
        ==
X-Received: by 2002:a0c:f805:: with SMTP id r5mr2752073qvn.45.1616460577199;
        Mon, 22 Mar 2021 17:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf8TDGDMVgqtBSuLbWSmrCugVffrpBoNx4NuHOZZ6VA9Ugvm4eHQ0tm4uAnu2RFfyiBQGo4A==
X-Received: by 2002:a0c:f805:: with SMTP id r5mr2752046qvn.45.1616460576859;
        Mon, 22 Mar 2021 17:49:36 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 13/23] shmem/userfaultfd: Handle the left-overed special swap ptes
Date:   Mon, 22 Mar 2021 20:49:02 -0400
Message-Id: <20210323004912.35132-14-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index bd83379d4dd2..72956f9cc892 100644
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
index e88aaabaeb27..90d67406af66 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2469,7 +2469,18 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
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
 
 	if (!is_continue) {
-- 
2.26.2

