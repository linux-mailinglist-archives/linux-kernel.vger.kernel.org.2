Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D132D313
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbhCDMbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:31:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbhCDMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:31:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Drqsh65nzzlShM;
        Thu,  4 Mar 2021 20:28:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 20:30:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <riel@redhat.com>, <kirill.shutemov@linux.intel.com>,
        <ebru.akagunduz@gmail.com>, <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] khugepaged: remove unnecessary mem_cgroup_uncharge() in collapse_[file|huge_page]
Date:   Thu, 4 Mar 2021 07:30:12 -0500
Message-ID: <20210304123013.23560-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210304123013.23560-1-linmiaohe@huawei.com>
References: <20210304123013.23560-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7ae88534cdd9 ("mm: move mem_cgroup_uncharge out of
__page_cache_release()"), the mem_cgroup will be uncharged when hpage is
freed. Uncharge mem_cgroup here is harmless but it looks confusing and
buggy: if mem_cgroup charge failed, we will call mem_cgroup_uncharge()
uncorrectly in error path because hpage is not IS_ERR_OR_NULL().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e886a8618c33..68579cdbdc9b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1211,8 +1211,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 out_up_write:
 	mmap_write_unlock(mm);
 out_nolock:
-	if (!IS_ERR_OR_NULL(*hpage))
-		mem_cgroup_uncharge(*hpage);
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 out:
@@ -1968,8 +1966,6 @@ static void collapse_file(struct mm_struct *mm,
 	unlock_page(new_page);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	if (!IS_ERR_OR_NULL(*hpage))
-		mem_cgroup_uncharge(*hpage);
 	/* TODO: tracepoints */
 }
 
-- 
2.19.1

