Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77CC30D663
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhBCJdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:33:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12014 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhBCJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:33:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVxJN3MGLzjJXb;
        Wed,  3 Feb 2021 17:31:16 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Feb 2021
 17:32:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/rmap: Correct obsolete comment of page_get_anon_vma()
Date:   Wed, 3 Feb 2021 04:32:15 -0500
Message-ID: <20210203093215.31990-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 746b18d421da ("mm: use refcounts for page_lock_anon_vma()"),
page_lock_anon_vma() is renamed to page_get_anon_vma() and converted to
return a refcount increased anon_vma. But it forgot to change the relevant
comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/rmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b49e85605f8f..b0fc27e77d6d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -462,8 +462,8 @@ void __init anon_vma_init(void)
  * Getting a lock on a stable anon_vma from a page off the LRU is tricky!
  *
  * Since there is no serialization what so ever against page_remove_rmap()
- * the best this function can do is return a locked anon_vma that might
- * have been relevant to this page.
+ * the best this function can do is return a refcount increased anon_vma
+ * that might have been relevant to this page.
  *
  * The page might have been remapped to a different anon_vma or the anon_vma
  * returned may already be freed (and even reused).
-- 
2.19.1

