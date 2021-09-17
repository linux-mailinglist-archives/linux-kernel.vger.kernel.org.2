Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1A40FE22
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbhIQQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240641AbhIQQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631897285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhwkRZZomqS7IRkM943StXbgZUJTllJV3QENdXcVkKA=;
        b=IVZqccw4s4mJKJ0CTjNlKwLG1Mnh6kCS+F0amBl3ggZEB9QftqYR5/mqrak99feIYRMZsS
        HdX9d73V+xhyLSsEiHnLpXUhCNJDt4cY0GjL5Mb2FLZit5uA3hRFKLlxXz1czF2iRt7qUa
        C8zW2FNCMJxWT/Enbq3RxTfkl6lrL88=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-PdQzTptdPC2XjnSBia1N_Q-1; Fri, 17 Sep 2021 12:48:05 -0400
X-MC-Unique: PdQzTptdPC2XjnSBia1N_Q-1
Received: by mail-qv1-f70.google.com with SMTP id r18-20020a056214069200b0037a291a6081so92536180qvz.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhwkRZZomqS7IRkM943StXbgZUJTllJV3QENdXcVkKA=;
        b=MxJBzSj8GXZJHOy8Nwh691oZZ+WPywj5JaVam3J1qp9xa+RIrHLovH0OmhTxauagOr
         D6c8xobYW8HiStKTnNDNoRJ5gdfWhbGe8V0fR8fBLvCP0sNTX3exsnyGRoOgVmarWZjX
         Qn3ccr/drJOa1hwIQoqs40YfvKvRo0Zwk3SYEtNQOME416P1PIhOeO/DQ5NVyRoCTZSR
         jRKnHPlHh8pR1VjftyJ4hm+krrArLI2mGAktPxhDcDoAmfFLRizgUuVPMfn0vYZKH6d/
         IBzf7ZCcRY5+psVSG5AekF33GCixsR7GuMiqdfdvJ2WYaHzcvP/3SpKUU9z8TY+p1zYA
         DAQg==
X-Gm-Message-State: AOAM532bWch6v67FWSOwaBDT9AnMGi8v/K8+hXzCpfkYJixjQdSe34iD
        k+GrEn4OUzAfZwMGfICto2cBbkxvyBgJUsQ90DrcuK8B6SfMMafANwGUCJ+GJxAZTlyR1K+oAal
        xKxFaiXNWi3yFFN9/Yozz3PdS
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr11380270qto.63.1631897284384;
        Fri, 17 Sep 2021 09:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1nXcUZuUXlV6357X6Rp9A+NjJOAP7ILOrMrY0DUvD6B4OVjkMZ8OBuC+G4k8LXezyzfvUjQ==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr11380251qto.63.1631897284165;
        Fri, 17 Sep 2021 09:48:04 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id t26sm4898057qkm.0.2021.09.17.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:48:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/3] mm/smaps: Simplify shmem handling of pte holes
Date:   Fri, 17 Sep 2021 12:47:56 -0400
Message-Id: <20210917164756.8586-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917164756.8586-1-peterx@redhat.com>
References: <20210917164756.8586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, check_shmem_swap variable is actually not necessary, because it's
always set with pte_hole hook; checking each would work.

Meanwhile, the check within smaps_pte_entry is not easy to follow.  E.g.,
pte_none() check is not needed as "!pte_present && !is_swap_pte" is the same.
Since at it, use the pte_hole() helper rather than dup the page cache lookup.

Still keep the CONFIG_SHMEM part so the code can be optimized to nop for !SHMEM.

There will be a very slight functional change in smaps_pte_entry(), that for
!SHMEM we'll return early for pte_none (before checking page==NULL), but that's
even nicer.

Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2197f669e17b..ad667dbc96f5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -397,7 +397,6 @@ struct mem_size_stats {
 	u64 pss_shmem;
 	u64 pss_locked;
 	u64 swap_pss;
-	bool check_shmem_swap;
 };
 
 static void smaps_page_accumulate(struct mem_size_stats *mss,
@@ -490,6 +489,16 @@ static int smaps_pte_hole(unsigned long addr, unsigned long end,
 #define smaps_pte_hole		NULL
 #endif /* CONFIG_SHMEM */
 
+static void smaps_pte_hole_lookup(unsigned long addr, struct mm_walk *walk)
+{
+#ifdef CONFIG_SHMEM
+	if (walk->ops->pte_hole) {
+		/* depth is not used */
+		smaps_pte_hole(addr, addr + PAGE_SIZE, 0, walk);
+	}
+#endif
+}
+
 static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		struct mm_walk *walk)
 {
@@ -518,12 +527,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			}
 		} else if (is_pfn_swap_entry(swpent))
 			page = pfn_swap_entry_to_page(swpent);
-	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
-							&& pte_none(*pte))) {
-		page = xa_load(&vma->vm_file->f_mapping->i_pages,
-						linear_page_index(vma, addr));
-		if (xa_is_value(page))
-			mss->swap += PAGE_SIZE;
+	} else {
+		smaps_pte_hole_lookup(addr, walk);
 		return;
 	}
 
@@ -737,8 +742,6 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 		return;
 
 #ifdef CONFIG_SHMEM
-	/* In case of smaps_rollup, reset the value from previous vma */
-	mss->check_shmem_swap = false;
 	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
 		/*
 		 * For shared or readonly shmem mappings we know that all
@@ -756,7 +759,6 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 					!(vma->vm_flags & VM_WRITE))) {
 			mss->swap += shmem_swapped;
 		} else {
-			mss->check_shmem_swap = true;
 			ops = &smaps_shmem_walk_ops;
 		}
 	}
-- 
2.31.1

