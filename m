Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECD40DA14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbhIPMk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:40:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9740 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbhIPMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:18 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H9Gnt3rx0zWBp3;
        Thu, 16 Sep 2021 20:37:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 20:38:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <gregkh@linuxfoundation.org>, <faiyazm@codeaurora.org>,
        <andreyknvl@gmail.com>, <ryabinin.a.a@gmail.com>,
        <thgarnie@google.com>, <keescook@chromium.org>,
        <bharata@linux.ibm.com>, <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm, slub: fix potential use-after-free in slab_debugfs_fops
Date:   Thu, 16 Sep 2021 20:39:19 +0800
Message-ID: <20210916123920.48704-5-linmiaohe@huawei.com>
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

When sysfs_slab_add failed, we shouldn't call debugfs_slab_add() for s
because s will be freed soon. And slab_debugfs_fops will use s later
leading to a use-after-free.

Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bf1793fb4ce5..f3df0f04a472 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4887,13 +4887,15 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 		return 0;
 
 	err = sysfs_slab_add(s);
-	if (err)
+	if (err) {
 		__kmem_cache_release(s);
+		return err;
+	}
 
 	if (s->flags & SLAB_STORE_USER)
 		debugfs_slab_add(s);
 
-	return err;
+	return 0;
 }
 
 void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
-- 
2.23.0

