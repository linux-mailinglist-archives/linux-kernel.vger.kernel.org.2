Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DAF3AB6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhFQPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:07:45 -0400
Received: from pv50p00im-ztdg10011201.me.com ([17.58.6.39]:35721 "EHLO
        pv50p00im-ztdg10011201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231712AbhFQPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623942336; bh=sbpr7pTnQ+UXVVLcsU5mLj6Dl52CAls13Z+HWM/69w8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=K0k3mjHRWeulvVqrSnaMfZpiaHxu4nZ1tPf0yQxrh5QUtygwEb6YeQvhcjg1QPTn0
         XqTk8cDxNV7NspGA5s+xFCxqWfQLBjlBP1jBXFkXlBT1uQVVq1w+0ah8hkxLtGJ2v0
         pHovor2bHgWoYHvacnuvvDqgk5yvg1rVEHtIh8zIIt1rHsFZ0NfpEFinw+w4na2nOT
         J0MVRueAXIGsG4W+pFN+Hao5rpBBcQ6kDIey7wSa6PxmmMyRxFbAzbXo9iNuRWRHcU
         +8l+b8DiTcgAVA2SP6/5/u9VT8TxuOMbYSMLBqc26F0Sge1zTObXz3xlI0eFMhH3ki
         H0KX/t3OQ55UA==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id C21922A02CF;
        Thu, 17 Jun 2021 15:05:32 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] locking/lockdep: correct the description error for check_redundant()
Date:   Thu, 17 Jun 2021 23:05:23 +0800
Message-Id: <20210617150523.454965-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_14:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=742 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106170097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

If there is no matched result, check_redundant() will return BFS_RNOMATCH.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cfe0f4374594..1f126ca7fbd7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2726,7 +2726,7 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
  * <target> or not. If it can, <src> -> <target> dependency is already
  * in the graph.
  *
- * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
+ * Return BFS_RMATCH if it does, or BFS_RNOMATCH if it does not, return BFS_E* if
  * any error appears in the bfs search.
  */
 static noinline enum bfs_result
-- 
2.30.2

