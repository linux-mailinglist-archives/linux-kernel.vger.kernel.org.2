Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EBB3ACE14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhFRO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:58:16 -0400
Received: from pv50p00im-ztdg10021101.me.com ([17.58.6.44]:54030 "EHLO
        pv50p00im-ztdg10021101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234808AbhFRO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624028163; bh=yJ2wc/yTA/kKyoo3dm7VmVcGUb+nPCIAk5AwTpaqjN4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=E1dsB+0oS6yvDKSGweQIjnkjrjcWTYsT8WpBrvni5R2X3DLsHbFVIv2BT/8sjZ8Qj
         jTLMNwYjB6MJfYIVCGNwFctBnjh/DO8pnbmhjgYfcG1TVU0IGS9WalU106NgE2O1sv
         pFOdhVBo9ewScmazCnYxiuXPWB3teHb62Bss7qdYmZOgyFSsQQSpu+E8G6srhiWjDq
         fiwT1VxTH3yvGQLw7JhKhXNVUzj/NuQdFbaodFw6J4glt31wn4pkDcdgnIENMHR3j3
         vn0WKPAW7oDn85gPQMg8PZykqp48DbZ2StOMc0qux8jQ5v5jkCZL3cQcxYH1PZIoZ/
         RJYJb61C9N7Iw==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id A889E1801B2;
        Fri, 18 Jun 2021 14:56:00 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 2/3] locking/lockdep: Unlikely conditons about BFS_RMATCH
Date:   Fri, 18 Jun 2021 22:55:33 +0800
Message-Id: <20210618145534.438816-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618145534.438816-1-sxwjean@me.com>
References: <20210618145534.438816-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106180088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The probability that graph walk will return BFS_RMATCH is slim, so unlikey
conditons about BFS_RMATCH can improve performance a little bit.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a8a66a2a9bc1..cb94097014d8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2750,7 +2750,7 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 	 */
 	ret = check_path(target, &src_entry, hlock_equal, usage_skip, &target_entry);
 
-	if (ret == BFS_RMATCH)
+	if (unlikely(ret == BFS_RMATCH))
 		debug_atomic_inc(nr_redundant);
 
 	return ret;
@@ -2992,7 +2992,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	ret = check_redundant(prev, next);
 	if (bfs_error(ret))
 		return 0;
-	else if (ret == BFS_RMATCH)
+	else if (unlikely(ret == BFS_RMATCH))
 		return 2;
 
 	if (!*trace) {
-- 
2.30.2

