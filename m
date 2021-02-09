Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53CF314DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhBILDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhBIK53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:57:29 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C7C061793
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:56:49 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l19so6467104oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7q2vgd6GPGmGunsWTVUHI10pMlkl28NmpYlDYf/aRo=;
        b=fwCut5Niql0JG94VzPHt09KL8mT5vyceC3jqm+dWNCWohVILFNLFGFLCXMrvB9PAZh
         uM7mkHXr318esVxiFuZqu+0B+jwSWJEHyn5H2AR42VpwHrpgnNCsjMLlnOFOusgt+TXn
         gs3zT04Z6BlhZj6obXNi2hq7TfpBDIwbuFANtTuUiGMqYspoJYkmmT9439klI+MKU4/9
         t5zwexVRGA54bgBYGxk4tIMibzvl+8F/fgH3hbLRkT6RIB86zqoXxLF2cAUq0W1W63Ug
         oo/uAhnHM9Knr2A2ojDHe6+RCTOxlj7iev8xQyWgYPBlUl72u9b0KPep0jkbDKQWNJ6V
         QLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7q2vgd6GPGmGunsWTVUHI10pMlkl28NmpYlDYf/aRo=;
        b=SIBvYs5ouVZp67rJY0Ol5npT0yY+Xr9ZIkk4izXYkjx1Pnhbkc4zdfchAsLUK2L6x7
         m+HsA2tTMMRTQoDP8x/X5OGW+7RKz+dpXVO7PSdFPFu5ipyi/kcgzbdDpDi+tNrV5Orx
         YwrOphTrrzlbuVucIHfUrg3wd9mnBLP+cf3pTOMAMXkGxMsBJJc5h4dubV3zUQxPO/w6
         iBqxqVs+ZtnhEZdZ8vsaA9tho+epoAS6ok3qkh/sCphARQC/qncS9KXCds+vxYleVPfU
         SyzrlmxutsMBtfAdYbPxeCmcD6GuHc0Qjqj7TH8zlCyIhkZbqqvuDN4JmEE4jf06kQb3
         WYig==
X-Gm-Message-State: AOAM530y+XWo1GPXi6wvOxN8oFv7xoj/caAQakpdQ4iHiwqTD4/jrXzL
        QHLOW6GXu2DP3QxTmJeqUeY=
X-Google-Smtp-Source: ABdhPJyLW5f385Naxy45QhOOjhIEed19clGHeM7+L/mh+Irh7umoNKaBJP8mOGifb1aZByaSIGYkrw==
X-Received: by 2002:a05:6808:21a:: with SMTP id l26mr1987055oie.42.1612868208449;
        Tue, 09 Feb 2021 02:56:48 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id g3sm4171377ooi.28.2021.02.09.02.56.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:56:47 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 2/3] mm, slub: don't combine pr_err with INFO
Date:   Tue,  9 Feb 2021 18:56:12 +0800
Message-Id: <20210209105613.42747-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210209105613.42747-1-laoar.shao@gmail.com>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is strange to combine "pr_err" with "INFO", so let's remove the
prefix completely.
This patch is motivated by David's comment[1].

- before the patch
[ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)

- after the patch
[ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)

[1]. https://lore.kernel.org/linux-mm/b9c0f2b6-e9b0-0c36-ebdd-2bc684c5a762@redhat.com/#t

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/slub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 87ff086e68a4..2514c37ab4e4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -612,7 +612,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 	if (!t->addr)
 		return;
 
-	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
+	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
 #ifdef CONFIG_STACKTRACE
 	{
@@ -638,7 +638,7 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
 	       page, page->objects, page->inuse, page->freelist,
 	       page->flags, &page->flags);
 
@@ -695,7 +695,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 
 	print_page_info(page);
 
-	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
+	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
 	       p, p - addr, get_freepointer(s, p));
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -788,7 +788,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 		end--;
 
 	slab_bug(s, "%s overwritten", what);
-	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
@@ -3854,7 +3854,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	for_each_object(p, s, addr, page->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), map)) {
-			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
+			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
 	}
-- 
2.17.1

