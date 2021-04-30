Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16EF37019A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhD3TzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:55:03 -0400
Received: from server.lespinasse.org ([63.205.204.226]:56609 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhD3Txh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:37 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=8JAcgap2Y6VBqeBYCFSL5shic9T9aRbFwbzzfMi53Zk=;
 b=cHUjMGrj2X1IDinPMY0+dKYe5adB499TJ7H+bfr7ETPsZilLoPfMVym38TQeMy1ziuWpJ
 F9gf1FUC9B6sDyRAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=8JAcgap2Y6VBqeBYCFSL5shic9T9aRbFwbzzfMi53Zk=;
 b=UOOGCy41woDuBjIDj9AxgKSCdxZe8jlgAyT+CGVtOzwTmo1GlRVsIqe2Zdz1vQCn5TA1M
 /JofEHwPBChM0jwFBGv0l1piRk7vawrDfwuf8LY+3xed2fTKScXpJPoombyg5uNGM7eV5ys
 xx3jPzEFN1dABh3CoMDkDS3TWTTz69MLk5zsxFvPx3xklT+UzFtYV9KZhNn5QP/dj3HJLuE
 oWD2jRpym5v+B+ektmeW8VK4vXJsA6jn/3xVM28w/qteRSICYJ9RWdZkWdfSooPqFR0JBEo
 CbTC/gyL58DqgVVo/N8uTUPO51ELndImk4v7llW3NZgVtzXawHqurgd+x5uA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id B03AB160361;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id A135219F524; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 25/29] mm: disable speculative faults for single threaded user space
Date:   Fri, 30 Apr 2021 12:52:26 -0700
Message-Id: <20210430195232.30491-26-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance tuning: single threaded userspace does not benefit from
speculative page faults, so we turn them off to avoid any related
(small) extra overheads.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 463061186827..b5c21585e35f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1321,6 +1321,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 #endif
 
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+	/*
+	 * No need to try speculative faults for kernel or
+	 * single threaded user space.
+	 */
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
 	count_vm_event(SPF_ATTEMPT);
 	seq = mmap_seq_read_start(mm);
 	if (seq & 1)
@@ -1353,7 +1361,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 spf_abort:
 	count_vm_event(SPF_ABORT);
-#endif
+no_spf:
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 	/*
 	 * Kernel-mode access to the user address space should only occur
-- 
2.20.1

