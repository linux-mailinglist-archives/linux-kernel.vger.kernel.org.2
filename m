Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA933A3A3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhCNIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbhCNIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:37:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:37:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a8so7332373plp.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNJwfxygBk8och6dkCm3Z6jjDTILZpQ6YdR+YYjbt2o=;
        b=WOPZnEPTCfPmKaWtnRdh31FiRGZs2NIdID2ASjad7I4JZl36UhWrcMHy0MPtU3K6cs
         3lTi+73oLkW6tZdoChX9ziYWNYxMlxfLda4xzOVfb3ZwijAzaZcdAOO/ixHHsxdx1nib
         2NV3Y/f026o4M1xZc7zHvPqm7io3al4sufjywiBN7P7DLwkC9Zhsmfudu9oWsvpJPHtQ
         qTEd3f5s6fvrWYbCOIn2+gqB5MZ77vw1yf7I7qZbreYZtdhea1HUDcGdgQua5wBC8ZZx
         FZOWtp/Fd9J9AswkAzGTmddGBmyZ/Iv2sV1KZN9LHrBY6OwuYwKis4yddStItWVgTjXP
         f/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNJwfxygBk8och6dkCm3Z6jjDTILZpQ6YdR+YYjbt2o=;
        b=Muqo3cISxkx0m21to/mcslbEGJrnS9p2V29vZ0DYStTj5KLKPcauGIzdGaQWlgRvab
         qqaaLk2fIwfhzD3Yn2f3g4AdTvhCFnGZN3/HMx7WTvEGyu1oAmVvN43gNOaIV1ywrh9i
         ag0GMo5BmwQOASvJP1X8Sw+jhYEk4JsB4qDUNAsktBfA0WYP8rLFvzJsbbfQb+dmsSib
         IF6xFPUR+zji3a6dHzq9FhiCpO30A9MsAl21MckKfWHIhh78fR3p3RSNw+RNjhWLpXAd
         1q2beCY0q5hdqjGRYQJuNvzPZ2vYvmWKpwt1IBENB3gghi97WIA+WW3UoX4JkvZjgKAK
         czkw==
X-Gm-Message-State: AOAM5308r6aNouVcc08kMMxunNBb5LqeNBUX9ITlOWLNU+4Xx0blwTe9
        vCua+txFVv0WvXGDzVB1Nno=
X-Google-Smtp-Source: ABdhPJzPybjeyHBLvaO48RQbVJnWPpfO8yapizyFqEhGdIL1M0Oo03KJbYvalNWol/SyvQY+kYDbnQ==
X-Received: by 2002:a17:902:8641:b029:e4:7e05:c916 with SMTP id y1-20020a1709028641b02900e47e05c916mr6004931plt.57.1615711065661;
        Sun, 14 Mar 2021 00:37:45 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id s28sm10462585pfd.155.2021.03.14.00.37.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 00:37:45 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 1/3] mm, slub: use pGp to print page flags
Date:   Sun, 14 Mar 2021 16:37:15 +0800
Message-Id: <20210314083717.96380-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210314083717.96380-1-laoar.shao@gmail.com>
References: <20210314083717.96380-1-laoar.shao@gmail.com>
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

