Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB13ACE15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhFRO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:58:20 -0400
Received: from pv50p00im-ztdg10021101.me.com ([17.58.6.44]:54336 "EHLO
        pv50p00im-ztdg10021101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234805AbhFRO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624028167; bh=0O3l7oGjkhbOmiexAlPi5k5xB5f/6DpbDCfWzs5crZI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=jaT5Thp4tLcysIuPd5D8En03QdSz2PaczKtsQkGxKOkWp/EPg5FmvuE3E9S9FMvyk
         9pQWsNop+ZkdjdZYKgh/IK/gPwj1BOmWniIqPIKdJUMULzJz8MEXVX1dmUeSABHlhH
         w0WY9iyoGwZaxAHp05Gk/no2alFab57I84N68O6b9gtU8RTPw6dFPa+Q9KGBK1xgwD
         BIoQ3m9PlVsMNObcbcKe9U7RwWlPVJQj3zoHrLnXrYT9ndO5aCFEiQYHW8/8CSmHWb
         Cka1yw0whtJbmTVcGfogI7/dLPVEDocDD9vfUK4NeUUXb9sRfyctE9b8ouNkUq+Yq+
         tCPX8b5bt7DkA==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 57F6F1803AF;
        Fri, 18 Jun 2021 14:56:04 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 3/3] locking/lockdep: Print possible warning after counting deps
Date:   Fri, 18 Jun 2021 22:55:34 +0800
Message-Id: <20210618145534.438816-4-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618145534.438816-1-sxwjean@me.com>
References: <20210618145534.438816-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106180088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The graph walk might hit error when counting dependencies. Once the
return value is negative, print a warning to reminder users.

However, lockdep_unlock() would be called twice if we call print_bfs_bug()
directly in __lockdep_count_*_deps(), so as the suggestion from Boqun:
"
Here print_bfs_bug() will eventually call debug_locks_off_graph_unlock()
to release the graph lock, and the caller (lockdep_count_fowards_deps())
will also call graph_unlock() afterwards, and that means we unlock
*twice* if a BFS error happens... although in that case, lockdep should
stop working so messing up with the graph lock may not hurt anything,
but still, I don't think we want to do that.

So probably you can open-code __lockdep_count_forward_deps() into
lockdep_count_forwards_deps(), and call print_bfs_bug() or
graph_unlock() accordingly. The body of __lockdep_count_forward_deps()
is really small, so I think it's OK to open-code it into its caller.
"
we put the code in __lockdep_count_*_deps() into lockdep_count_*_deps().

Suggested-by: Waiman Long <longman@redhat.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 45 +++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cb94097014d8..c29453b1df50 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2024,55 +2024,52 @@ static bool noop_count(struct lock_list *entry, void *data)
 	return false;
 }
 
-static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
-{
-	unsigned long  count = 0;
-	struct lock_list *target_entry;
-
-	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
-
-	return count;
-}
 unsigned long lockdep_count_forward_deps(struct lock_class *class)
 {
-	unsigned long ret, flags;
+	unsigned long count = 0, flags;
 	struct lock_list this;
+	struct lock_list *target_entry;
+	enum bfs_result result;
 
 	__bfs_init_root(&this, class);
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
-	ret = __lockdep_count_forward_deps(&this);
-	lockdep_unlock();
-	raw_local_irq_restore(flags);
 
-	return ret;
-}
+	result = __bfs_forwards(&this, (void *)&count, noop_count, NULL, &target_entry);
 
-static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
-{
-	unsigned long  count = 0;
-	struct lock_list *target_entry;
+	if (bfs_error(result))
+		print_bfs_bug(result);
+	else
+		lockdep_unlock();
 
-	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
+	raw_local_irq_restore(flags);
 
 	return count;
 }
 
 unsigned long lockdep_count_backward_deps(struct lock_class *class)
 {
-	unsigned long ret, flags;
+	unsigned long  count = 0, flags;
 	struct lock_list this;
+	struct lock_list *target_entry;
+	enum bfs_result result;
 
 	__bfs_init_root(&this, class);
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
-	ret = __lockdep_count_backward_deps(&this);
-	lockdep_unlock();
+
+	result = __bfs_backwards(&this, (void *)&count, noop_count, NULL, &target_entry);
+
+	if (bfs_error(result))
+		print_bfs_bug(result);
+	else
+		lockdep_unlock();
+
 	raw_local_irq_restore(flags);
 
-	return ret;
+	return count;
 }
 
 /*
-- 
2.30.2

