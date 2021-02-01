Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0965D30A6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhBAL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBAL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:57:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA8C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:57:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m12so961767pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9ylQWblYtnPRQvoph8wZjHjgqRFeyFluXHMnXSNEII=;
        b=Cgs5/WEVA1zE3HynJRWc9yOQHPVngA7hG6MVTwWqBpVLN3EQ0daP5cr/pFQ00U3F3H
         Ct+zTvg5uiFpQVsmCaOL7HWzU4SzvJBmsUd0g5YPGDt4SFnrH4sBjMjjISuEI8QdNWaJ
         OfWdwyosuqi4lISVDOCV6ogPjs911BjuQo1V5TCv7L9MgKucbHup40LG0uqnzzC7NrJb
         2fhQ+LV5yfZyKY40YqWeGOM7PNvIULEB/Rpw+V28oiVRSEdpi7lGlwjxWT9Jgj6P1lMM
         7J6vnMuALYbot0o34PhXbaz+dixJWyBYtm/m58rfcduSDgk8M62z5lS8KcaQxPVdLq5w
         9fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9ylQWblYtnPRQvoph8wZjHjgqRFeyFluXHMnXSNEII=;
        b=lIwbdplq1iuGlztUItFXHmmI44q8+sQwtKLn7j28nR2oiNvqTVXrjwnXpsLidRuLzd
         iJo0auVYsYovEWN02NH7BU4tQisoLgoXfOl4gm4QTHPIbz9rE5zVVYqeIMZM8rZOxg97
         OfK8SHRUtEnyQLBBV0LaC72mK3ZFxzWvbwyu17ZBwcatrKMoZwU8poiCbSFSJGPHQHln
         G5hF/1uRcjAz4OGv4AB3CeMwgGudedtHHtqFyEIIg7+uyNPuxcLY1PKrLU3ajqk3oV5t
         vwTp3Nn/raDPRtwu8aorY0mdbgC3T3v8cGRZ4CxJrBD+iY1Lr7xtQLgid7oNIfGJ8cT7
         gLqg==
X-Gm-Message-State: AOAM530RCP6aVgN/axlvp4rvFBomMV8Yn8BiG+9cKNNLYOa8Zgq2k0oj
        KtyXOGePEm2bmqoWCzEWeh4=
X-Google-Smtp-Source: ABdhPJyxqcsyP9BhzwpDIdlbYS1Ys5AUwk58ua/k09wfRuXbCCa0mq/TManxrwn+c2O4Eh8h/MtaCw==
X-Received: by 2002:a17:90a:cb15:: with SMTP id z21mr7227873pjt.164.1612180623979;
        Mon, 01 Feb 2021 03:57:03 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id dw23sm7195152pjb.3.2021.02.01.03.56.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:57:03 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 2/3] mm, slub: don't combine pr_err with INFO
Date:   Mon,  1 Feb 2021 19:56:09 +0800
Message-Id: <20210201115610.87808-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210201115610.87808-1-laoar.shao@gmail.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
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
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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

