Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA563CA12C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhGOPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:12:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11320 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhGOPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:11:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GQd226hnvz7tgb;
        Thu, 15 Jul 2021 23:04:26 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 23:08:56 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 23:08:56 +0800
From:   Bin Wang <wangbin224@huawei.com>
To:     <linux-mm@kvack.org>
CC:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <wuxu.wu@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/hwpoison: dissolve error hugepages of file mapping
Date:   Thu, 15 Jul 2021 23:08:52 +0800
Message-ID: <20210715150852.1655-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.206]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We handle error on hugetlb file with hugetlbfs_error_remove_page(),
which removes the error hugepages from page cache. And with the
HWPoison flag in head page, it is safe to free the error hugepages
and dissolve it.

Fixes: 78bb920344b8a ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
Signed-off-by: Bin Wang <wangbin224@huawei.com>
---
 mm/memory-failure.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eefd823deb67..6a3c46b601ef 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -988,6 +988,13 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 	if (mapping) {
 		res = truncate_error_page(hpage, pfn, mapping);
 		unlock_page(hpage);
+		if (ret == MF_RECOVERED) {
+			put_page(hpage);
+			if (__page_handle_poison(p))
+				page_ref_inc(p);
+			else
+				ret = MF_FAILED;
+		}
 	} else {
 		res = MF_FAILED;
 		unlock_page(hpage);
-- 
2.23.0

