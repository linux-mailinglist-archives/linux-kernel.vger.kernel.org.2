Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA040DA12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhIPMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:40:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16266 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbhIPMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:17 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H9GpJ6smCz8t3l;
        Thu, 16 Sep 2021 20:38:16 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 20:38:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <gregkh@linuxfoundation.org>, <faiyazm@codeaurora.org>,
        <andreyknvl@gmail.com>, <ryabinin.a.a@gmail.com>,
        <thgarnie@google.com>, <keescook@chromium.org>,
        <bharata@linux.ibm.com>, <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/5] mm, slub: fix mismatch between reconstructed freelist depth and cnt
Date:   Thu, 16 Sep 2021 20:39:17 +0800
Message-ID: <20210916123920.48704-3-linmiaohe@huawei.com>
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

If object's reuse is delayed, it will be excluded from the reconstructed
freelist. But we forgot to adjust the cnt accordingly. So there will be
a mismatch between reconstructed freelist depth and cnt. This will lead
to free_debug_processing() complain about freelist count or a incorrect
slub inuse count.

Fixes: c3895391df38 ("kasan, slub: fix handling of kasan_slab_free hook")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ed160b6c54f8..a56a6423d4e8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1701,7 +1701,8 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 }
 
 static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-					   void **head, void **tail)
+					   void **head, void **tail,
+					   int *cnt)
 {
 
 	void *object;
@@ -1728,6 +1729,12 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 			*head = object;
 			if (!*tail)
 				*tail = object;
+		} else {
+			/*
+			 * Adjust the reconstructed freelist depth
+			 * accordingly if object's reuse is delayed.
+			 */
+			--(*cnt);
 		}
 	} while (object != old_tail);
 
@@ -3480,7 +3487,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
 	 */
-	if (slab_free_freelist_hook(s, &head, &tail))
+	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
 		do_slab_free(s, page, head, tail, cnt, addr);
 }
 
-- 
2.23.0

