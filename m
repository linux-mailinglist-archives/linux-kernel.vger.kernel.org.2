Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6133CADAA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbhGOURq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240899AbhGOUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMR1rwc2VptPVcJogLZEh7U1JPTpYleS0uDSBMQzgKI=;
        b=Y/J20JSk1AMVC5LLtnG1KaQcoH21HOh9UScpx3/CObrI3ZAiyRznf7DicfEVOAiYocd9JW
        PsKczIvXuzRgY6aRsKybf25lfOMJhKez9ALDaskQL8rK4XemMLAmpojSqqwIgHew0yqUe8
        rFzYaBqYwRVH1/IkCBHokM5S1Bj2pr0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-0j3q9AfIOl-djQpfA_i-Nw-1; Thu, 15 Jul 2021 16:14:32 -0400
X-MC-Unique: 0j3q9AfIOl-djQpfA_i-Nw-1
Received: by mail-qv1-f71.google.com with SMTP id r13-20020a0cf60d0000b02902f3a4c41d77so5004158qvm.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMR1rwc2VptPVcJogLZEh7U1JPTpYleS0uDSBMQzgKI=;
        b=fLaLgtW1ia3khtc0soEuIjpvHHgLOE1hUfH1EZpKGsP61DPXS9ENqe87tb86R6RUUH
         Orlk75ePh+WS4fUUbW+NwQ4kgV+ivVfEQ7rPathJE4aeSGQEi6YWJxP3KLqQdP1GJIBV
         eEfuBq0oHCZ9q53S0hZpDAMya1CZu+gp3RiCk8518aW3ydwBieudxS+rfaaQ3SfuDN9r
         rp+vRqlGS0kUjpJ72QIE1z9L4CCjKmPb2rcCqBfPCy13odL8RxNyFTSBiWbgda+BX1WQ
         qs77z9Fi3tH4ezkOM7tUSsDBB4L07REGtJlWcCvo3dLEdkOtn3+MyYlksRaELGjKnypD
         J/BA==
X-Gm-Message-State: AOAM53368tL2v3hOw9cdX5HYwf//yo90mEOD527J/NYHflZ0yvsM2hmM
        hW49nYLCOhLsKWHEgrIlQGnEHEpRCk+XbSNQXRJaX4u1luhgRbCtW5oEyLP2mGktAgeDQtPSqKT
        v1SFf+BatLxzxEmfDuTYGGcXw
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr6073189qvb.43.1626380072065;
        Thu, 15 Jul 2021 13:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlBHY4Z+BDWvhGa8Yy/XqxFA2nwb1a0Wt+fU8w7V6fJuetg9iU+zAJFMmWY/VEDRE3t+sHtg==
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr6073172qvb.43.1626380071851;
        Thu, 15 Jul 2021 13:14:31 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:31 -0700 (PDT)
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
Subject: [PATCH v5 03/26] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Thu, 15 Jul 2021 16:13:59 -0400
Message-Id: <20210715201422.211004-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
will not be valid any more.  We should clear it.

It was safe only because no one is accessing vmf->pte after pte_unmap_same()
returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
where vmf->pte will in most cases be overwritten very soon.

pte_unmap_same() will be used in other places in follow up patches, so that
vmf->pte will not always be re-written.  This patch enables us to call
functions like finish_fault() because that'll conditionally unmap the pte by
checking vmf->pte first.  Or, alloc_set_pte() will make sure to allocate a new
pte even after calling pte_unmap_same().

Since we'll need to modify vmf->pte, directly pass in vmf into pte_unmap_same()
and then we can also avoid the long parameter list.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 747a01d495f2..0e0de08a2cd5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2724,19 +2724,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
  * proceeding (but do_wp_page is only called after already making such a check;
  * and do_anonymous_page can safely check later on).
  */
-static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
-				pte_t *page_table, pte_t orig_pte)
+static inline int pte_unmap_same(struct vm_fault *vmf)
 {
 	int same = 1;
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spinlock_t *ptl = pte_lockptr(mm, pmd);
+		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 		spin_lock(ptl);
-		same = pte_same(*page_table, orig_pte);
+		same = pte_same(*vmf->pte, vmf->orig_pte);
 		spin_unlock(ptl);
 	}
 #endif
-	pte_unmap(page_table);
+	pte_unmap(vmf->pte);
+	/* After unmap of pte, the pointer is invalid now - clear it. */
+	vmf->pte = NULL;
 	return same;
 }
 
@@ -3487,7 +3488,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	if (!pte_unmap_same(vmf))
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.31.1

