Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21963771DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhEHMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 08:41:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17485 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEHMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 08:41:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fcmzq42HhzkXPc;
        Sat,  8 May 2021 20:37:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 20:39:56 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: page-writeback: Kill get_writeback_state() comments
Date:   Sat, 8 May 2021 20:50:26 +0800
Message-ID: <20210508125026.56600-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_writeback_state() has gone since 2006, kill related comments.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page-writeback.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..1bbe185a6524 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1869,10 +1869,9 @@ DEFINE_PER_CPU(int, dirty_throttle_leaks) = 0;
  * which was newly dirtied.  The function will periodically check the system's
  * dirty state and will initiate writeback if needed.
  *
- * On really big machines, get_writeback_state is expensive, so try to avoid
- * calling it too often (ratelimiting).  But once we're over the dirty memory
- * limit we decrease the ratelimiting by a lot, to prevent individual processes
- * from overshooting the limit by (ratelimit_pages) each.
+ * Once we're over the dirty memory limit we decrease the ratelimiting
+ * by a lot, to prevent individual processes from overshooting the limit
+ * by (ratelimit_pages) each.
  */
 void balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
@@ -2045,8 +2044,6 @@ void laptop_sync_completion(void)
 /*
  * If ratelimit_pages is too high then we can get into dirty-data overload
  * if a large number of processes all perform writes at the same time.
- * If it is too low then SMP machines will call the (expensive)
- * get_writeback_state too often.
  *
  * Here we set ratelimit_pages to a level which ensures that when all CPUs are
  * dirtying in parallel, we cannot go more than 3% (1/32) over the dirty memory
-- 
2.26.2

