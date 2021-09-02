Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA25F3FF4BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbhIBUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345222AbhIBUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630613847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUFjqTEK/Z5AKo1Agn+ijWYpHJREXXiYmYHdAc5BzAA=;
        b=Kuq3fM/nrZFHmH4UVXImKaJz8MTueKOguF5mvXXt0I2rx+rDFM71VxYxzGpo5ya6xsBCgy
        ALZxQjA4rgEpOaZQ3bBgyX9rmkToGuhvNGdknuYDV0Tk5SXfeMwEj03783YwRxl1wnLg0o
        wRs0kiW90gWrqpgfWdv5w99kXi4IkeQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-R2GBGOSlMwScHPjNzfWzZA-1; Thu, 02 Sep 2021 16:17:26 -0400
X-MC-Unique: R2GBGOSlMwScHPjNzfWzZA-1
Received: by mail-qv1-f69.google.com with SMTP id u8-20020a0cee88000000b00363b89e1c50so3420407qvr.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUFjqTEK/Z5AKo1Agn+ijWYpHJREXXiYmYHdAc5BzAA=;
        b=JsBsiAoNJmrY4taTQZu5UJw4aosk5c3CJOLnFVhfBq9ZGjk401/U4G8Ib5UXekkWii
         u+TXGplkvHp/7hzdb4mzDAkMsQ+r+n7+m8Rh7IQwIzdZrYX9IRg4QZpAPQB/W2aKVens
         kgJyfq/1kamlz6b2hBnr6ogSvleF7WSa+BmvkrJB1Vf03mUhmnwWddEF4FjLhSDOiv7v
         T/830E0GTZOj4shSeaOmW/CQpPdO47tv+d8OpvBX0+zktlBkQjEd8YRQPJGjQtjFPFTW
         WWns+/uPsanZUQCPxn2wqJISkU8ZdQiU8qbSflI7K2r9vC5aH6/6VHJZXm2lvzys7N+T
         HQhg==
X-Gm-Message-State: AOAM531EUUn9moqkyNxo2HylX13fGuNTNkDgCUbD2FqwDp3mPCw4v+DY
        KMXFUiiNcI+wzkZGYfHveVehniYSWeL5NkuQOQqoSh4u7e16kzMpFopOFbB/Asz30YBZCPig28B
        BZklNB8CeZrPV0GUZqyax/n/ZEJ9V0I/UJ7XaZhiwngqtlTtC+oDDsk7Jo8JU8m+sNELRv1jOXg
        ==
X-Received: by 2002:ac8:4891:: with SMTP id i17mr124480qtq.321.1630613845721;
        Thu, 02 Sep 2021 13:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywigrvnlxKpAN78Q/CgPMddaGPkdQXUBfT3wFLvHKkKpWp9wEzSSYfVzG1sJzo6z/t9ArXKA==
X-Received: by 2002:ac8:4891:: with SMTP id i17mr124450qtq.321.1630613845467;
        Thu, 02 Sep 2021 13:17:25 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id m8sm2219962qkk.130.2021.09.02.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:17:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 1/5] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Thu,  2 Sep 2021 16:17:17 -0400
Message-Id: <20210902201721.52796-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902201721.52796-1-peterx@redhat.com>
References: <20210902201721.52796-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c       | 1 -
 mm/userfaultfd.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index dacda7463d54..3f91c8ce4d02 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2437,7 +2437,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-	SetPageDirty(page);
 	unlock_page(page);
 	return 0;
 out_delete_from_cache:
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0e2132834bc7..b30a3724c701 100644
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

