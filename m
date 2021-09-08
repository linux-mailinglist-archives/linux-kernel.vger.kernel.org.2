Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF9403DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbhIHQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349554AbhIHQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0jOEqk3duu/S7ny3QESOOgnrnVwgkDjlQfF0n80v8I=;
        b=ClYLqRp/iyTbrJUs8cKHucD8ixvfFh6a/np1uEH8uuaSUYZ4E4aiM+20gy6dxAf02Eiaxk
        96+6wM8SCDyFg/vrSMrctL6JygT5G00951ojMionNTRhZsVRC96ts2fAvhvaUhJEZxhXKw
        0S7enpQvorzC8xw3T0Y1prKPyTc8MOg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-Kdp_56THPfaawvc_jNe9RA-1; Wed, 08 Sep 2021 12:35:24 -0400
X-MC-Unique: Kdp_56THPfaawvc_jNe9RA-1
Received: by mail-il1-f200.google.com with SMTP id a15-20020a92444f000000b0022473393120so2104101ilm.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0jOEqk3duu/S7ny3QESOOgnrnVwgkDjlQfF0n80v8I=;
        b=BBBs/svilQP12KQLT9dX8L8Ut8RC2iKXKeghSvTT9xn3ChsA5LFfF5uXz4YVh/s06v
         ietLCZgLcOCKoiOCu4bOHuois+zGP5fCfPPcJJvdFIwIhEEBSvGezZW4jr+0ckZIkaL0
         yRJmz+Cd63hgPnArfZP60vfXcAYAofcBWqON0n8PMLDhKgCwmB/r1tiwMtQf88kkBIqg
         NvM3+5gKvgapuWrbK2G0TXTNPhclwNZAN6GNqiBCr9mIxb0dLdO22k57/lkUJfejNzAr
         pT4wUNzwf7lH5haaTfzR27HXKplFIQxV79PaAZNaye2EWp6oklSQKtvNBGyxjwXpsfkK
         dGzA==
X-Gm-Message-State: AOAM531c46Y3FFEDtFt+0SaE0LjAPBSu2KnYVAtRiG3AfkPone1oxRjS
        4XC3e6IOkWsk4DsFpT2nfjwU+P5By8IeBfNxvUNJZxzW36z7K+BjnSigyudEEHMZHIOBJHAPR4Q
        Tnm4F+1e3jMA30HbzHheHZW4sXqQUYefmQqvPBGuiSVVmLqSXYcaTjAJ8GX6iJtVZ2HtnCuaSmg
        ==
X-Received: by 2002:a92:c9cd:: with SMTP id k13mr518817ilq.169.1631118921747;
        Wed, 08 Sep 2021 09:35:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaDhl3W2lZk1HaXU2PU7Ni0ECC9fyLGs82p9dRaw7bfzwNvMEP/+GFrjJV2NjJwJoK0CCEOQ==
X-Received: by 2002:a92:c9cd:: with SMTP id k13mr518786ilq.169.1631118921445;
        Wed, 08 Sep 2021 09:35:21 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id b10sm1336961ils.13.2021.09.08.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:35:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 1/5] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Wed,  8 Sep 2021 12:35:12 -0400
Message-Id: <20210908163516.214441-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908163516.214441-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was conditionally done previously, as there's one shmem special case that we
use SetPageDirty() instead.  However that's not necessary and it should be
easier and cleaner to do it unconditionally in mfill_atomic_install_pte().

The most recent discussion about this is here, where Hugh explained the history
of SetPageDirty() and why it's possible that it's not required at all:

https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/

Currently mfill_atomic_install_pte() has three callers:

        1. shmem_mfill_atomic_pte
        2. mcopy_atomic_pte
        3. mcontinue_atomic_pte

After the change: case (1) should have its SetPageDirty replaced by the dirty
bit on pte (so we unify them together, finally), case (2) should have no
functional change at all as it has page_in_cache==false, case (3) may add a
dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
it's merely 100% sure the page is dirty after all, so should not make a real
difference either.

This should make it much easier to follow on which case will set dirty for
uffd, as we'll simply set it all now for all uffd related ioctls.  Meanwhile,
no special handling of SetPageDirty() if there's no need.

Cc: Hugh Dickins <hughd@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c       | 1 -
 mm/userfaultfd.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 88742953532c..96ccf6e941aa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2424,7 +2424,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-	SetPageDirty(page);
 	unlock_page(page);
 	return 0;
 out_delete_from_cache:
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7a9008415534..caf6dfff2a60 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -69,10 +69,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	pgoff_t offset, max_off;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
+	_dst_pte = pte_mkdirty(_dst_pte);
 	if (page_in_cache && !vm_shared)
 		writable = false;
-	if (writable || !page_in_cache)
-		_dst_pte = pte_mkdirty(_dst_pte);
 	if (writable) {
 		if (wp_copy)
 			_dst_pte = pte_mkuffd_wp(_dst_pte);
-- 
2.31.1

