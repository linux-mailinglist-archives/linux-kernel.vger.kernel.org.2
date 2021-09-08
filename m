Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D96403DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349801AbhIHQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343797AbhIHQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCBcgdQfSQO0vdlLaUvPYqHDlVPUHtkRpfsoC2DOf1s=;
        b=F+acU++NWq5GgBotjOAd5jfmK0sQKooqoyWL/sgTcVl7kO679ga5M9mUI5/nw2Ct+otLYx
        GeUr1FZxZ3PiahqcAXgi69P4IPPENhmQrq62xeXQI7Lea/L/n8ZDIjw8/E75zMbr+ASC1H
        vdmfJt9cJEu3A//je88IMK9x7XBY4Ts=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-Z9xfEx9QNMizBR7xLuORTg-1; Wed, 08 Sep 2021 12:36:23 -0400
X-MC-Unique: Z9xfEx9QNMizBR7xLuORTg-1
Received: by mail-io1-f69.google.com with SMTP id k6-20020a6b3c060000b0290568c2302268so2198935iob.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCBcgdQfSQO0vdlLaUvPYqHDlVPUHtkRpfsoC2DOf1s=;
        b=NhiE73nAVZmiVD1EcdYqWRjf3O0ozhjVL3sRuMTdxd74S+xBIQHvC2duFlJDMul5tc
         /Wqd0GQJdvkIUQZkQycO+4dFxHNHavh9Z8oSBFphMZO4tzxXPREv+rHElbQaXLVbXtBK
         jul/XqNm+vJgJcKCejn0zWyQRD5RyG8oZ02Drcz+Vo24Mu5P8zE3wGAf/KHo7yECCC5I
         WEU4007+YGikDWBYVln25f8BVYuW8OLF04xPquTcznk1dT/xp8rzeqcxGrSj8h3lZSdy
         kW18X+DP8Dlln9ipIkIV9taLkdU/vd9vjMKfmZ1hNhDR05so8gqF6y0mrp/d2jWbfArJ
         DJ4A==
X-Gm-Message-State: AOAM532cXjrADk2d/FTcvcb7+MeEmNCfmxJie2YjjukfrR+W25AIdKDy
        L2gnFanCmTdCsP+6YvlYQxuLnEgaqqG/qp+K7OmR1GgIdjvmbTWvwrXBw6plUoxZBmn6oHdtV0K
        85pqGKRdhJGVgherwG3RPs69+NZCKfM3/iGW0/hAMyHj3RB8g8SlPfW2BRPjprvuuGBwabmwUXQ
        ==
X-Received: by 2002:a05:6602:d9:: with SMTP id z25mr645564ioe.154.1631118982082;
        Wed, 08 Sep 2021 09:36:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1EbGLCnuAcfZACCBnyvgCaW1SFMtQKrjHJRqiyYZqaaZQiJRFzEufdRaFsqV34fbIanuG2w==
X-Received: by 2002:a05:6602:d9:: with SMTP id z25mr645522ioe.154.1631118981774;
        Wed, 08 Sep 2021 09:36:21 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id n37sm1268406ioz.5.2021.09.08.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:36:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v3 2/5] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Wed,  8 Sep 2021 12:36:19 -0400
Message-Id: <20210908163619.214901-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908163516.214441-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com>
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
Reviewed-by: Liam Howlett <liam.howlett@oracle.com>
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

