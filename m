Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1533FE452
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhIAU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhIAU51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630529790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUFjqTEK/Z5AKo1Agn+ijWYpHJREXXiYmYHdAc5BzAA=;
        b=iPtQ6v8gkKydPOiqfVmHrpRkLwCg6jiDH9dCrNMdpKq/4IIewkE0KMbBnvGhU/WufajKmX
        rbDiKdoR+SRNXQStDA/bt7UAoP9ZtpVDfy5R92vRqp4p0kX2pp8H+yl8jSHFyiNMjmo27E
        GWJFL0f9IN/UUyxpTAuF2ZUHm1eF/nk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-lGKpOB_EO4i3PpgABTrAOQ-1; Wed, 01 Sep 2021 16:56:29 -0400
X-MC-Unique: lGKpOB_EO4i3PpgABTrAOQ-1
Received: by mail-qk1-f197.google.com with SMTP id h186-20020a3785c3000000b00425f37f792aso795875qkd.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUFjqTEK/Z5AKo1Agn+ijWYpHJREXXiYmYHdAc5BzAA=;
        b=kXy6P0aYcRVOtlEG6PBVu+B1sn3jrnQIl7fhT66NAcKGnCS0gFGPw7mxU5sgfc2bb7
         l6OlvjPouDOkr4ob7Y0WleMAadiKDJjwPr6H0InwpPOKDFu0fZHKxi+2aoPkLJewK2kl
         HofOru0IrMJbrYAlZObZRLL6mQZsIHSbqXGW1/QAEDZuF/viaB3zW4R2d1LCPRoArfon
         j3q6/J2/jtlPWzCSNRCdqn+Yyx4bYx7AouXFXaOTwUaibgzUfiTdKlTD0DUQLpo92APG
         m6Mnl6eACEHn9uH8eO3dfTJ1g7eo7b+ao/wEVK5sB6s33YXAlO0ooyIEo/ytRxD84HUx
         YO5Q==
X-Gm-Message-State: AOAM533kCZq6WHN3nd5uSmvb01Utgit7CsykkKma5j7JNw/sdKJj2vc+
        lWo9vKy7xx+jppD/9GCvwvrKF+t+0sASmdTShZCNmOJEhXczd1+1bJc/QjhBm4AGN0+IWG3NebN
        OLO/zOdcopHaeo22Zq5sYYCdG8EPHzhhKJWLp5A185XSTWMRH3BzSzy+W0OilW2iFUNmHhkc4QA
        ==
X-Received: by 2002:a37:741:: with SMTP id 62mr1642020qkh.490.1630529788123;
        Wed, 01 Sep 2021 13:56:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg27bfuu/yWSrJR+ACgldtYrxoQNg/w2ohixTNUzohW/oZaLbtRecN5m3ghvaicA92Bsp6WQ==
X-Received: by 2002:a37:741:: with SMTP id 62mr1641988qkh.490.1630529787864;
        Wed, 01 Sep 2021 13:56:27 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f3sm624865qti.65.2021.09.01.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:56:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 1/5] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
Date:   Wed,  1 Sep 2021 16:56:18 -0400
Message-Id: <20210901205622.6935-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901205622.6935-1-peterx@redhat.com>
References: <20210901205622.6935-1-peterx@redhat.com>
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

