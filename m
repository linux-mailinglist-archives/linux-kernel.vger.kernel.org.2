Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7153232F81C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCFDaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:30:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13444 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:30:31 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dsqp45NdlzjVSn;
        Sat,  6 Mar 2021 11:29:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 6 Mar 2021
 11:30:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>
CC:     <riel@redhat.com>, <ebru.akagunduz@gmail.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 3/4] khugepaged: use helper khugepaged_test_exit() in __khugepaged_enter()
Date:   Fri, 5 Mar 2021 22:29:46 -0500
Message-ID: <20210306032947.35921-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210306032947.35921-1-linmiaohe@huawei.com>
References: <20210306032947.35921-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4d45e75a9955 ("mm: remove the now-unnecessary mmget_still_valid()
hack") have made khugepaged_test_exit() suitable for check mm->mm_users
against 0. Use this helper here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 287e7ecf978c..e886a8618c33 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -481,7 +481,7 @@ int __khugepaged_enter(struct mm_struct *mm)
 		return -ENOMEM;
 
 	/* __khugepaged_exit() must not run from under us */
-	VM_BUG_ON_MM(atomic_read(&mm->mm_users) == 0, mm);
+	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
 	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
 		free_mm_slot(mm_slot);
 		return 0;
-- 
2.19.1

