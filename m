Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB02349FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCZC0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:26:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14906 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCZCZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:25:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F65QC2wKpzkg9d;
        Fri, 26 Mar 2021 10:24:19 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 10:25:50 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <akpm@linux-foundation.org>, <pasha.tatashin@oracle.com>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH] mm/sparse: Add the missing sparse_buffer_fini() in error branch
Date:   Fri, 26 Mar 2021 02:23:25 +0000
Message-ID: <20210326022325.3181-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse_buffer_init() and sparse_buffer_fini() should appear in pair, or
a WARN issue would be through the next time sparse_buffer_init() runs.

Add the missing sparse_buffer_fini() in error branch.

Fixes: 85c77f791390 ("mm/sparse: add new sparse_init_nid() and sparse_init()")
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 mm/sparse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7bd23f9..33406ea 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -547,6 +547,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
 			       __func__, nid);
 			pnum_begin = pnum;
+			sparse_buffer_fini();
 			goto failed;
 		}
 		check_usemap_section_nr(nid, usage);
-- 
2.9.4

