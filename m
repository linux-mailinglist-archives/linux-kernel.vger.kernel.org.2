Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21536C91F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhD0QTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237430AbhD0QOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tertuAFVCCpsfAn7kyP9pkuWqwtVeARZYQAUe1yux2Y=;
        b=K3feAOJG1lcnZsCe9wPn/CXhYiPxDV4Jvv9Ixj/Le3UhbN2AAvTOdPoOworSV5hUonM4c9
        ZNryWuX14ffHc5p9FO6WhOEdWwsfEoK0DQDrPgJNwAEs4v8+8IpYCscbGAtWhzoi3q4Mat
        dLxOAjDwcJMIgpQ1L/JMiYC4wKVqMfU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-SUz212AmO8K-IgLdfh_iSg-1; Tue, 27 Apr 2021 12:13:24 -0400
X-MC-Unique: SUz212AmO8K-IgLdfh_iSg-1
Received: by mail-qv1-f72.google.com with SMTP id x15-20020a0ce0cf0000b029019cb3e75c62so26246928qvk.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tertuAFVCCpsfAn7kyP9pkuWqwtVeARZYQAUe1yux2Y=;
        b=Q43js53PF01AsYBckhQB/5dJ2JbWipZ1acOlbyDN1LKI9/V+KEz0aZ91y5wVgZUGGX
         CEEWdK/+UjyS22NU8xgaVU5e0WoB2m8ntfNj09S8ikETxsv+a1rzs9OfPq5auRHLun1m
         b90cFcM3LXPiK/6GxF2E/bPSkXdwgzgbrviWWRgvtwvA0cKRLljHkiLFLNHypx00zrAs
         pI1yMppKlFDfNK4q0CLX8T81yy/lWb2DKz6uegjrxz/qu+A/PaZ4ItYAjOixg3BXfoFl
         WzTES8oe2t45/puqqF/ADJBhqRo2OgleSp56K98I2CJFwFEMYaklKQvke3hPOqRzbcgS
         2NDQ==
X-Gm-Message-State: AOAM532Iv8i4L3LWkH4nwHWNxGsK23MRbgwHA0IebZgQ6MiIuJA013jL
        RlQwiQEfoq7YJFKkq8EClNNPD+it9f+APNWZhjPHShJrzmXLG4zzqy58xRfX3EvXc1ig13eiXiF
        deZk/+/VgCqF3Ug8Ivrep79gn
X-Received: by 2002:a05:620a:1439:: with SMTP id k25mr15521479qkj.439.1619540003896;
        Tue, 27 Apr 2021 09:13:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt4RxZQcMhYZdYCMXlw1LswxlEQbOKnDM/0s3R+vwolBpcTn/z++YiH5clcERdhpGhQS5p/Q==
X-Received: by 2002:a05:620a:1439:: with SMTP id k25mr15521457qkj.439.1619540003656;
        Tue, 27 Apr 2021 09:13:23 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 02/24] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Tue, 27 Apr 2021 12:12:55 -0400
Message-Id: <20210427161317.50682-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index ffda19542bc6d..955a0bb6b855c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2618,19 +2618,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
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
 
@@ -3319,7 +3320,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	if (!pte_unmap_same(vmf))
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.26.2

