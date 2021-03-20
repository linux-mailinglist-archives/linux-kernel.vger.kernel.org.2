Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D49342C75
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCTLpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:45:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14834 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhCTLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:45:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F2bH71QLNz916v;
        Sat, 20 Mar 2021 17:36:03 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Mar 2021
 17:37:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm/migrate.c: fix potential indeterminate pte entry in migrate_vma_insert_page()
Date:   Sat, 20 Mar 2021 05:36:59 -0400
Message-ID: <20210320093701.12829-4-linmiaohe@huawei.com>
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

If the zone device page does not belong to un-addressable device memory,
the variable entry will be uninitialized and lead to indeterminate pte
entry ultimately. Fix this unexpectant case and warn about it.

Fixes: df6ad69838fc ("mm/device-public-memory: device memory cache coherent with CPU")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 20a3bf75270a..271081b014cb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2972,6 +2972,13 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 			swp_entry = make_device_private_entry(page, vma->vm_flags & VM_WRITE);
 			entry = swp_entry_to_pte(swp_entry);
+		} else {
+			/*
+			 * For now we only support migrating to un-addressable
+			 * device memory.
+			 */
+			WARN_ON(1);
+			goto abort;
 		}
 	} else {
 		entry = mk_pte(page, vma->vm_page_prot);
-- 
2.19.1

