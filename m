Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35239781C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhFAQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:33:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45773 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhFAQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:33:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UazGnUc_1622565117;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UazGnUc_1622565117)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Jun 2021 00:31:58 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: [PATCH] mm, thp: relax migration wait when failed to get tail page
Date:   Wed,  2 Jun 2021 00:31:41 +0800
Message-Id: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
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
copy_to_user, which will immediately fault again without rescheduling,
and thus occupy the cpu fully.

When there are too many processes performing __migration_entry_wait on
tail page, remap_page will never be done after cond_resched.

This relaxes __migration_entry_wait on tail page, thus gives remap_page
a chance to complete.

Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..df2dc39fe566 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -301,8 +301,11 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	 * is zero; but we must not call put_and_wait_on_page_locked() without
 	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
 	 */
-	if (!get_page_unless_zero(page))
-		goto out;
+	if (!get_page_unless_zero(page)) {
+		pte_unmap_unlock(ptep, ptl);
+		cond_resched();
+		return;
+	}
 	pte_unmap_unlock(ptep, ptl);
 	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 	return;
-- 
2.20.1.2432.ga663e714

