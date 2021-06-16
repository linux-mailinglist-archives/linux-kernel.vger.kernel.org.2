Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EB03A9DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhFPOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:44:43 -0400
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:60303 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233919AbhFPOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623854556; bh=u1X+vt8zI6f6plB9FC1PC3QZFqTsSMdz/tE/Bb75RRk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=WrnIglfVudnLX73s4JDh7q6WjGXSJIDxhbuti2wnu5rdHFG8SIR3UQphbepgf3Nl1
         xQRc2rp4D75MKaYQxWfSytlv7dbke7lrgM6naIbnYkx56BzvOR48uCEjYFEtc5Nrmp
         d7xVaX0CDt/ufBRfA+fv7m2c/yULpuTRLaIz0tmLl5SNKkT65kvd2IhbIdN+jgiAWC
         nW4DRTcygqDunahkL/MQ9ZEWT9YOmrHoDBUGCxaUo50Xp/sCI0eMXVbtRmFbY3eznx
         8JJssPY4Xt31Pb2EHfLzgN69lN6jTEka7iwH84awE5cZY0d4nEDNEZ9OEyBUF+jRUH
         cg48FuTebDRCw==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 58A839005F1;
        Wed, 16 Jun 2021 14:42:27 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] locking/lockdep: unlikely bfs error check
Date:   Wed, 16 Jun 2021 22:42:09 +0800
Message-Id: <20210616144210.278662-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106160085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The error from graph walk is small probability event, so unlikely
bfs_error can improve performance a little bit.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 074fd6418c20..af8c9203cd3e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2646,7 +2646,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	bfs_init_rootb(&this, prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, usage_skip, NULL);
-	if (bfs_error(ret)) {
+	if (unlikely(bfs_error(ret))) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -2664,7 +2664,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	bfs_init_root(&that, next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
-	if (bfs_error(ret)) {
+	if (unlikely(bfs_error(ret))) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -2679,7 +2679,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	backward_mask = original_mask(target_entry1->class->usage_mask);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
-	if (bfs_error(ret)) {
+	if (unlikely(bfs_error(ret))) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -2998,7 +2998,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Is the <prev> -> <next> link redundant?
 	 */
 	ret = check_redundant(prev, next);
-	if (bfs_error(ret))
+	if (unlikely(bfs_error(ret)))
 		return 0;
 	else if (ret == BFS_RMATCH)
 		return 2;
@@ -3911,7 +3911,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 
 	bfs_init_root(&root, this);
 	ret = find_usage_forwards(&root, usage_mask, &target_entry);
-	if (bfs_error(ret)) {
+	if (unlikely(bfs_error(ret))) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -3946,7 +3946,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 
 	bfs_init_rootb(&root, this);
 	ret = find_usage_backwards(&root, usage_mask, &target_entry);
-	if (bfs_error(ret)) {
+	if (unlikely(bfs_error(ret))) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-- 
2.30.2

