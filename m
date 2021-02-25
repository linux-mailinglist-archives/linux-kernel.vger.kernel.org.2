Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8EB324B56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhBYHgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhBYHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:41 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB0C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g4so3242522pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5/6+cfz5gtBsby2ty8cXFbwclvAT3dDAZAxr63sxVg=;
        b=ibGos30OWkGhK94St7H4ygsjcHlkjiHBe5OfiXsHHCMi8KokCyS8CUUj6+jho55QZL
         vockORGC/YpJq4oaHSlTs5c6p1B9UfpQVf+26G/WLd1nZ974LY3hgX2NJmUkMYjVn4yQ
         Ujdew4CI+s0gBBq1esyGow3zdyEO1HNPG4Nu+VblemfLozhl6TfV9heeBW1Y6yda+KCG
         ZwNpD0fxcntbR75Z5IkbtixArbBQzph7R7+XZvt2GD9uvzBGIY8TRKfX/tfCEbRIHSV3
         CC0zzYWVRQNpMJMgbcTSGTSeXhV2+TIptv1V3XkTbY/+YOAgUaVZRP9s17XEPl+cZ5HS
         dvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5/6+cfz5gtBsby2ty8cXFbwclvAT3dDAZAxr63sxVg=;
        b=BZrWDZkpRlxRzYJmSkLqAPSahsKhNd8XdrurhTfLbnWWhk04/qzSspx4mTD5esHUxn
         wkrmUUa1Rj7qu291qi8BvSVNSDa7Or9t/8UUJLwifNeSN+Vy0AI8etjen7WFlVjfV45t
         GaN26JhiNVDJYtoYXjmLZ/zYszgf/Gvkl4qgVOifyLwYKFzhtvMFwSoSoRhog9Ps1m92
         SGormo2Y1ECGRXMui8Vbo0LvoedJca10wAfuYmx8j9OwbkhbfTD/CUAjS4wnEMzsG4UE
         grTou0UiQ94va8Tv6khKDI21OOAhrPB/Y5P9GB8/QU2VZkntrbarJ3S9wRjkBbKhjj0n
         Gmtw==
X-Gm-Message-State: AOAM531aPAucRmzX+hGpZW786wFOoAxCz0BBaK6PhQw64WsNlTgSovBa
        BDlaspnbgT48ILc70tOYBJ8=
X-Google-Smtp-Source: ABdhPJzlg70x3wr3Y1hic7wjGCwzmQfHI7U2X3bfeBjzjSYddIgrS14TA6tUsoKVfGhF8hS6lxHCYw==
X-Received: by 2002:a62:1412:0:b029:1ec:bc11:31fd with SMTP id 18-20020a6214120000b02901ecbc1131fdmr1997292pfu.76.1614238434086;
        Wed, 24 Feb 2021 23:33:54 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:53 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [RFC 4/6] mm/swap_state: respect FAULT_FLAG_RETRY_NOWAIT
Date:   Wed, 24 Feb 2021 23:29:08 -0800
Message-Id: <20210225072910.2811795-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Certain use-cases (e.g., prefetch_page()) may want to avoid polling
while a page is brought from the swap. Yet, swap_cluster_readahead()
and swap_vma_readahead() do not respect FAULT_FLAG_RETRY_NOWAIT.

Add support to respect FAULT_FLAG_RETRY_NOWAIT by not polling in these
cases.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/memory.c     | 15 +++++++++++++--
 mm/shmem.c      |  1 +
 mm/swap_state.c | 12 +++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..13b9cf36268f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3326,12 +3326,23 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		}
 
 		if (!page) {
+			/*
+			 * Back out if we failed to bring the page while we
+			 * tried to avoid I/O.
+			 */
+			if (fault_flag_allow_retry_first(vmf->flags) &&
+			    (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
+				ret = VM_FAULT_RETRY;
+				delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+				goto out;
+			}
+
 			/*
 			 * Back out if somebody else faulted in this pte
 			 * while we released the pte lock.
 			 */
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
+			vmf->pte = pte_offset_map_lock(vma->vm_mm,
+				vmf->pmd, vmf->address, &vmf->ptl);
 			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
diff --git a/mm/shmem.c b/mm/shmem.c
index 7c6b6d8f6c39..b108e9ba9e89 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1525,6 +1525,7 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
 	shmem_pseudo_vma_init(&pvma, info, index);
 	vmf.vma = &pvma;
 	vmf.address = 0;
+	vmf.flags = 0;
 	page = swap_cluster_readahead(swap, gfp, &vmf);
 	shmem_pseudo_vma_destroy(&pvma);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 751c1ef2fe0e..1e930f7ff8b3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -656,10 +656,13 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long mask;
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
-	bool do_poll = true, page_allocated;
+	bool page_allocated, do_poll;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
+	do_poll = !fault_flag_allow_retry_first(vmf->flags) ||
+		!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
+
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
@@ -838,7 +841,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	pte_t *pte, pentry;
 	swp_entry_t entry;
 	unsigned int i;
-	bool page_allocated;
+	bool page_allocated, do_poll;
 	struct vma_swap_readahead ra_info = {
 		.win = 1,
 	};
@@ -873,9 +876,12 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	}
 	blk_finish_plug(&plug);
 	lru_add_drain();
+
 skip:
+	do_poll = (!fault_flag_allow_retry_first(vmf->flags) ||
+		!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) && ra_info.win == 1;
 	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1);
+				     do_poll);
 }
 
 /**
-- 
2.25.1

