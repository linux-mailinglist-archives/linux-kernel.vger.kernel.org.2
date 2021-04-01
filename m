Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1394E351F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhDATV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhDATVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:21:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F7C048F2C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 11:17:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so6571369ybk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SQmWyihLynq1vxlXIZnnYrhWJiVcwsY6ykKbBmHmp/w=;
        b=P0s9nmSUOso3M4IwpWpTuWzReIWrwsNczHXACiQLGjUVD59T6zAZhOZTKqVDoOGZPM
         ELqsOa6/b6oxSB/BpxzS6H8PFYB2iNb3A6Ko5THKzv1XQSjGF0+OV+bAA2hzf1oei2G9
         waMHYgD1BtXe2ARHAGth7KBqipiyJj+jHcsvAVXmhu4iSPF6R/LnnUdRRxE1RXCxCoZF
         DYnGQpp1mo3XFHEyCzTOcvoC2c1sCFBkMLDkU/KUfVUDnbg/WpsvqF33X3hoeqqLqxF9
         6nmCH+s3SYWbdx87hp8/JLThMxWLAoLpf29erRSjdcs/BTJ4EPhMOa4y7k/+x2mi9m4I
         YwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SQmWyihLynq1vxlXIZnnYrhWJiVcwsY6ykKbBmHmp/w=;
        b=JNsWAVaYaGU4Lvu6NrNd03anRsGEARoOP92q3l4EhnvPcVtIf/Bgdy8smXtZDk44kv
         oCIFWeXJeRwA0tvdvXtmGV4eED4zEkJ/EJcpGvymRgSBkWflQAz+YaSPvRZ1xboULlSP
         pRWlEY8XsUB8Y9uTbDjrETSoem2ZWYD0OeJbfLcghlXNtim2IZ47SlJlHrTKspl4tFb0
         KU+RPcLMk3ObxhC503YOkmK43ol/i17d9VFjfOCymREwiJDLzDqPYj7mGxRVA/O+Z0Tz
         7QoglRbMeRjFG5eNTLmyd8zwAybh2qGJJYfTJYUHsvswveiP9m7UYN7XtdJEgWUoDjei
         I6Cw==
X-Gm-Message-State: AOAM532ib9ZhrK4N0Nsad05Xt+1+5kvNIgFP4QYp/oL7qQdVVKaDq766
        McXhD3DaQzNibCrM8x6NnseneW2PzTs=
X-Google-Smtp-Source: ABdhPJw36/jc6xurXz6R7Fq8v13fytweZrUVCqZMZTqkwel5NP1HU4iFmgcBmdujTpkEUebtBKXFFUZhRpM=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:899:1066:21fc:b3c5])
 (user=surenb job=sendgmr) by 2002:a25:6f44:: with SMTP id k65mr12694020ybc.218.1617301071663;
 Thu, 01 Apr 2021 11:17:51 -0700 (PDT)
Date:   Thu,  1 Apr 2021 11:17:38 -0700
In-Reply-To: <20210401181741.168763-1-surenb@google.com>
Message-Id: <20210401181741.168763-3-surenb@google.com>
Mime-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 2/5] mm: do_wp_page() simplification
From:   Suren Baghdasaryan <surenb@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jannh@google.com, ktkhai@virtuozzo.com,
        torvalds@linux-foundation.org, shli@fb.com, namit@vmware.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

How about we just make sure we're the only possible valid user fo the
page before we bother to reuse it?

Simplify, simplify, simplify.

And get rid of the nasty serialization on the page lock at the same time.

[peterx: add subject prefix]

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 mm/memory.c | 58 ++++++++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6920bfb3f89c..e84648d81d6d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2832,49 +2832,25 @@ static int do_wp_page(struct vm_fault *vmf)
 	 * not dirty accountable.
 	 */
 	if (PageAnon(vmf->page)) {
-		int total_map_swapcount;
-		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
-					   page_count(vmf->page) != 1))
+		struct page *page = vmf->page;
+
+		/* PageKsm() doesn't necessarily raise the page refcount */
+		if (PageKsm(page) || page_count(page) != 1)
+			goto copy;
+		if (!trylock_page(page))
+			goto copy;
+		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+			unlock_page(page);
 			goto copy;
-		if (!trylock_page(vmf->page)) {
-			get_page(vmf->page);
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			lock_page(vmf->page);
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
-			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
-				unlock_page(vmf->page);
-				pte_unmap_unlock(vmf->pte, vmf->ptl);
-				put_page(vmf->page);
-				return 0;
-			}
-			put_page(vmf->page);
-		}
-		if (PageKsm(vmf->page)) {
-			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
-						     vmf->address);
-			unlock_page(vmf->page);
-			if (!reused)
-				goto copy;
-			wp_page_reuse(vmf);
-			return VM_FAULT_WRITE;
-		}
-		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
-			if (total_map_swapcount == 1) {
-				/*
-				 * The page is all ours. Move it to
-				 * our anon_vma so the rmap code will
-				 * not search our parent or siblings.
-				 * Protected against the rmap code by
-				 * the page lock.
-				 */
-				page_move_anon_rmap(vmf->page, vma);
-			}
-			unlock_page(vmf->page);
-			wp_page_reuse(vmf);
-			return VM_FAULT_WRITE;
 		}
-		unlock_page(vmf->page);
+		/*
+		 * Ok, we've got the only map reference, and the only
+		 * page count reference, and the page is locked,
+		 * it's dark out, and we're wearing sunglasses. Hit it.
+		 */
+		wp_page_reuse(vmf);
+		unlock_page(page);
+		return VM_FAULT_WRITE;
 	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
 					(VM_WRITE|VM_SHARED))) {
 		return wp_page_shared(vmf);
-- 
2.31.0.291.g576ba9dcdaf-goog

