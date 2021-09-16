Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DF40DA10
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhIPMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:40:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9739 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbhIPMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:16 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H9Gnr2pMJzWBdJ;
        Thu, 16 Sep 2021 20:37:52 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 20:38:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <gregkh@linuxfoundation.org>, <faiyazm@codeaurora.org>,
        <andreyknvl@gmail.com>, <ryabinin.a.a@gmail.com>,
        <thgarnie@google.com>, <keescook@chromium.org>,
        <bharata@linux.ibm.com>, <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm, slub: fix two bugs in slab_debug_trace_open()
Date:   Thu, 16 Sep 2021 20:39:16 +0800
Message-ID: <20210916123920.48704-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210916123920.48704-1-linmiaohe@huawei.com>
References: <20210916123920.48704-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that __seq_open_private() will return NULL. So we should
check t before using lest dereferencing NULL pointer. And in error paths,
we forgot to release private buffer via seq_release_private(). Memory
will leak in these paths.

Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..ed160b6c54f8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6108,9 +6108,14 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 	struct kmem_cache *s = file_inode(filep)->i_private;
 	unsigned long *obj_map;
 
+	if (!t)
+		return -ENOMEM;
+
 	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
-	if (!obj_map)
+	if (!obj_map) {
+		seq_release_private(inode, filep);
 		return -ENOMEM;
+	}
 
 	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
 		alloc = TRACK_ALLOC;
@@ -6119,6 +6124,7 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 
 	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
 		bitmap_free(obj_map);
+		seq_release_private(inode, filep);
 		return -ENOMEM;
 	}
 
-- 
2.23.0

