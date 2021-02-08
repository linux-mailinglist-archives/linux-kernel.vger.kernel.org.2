Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12660312EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBHK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhBHKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:15:56 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5572C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:15:15 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id k25so11558228otb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9ylQWblYtnPRQvoph8wZjHjgqRFeyFluXHMnXSNEII=;
        b=awjEmhyhbPa7TQcywn8ev/HkkPlBSZJqzZvYodfSwHh8vMdr2noz+9czPlIAqP2wBD
         zunFWlnDaxpggVrd+plHciOdwF9/oWhdrR19PMwM+ZVOh5mhGtJUe92Kk6ThP61UnKxU
         dN1ngdbXFri6QfupQj5jfXkV4aUqIJWwv2JpFuumEHQPbiuytYPRZb8ufB3LHum9Me6B
         ZAWssz6+EyuZZ7uowOaenyYte+Urkwxx7jUmc3HamrrlhZVk2HRnN2p3VabmZ/xlSsup
         aDUKw7BDjS/gaP3vg9S7e2I/87aB06ttFeZaFcXcusAsZKMkqiGq05IvQ8Ed6MhOerEJ
         fzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9ylQWblYtnPRQvoph8wZjHjgqRFeyFluXHMnXSNEII=;
        b=fsk79iMdVpInjLODXtx02VZ+E88AXyrCIn3ydj4RHR11B3f9JEIGrdNnwyiGZGZsuK
         WaW0Pbl+JYIc4gwnRUluZ3VfvqZghfEd/0GeYlERr5vhAqcHBqyjs/oKd9PBhDzJ01k9
         DlzjydEx8l5GiNbtKa2wAXWly7EmNS1973BCGGp12uT8u+ubUpqtPa/PvFqfB6aPblLV
         Wv5ACzTvMm0KXJ9Tw4qyvGMoplURVxblRQ8fopNYVK7AP3dsBRKVRJifWHmDZ2IP2txX
         6RzSCKUA8c2uLQUrNAikaodcnRJgn9ePSS+DDhtidCC5RFVh2PRzV+k/CgbYB8uR8mYP
         35Tg==
X-Gm-Message-State: AOAM531hIPyHpTwzbQZlfsxnjWM70lki0xBupgh3O6xLVxhoxoDPDfb5
        jK8V4VBuR9nnJWfJU0130ho=
X-Google-Smtp-Source: ABdhPJySj3w4RJY0tl1RpCm1w7jT4MVla6K/FvhIrBymhMRaBZ22qFnBwEYLdS8HLfU15O32j3gdiA==
X-Received: by 2002:a9d:6c51:: with SMTP id g17mr12595020otq.197.1612779315154;
        Mon, 08 Feb 2021 02:15:15 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t3sm607226otb.36.2021.02.08.02.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 02:15:14 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, willy@infradead.org, cl@linux.com,
        linmiaohe@huawei.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/3] mm, slub: don't combine pr_err with INFO
Date:   Mon,  8 Feb 2021 18:14:38 +0800
Message-Id: <20210208101439.55474-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210208101439.55474-1-laoar.shao@gmail.com>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
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

