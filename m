Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA23B73A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhF2OCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:02:01 -0400
Received: from pv50p00im-tydg10011801.me.com ([17.58.6.52]:51581 "EHLO
        pv50p00im-tydg10011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233478AbhF2OB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624975170; bh=U8jC3Z4NOxymfl0o3wyubDPnPgL2VYYqJT5yEYjtwkc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=qdme7DUMDA1fziS5X2m0XVyDx3vCy0QJ6qaR4I2Xu/g9mb7rQMN5gMaCfK57Lyy+J
         NwliffLl/veLsYy6t6ka4Uqy5D4H3H57iry6UoHft7YLPMELnxeJ5dlHceXCXQ2+Kl
         YMolxuO63Y0TweJYAAOMdAF0URpLVRQ1BQlslYEckQY157NoAQwzKkRj33dW3GSjhI
         W50bhDT40LF7wR1nXOEbnFBxMowPvFy/4iNcN/T3NQpl3CKUR3hdMQgP26iSqX69u6
         HoOrouQTCHuCfvHlyqID3wZPEOjiQfihAsXtLn3DaBxY0juzvq5KCTcT46Ndj9sxes
         6W5zEUMBP4ObA==
Received: from xiongwei.. (unknown [120.245.2.115])
        by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 56254660161;
        Tue, 29 Jun 2021 13:59:27 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v3] locking/lockdep: Fix meaningless usages output of lock classes
Date:   Tue, 29 Jun 2021 21:59:16 +0800
Message-Id: <20210629135916.308210-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106290095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

When enabling CONFIG_LOCK_STAT, then CONFIG_LOCKDEP is forcedly enabled.
We can get output from /proc/lockdep, which currently includes usages of
lock classes. But the usages are meaningless, see the output below:

/ # cat /proc/lockdep
all lock classes:
ffffffff9af63350 ....: cgroup_mutex

ffffffff9af54eb8 ....: (console_sem).lock

ffffffff9af54e60 ....: console_lock

ffffffff9ae74c38 ....: console_owner_lock

ffffffff9ae74c80 ....: console_owner

ffffffff9ae66e60 ....: cpu_hotplug_lock

Only one usage context for each lock, this is because each usage is only
changed in mark_lock() that is in CONFIG_PROVE_LOCKING defined section,
however in the test situation, it's not.

The fix is to move the usages reading and seq_print from
CONFIG_PROVE_LOCKING undefined setcion to its defined section. Also,
locks_after list of lock_class is empty when CONFIG_PROVE_LOCKING
undefined, so do the same thing as what have done for usages of lock
classes.

With this patch with CONFIG_PROVE_LOCKING undefined, we can get the
results below:

/ # cat /proc/lockdep
all lock classes:
ffffffff85163290: cgroup_mutex
ffffffff85154dd8: (console_sem).lock
ffffffff85154d80: console_lock
ffffffff85074b58: console_owner_lock
ffffffff85074ba0: console_owner
ffffffff85066d60: cpu_hotplug_lock

a class key and the relevant class name each line.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---

v3: Improve commit log. Thank Longman very much for the comments.
v2: https://lkml.org/lkml/2021/6/28/1549

---
 kernel/locking/lockdep_proc.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 806978314496..b8d9a050c337 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -70,26 +70,28 @@ static int l_show(struct seq_file *m, void *v)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	seq_printf(m, " OPS:%8ld", debug_class_ops_read(class));
 #endif
-#ifdef CONFIG_PROVE_LOCKING
-	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
-	seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
-#endif
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
+		seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
 
-	get_usage_chars(class, usage);
-	seq_printf(m, " %s", usage);
+		get_usage_chars(class, usage);
+		seq_printf(m, " %s", usage);
+	}
 
 	seq_printf(m, ": ");
 	print_name(m, class);
 	seq_puts(m, "\n");
 
-	list_for_each_entry(entry, &class->locks_after, entry) {
-		if (entry->distance == 1) {
-			seq_printf(m, " -> [%p] ", entry->class->key);
-			print_name(m, entry->class);
-			seq_puts(m, "\n");
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		list_for_each_entry(entry, &class->locks_after, entry) {
+			if (entry->distance == 1) {
+				seq_printf(m, " -> [%p] ", entry->class->key);
+				print_name(m, entry->class);
+				seq_puts(m, "\n");
+			}
 		}
+		seq_puts(m, "\n");
 	}
-	seq_puts(m, "\n");
 
 	return 0;
 }
-- 
2.30.2

