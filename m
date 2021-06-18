Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678163ACB92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhFRNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:04:58 -0400
Received: from pv50p00im-ztdg10022001.me.com ([17.58.6.58]:34684 "EHLO
        pv50p00im-ztdg10022001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230243AbhFRNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624021366; bh=ugLh746OO0SNJWXsgRc08+EAuOljXKfy3d1bDRmZEAg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=eG9+Vq9f0MttMKcrtEY8nCW+w3wIeT3OeGlXtlUacnfBYjpqQ6unQAe949r38eJ+/
         iDlUmAwptTgy9hAlEexeUFjCU6Dfi/+Q5HV1VE3kIQN78TZuJ1aLJHxdce5yAyb0NS
         W1BzfGYCF5t1LTM32fJw1Cp2aAkf8A7I0JKUDMjtrsnUb/yWePqEm2J08inklwF2uq
         4GKs2vGK1q8WycuQBPcu8F+nLPuQzwwuxApqxuzY5Jqt93vvG6GdirTAaAtoa8S+bJ
         5MI9PcKAc1jk+zm1ldGTACwH97F6IRFbPzrh/il/AagGevY1fpvz3hgwDAkbXSv4P4
         SgzsWysLzmwPg==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 9E373A0490;
        Fri, 18 Jun 2021 13:02:42 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] locking/lockdep: Correct the description error for check_redundant()
Date:   Fri, 18 Jun 2021 21:02:30 +0800
Message-Id: <20210618130230.123249-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=721 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106180077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

If there is no matched result, check_redundant() will return BFS_RNOMATCH.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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

