Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6F3C93B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhGNWYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236625AbhGNWYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMR1rwc2VptPVcJogLZEh7U1JPTpYleS0uDSBMQzgKI=;
        b=SQwkHQ19TZHyo7CnZQy7vJvwxZZopHJVTblbGjnf0N39g1VApQnAPgw0JgIt8lOnECAuh6
        KG2DdwYRrdixN35vODRweV0wtdwDXvfCQn7tQsUS/vhbQJOjxQb0xbCcB3u78r3vNfQsOX
        sFxK6eVjPbiaA/qqeTDvuykINXMs2Sg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-sOSJmg8BMWSf7MtOLC91sg-1; Wed, 14 Jul 2021 18:21:27 -0400
X-MC-Unique: sOSJmg8BMWSf7MtOLC91sg-1
Received: by mail-qv1-f72.google.com with SMTP id y12-20020a0ceacc0000b02902eaed054a57so2680229qvp.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMR1rwc2VptPVcJogLZEh7U1JPTpYleS0uDSBMQzgKI=;
        b=ikwNYCut4zfeIJ6NN76kgSOx+FMkJ0hVFOx14FCkT4zPuEwo/s/TjKBc7Zh9Js0lyR
         y+xew4E6EAJkjlvgZV9zMzTlpHGIHf5kY3Ck29dhw1+I3y6UVL5bSc8SayVEXatDSNn/
         1ivMLaSSgn9vWBPm4eOIufwvAVzkWpyP2Am5YTjQVIU6hsY0Glu9Z5EjGa8ydN+Msr5d
         VrpXlYHZCTG0Lr4eAE3wQfMADpd3Yr5GG0BLXv3Tp3vC/FmPPChI3NVpvyzITG0+GS+1
         4aUvpcXC7DXPGL3NO7xrEAuFoWlQhgDhMF5741rOnafk8rXTWzBvyVVk9PFGlar1y6VB
         lsow==
X-Gm-Message-State: AOAM530Hm8NcfXlDoPWebsMfhG+twqxWl5KQ5m7DgQPJxWzo1ZTWfKoK
        jJXkL+v3soTgXU9AuGeIHyp/5wrZcxt91Ox/5r3PRTd0uTBQF9Ed9gvKgmc9PICvZlYUX+QQz1C
        g7I9j0fnzR/hqsXip8wdrPxa2H7v2CbVthU3yOS9EB/ewk0+K4BWL0cShJojXHiY7QTZv+qBdLA
        ==
X-Received: by 2002:a05:620a:684:: with SMTP id f4mr223909qkh.258.1626301286530;
        Wed, 14 Jul 2021 15:21:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymnAJAG1s3IIuL8U1KCptLk3RkFUZv2CP2yXs2+mvIhz26/ER+UYtoKJw1cDncE9s3s+WTuw==
X-Received: by 2002:a05:620a:684:: with SMTP id f4mr223873qkh.258.1626301286213;
        Wed, 14 Jul 2021 15:21:26 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:25 -0700 (PDT)
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
Subject: [PATCH v4 03/26] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Wed, 14 Jul 2021 18:20:54 -0400
Message-Id: <20210714222117.47648-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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

