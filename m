Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269B4345427
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhCWAt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhCWAtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzE2FQvBgwjcQuvAyEoA4yo8mQxpoaRUw1a4rmG7XTE=;
        b=Q50dQBv9zUTR7i9G8B/Q2lfrczzgWDsVmLVHvxdMwy9fIxoYz21kd0k3vX0fqxTTT+V+cs
        QSqZeiTcEPAGNTYCcIlAhkZ9rupGYTJLP0fThtDOtDr8GSeRl8Dh/e4PTIiL6Qkzr1GvS9
        8I1yWdwrLykmLhArRxlt+2BjT3m4C6g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-uGjum31sMsK2UHrmZRRVIQ-1; Mon, 22 Mar 2021 20:49:19 -0400
X-MC-Unique: uGjum31sMsK2UHrmZRRVIQ-1
Received: by mail-qt1-f200.google.com with SMTP id a11so410664qtd.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzE2FQvBgwjcQuvAyEoA4yo8mQxpoaRUw1a4rmG7XTE=;
        b=WS5R7bk4O9CUUaNNTXOXYKpSpuL8EM7ylc98SUeIBZYhhwPlZad7SGkRPXviS9XPhf
         lorB0Oga2TUCZujg71jEPBWpop2z7Zazw52jf9kwfub+2xpZbp8lC1bDQvKckzIoMzT8
         4Eb8MeTUoywAxENY1vrx7eNUOByMCnG8+D4uZR0VhlyMHuflAt32n9dreGQS4ytAfaVs
         XF5Dm2xhGzCeDTRIphrWsBeWAPlhfv3oydgZAmSRw1q2ACOURVl+qjHNNZcK3Y1q8eD3
         D4QP4Awr4ni4O/fcbj+ehcIv9V8Z9tLn8Lk5fFzQ2oy5Jergd7qETBn/I2xJwibK/mpO
         8JVg==
X-Gm-Message-State: AOAM530QJgoMYdAuC2QP/pLRPbzYI3MW6+VVKrau1EhYvcAKdGAYsnzH
        hKvGyZZ6jdo7mxjjfWjcWLi48olVoQJ0yuOSdyuq3IraRpbUWH6PiIDm/YF+z5DFdIw9Dr2jOjS
        wpgbWVmTXgagG1O0v8aHRu/RSj8sMHS+td35TXFSE0Xn7I1y5yzDUNSQkNUoBkTmks9vxog9hIQ
        ==
X-Received: by 2002:ac8:4314:: with SMTP id z20mr2399461qtm.127.1616460558880;
        Mon, 22 Mar 2021 17:49:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGnxyaubPdosmeB8+KjtwtJv00yj3i3xw1XrG7tvd1zJbFrOCn0HMVDuIqra3FYF+x1R7Apg==
X-Received: by 2002:ac8:4314:: with SMTP id z20mr2399429qtm.127.1616460558565;
        Mon, 22 Mar 2021 17:49:18 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 02/23] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Mon, 22 Mar 2021 20:48:51 -0400
Message-Id: <20210323004912.35132-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a458a595331f..d534eba85756 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2607,19 +2607,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
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
 
@@ -3308,7 +3309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	if (!pte_unmap_same(vmf))
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.26.2

