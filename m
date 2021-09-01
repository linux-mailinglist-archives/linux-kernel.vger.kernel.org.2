Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4F3FE453
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhIAU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238528AbhIAU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630529792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H80HJYI0qyzkG5zbmWICcaBUu/kpdbMbG4peNGDuQ4A=;
        b=AQwDPwF/i0xiMQ5H5Y4IHAurf78a6FP9bfIDaGJ8Ejo/InSpzh2H8qLAV1JRHYfI/stkxs
        9xaoaq3kjIedOsox2lESN2/ON8+ARbTOiYd3f68LUMQ8p4wYFyzG2G6ZEuYSZHxpPhDo2t
        By0bGK8FRUsAz3QrxTkrT/msDW7++tE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-I8XtxldKMlaTrocXcnSB3g-1; Wed, 01 Sep 2021 16:56:31 -0400
X-MC-Unique: I8XtxldKMlaTrocXcnSB3g-1
Received: by mail-qt1-f200.google.com with SMTP id q19-20020ac87353000000b0029a09eca2afso843349qtp.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H80HJYI0qyzkG5zbmWICcaBUu/kpdbMbG4peNGDuQ4A=;
        b=i/3m96dKHkMXEPojh0Rj2EQU5U3+FNb5TEf7Xqn0/kZ28hVtxJjhBjerD6nV4UOHq2
         4qm0aKOAOefD7l9UFjEqM/0qPGfVOJys3/NT0RNVjlOhE7qwDoz/IcecLq5w/NiL2N9/
         3S1lXLK6sx5n1+T0P4O8KqdQtiqAFSkXrHnYKXEOAwUI6t6pNg/G4AopAxmj46uc7z+1
         rwjYOq1EpxObdOKrr9h/Lk0mUteKjGsTM/GhmU1c2XUytOKbXKDCAC67xA9HAF6yQA4M
         adqx+2Utt2v9oC6OokvMYP8dg7JEukA5qvqvIpS+TJgSZ6hfMS//Z+/QaPWT3gGzYhib
         FwMg==
X-Gm-Message-State: AOAM530JA4uyYgNFU/URs3i/Jf9y+VN9dLA4dfj0gIjjObJj+tQyDUMY
        GgcAdGADxBKODAdn3uOrAEnkWjiS4TrBUNLJMA7OeoZEyRpPBBcV6GA6FX1sNko+rD+bKOcm6Ec
        pJcFf1YRLsAqj6UCJalEWjvcRDTSgw/0PV48RGfRFnLeuJgcltIletBfBuk4QoZC/dn9LYw7VnA
        ==
X-Received: by 2002:ac8:4241:: with SMTP id r1mr433343qtm.296.1630529790220;
        Wed, 01 Sep 2021 13:56:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfX94m0Q5rz7prZMT3zggqIDbw5ktE9Et7MQf17IWYgA/u195BGGhxvkI+Dg/upwPF/Y2ASQ==
X-Received: by 2002:ac8:4241:: with SMTP id r1mr433306qtm.296.1630529789960;
        Wed, 01 Sep 2021 13:56:29 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f3sm624865qti.65.2021.09.01.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:56:29 -0700 (PDT)
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
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 2/5] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Wed,  1 Sep 2021 16:56:19 -0400
Message-Id: <20210901205622.6935-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901205622.6935-1-peterx@redhat.com>
References: <20210901205622.6935-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..204141e8a53d 100644
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

