Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368913AB601
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhFQOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:31:26 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:53450 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232588AbhFQObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623940153; bh=yJ2wc/yTA/kKyoo3dm7VmVcGUb+nPCIAk5AwTpaqjN4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=SPRs8FfERUktSbN4CRUrnl2DC0ciDjtlFD3TFfxmIaJrq0kX9ZC4hZgw6FhfswVeG
         RMTF5OYGwqS4nTiZSPMMMRLLeQwbWagBMuSbq4wUXRh4qYvZGPLYCRNHI4XXNwBte0
         e39/9DygO9TPHCgamm62qwkDUTXRI0OCDBzqajtUnXWoyIXnNb7DtOLNnrB9g3bQtl
         YRuQM5NnDYmXUhlCM7307suW2CC9rEWPKdZhEIvhC2K6B8Z5wijHM1CB6gy/VTR0CC
         dRaFriohYRh3gtmKtnVQRRF1mlyH96UqRSPhBeiLzMyt193bhyBLSyufRyWNldRyC5
         +wGUbWGKWgqrQ==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 8BFF4B003F4;
        Thu, 17 Jun 2021 14:29:10 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 2/3] locking/lockdep: unlikely conditons about BFS_RMATCH
Date:   Thu, 17 Jun 2021 22:28:27 +0800
Message-Id: <20210617142828.346111-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617142828.346111-1-sxwjean@me.com>
References: <20210617142828.346111-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_13:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106170092
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

