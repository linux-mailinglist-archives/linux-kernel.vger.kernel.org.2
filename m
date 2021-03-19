Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C243419A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCSKNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCSKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:13:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v3so5449683ioq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNJwfxygBk8och6dkCm3Z6jjDTILZpQ6YdR+YYjbt2o=;
        b=E7ar8hPU9t6xEXWuWBRTWzZJeNGjPlRnCY9ZgASWw156E3ebESlFuuqu8rwWLnGiLl
         i5SO8yUVX1tTZuW8dbPXd5G03ZxLwlsJUApXG88XfAmfrNSnunuvuTS0GNvP0stVHFyG
         2bYDX3JgkoNBZL/SZSMobQVUrp7J3GOcOlFub6LNnXK9HPOA982o3pEwW1XXNRb8hJNw
         Zt2t/EuI8Ciz2hgAzA2ZM2l8cFJCfMUVuGCfaJZnR7FqN01V10rjYvYfZ7v/2a64dkeU
         z6u/yr3BaXRl+0UKkJE3wEr4l+wQWWMayG5C1oDHow9bGCWLfnIip0ow3NeRwWKzYEka
         RZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNJwfxygBk8och6dkCm3Z6jjDTILZpQ6YdR+YYjbt2o=;
        b=JX6c8Naeh/tu14KIuGu5IQ0pTwn5TOUlvlYTdJSLzzYzvjnzvEtO6gJ3atvKSA8rxK
         iCuxvTPGLr0lvtHnClKHkXZB9UQMI9cdlKtrQAxN0C4/yEh2okdbrg8tj7JVk/Gswy+z
         SWpwdMkzdREC+lUxnQN92N/dQgYKzn8VyAiNQHLzw2HMWU84uLNwYVLnr0jqTZnZWDPh
         CyWvzjkCzsbwBydO7cIZOcyTFmpPs2YMV7+33x61TU6au3m1IbZqKpp/xAPNVqsSe3fE
         G8Iy3x6O3OrKZIBNg6b83id+e80M9icxd8U5rAY40sIonkrw6UiR6j5tRhiJabrpaZQJ
         fepA==
X-Gm-Message-State: AOAM531Gd49b8zf+g3MTUbN2SH6hgIKyyDxW1sCX77UMyu0+8LWyKk+k
        xfR+baILGm/C9FnSNfLdcoY=
X-Google-Smtp-Source: ABdhPJw2AQnv51o88wDaOBZCJpc7VxubU4CRTTOX97WTqqFtSTY9Eza6VIRKrMg8EwLrc1tijESftg==
X-Received: by 2002:a02:605d:: with SMTP id d29mr561106jaf.81.1616148801857;
        Fri, 19 Mar 2021 03:13:21 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id v19sm2372827ilj.60.2021.03.19.03.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 03:13:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 resend 1/3] mm, slub: use pGp to print page flags
Date:   Fri, 19 Mar 2021 18:12:44 +0800
Message-Id: <20210319101246.73513-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210319101246.73513-1-laoar.shao@gmail.com>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pGp has been already introduced in printk, we'd better use it to make
the output human readable.

Before this change, the output is,
[ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200

While after this change, the output is,
[ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Christoph Lameter <cl@linux.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3021ce9bf1b3..ed3f728c1367 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -650,8 +650,9 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
-	       page, page->objects, page->inuse, page->freelist, page->flags);
+	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	       page, page->objects, page->inuse, page->freelist,
+	       page->flags, &page->flags);
 
 }
 
-- 
2.18.2

