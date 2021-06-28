Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC93B65BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhF1PfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:35:01 -0400
Received: from pv50p00im-ztbu10021601.me.com ([17.58.6.57]:40640 "EHLO
        pv50p00im-ztbu10021601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237768AbhF1PUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624893472; bh=giHbjBf++rogiLGAOt9HJUmkwkKfSi+Vn7w9ZvDIEbs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=aOLuUBqQPLCC+7v8dTC5dnj9RauiQqR52DoXxQT1W6ZmR4zDs139xL/weFC2VHLRM
         uBVC7F2Kzf2zQfcMY21RKU6LCZqr7fIGCfCPEmTGvVo5WjHas8rpv1jMNpuq8MgTDM
         Kvk7LkieRdZeMjYrf3arxNA2kZ7BlP5d3mC9S8tjYAAmDpGDU9Tg3esmjq9WbHdnM+
         MjaV0PSunvhXf/yf4kxSEKCuzBSRaaQbipstsU7C9Jq3RZfBrgQnU9sP8N8t1Us/2/
         CDYoAKd7xhLKx9FNIQJDv47gvb/H8AikyKRnr32GyohsFuVUqIco/on0JSS0mOFnyw
         iXQhw49r8JOtA==
Received: from xiongwei.. (unknown [120.245.2.115])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 663A56E05A7;
        Mon, 28 Jun 2021 15:17:49 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2] locking/lockdep: Fix meaningless usages output of lock classes
Date:   Mon, 28 Jun 2021 23:17:08 +0800
Message-Id: <20210628151708.138524-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_12:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106280104
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

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep_proc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 806978314496..a1ec2652d492 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -70,23 +70,25 @@ static int l_show(struct seq_file *m, void *v)
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
 	}
 	seq_puts(m, "\n");
-- 
2.30.2

