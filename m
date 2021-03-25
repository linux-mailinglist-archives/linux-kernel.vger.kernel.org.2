Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518D0349376
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCYN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:57:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14596 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhCYN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:57:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5mpC5cFgz19Hkx;
        Thu, 25 Mar 2021 21:55:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:57:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/3] khugepaged: remove meaningless !pte_present() check in khugepaged_scan_pmd()
Date:   Thu, 25 Mar 2021 09:56:47 -0400
Message-ID: <20210325135647.64106-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210325135647.64106-1-linmiaohe@huawei.com>
References: <20210325135647.64106-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know it must meet the !is_swap_pte() and !pte_none() condition if we
reach here. Since !is_swap_pte() indicates pte_none() or pte_present()
is met, it's guaranteed that pte must be present here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 58466af69e70..01c2d0ed9abd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1271,10 +1271,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (!pte_present(pteval)) {
-			result = SCAN_PTE_NON_PRESENT;
-			goto out_unmap;
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
-- 
2.19.1

