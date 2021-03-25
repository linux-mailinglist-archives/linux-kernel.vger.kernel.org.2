Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE423490EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhCYLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:41:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14474 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhCYLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:34:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5jd74Mq0zrZkW;
        Thu, 25 Mar 2021 19:32:27 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 19:34:18 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <pasha.tatashin@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH] mm/sparse: Add the missing sparse_buffer_fini() in error branch
Date:   Thu, 25 Mar 2021 11:31:55 +0000
Message-ID: <20210325113155.118574-1-wangwensheng4@huawei.com>
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

