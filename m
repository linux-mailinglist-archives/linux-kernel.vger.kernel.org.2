Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED1342C73
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCTLpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:45:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14832 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCTLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:45:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F2bH71j61z9186;
        Sat, 20 Mar 2021 17:36:03 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Mar 2021
 17:37:48 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on putback_movable_page()
Date:   Sat, 20 Mar 2021 05:36:57 -0400
Message-ID: <20210320093701.12829-2-linmiaohe@huawei.com>
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

The !PageLocked() check is implicitly done in PageMovable(). Remove this
explicit one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 47df0df8f21a..e4ca5ef508ea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -146,7 +146,6 @@ void putback_movable_page(struct page *page)
 	struct address_space *mapping;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	mapping = page_mapping(page);
-- 
2.19.1

