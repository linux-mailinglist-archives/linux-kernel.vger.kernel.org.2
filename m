Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8217641D3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbhI3HJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:09:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27935 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhI3HJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:09:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKkjv6BBhzbh7S;
        Thu, 30 Sep 2021 15:03:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:08:05 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:08:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <shakeelb@google.com>, <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] slub: add back check for free nonslab objects
Date:   Thu, 30 Sep 2021 15:02:14 +0800
Message-ID: <20210930070214.61499-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
which only check with CONFIG_DEBUG_VM enabled, but this config may impact
performance, so it only for debug.

Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
add the ability, which should be needed in any configs to catch the
invalid free, they even could be potential issue, eg, memory corruption,
use after free and double free, so replace VM_BUG_ON_PAGE to WARN_ON_ONCE,
add object address printing to help use to debug the issue.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v3:
- use 'once' mechanism sugguested by Shakeel Butt
- drop dump_page sugguested by Matthew Wilcox
v2:
- add object address printing sugguested by Matthew Wilcox

 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..336eceea0c75 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3513,7 +3513,9 @@ static inline void free_nonslab_page(struct page *page, void *object)
 {
 	unsigned int order = compound_order(page);
 
-	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	if (WARN_ON_ONCE(!PageCompound(page)))
+		pr_warn_once("object pointer: 0x%p\n", object);
+
 	kfree_hook(object);
 	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
 	__free_pages(page, order);
-- 
2.26.2

