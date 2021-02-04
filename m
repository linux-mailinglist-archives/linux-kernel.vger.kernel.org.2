Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2C30F19B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhBDLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:08:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12420 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhBDLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:08:08 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWbMf10cXzjHTb;
        Thu,  4 Feb 2021 19:06:22 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 19:07:16 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mlock: stop counting mlocked pages when none vma is found
Date:   Thu, 4 Feb 2021 06:07:05 -0500
Message-ID: <20210204110705.17586-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be no vma satisfies addr < vm_end when find_vma() returns NULL.
Thus it's meaningless to traverse the vma list below because we can't find
any vma to count mlocked pages. Stop counting mlocked pages in this case to
save some vma list traversal cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 73960bb3464d..f8f8cc32d03d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -622,7 +622,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 
 	vma = find_vma(mm, start);
 	if (vma == NULL)
-		vma = mm->mmap;
+		return 0;
 
 	for (; vma ; vma = vma->vm_next) {
 		if (start >= vma->vm_end)
-- 
2.19.1

