Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD435EFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbhDNIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350151AbhDNIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:38:21 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85241C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:37:58 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a2-20020a0568300082b029028d8118b91fso188613oto.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiBo43OFru+bDu0uJ6yuLMmVjzq0Az7R5lB0fiAm//I=;
        b=XTy+w1bUUAQFN9swD0nRJtOWVb602f1PClQTxXfmtBVhcW9gBfZBTW8fdG6scCucET
         CgcpWCAWbeprQUSRVGX9E104UzoreACyFgyh32CjIvSxuQC1SR2fiBAnUFX1/AgpFfYr
         Qhny1WJ50LIoboImNyPOyT1II5zFs7N8uicLZKgkxGktrbim4gQlbwqXDkg1xrGdMROC
         lTaM1QkHXEEySKBsoTf/RWvqse0Zh7peEOtU+wIX47OVCveLe2XWFgS41SWhdnGSV3p2
         bhRDqTApd70l5iQ1Vw2+wLYtPR22DJF1whtxHokp2YdnOKzRh22X5NMVWzYOYBYiarFp
         +cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiBo43OFru+bDu0uJ6yuLMmVjzq0Az7R5lB0fiAm//I=;
        b=kTJJhu95LU713VwUAvwE7VH5m6ezqULAO+P9iHZnQ6CvA+DH1/2UadrE8r9zeo36H4
         vHcCi/yRrtJ3XPJnv3E6GHCGrjaxcIbC4c8EKgpk9qjMfaOHB32qpLG+LIxfs8bVIqWR
         MwSUV6fINsQVmxor6fA+MNZIPetu8l727Y4IbMdvKHVoLUz8VRvDZoTexGxHao1ks4jy
         23EQ0HpzoTypgbbVWVakuRKT60A7CVdJENpUkeIwmmYyzEJIXwFOy5b5RTVguGQwzYJB
         GKh+/HRSdanoUS5GXeP/xpx3KC4soIQrdCjtuy0exPoRyYUwyFBTreb1czNFDSXOd08O
         lhfA==
X-Gm-Message-State: AOAM533WzFz5Ir2q4YzIwsJhRn9qo4zh+5ooXZZHjz07+z90Apv9tG/p
        aYQulIIqJZ0tD3/9eNGvBEg=
X-Google-Smtp-Source: ABdhPJxZ+8mZFMagXaVma1kvisjVi5zf3Pi2LTacRvW5vrRJ5qOpw9T4GVM2FSWCjobVJ2k2t2CpXQ==
X-Received: by 2002:a05:6830:2117:: with SMTP id i23mr10450350otc.331.1618389477980;
        Wed, 14 Apr 2021 01:37:57 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id r19sm284616oie.58.2021.04.14.01.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 01:37:57 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     bsingharora@gmail.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
        Josh Snyder <joshs@netflix.com>
Subject: [PATCH] delayacct: clear right task's flag after blkio completes
Date:   Wed, 14 Apr 2021 16:37:20 +0800
Message-Id: <20210414083720.24083-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was implementing a latency analyze tool by using task->delays and
other things, I found there's issue in delayacct. The issue is it should
clear the target's flag instead of current's in delayacct_blkio_end().

When I git blame delayacct, I found there're some similar issues we have
fixed in delayacct_blkio_end().
'Commit c96f5471ce7d ("delayacct: Account blkio completion on the correct task")'
fixed the issue that it should account blkio completion on the target
task instead of current.
'Commit b512719f771a ("delayacct: fix crash in delayacct_blkio_end() after delayacct init failure")'
fixed the issue that it should check target task's delays instead of
current task'. It seems that delayacct_blkio_{begin, end} are error prone.
So I introduce a new paratmeter - the target task 'p' into these helpers,
after that change, the callsite will specifilly set the right task, which
should make it less error prone.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josh Snyder <joshs@netflix.com>
---
 include/linux/delayacct.h | 20 ++++++++++----------
 mm/memory.c               |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 2d3bdcccf5eb..21651f946751 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -82,16 +82,16 @@ static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
 		return 0;
 }
 
-static inline void delayacct_set_flag(int flag)
+static inline void delayacct_set_flag(struct task_struct *p, int flag)
 {
-	if (current->delays)
-		current->delays->flags |= flag;
+	if (p->delays)
+		p->delays->flags |= flag;
 }
 
-static inline void delayacct_clear_flag(int flag)
+static inline void delayacct_clear_flag(struct task_struct *p, int flag)
 {
-	if (current->delays)
-		current->delays->flags &= ~flag;
+	if (p->delays)
+		p->delays->flags &= ~flag;
 }
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
@@ -114,7 +114,7 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
 
 static inline void delayacct_blkio_start(void)
 {
-	delayacct_set_flag(DELAYACCT_PF_BLKIO);
+	delayacct_set_flag(current, DELAYACCT_PF_BLKIO);
 	if (current->delays)
 		__delayacct_blkio_start();
 }
@@ -123,7 +123,7 @@ static inline void delayacct_blkio_end(struct task_struct *p)
 {
 	if (p->delays)
 		__delayacct_blkio_end(p);
-	delayacct_clear_flag(DELAYACCT_PF_BLKIO);
+	delayacct_clear_flag(p, DELAYACCT_PF_BLKIO);
 }
 
 static inline int delayacct_add_tsk(struct taskstats *d,
@@ -166,9 +166,9 @@ static inline void delayacct_thrashing_end(void)
 }
 
 #else
-static inline void delayacct_set_flag(int flag)
+static inline void delayacct_set_flag(struct task_struct *p, int flag)
 {}
-static inline void delayacct_clear_flag(int flag)
+static inline void delayacct_clear_flag(struct task_struct *p, int flag)
 {}
 static inline void delayacct_init(void)
 {}
diff --git a/mm/memory.c b/mm/memory.c
index 550405fc3b5e..a013d32a6611 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3296,7 +3296,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 
-	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
+	delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry, vma, vmf->address);
 	swapcache = page;
 
@@ -3347,7 +3347,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					vmf->address, &vmf->ptl);
 			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
-			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+			delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 			goto unlock;
 		}
 
@@ -3361,13 +3361,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * owner processes (which may be unknown at hwpoison time)
 		 */
 		ret = VM_FAULT_HWPOISON;
-		delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+		delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 		goto out_release;
 	}
 
 	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
 
-	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+	delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 	if (!locked) {
 		ret |= VM_FAULT_RETRY;
 		goto out_release;
-- 
2.18.2

