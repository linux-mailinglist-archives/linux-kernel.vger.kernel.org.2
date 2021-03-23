Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF37346065
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhCWNza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:55:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14129 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhCWNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:54:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4Xr51pwNz19HCB;
        Tue, 23 Mar 2021 21:52:53 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 21:54:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/5] mm/migrate.c: fix potential indeterminate pte entry in migrate_vma_insert_page()
Date:   Tue, 23 Mar 2021 09:54:03 -0400
Message-ID: <20210323135405.65059-4-linmiaohe@huawei.com>
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

If the zone device page does not belong to un-addressable device memory,
the variable entry will be uninitialized and lead to indeterminate pte
entry ultimately. Fix this unexpected case and warn about it.

Fixes: df6ad69838fc ("mm/device-public-memory: device memory cache coherent with CPU")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 97da1fabdf72..d372be3da9b2 100644
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
+			pr_warn_once("Unsupported ZONE_DEVICE page type.\n");
+			goto abort;
 		}
 	} else {
 		entry = mk_pte(page, vma->vm_page_prot);
-- 
2.19.1

