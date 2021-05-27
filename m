Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA93936F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhE0UVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhE0UVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhEVhq4PGqE11D2YgrHebPE630Tm9aX+8YBhc8WEcaU=;
        b=OqUvHBS9ps9YSfDhyHmVYHNBA87hSkTuiw1jJ2EqmkCJOmq3V/SHtNQjJqGopR2qByGMSZ
        VphqCSQw9OzZD+qZ7ir1dL7VPRCVAJCbaLCZwx4NcCkL/TljwsombiCBES6WJtJ/+Af8Xz
        jGG7u0wXWYrKmOfyvh3B7y+Hotvn4eI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-ttVxNxfRPqyAt69MD9bm4g-1; Thu, 27 May 2021 16:19:36 -0400
X-MC-Unique: ttVxNxfRPqyAt69MD9bm4g-1
Received: by mail-qt1-f198.google.com with SMTP id h7-20020ac846c70000b0290231af0e7829so868938qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hhEVhq4PGqE11D2YgrHebPE630Tm9aX+8YBhc8WEcaU=;
        b=OZnVB7aByatoKLNrbH9fQghhUt6OAhPRxovlMr9SI51d9sY30z0vLss5m1kAOQrQIB
         6vhdiqWB8R1pxQZRR9gfzdS+mApboHcXwWJLE9JV2QyCeIxWDD/3jihmL0THR3EMCDSW
         oNm8aXqaYhMKdXnOJmCt5Yb2K/tVPEki5F1guk3GrA5kLmwkmxMcuZpJqBbkYSoMRdR1
         wchjO1TC3wJP99FYPOjaGRAkXUX2+d4/6XLOcIIX9Yycq6kwfMaP2h4QEdIJ2QQUDGRk
         Aj6RWBQbLtOZcoCFDyPYEliu7ulO8L/A2FNYL9ApYCCPzVC1LCrERN18SHrBAHfPzRwc
         kpsg==
X-Gm-Message-State: AOAM530IWFQQj93kXTguiT9Vd9MZkCT9+fSJRQg7rYcBK3atBM8M193C
        4B7Sw7MtHTRTZOcPb0orO45a2GB+H/Dhh1xYdCK0nP3AG4ypagAJfNuhydEWjTNi7EID7aHuPAH
        0feMHKg7Oi7xVnhb85zH8ctQgVeyFY857242/Xx5DQK/v7r3ca5ET1ITWNc4QtNMURzhcihp+Jg
        ==
X-Received: by 2002:a05:620a:56a:: with SMTP id p10mr329570qkp.238.1622146774459;
        Thu, 27 May 2021 13:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhQTpN08TmWtg7+wKKOD9e8MtoWozMDaw4Mi24l38BYVLrAve1MtC/JueAUjGIQC5CxsYQeQ==
X-Received: by 2002:a05:620a:56a:: with SMTP id p10mr329530qkp.238.1622146774179;
        Thu, 27 May 2021 13:19:34 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u14sm2089536qkp.80.2021.05.27.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:19:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 01/27] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Thu, 27 May 2021 16:19:01 -0400
Message-Id: <20210527201927.29586-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index ccce139d4e5c..4085a5cf4a13 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2449,7 +2449,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-	SetPageDirty(page);
 	unlock_page(page);
 	return 0;
 out_delete_from_cache:
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9ce5a3793ad4..462fa6e25e03 100644
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

