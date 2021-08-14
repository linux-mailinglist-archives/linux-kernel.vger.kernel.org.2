Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974EA3EC220
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhHNKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:52:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13423 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbhHNKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:52:03 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gmxw81X6tzdZPg;
        Sat, 14 Aug 2021 18:47:52 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 14
 Aug 2021 18:51:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/4] mm/hwpoison: change argument struct page **hpagep to *hpage
Date:   Sat, 14 Aug 2021 18:51:30 +0800
Message-ID: <20210814105131.48814-4-linmiaohe@huawei.com>
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

It's unnecessary to pass in a struct page **hpagep because it's never
modified. Changing to use *hpage to simplify the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 54f61133bf60..a4e585f812c1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1265,14 +1265,13 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
  * the pages and send SIGBUS to the processes if the data was dirty.
  */
 static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
-				  int flags, struct page **hpagep)
+				  int flags, struct page *hpage)
 {
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
 	int kill = 1, forcekill;
-	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
 
 	/*
@@ -1497,7 +1496,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 		goto out;
 	}
 
-	if (!hwpoison_user_mappings(p, pfn, flags, &head)) {
+	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
 		goto out;
@@ -1777,7 +1776,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Now take care of user space mappings.
 	 * Abort on fail: __delete_from_page_cache() assumes unmapped page.
 	 */
-	if (!hwpoison_user_mappings(p, pfn, flags, &p)) {
+	if (!hwpoison_user_mappings(p, pfn, flags, p)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
 		goto unlock_page;
-- 
2.23.0

