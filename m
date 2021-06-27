Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A243B53B7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhF0O0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:26:03 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:55654 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230304AbhF0O0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624803817; bh=lgolaH+JizXO6M2F/PoTfuO7n7XI8eL5iOkb/EwPJJ8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=vA482aI60WQI9eTfG9taIj6IpMTIa/qh20OJVj8VFkxfjZzjBLfXQM5RCFrYiB3Uy
         09/K1jj0ytKNBMEfiJ/RYIyfGG6qNMwz33Bl1PKzldBJQjzkjQ+JnnVl7jp42rVLE5
         zY1zr/GgZOiO/BqKr6I4aet2Z7xkoWdf9Ao50ux+WuCU5Kk1nglM2xPiZ6caS6AHjH
         rla1j6fPxDI6TNzJ5qTrNGRO2wzM4jfrAFOPAG7H4z+r/7suW5DovmRFDAH4fOTutF
         Atjy13W87pOwwFXlFq3JpTLbKPVD2TONnkfiHYJaX8vat5Ovy5hnxzr+DGChc3glKH
         yF/RDshVxz0+Q==
Received: from xiongwei.. (unknown [120.245.2.115])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 15969B00088;
        Sun, 27 Jun 2021 14:23:33 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] locking/lockdep: Fix meaningless usages output of lock classes
Date:   Sun, 27 Jun 2021 22:23:20 +0800
Message-Id: <20210627142320.455525-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-27_04:2021-06-25,2021-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106270105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

When enabling CONFIG_LOCK_STAT, then CONFIG_LOCKDEP is forcedly enabled.
We can get output from /proc/lockdep, which currently includes usages of
classes. But the usages of classes are meaningless, see the output
below:

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
CONFIG_PROVE_LOCKING undefined setcion to it defined section.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep_proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 806978314496..1b1103ee7dc6 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -73,10 +73,11 @@ static int l_show(struct seq_file *m, void *v)
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
 	seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
-#endif
 
 	get_usage_chars(class, usage);
 	seq_printf(m, " %s", usage);
+#endif
+
 
 	seq_printf(m, ": ");
 	print_name(m, class);
-- 
2.30.2

