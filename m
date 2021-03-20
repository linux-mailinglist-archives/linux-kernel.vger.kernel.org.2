Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475D1342C77
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCTLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:45:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14039 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhCTLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:45:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F2bGW3nqlzPkf5;
        Sat, 20 Mar 2021 17:35:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Mar 2021
 17:37:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] mm/migrate.c: remove unnecessary rc != MIGRATEPAGE_SUCCESS check in 'else' case
Date:   Sat, 20 Mar 2021 05:36:58 -0400
Message-ID: <20210320093701.12829-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210320093701.12829-1-linmiaohe@huawei.com>
References: <20210320093701.12829-1-linmiaohe@huawei.com>
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

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e4ca5ef508ea..20a3bf75270a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1374,7 +1374,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
 		putback_active_hugepage(hpage);
-	else if (rc != -EAGAIN && rc != MIGRATEPAGE_SUCCESS)
+	else if (rc != -EAGAIN)
 		list_move_tail(&hpage->lru, ret);
 
 	/*
-- 
2.19.1

