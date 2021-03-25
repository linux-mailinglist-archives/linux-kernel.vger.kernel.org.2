Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16003492EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhCYNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:16:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13697 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCYNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:16:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5lsx4xGpzpVKj;
        Thu, 25 Mar 2021 21:13:41 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:16:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 2/5] mm/migrate.c: remove unnecessary rc != MIGRATEPAGE_SUCCESS check in 'else' case
Date:   Thu, 25 Mar 2021 09:15:21 -0400
Message-ID: <20210325131524.48181-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210325131524.48181-1-linmiaohe@huawei.com>
References: <20210325131524.48181-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's guaranteed that in the 'else' case of the rc == MIGRATEPAGE_SUCCESS
check, rc does not equal to MIGRATEPAGE_SUCCESS. Remove this unnecessary
check.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 61e7f848b554..dacbdc9710ac 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1370,7 +1370,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
 		putback_active_hugepage(hpage);
-	else if (rc != -EAGAIN && rc != MIGRATEPAGE_SUCCESS)
+	else if (rc != -EAGAIN)
 		list_move_tail(&hpage->lru, ret);
 
 	/*
-- 
2.19.1

