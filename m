Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8F3CADB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbhGOUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242612AbhGOUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wghNqx4JftAFaj2ufqftGGQbCHL8Jx+CkAGBQbGsx4=;
        b=MV33nR12rNV/tssz5p9RcnE5UErRbIqf5khPI0kYBanL+kitJjCdPxETwsSv3NnWUpRI3Z
        IFIyQntluNBH+kd38YXymCpa/t7kQUQgO3ScRjMa6N1IJ2HSvsjazxuL5N43YFB4qY+1Qq
        irgkpHSAtw8pLA+kUWhvk3inmY3ZHcQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-T6coLU7bN7KUvuFpogxSPw-1; Thu, 15 Jul 2021 16:14:41 -0400
X-MC-Unique: T6coLU7bN7KUvuFpogxSPw-1
Received: by mail-qt1-f198.google.com with SMTP id j16-20020ac855100000b029025bf786be09so4899842qtq.20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wghNqx4JftAFaj2ufqftGGQbCHL8Jx+CkAGBQbGsx4=;
        b=LV2f0LWThL/28E5qL96VY+OboK7XHPv+wav5xkP8gVK3M/toTBPiCI6fs6TBzqQtgK
         NkXXG/XK4q0mqP3ajCVMPkb+JJEECazo4gonfSrXqutp6c9wgbzo0nZVl6YnYLBVlQaF
         vy3ppqclq+Bcw63W1s2QxaZzqyshCnU+3qbNlFCXLmEMXGvuThPimdz/MrgfqCPASykO
         +a6dHMQyRRGRollRQK+lEBvn2Wm0lKpNGTyTiw2cUVrpa/Ov3SpGc2WBHypDLX1G6t/9
         SwnfMioTvHE2pXCgaxFf30ldmvE6k2XQAjxUqnmxE57u4tD+qRPcPlQzuFHuTd5H6uyE
         fYnA==
X-Gm-Message-State: AOAM531DEUIzTvoKJG9n9axfEFgZi39LadPaq42JPUqUyxrMa8siCXB6
        e1BkRE9DWIY8F2ozDwl/DujcylMNJW/gUmeZ9PDWVnsMO9hGWPUYeeaHdFNklGwXUS6RbHD/A/4
        NqwGJZYTKs7KDwoBeAiKciXGm
X-Received: by 2002:ac8:7f87:: with SMTP id z7mr5609319qtj.238.1626380068405;
        Thu, 15 Jul 2021 13:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYiIOaBejzNlOkLIIJ+VXgCviFKyIjcPF0DBG/jNzKBWMzDBJuvwvh/GVjLWwetiFqzg2V7Q==
X-Received: by 2002:ac8:7f87:: with SMTP id z7mr5609296qtj.238.1626380068187;
        Thu, 15 Jul 2021 13:14:28 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, peterx@redhat.com
Subject: [PATCH v5 01/26] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Thu, 15 Jul 2021 16:13:57 -0400
Message-Id: <20210715201422.211004-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index 70d9ce294bb4..dc9f95b5fb34 100644
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

