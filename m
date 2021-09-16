Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE940DA13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbhIPMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:40:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16221 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbhIPMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:18 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H9Gnt0BGlz1DH10;
        Thu, 16 Sep 2021 20:37:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 20:38:55 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <gregkh@linuxfoundation.org>, <faiyazm@codeaurora.org>,
        <andreyknvl@gmail.com>, <ryabinin.a.a@gmail.com>,
        <thgarnie@google.com>, <keescook@chromium.org>,
        <bharata@linux.ibm.com>, <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm, slub: fix potential memoryleak in kmem_cache_open()
Date:   Thu, 16 Sep 2021 20:39:18 +0800
Message-ID: <20210916123920.48704-4-linmiaohe@huawei.com>
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

In error path, the random_seq of slub cache might be leaked. Fix this by
using __kmem_cache_release() to release all the relevant resources.

Fixes: 210e7a43fa90 ("mm: SLUB freelist randomization")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index a56a6423d4e8..bf1793fb4ce5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4210,8 +4210,8 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	if (alloc_kmem_cache_cpus(s))
 		return 0;
 
-	free_kmem_cache_nodes(s);
 error:
+	__kmem_cache_release(s);
 	return -EINVAL;
 }
 
-- 
2.23.0

