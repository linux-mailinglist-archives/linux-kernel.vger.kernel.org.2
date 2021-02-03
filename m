Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042330D625
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhBCJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:21:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12113 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhBCJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:20:02 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVx140Q7lz163VZ;
        Wed,  3 Feb 2021 17:18:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Feb 2021
 17:19:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>, <sergey.senozhatsky.work@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/zsmalloc.c: use page_private() to access page->private
Date:   Wed, 3 Feb 2021 04:18:57 -0500
Message-ID: <20210203091857.20017-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's recommended to use helper macro page_private() to access the private
field of page. Use such helper to eliminate direct access.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cf0ed0e4e911..6678951ac83d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -816,7 +816,7 @@ static int get_pages_per_zspage(int class_size)
 
 static struct zspage *get_zspage(struct page *page)
 {
-	struct zspage *zspage = (struct zspage *)page->private;
+	struct zspage *zspage = (struct zspage *)page_private(page);
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
-- 
2.19.1

