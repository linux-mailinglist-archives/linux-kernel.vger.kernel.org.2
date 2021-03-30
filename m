Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E110734E9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhC3ODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:03:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14638 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhC3ODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:03:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8rgr2wrYznWHF;
        Tue, 30 Mar 2021 22:00:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:03:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/4] ksm: remove dedicated macro KSM_FLAG_MASK
Date:   Tue, 30 Mar 2021 10:02:27 -0400
Message-ID: <20210330140228.45635-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210330140228.45635-1-linmiaohe@huawei.com>
References: <20210330140228.45635-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro KSM_FLAG_MASK is used in rmap_walk_ksm() only. So we can replace
~KSM_FLAG_MASK with PAGE_MASK to remove this dedicated macro and make code
more consistent because PAGE_MASK is used elsewhere in this file.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/ksm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 5650a282da3e..f9ca6d94bf7f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -215,8 +215,6 @@ struct rmap_item {
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
 #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
 #define STABLE_FLAG	0x200	/* is listed from the stable tree */
-#define KSM_FLAG_MASK	(SEQNR_MASK|UNSTABLE_FLAG|STABLE_FLAG)
-				/* to mask all the flags */
 
 /* The stable and unstable tree heads */
 static struct rb_root one_stable_tree[1] = { RB_ROOT };
@@ -2631,7 +2629,7 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
 			vma = vmac->vma;
 
 			/* Ignore the stable/unstable/sqnr flags */
-			addr = rmap_item->address & ~KSM_FLAG_MASK;
+			addr = rmap_item->address & PAGE_MASK;
 
 			if (addr < vma->vm_start || addr >= vma->vm_end)
 				continue;
-- 
2.19.1

