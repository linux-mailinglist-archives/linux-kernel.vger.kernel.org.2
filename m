Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33C418D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhI0CIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:08:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:21256 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhI0CIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:08:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HHmFV5Ysqz8tHm;
        Mon, 27 Sep 2021 10:05:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 10:06:40 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 10:06:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <shakeelb@google.com>, <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] slub: Add back check for free nonslab objects
Date:   Mon, 27 Sep 2021 10:09:22 +0800
Message-ID: <20210927020922.87449-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
which only check with CONFIG_DEBUG_VM enabled, but this config may
impact performance, so it only for debug.

Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
add the ability, which should be needed in any configs to catch the
invalid free, they even could be potential issue, eg, memory corruption,
use after free and double free, so replace VM_BUG_ON_PAGE to WARN_ON, and
add dump_page() to help use to debug the issue.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3095b889fab4..1bfe09098485 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3522,7 +3522,8 @@ static inline void free_nonslab_page(struct page *page, void *object)
 {
 	unsigned int order = compound_order(page);
 
-	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	if (WARN_ON(!PageCompound(page)))
+		dump_page(page);
 	kfree_hook(object);
 	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
 	__free_pages(page, order);
-- 
2.26.2

