Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3303FF4BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbhIBUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345669AbhIBUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630613849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdgHKq2iasOqwEaJuLz/zWtoLSwDiCtJqQzcku8x6HU=;
        b=GebE6rZMIfxERowakbTo+nzkYxn/gNaGAHbiLk213erv6Y/dPr5qlD8XUjTK2Y4VnChHI4
        aw6Elp6GWt1pzpMSnhiMqIqpTjV1tw5Y4IajBKwteS6NufaTUNg6R1d6Lwlhehw8nj/GGx
        dcV9HMiCUMEa5rdKOhKqbd7KC+K5mrU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-8j17q3n3MeOvhZ5beYpT3g-1; Thu, 02 Sep 2021 16:17:28 -0400
X-MC-Unique: 8j17q3n3MeOvhZ5beYpT3g-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac872d60000b029029817302575so2814377qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdgHKq2iasOqwEaJuLz/zWtoLSwDiCtJqQzcku8x6HU=;
        b=Ybp69nY6tGVNaV5FZrtAiyhD0gFUlXK7Eo4CX/ClrKQ0wsKtCmVY2L/e2Aa3Fezs95
         PfJr+CnBfpXLRAP7eXmdWhuskC8CDEtr7TrXJzW4VhV6XLRggE8VAjTqtkepbQljixsP
         JS3M5zadjWxNfnMF5Zvya5LxuEGRq1QBidtPg4ZZFtyEAnt1V2We9Xbj2w0i5dbiyin3
         VkdUuOh5pBWYU7lXI055dv0dkXn53NbABXWBi9zZUlkR1IDWK301aIMshG6sNgiWT5Qn
         BW13dh4QxBtbL2aE7g3VwYt1wRmDiNn1ruUNx0l+n1RCSowhPuJe3BOAV3g0Fd/dYzn7
         ZHKQ==
X-Gm-Message-State: AOAM530Jtw6z1j0Z+cIeIdyFjTcdkSNzx5q5R4FHa3TfKWCed/oxTj32
        kDjpI8uFsHirAhxzFzMM1cr69iEtI3oiYSpE+k6smyo6ttjIoQx5Z1aME5ruk39heY1dxtlngDR
        zzxZCwNKVdpWp6YiqVWx+0yENUJIz0rVyVJaYptonAZKzEDCf7TKIvJdzw7S/IoTal4vXUjO7VA
        ==
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr5073149qkf.225.1630613847450;
        Thu, 02 Sep 2021 13:17:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy538vhBDKUaB7nJWBgP4Dij+Fv0SB/UrIvpqCgIyHMHGnI8luhqctobjoYIX8mKB8YeK+nsw==
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr5073117qkf.225.1630613847180;
        Thu, 02 Sep 2021 13:17:27 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id m8sm2219962qkk.130.2021.09.02.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:17:26 -0700 (PDT)
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
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 2/5] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Thu,  2 Sep 2021 16:17:18 -0400
Message-Id: <20210902201721.52796-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902201721.52796-1-peterx@redhat.com>
References: <20210902201721.52796-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
will not be valid any more, we should clear it.

It was safe only because no one is accessing vmf->pte after pte_unmap_same()
returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
where vmf->pte will in most cases be overwritten very soon.

Directly pass in vmf into pte_unmap_same() and then we can also avoid the long
parameter list too, which should be a nice cleanup.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..7b095f07c4ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2724,19 +2724,19 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
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
+	vmf->pte = NULL;
 	return same;
 }
 
@@ -3487,7 +3487,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	if (!pte_unmap_same(vmf))
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.31.1

