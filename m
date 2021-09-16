Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110840DA15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhIPMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:40:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9885 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbhIPMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:19 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H9Gjy0NjMz8yZ3;
        Thu, 16 Sep 2021 20:34:30 +0800 (CST)
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
Subject: [PATCH 5/5] mm, slub: fix incorrect memcg slab count for bulk free
Date:   Thu, 16 Sep 2021 20:39:20 +0800
Message-ID: <20210916123920.48704-6-linmiaohe@huawei.com>
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

kmem_cache_free_bulk() will call memcg_slab_free_hook() for all objects
when doing bulk free. So we shouldn't call memcg_slab_free_hook() again
for bulk free to avoid incorrect memcg slab count.

Fixes: d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index f3df0f04a472..d8f77346376d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3420,7 +3420,9 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
 
-	memcg_slab_free_hook(s, &head, 1);
+	/* memcg_slab_free_hook() is already called for bulk free. */
+	if (!tail)
+		memcg_slab_free_hook(s, &head, 1);
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
-- 
2.23.0

