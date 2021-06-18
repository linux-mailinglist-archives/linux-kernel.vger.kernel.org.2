Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655C23ACE12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhFRO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:58:10 -0400
Received: from pv50p00im-ztdg10021101.me.com ([17.58.6.44]:53722 "EHLO
        pv50p00im-ztdg10021101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234791AbhFRO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624028160; bh=1JIjVblmIBwSMEEZ+LXUVg56tLYtzwLVT259Gir4bfY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XYRKV+RhhdpiCv91uaxEc4ic2wVRjPPwL/XGJaAOpaiUen1S8N27OsqBhI0u3le8R
         mH85tc3Nma8l7GSW19nOlJHuYr0ZSkY/EZ2em4swZTSg7CloGuHixvaSKFDS8suLnr
         tHzk2kaS/JLOMRl0Gk69LH/qqGY5wHjUkeyalqVfvKHtkf54tiryLBNtOC2st7Jxc6
         mTyIfgO5KJvoSJh+U7eVLqc4WoEd87WFwg0EaPaEBXxC6iI0Hf1IhXDOWpQlw4caUL
         Cex/iCCbCP8FBF6Tjx497kM8S1a0HCFN4LriorzKHIgNu1nJ/DktRoCkz34hxzd7RP
         +J/GueD2KZrbQ==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 161B1180384;
        Fri, 18 Jun 2021 14:55:56 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 1/3] locking/lockdep: Unlikely bfs_error() inside
Date:   Fri, 18 Jun 2021 22:55:32 +0800
Message-Id: <20210618145534.438816-2-sxwjean@me.com>
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

The error from graph walk is small probability event, and there are some
bfs_error calls during lockdep detection, so unlikely bfs_error inside
can improve performance a little bit.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7641bd407239..a8a66a2a9bc1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1540,7 +1540,7 @@ enum bfs_result {
  */
 static inline bool bfs_error(enum bfs_result res)
 {
-	return res < 0;
+	return unlikely(res < 0);
 }
 
 /*
@@ -2089,7 +2089,7 @@ check_path(struct held_lock *target, struct lock_list *src_entry,
 
 	ret = __bfs_forwards(src_entry, target, match, skip, target_entry);
 
-	if (unlikely(bfs_error(ret)))
+	if (bfs_error(ret))
 		print_bfs_bug(ret);
 
 	return ret;
@@ -2936,7 +2936,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * in the graph whose neighbours are to be checked.
 	 */
 	ret = check_noncircular(next, prev, trace);
-	if (unlikely(bfs_error(ret) || ret == BFS_RMATCH))
+	if (bfs_error(ret) || unlikely(ret == BFS_RMATCH))
 		return 0;
 
 	if (!check_irq_usage(curr, prev, next))
-- 
2.30.2

