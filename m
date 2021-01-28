Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDE306B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhA1CV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhA1CVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:21:04 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C09C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:24 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id v1so3784708ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1OYii8qckcq3S4gy4A47ko/gHa9BnhGIgmWAQqpg/M=;
        b=lb/j1XcyuwWJe7Zai31RMj1jc53IDDwwGEpjbhzP/USvR95gA71GKXbDkcXvtrdoGw
         ILKKhge9urM+lLMMprP/r658rPFYW577v+tIy7h6UdUt1+WcbExLye4FbJNDWjiAM1nj
         fzElQ1h/coZWpRrZSbZq9FaD+JsZMZfYuJke9knxlxoTAHWmmH1LrmJPAhZ0w8Fzpc0k
         ary9eAAScmaaq7v4nzdFc4BxKBcZm6EZthSOPLlo1ddCCV/CRjdnPyoLtveON8Z6Abcd
         paKYTDA3eD/Fiq/18zEe1IVHrEu3OhmLHcAvhhbGmEaScwWOkjOzYOIrEGy0b+lYdA0t
         XMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1OYii8qckcq3S4gy4A47ko/gHa9BnhGIgmWAQqpg/M=;
        b=fsm5FrDvyyb62PdfnvSjqAIIj/XgJY4UhBIifxPkUHbsKfOtHk0D8EF+OQ/J5YVqQd
         Aa996jHFds4+6Tch3f/QewsXr5mKw36lTVBok/Bj+YLrb9yC5GWLFhhiQmlhqDfMF7qX
         bG8g8jU3gFqsy+ZIqSv57zWAjRctukMaCTljDonW+Ho0hIcncNnAsxF3ZwWNZhREDCee
         zX77YF1e/DKOMRFAbOdDHv6ER/tDIEGbuFAx/rfQzqDYUHov13s/iqFf7UIbOrPGVNYr
         NoNp3J1pjIRFF9YeUk89+fQ6k2jKwTyyHWIlk8EutAsVPGS7G+SLWBjRb4N4H30H3InI
         wRgw==
X-Gm-Message-State: AOAM533RPbfEyA4uaR49j637pwhd2qgp6XafY8h9/27UJ7tNis4VE1JO
        pNfHpFFkHvqQsGpd9CmWMps=
X-Google-Smtp-Source: ABdhPJy/5gSK2bRCKJPk6p1+J1Yppy/v2zByLpU1b0adu5bjtUcBkyhg2AnC+OSyMCu9aAHlMkrWOg==
X-Received: by 2002:a9d:2035:: with SMTP id n50mr9470077ota.44.1611800424005;
        Wed, 27 Jan 2021 18:20:24 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id m10sm731246otp.19.2021.01.27.18.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 18:20:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/3] mm, slub: don't combine pr_err with INFO
Date:   Thu, 28 Jan 2021 10:19:46 +0800
Message-Id: <20210128021947.22877-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210128021947.22877-1-laoar.shao@gmail.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is strange to combine "pr_err" with "INFO", so let's clean them up.
This patch is motivated by David's comment[1].

- before the patch
[ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)

- after the patch
[ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)

[1]. https://lore.kernel.org/linux-mm/b9c0f2b6-e9b0-0c36-ebdd-2bc684c5a762@redhat.com/#t

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/slub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4b9ab267afbc..18b4474c8fa2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -615,7 +615,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 	if (!t->addr)
 		return;
 
-	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
+	pr_err("ERR: %s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
 #ifdef CONFIG_STACKTRACE
 	{
@@ -641,7 +641,7 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	pr_err("ERR: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
 	       page, page->objects, page->inuse, page->freelist,
 	       page->flags, &page->flags);
 
@@ -698,7 +698,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 
 	print_page_info(page);
 
-	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
+	pr_err("ERR: Object 0x%p @offset=%tu fp=0x%p\n\n",
 	       p, p - addr, get_freepointer(s, p));
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -791,7 +791,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 		end--;
 
 	slab_bug(s, "%s overwritten", what);
-	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	pr_err("ERR: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
@@ -3855,7 +3855,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	for_each_object(p, s, addr, page->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), map)) {
-			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
+			pr_err("ERR: Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
 	}
-- 
2.17.1

