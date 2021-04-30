Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF737019B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhD3TzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:55:05 -0400
Received: from server.lespinasse.org ([63.205.204.226]:47601 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhD3Txh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:37 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=GfsT7km1e4u9essBB1Wu9kC04UOBGN5ahWAVC6IN8es=;
 b=QJjr+jhIyojTjZZUIgmmlJdhwxp1SplGNE0HRwgP8Nt0MWqhEvdhVMBV6dKGh9nbTPbnl
 EwzltSshob+oxI6BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=GfsT7km1e4u9essBB1Wu9kC04UOBGN5ahWAVC6IN8es=;
 b=wKDBDf36V1KWAErgdFzL/otW+avow+vT/EaKwdglJLtyRP95dA3S7xlKS+lK3mwNFj0lj
 MHPXq5SZRut4O8MZby6+wWCIuBmJtC8/Zex9JuElWKPSuaeBrbklTpODIHHKojHY3Qp7Sd2
 aw4XbgGFObcnn57pMDO9JTHRFsG3cDTzhVCXEamUpBn5vRExQ/8E4+1vI8x6HIx2ZEDzkwR
 WGynlLA+SouY0L+mVA+lVh/dbllPZsBTwFI86XwEbVz/jaQWEcVzBLsbhScf1TY/3XqI8cF
 maV2tfOCc2KsvtVGDc/TEZFftizW8kBY1t6UJYzRq1dQRS+JV+xLHrEtv2EQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id B6CC8160365;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id A802819F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 26/29] mm: disable rcu safe vma freeing for single threaded user space
Date:   Fri, 30 Apr 2021 12:52:27 -0700
Message-Id: <20210430195232.30491-27-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance tuning: as single threaded userspace does not use
speculative page faults, it does not require rcu safe vma freeing.
Turn this off to avoid the related (small) extra overheads.

For multi threaded userspace, we often see a performance benefit from
the rcu safe vma freeing - even in tests that do not have any frequent
concurrent page faults ! This is because rcu safe vma freeing prevents
recently released vmas from being immediately reused in a new thread.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 kernel/fork.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7c22bf2b1f9d..18659d802d24 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -381,10 +381,12 @@ static void __vm_area_free(struct rcu_head *head)
 void vm_area_free(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
-	call_rcu(&vma->vm_rcu, __vm_area_free);
-#else
-	kmem_cache_free(vm_area_cachep, vma);
+	if (atomic_read(&vma->vm_mm->mm_users) > 1) {
+		call_rcu(&vma->vm_rcu, __vm_area_free);
+		return;
+	}
 #endif
+	kmem_cache_free(vm_area_cachep, vma);
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.20.1

