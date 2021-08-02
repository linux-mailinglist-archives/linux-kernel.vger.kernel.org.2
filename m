Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C103DDEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHBSJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:09:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B30C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:08:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x7-20020a170902b407b029012c8cffc695so8256747plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j+JSAL2TyTO06rmOJxXfenDO1JaBiOx8vJieMlI9pfs=;
        b=UcuHbh2lDaqGs/MbwByb6nz+B/co5nzT1R6NZhmA9NdIsZ040uo8xyHQh0XBBND7N5
         FI3HwlivUGntgnh0D27Em+HiAYwCVDKhqhfH8YZqQr00B7tzgf1u57utnYjG6aBwlvLF
         zFfPvhhCPnxnqP3fbByF+3iehSxCd4BIkM9ceagxD6y9bOjLtC0LxoDDrFvIVYdK6RUz
         W6vlGioEeNf8j8C4Zerh4WMqwFyKa206rBGYI+IDnAWVAHEZrfbfIqzVOHQfXRNGygq5
         9DkbD0DIugA89cd7d6aIje5OBCTvhjnYkYEirB168/1Atr4V9lq2mK4GRyUBBX6ij9wm
         +FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j+JSAL2TyTO06rmOJxXfenDO1JaBiOx8vJieMlI9pfs=;
        b=Ke8F7HqI1kxz3JN6pxYV/0fE2IdvXauozJVkb7SR77EAoA1NtKHXpkZLrjNG+g6758
         1gAuaBBmbkGUYQ9gVr2kck1rhVf3rX7mH15jfbFtavU6AGqn+oLIm/Frro2ckhUryuMN
         6ekVYUoHp4eCEk00rbLWxtwYVSGcEMFyvCB4A9aY4QMemahRvYxlfv39Y1WfNi8CdCeg
         W3Jh9q7aPdA/9WVGbA1JuWW7eHjSyvGGzuwiUBXjtlr2kQCRnA5nHTrF874cjhUA3xWz
         OFlOfQw3/0Ijy43ETrA8BuYtKK741C4dGyWM/8gPAVS+a+kMV5YnvWYSdX5wFj5W6711
         O1cw==
X-Gm-Message-State: AOAM532LjX5whuCcn9jIbU3y3eBqRDcGqPo2Lx/q6We72/2mGYjNqbBL
        srZp+6ZVtxqmK35XUZg2mjl+zLtoUuHpVg==
X-Google-Smtp-Source: ABdhPJyd4GLuBK30tc+5jzFp8zuC3MlneqxzEE85Lh3H94nGR7V9ZsC5tnunYlguKVQtH2odY7sLIdyuQCtq3Q==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:75f8:2e73:f9c:f799])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:3d6:: with SMTP id
 go22mr18047527pjb.40.1627927729598; Mon, 02 Aug 2021 11:08:49 -0700 (PDT)
Date:   Mon,  2 Aug 2021 11:08:18 -0700
Message-Id: <20210802180819.1110165-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] slub: fix kmalloc_pagealloc_invalid_free unit test
From:   Shakeel Butt <shakeelb@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit test kmalloc_pagealloc_invalid_free makes sure that for the
higher order slub allocation which goes to page allocator, the free is
called with the correct address i.e. the virtual address of the head
page.

The commit f227f0faf63b ("slub: fix unreclaimable slab stat for bulk
free") unified the free code paths for page allocator based slub
allocations but instead of using the address passed by the caller, it
extracted the address from the page. Thus making the unit test
kmalloc_pagealloc_invalid_free moot. So, fix this by using the address
passed by the caller.

Should we fix this? I think yes because dev expect kasan to catch these
type of programming bugs.

Fixes: f227f0faf63b ("slub: fix unreclaimable slab stat for bulk free")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>

---
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index af984e4990e8..60aeedc436d5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3236,12 +3236,12 @@ struct detached_freelist {
 	struct kmem_cache *s;
 };
 
-static inline void free_nonslab_page(struct page *page)
+static inline void free_nonslab_page(struct page *page, void *object)
 {
 	unsigned int order = compound_order(page);
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
-	kfree_hook(page_address(page));
+	kfree_hook(object);
 	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
 	__free_pages(page, order);
 }
@@ -3282,7 +3282,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	if (!s) {
 		/* Handle kalloc'ed objects */
 		if (unlikely(!PageSlab(page))) {
-			free_nonslab_page(page);
+			free_nonslab_page(page, object);
 			p[size] = NULL; /* mark object processed */
 			return size;
 		}
@@ -4258,7 +4258,7 @@ void kfree(const void *x)
 
 	page = virt_to_head_page(x);
 	if (unlikely(!PageSlab(page))) {
-		free_nonslab_page(page);
+		free_nonslab_page(page, object);
 		return;
 	}
 	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
-- 
2.32.0.554.ge1b32706d8-goog

