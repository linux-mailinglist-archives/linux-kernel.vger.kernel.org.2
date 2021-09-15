Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4A40CC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhIOSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhIOSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631729703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JtLLJZ1Bt4HNZ1/rns47BurBkMZGMTII6QW5YE/blU=;
        b=KLf87m4zPxPn9vD09SqfneHF0Cay4IxsFrLixUJA2dXB0Yx9ovsUsFp4zeud9rPvSicWrR
        VMO1Y0RAwDobGPlJ4UX4nO2rCla90JIesr/LS7sp12XMP0eBUM6Tg2/SUx1D1IKFnzmUoH
        8v1oDJkL+CmEqIzShT6uADyE5+LlZuI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-DSVhi2deP8aqHnPaWKEFwg-1; Wed, 15 Sep 2021 14:15:02 -0400
X-MC-Unique: DSVhi2deP8aqHnPaWKEFwg-1
Received: by mail-qt1-f197.google.com with SMTP id e6-20020ac84e46000000b0029baad9aaa0so5525425qtw.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JtLLJZ1Bt4HNZ1/rns47BurBkMZGMTII6QW5YE/blU=;
        b=j887spL52ztcaUnlVtqReBONRMkkakrdX7BHz7Ic6uwUymUZ1y0a6bM+Agvpv4dw+S
         xsINQylLqxrIWaoqCEhLqKMu/i7XlohPbfHfGdc/XVt9LLpMZzY+DJhG8Qx9wdoKhlLd
         ch7iEkolyGXlyobGLNB1Qdt/0IjtIhfoj/BROSnnoXn+ihGApK4eXQbHN6Cyww1/LySL
         HMkXggeVpRNOlzdvRdLufKTPqj3BRc+BwAhx7wTmWU87Tmitxy6gSDgR92ArjCNeOIsA
         mXx7F7ft/mfVFsBC+1eUfT8h+CGKuGCQXx4M4+x5sr1EQIDQ6X9bAU9DVvnUqcNmCTtx
         TpJA==
X-Gm-Message-State: AOAM530NGIBnmXHde2N+P6pIw44QVNU1BVVRVcFQq0h16pxW5vPDJqCH
        MQJrxFefjCcWZcBY/SoCmmAg5YO9i4YEQUuK75tP1P58e6tZ0WRf6XvdyuL2+2qUf5H5h98g1bn
        r9E/mN34zYlCqNkwyns+SGkd1
X-Received: by 2002:a37:9445:: with SMTP id w66mr1329159qkd.410.1631729700629;
        Wed, 15 Sep 2021 11:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUlP/bFYTOYGW/AZ/geeOWP7U0B/+waHTXzFWcNOT4AybXR2GPW/I4aEVdSb5hzua//G11kw==
X-Received: by 2002:a37:9445:: with SMTP id w66mr1329128qkd.410.1631729700388;
        Wed, 15 Sep 2021 11:15:00 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id n18sm578663qkn.63.2021.09.15.11.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:14:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 1/4] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Wed, 15 Sep 2021 14:14:53 -0400
Message-Id: <20210915181456.10739-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915181456.10739-1-peterx@redhat.com>
References: <20210915181456.10739-1-peterx@redhat.com>
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
it's merely 100% sure the page is dirty after all because UFFDIO_CONTINUE
normally requires another process to modify the page cache and kick the faulted
thread, so should not make a real difference either.

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

