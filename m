Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28451339D96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhCMKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:33:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13166 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhCMKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:33:11 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DyJqZ2jkXzmWM6;
        Sat, 13 Mar 2021 18:30:50 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 13 Mar 2021
 18:33:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <richard.weiyang@linux.alibaba.com>, <peterx@redhat.com>,
        <anshuman.khandual@arm.com>, <thomas_os@shipmail.org>,
        <rcampbell@nvidia.com>, <aneesh.kumar@linux.ibm.com>,
        <yang.shi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 5/6] mm/huge_memory.c: remove unused macro TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG
Date:   Sat, 13 Mar 2021 05:32:24 -0500
Message-ID: <20210313103225.16607-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210313103225.16607-1-linmiaohe@huawei.com>
References: <20210313103225.16607-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4958e4d86ecb ("mm: thp: remove debug_cow switch") forgot to
remove TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG macro. Remove it here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/huge_mm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ba973efcd369..9626fda5efce 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -87,9 +87,6 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
-#ifdef CONFIG_DEBUG_VM
-	TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG,
-#endif
 };
 
 struct kobject;
-- 
2.19.1

