Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A549F370189
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhD3Tx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:58 -0400
Received: from server.lespinasse.org ([63.205.204.226]:37105 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhD3TxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:24 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=AZMDU3YPUBP+A8E2sGu7mqnPCKXc6C4guT20cQnVLhI=;
 b=/pCAvRaOx2Si6FofNn8xF8A4WTxfnjNRKNUDSB8g0cwI/beqZTwY7cyDrJpAZu0D/iqo3
 LQUWoCnxovEtWzLBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=AZMDU3YPUBP+A8E2sGu7mqnPCKXc6C4guT20cQnVLhI=;
 b=ZkO9R1pq60ZomZNC7gBkDtC53nRGzuc/y5a8x0+AHLNqjySZhHkBI3MVnw/GNC4XOaKpz
 AuHxRAomu7xORLhD1hDjxg1DPb9z84v9e8VwekRDtkFt/w/d/cvL9Ga/JKkiGTXTtB4k3Xu
 nSS/6Q9uOT3hkIFe8dy2U/5rg4Wx02H2Oo+kbx3vaYoVMYzMuqZKTuR5GHKJsrGlZxq1C7N
 hDXG6idcwcAw43SyrQKhk7slDaGxm5XGk92fRHU8dyIrcsMSw4/mRw/h35DQjLrZKPL8+Fa
 DHmlnOgonJqUpHWSCLosdIeh3ActgiuBby9lV33SymfaV0UyGKoWtugQjxMg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 61BFE160324;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 5277D19F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 13/29] mm: add speculative_page_walk_begin() and speculative_page_walk_end()
Date:   Fri, 30 Apr 2021 12:52:14 -0700
Message-Id: <20210430195232.30491-14-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speculative page faults will use these to protect against races with
page table reclamation.

This could always be handled by disabling local IRQs as the fast GUP
code does; however speculative page faults do not need to protect
against races with THP page splitting, so a weaker rcu read lock is
sufficient in the MMU_GATHER_RCU_TABLE_FREE case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 8258ff93a055..b28047765de7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2566,6 +2566,28 @@ int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+/*
+ * speculative_page_walk_begin() ... speculative_page_walk_end() protects
+ * against races with page table reclamation.
+ *
+ * This is similar to what fast GUP does, but fast GUP also needs to
+ * protect against races with THP page splitting, so it always needs
+ * to disable interrupts.
+ * Speculative page faults only need to protect against page table reclamation,
+ * so rcu_read_lock() is sufficient in the MMU_GATHER_RCU_TABLE_FREE case.
+ */
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+#define speculative_page_walk_begin() rcu_read_lock()
+#define speculative_page_walk_end()   rcu_read_unlock()
+#else
+#define speculative_page_walk_begin() local_irq_disable()
+#define speculative_page_walk_end()   local_irq_enable()
+#endif
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
-- 
2.20.1

