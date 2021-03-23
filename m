Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF2346061
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhCWNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:55:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14075 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhCWNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:54:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4XqS647hzPkFv;
        Tue, 23 Mar 2021 21:52:20 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 21:54:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on putback_movable_page()
Date:   Tue, 23 Mar 2021 09:54:01 -0400
Message-ID: <20210323135405.65059-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210323135405.65059-1-linmiaohe@huawei.com>
References: <20210323135405.65059-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The !PageLocked() check is implicitly done in PageMovable(). Remove this
explicit one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 47df0df8f21a..facec65c7374 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -145,7 +145,6 @@ void putback_movable_page(struct page *page)
 {
 	struct address_space *mapping;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
-- 
2.19.1

