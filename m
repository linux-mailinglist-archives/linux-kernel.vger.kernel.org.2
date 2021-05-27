Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05683936FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhE0UVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235818AbhE0UVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtpikodp79ycSP9XpJQBScIRhvTfN0ZcMiLJ1ThP9JQ=;
        b=iqQuAbPIsdOB5+uVKWixWFNYEESGn83iQJqCEUZZ1qcOyJgnhM5/zaD34Ep834iknw44Be
        A5oSMFLaMII5ibkU3Nsl975yIBJjXM0efGiEC+YqfZx4WL2Ylv74PhaV7SyY/73rPS07JG
        XkAXUCVGNf5VjLN5W0RFAub99jtqTIc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-L9Vee-K_M4OQFb8j3pFnnw-1; Thu, 27 May 2021 16:19:40 -0400
X-MC-Unique: L9Vee-K_M4OQFb8j3pFnnw-1
Received: by mail-qk1-f197.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so1342599qkj.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtpikodp79ycSP9XpJQBScIRhvTfN0ZcMiLJ1ThP9JQ=;
        b=fPGbG/QlkHEu6yKP4SpaVwCLMFY+PKEvTDVtA1ext+WB1piHgQHnevqK4T1OkF7mE/
         4QTbuj08wG/rEc11GmCIeFVLMBrJXKAkhejO8aTny/ApqTFDQC0oUZHJ2MfHR+8Ni/Hc
         +g3rldrJX8e+nHnZOleiLwMalTTUn/R1YAbBYzXxsRufcdDh9C8tBSK+hcEjcq1ANggK
         aHBGKd0QPi/pq/6iWu1UUYdrJhkASkDSBXHoxhirRRphkm19Z0Bw6k2lssBiUfXo7Z3Z
         Ua6L7T3OVTv9RKMTedFGsFk5zu87BX12RMMdJvyCrfD4LO6cy+OM7J9oPEEUJadFPYAH
         ltdw==
X-Gm-Message-State: AOAM532a74EPIHUhPXSMKrEgIqqy4uqenIrnn9sR+/iwgvAqf7Iykj85
        cIS3Uplr0E1jRDrrL+oNxCJ+UgNrQDzFivcBiffoSUIUqVG7NgAk3inrlXm61BfVT7wdNXEexqX
        sJUxfV3SjhFrLYdr0nRbxfSxmBEWs96oJAoVqZhTwQsF/pbtdTP4TOo0Zcbr4ZhKkl7/erdfD2g
        ==
X-Received: by 2002:a37:9b84:: with SMTP id d126mr286664qke.209.1622146779835;
        Thu, 27 May 2021 13:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4BrGFtNQT6/UXbcwV9vau/8TD3QkZQ1uE6aEORoTDdjOwC1wOoNc2OKlNxy0x4hF1f7DlsQ==
X-Received: by 2002:a37:9b84:: with SMTP id d126mr286628qke.209.1622146779507;
        Thu, 27 May 2021 13:19:39 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u14sm2089536qkp.80.2021.05.27.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:19:38 -0700 (PDT)
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
Subject: [PATCH v3 03/27] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Thu, 27 May 2021 16:19:03 -0400
Message-Id: <20210527201927.29586-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index 2b7ffcbca175..0ccaae2647c0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2710,19 +2710,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
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
 
@@ -3441,7 +3442,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	if (!pte_unmap_same(vmf))
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.31.1

