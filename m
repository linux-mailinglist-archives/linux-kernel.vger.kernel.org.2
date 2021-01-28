Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF82307456
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhA1LDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:03:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11458 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhA1LDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:03:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRHbC3ftkzjCjk;
        Thu, 28 Jan 2021 19:01:27 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 28 Jan 2021
 19:02:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/rmap: fix obsolete comment in __page_check_anon_rmap()
Date:   Thu, 28 Jan 2021 06:02:09 -0500
Message-ID: <20210128110209.50857-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21333b2b66b8 ("ksm: no debug in page_dup_rmap()") has reverted
page_dup_rmap() to an inline atomic_inc of mapcount. So page_dup_rmap()
does not call __page_check_anon_rmap() anymore.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/rmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 46fdbf541b8e..c3f6e060d73f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1086,8 +1086,7 @@ static void __page_check_anon_rmap(struct page *page,
 	 * be set up correctly at this point.
 	 *
 	 * We have exclusion against page_add_anon_rmap because the caller
-	 * always holds the page locked, except if called from page_dup_rmap,
-	 * in which case the page is already known to be setup.
+	 * always holds the page locked.
 	 *
 	 * We have exclusion against page_add_new_anon_rmap because those pages
 	 * are initially only visible via the pagetables, and the pte is locked
-- 
2.19.1

