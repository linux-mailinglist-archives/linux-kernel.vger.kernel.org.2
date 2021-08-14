Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19973EC221
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhHNKwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:52:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13317 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbhHNKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:52:04 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gmy0L5xrCz838P;
        Sat, 14 Aug 2021 18:51:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 14
 Aug 2021 18:51:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 4/4] mm/hwpoison: fix some obsolete comments
Date:   Sat, 14 Aug 2021 18:51:31 +0800
Message-ID: <20210814105131.48814-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210814105131.48814-1-linmiaohe@huawei.com>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cb731d6c62bb ("vmscan: per memory cgroup slab shrinkers"),
shrink_node_slabs is renamed to drop_slab_node. And doit argument is
changed to forcekill since commit 6751ed65dc66 ("x86/mce: Fix
siginfo_t->si_addr value for non-recoverable memory faults").

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a4e585f812c1..a6f2384d9933 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -296,7 +296,7 @@ void shake_page(struct page *p, int access)
 	}
 
 	/*
-	 * Only call shrink_node_slabs here (which would also shrink
+	 * Only call drop_slab_node here (which would also shrink
 	 * other caches) if access is not potentially fatal.
 	 */
 	if (access)
@@ -391,8 +391,8 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 /*
  * Kill the processes that have been collected earlier.
  *
- * Only do anything when DOIT is set, otherwise just free the list
- * (this is used for clean pages which do not need killing)
+ * Only do anything when FORCEKILL is set, otherwise just free the
+ * list (this is used for clean pages which do not need killing)
  * Also when FAIL is set do a force kill because something went
  * wrong earlier.
  */
-- 
2.23.0

