Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7C39F233
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFHJYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:24:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44065 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:24:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UbkfDnd_1623144164;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UbkfDnd_1623144164)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 17:22:45 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com
Cc:     akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Date:   Tue,  8 Jun 2021 17:22:39 +0800
Message-Id: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2432.ga663e714
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We notice that hung task happens in a conner but practical scenario when
CONFIG_PREEMPT_NONE is enabled, as follows.

Process 0                       Process 1                     Process 2..Inf
split_huge_page_to_list
    unmap_page
        split_huge_pmd_address
                                __migration_entry_wait(head)
                                                              __migration_entry_wait(tail)
    remap_page (roll back)
        remove_migration_ptes
            rmap_walk_anon
                cond_resched

Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
copy_to_user in fstat, which will immediately fault again without
rescheduling, and thus occupy the cpu fully.

When there are too many processes performing __migration_entry_wait on
tail page, remap_page will never be done after cond_resched.

This makes __migration_entry_wait operate on the compound head page,
thus waits for remap_page to complete, whether the THP is split
successfully or roll back.

Note that put_and_wait_on_page_locked helps to drop the page reference
acquired with get_page_unless_zero, as soon as the page is on the wait
queue, before actually waiting. So splitting the THP is only prevented
for a brief interval.

Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..41ff2c9896c4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -295,6 +295,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 		goto out;
 
 	page = migration_entry_to_page(entry);
+	page = compound_head(page);
 
 	/*
 	 * Once page cache replacement of page migration started, page_count
-- 
2.20.1.2432.ga663e714

