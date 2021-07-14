Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1C3C93AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhGNWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhGNWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wghNqx4JftAFaj2ufqftGGQbCHL8Jx+CkAGBQbGsx4=;
        b=gikX1saJLmrJRtNUrY3dGU4VRZeAUtoPlk+cxJp/KFLFe5+K9wna4pRznf2F0o/DXySpIG
        lqNB0P/LTc+xyNa9wP5JNgtopYU8492SDfYFQfy24RgIMHae+LHnPlDVldQAn28hlBDv+N
        6QS8l1JZitBMgiVy59u5DKzp/IlsaX8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-VAwzc0CNOg-07u10EOQodQ-1; Wed, 14 Jul 2021 18:21:23 -0400
X-MC-Unique: VAwzc0CNOg-07u10EOQodQ-1
Received: by mail-qv1-f69.google.com with SMTP id l4-20020a0ce0840000b02902cec39ab618so2708059qvk.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wghNqx4JftAFaj2ufqftGGQbCHL8Jx+CkAGBQbGsx4=;
        b=ShSfJOVfUO+hkw67BG/BpOk5jmyVc8lyswFIjf3XG0TLce6mJYaWWhqUDLTZAK6xAi
         j30eIfWlX+CsatKpVjUoP2BPU2MYAmbYMpDfMgR5oLjQY0eJWFw3sYR0+8B8DffrSY07
         KYy6MqcNEcmYmbaK2mnC5T7Gemt4lG1sUEPqRRclOU++u3VTZ2Y+V75/fUK4DdB45BYy
         jZFGL1vjzkD/0jcvnu8JFVMpCjbZnCUSo+XonboTW2HtMyXazaZ6BBuOjcKsm/T3kReY
         xow/VlD4ln6PtZ2vnUNvHpQHf9NEcHIjULTBmCGS9H83HxMoqoo7nD9kecMxut88otJn
         4ypA==
X-Gm-Message-State: AOAM5319XuRnfmAuqDVH9PT8QD4XlvIqN9/taK80Yy3L1/FKXTUAMu5f
        oX5Rje5aTfrErtknhbgOqZEURLN+ekcz1EfrB51VLTVPfp7UcSF7VO06E5sTF3ol8jV0xUFySvc
        2vY+zzz2GbKHSfGfJCAn8lF6wCKmexbBTaxO4P1GrxyE/Uyew7DjmntkNzl7fbNmwaMt7dIXTxQ
        ==
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr187851qkj.495.1626301282899;
        Wed, 14 Jul 2021 15:21:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHBJUlax/lXVspNfFXeao9SZKZfEe/LZ0w2Bg7nDn4nRH7cKQmqRx3VxQaS8Lv2fCmBULSGw==
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr187816qkj.495.1626301282594;
        Wed, 14 Jul 2021 15:21:22 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 01/26] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Wed, 14 Jul 2021 18:20:52 -0400
Message-Id: <20210714222117.47648-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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

