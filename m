Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7245C3C7B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhGNByR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:54:17 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11272 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhGNByQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:54:16 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GPgLy72Q6z1CJHc;
        Wed, 14 Jul 2021 09:45:46 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 09:51:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 09:51:23 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <serapheim.dimitro@delphix.com>,
        <urezki@gmail.com>, <wangkefeng.wang@huawei.com>,
        <weiyongjun1@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] mm/vmalloc: fix wrong behavior in vread
Date:   Wed, 14 Jul 2021 09:59:59 +0800
Message-ID: <20210714015959.3204871-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread()
lookups") use rb_tree instread of list to speed up lookup, but function
__find_vmap_area is try to find a vmap_area that include target address,
if target address is smaller than the leftmost node in vmap_area_root,
it will return NULL, then vread will read nothing. This behavior is
different from the primitive semantics.

The correct way is find the first vmap_are that bigger than target addr,
that is what function find_vmap_area_exceed_addr does.

Fixes: f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread() lookups")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/vmalloc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5cd52805149..47c3a551b6dc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -787,6 +787,28 @@ unsigned long vmalloc_nr_pages(void)
 	return atomic_long_read(&nr_vmalloc_pages);
 }
 
+static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
+{
+	struct vmap_area *va = NULL;
+	struct rb_node *n = vmap_area_root.rb_node;
+
+	while (n) {
+		struct vmap_area *tmp;
+
+		tmp = rb_entry(n, struct vmap_area, rb_node);
+		if (tmp->va_end > addr) {
+			va = tmp;
+			if (tmp->va_start <= addr)
+				break;
+
+			n = n->rb_left;
+		} else
+			n = n->rb_right;
+	}
+
+	return va;
+}
+
 static struct vmap_area *__find_vmap_area(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
@@ -3267,9 +3289,14 @@ long vread(char *buf, char *addr, unsigned long count)
 		count = -(unsigned long) addr;
 
 	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area((unsigned long)addr);
+	va = find_vmap_area_exceed_addr((unsigned long)addr);
 	if (!va)
 		goto finished;
+
+	/* no intersects with alive vmap_area */
+	if ((unsigned long)addr + count <= va->va_start)
+		goto finished;
+
 	list_for_each_entry_from(va, &vmap_area_list, list) {
 		if (!count)
 			break;
-- 
2.25.1

