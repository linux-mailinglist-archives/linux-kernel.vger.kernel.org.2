Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B893356118
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347841AbhDGBxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347846AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E62CC061765
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=lXqSL1NodLGVhPgvf3TxvfQ3Pft8FvuZOwvv5Jh0BNQ=;
 b=FlfakSxMf6XS9pz7xRsk0OujrO1Y78RHmmo/v92A3WTWxqHlRuojP7dpuZjf1jcdjqeSc
 qyqJph9vO91y4NKAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=lXqSL1NodLGVhPgvf3TxvfQ3Pft8FvuZOwvv5Jh0BNQ=;
 b=SyzMVd/oPjXcTxIr1A09NN6Sy6JN5EtqFXUb6m3buvczgQ6z+XTzaVJKtKnllmdM9j5M1
 aPxK0kiyf3ZhqUYkO11qmeybD7YLnpvV96GI0jWIp+EACru/Mg/MeH1B9aVU7sSnNDnBc+k
 KoSW+sD8JIMrPNMvgDvYJdhyF9IGT+Q3LUMAur5iLxaufNy68Vfa4Fdz60mILR1CZPiQCx8
 xz+MpCbQG9r9eqzGhlfg4dDWaS6vAl+sR4VEDtucW39saGCi7PdpfSX1/j6bqPaeIlzSpGE
 FUNB94XMo5K84qpqdA35DgxBaqyZrZAXjtA5jgO+3sQSjH61yDozMsxOp32w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 604D316068A;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 513F419F31D; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 34/37] mm: rcu safe vma freeing only for multithreaded user space
Date:   Tue,  6 Apr 2021 18:44:59 -0700
Message-Id: <20210407014502.24091-35-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index 2f20a5c5fed8..623875e8e742 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -389,10 +389,12 @@ static void __vm_area_free(struct rcu_head *head)
 void vm_area_free(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
-	call_rcu(&vma->vm_rcu, __vm_area_free);
-#else
-	____vm_area_free(vma);
+	if (atomic_read(&vma->vm_mm->mm_users) > 1) {
+		call_rcu(&vma->vm_rcu, __vm_area_free);
+		return;
+	}
 #endif
+	____vm_area_free(vma);
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.20.1

