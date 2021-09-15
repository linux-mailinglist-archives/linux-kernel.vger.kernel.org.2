Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B133A40CC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhIOSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhIOSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631729737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCBcgdQfSQO0vdlLaUvPYqHDlVPUHtkRpfsoC2DOf1s=;
        b=jVdUfGfoaK69uuH66J18ya2Q7Gb2TkGmwajOXQHIUzNKzqwDOx1sQWxgZPpbCKm9/5OQ3T
        f3rSGAZDMc/fDvUE4mwO/p7VFnahaGlPlZyIz+a7QCebwe9KeoEibdaS7/Wm1STa0zMGZq
        JiBpby7kktu6ZOsCiKk8/3rYNZSMu04=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-BNo0JLnLO4inNm8xuOMwCw-1; Wed, 15 Sep 2021 14:15:36 -0400
X-MC-Unique: BNo0JLnLO4inNm8xuOMwCw-1
Received: by mail-qk1-f199.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so6234653qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCBcgdQfSQO0vdlLaUvPYqHDlVPUHtkRpfsoC2DOf1s=;
        b=L6zQ3UBNrZUIvXq33f/gHFP3aAmvTPrq9ePEtyZqxUZPTmcoqAtk6u1kECtMJJ2y+S
         M8+smvvrrF94K8wZdFwIhV28sY7xXvjnzkC9eeCgMce4F1bTM8ZRdVCcDjTcT0ZE4MYb
         SIwnAM6fvnve10p6kBYNWVTtLzh/HZJNiuOmUqrMjYBnclfmwJlfugaficXyi4W6MkeV
         SIPHkQuJgUuSTnDPhqsiLevpzd3kdixi7JQ61XZY+CGj+DBM+xdlUWIajbkD6Go4ZUpy
         2IVp09YQ0dRn8CxJvqA6SitpMA2OJLNJTf8I/TCJwYC8nhMueW5xtYa3xpE4OEa+ftqb
         KbLA==
X-Gm-Message-State: AOAM531Y4I+LVMgvqjnrpUyIvoPb4sqaoiUzKXeGjm7UqXskQ3Qcb6Xx
        xQuMJi/kJVWIElWjKW9yof2/pQN7tryn2AbiBqXniM47gX2K3dXoxafmnzS1AZFTVdLfYlKUsM9
        TLoM5nJmb6V930W3cV7lmGLUOJbk4uQNrB3XVZg0X3AQo/VmRq9+VkAPyIhHYx4XvuTwELvDJpw
        ==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr1259147qkg.97.1631729735589;
        Wed, 15 Sep 2021 11:15:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNOKoWdJ3QZ+W2MJPuiiol1pHZKM860TkZUW+41Zl1wmq7UcHBNIiRCGRpEP4med2lISCytQ==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr1259106qkg.97.1631729735316;
        Wed, 15 Sep 2021 11:15:35 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id a9sm554724qko.27.2021.09.15.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:15:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v4 2/4] mm: Clear vmf->pte after pte_unmap_same() returns
Date:   Wed, 15 Sep 2021 14:15:33 -0400
Message-Id: <20210915181533.11188-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915181456.10739-1-peterx@redhat.com>
References: <20210915181456.10739-1-peterx@redhat.com>
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

