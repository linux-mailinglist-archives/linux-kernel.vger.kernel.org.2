Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B082D389AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhETBhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhETBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:37:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A02C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x18so6884188pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7oHny6E+9Ko5a6rRGAeWWFvuBQtmHaL/Gza4VQifxU=;
        b=fcRCAtiZ5HTP3JTgOukQxkda0xWdG5rCc20MoUARwhFZYcsrtMUkfIcKJm1OfSvC1z
         2pP6O78sXRx7E6OAzZ9GfOZYdOJQzxt9v8xlhB9XwTBvh+RCx6YIhbWOpkWvZmuGK3WH
         NDDDPsuSmrXkdjX6SDR678AMxIvyw9IuBAXXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7oHny6E+9Ko5a6rRGAeWWFvuBQtmHaL/Gza4VQifxU=;
        b=NQ10KcBlNUIfPiNyyI2RWdVezVZFuvDlwWFrkDZOOYe/Vr+pN20oB+ABI9LC3GayyB
         CniX5shLTQn4P96OIMRYpfOzP0VKHPo8PeR0qTTtS0uc6G0fehJwyBChM5K+Xz+pDkWH
         q4e4T0+dTKpkeozcrIMOYP1oyghVSBtyhBDJoaqvkllRqpHW/hm3DSVPh9IYq96thdeN
         uGHHcWGGZ0uL6K0wcQ3gRwOu5Q39vdKVmhlZRnOr7XFjg7wjBwS6fstOlkzS1qpPYrOz
         PXe0Xcr0eqZOtUtgJQ7UBpN7i6lv9n14IzaWf2DDf5m6UpfZigLjv41C/BHeplhOuF98
         zhcQ==
X-Gm-Message-State: AOAM5322HbaIiN/DPsmvOACAO5nOb8HtpHpSc2bbBkvm3hx6aeteyEpp
        jmthQ3PJbXHZTK7moZ95sGviYQ==
X-Google-Smtp-Source: ABdhPJxApI2DKKS7xj8Eo8mBKGs42dwKJxcluAloONpsm0qpwb5z0eKTSvWzCU0NKAYD8nTCnHEqFg==
X-Received: by 2002:a63:4d52:: with SMTP id n18mr1992699pgl.147.1621474543340;
        Wed, 19 May 2021 18:35:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:200b:db75:4e6c:8b96])
        by smtp.gmail.com with ESMTPSA id m20sm5097368pjq.40.2021.05.19.18.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:35:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: [PATCH 2/3] slub: Print raw pointer addresses when debugging
Date:   Wed, 19 May 2021 18:35:38 -0700
Message-Id: <20210520013539.3733631-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210520013539.3733631-1-swboyd@chromium.org>
References: <20210520013539.3733631-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obscuring the pointers that slub shows when debugging makes for some
confusing slub debug messages:

 Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17

Those addresses are hashed for kernel security reasons. If we're trying
to be secure with slub_debug on the commandline we have some big
problems given that we dump whole chunks of kernel memory to the kernel
logs. Let's use %px here and dump buffers with the actual address for
the buffer instead of the hashed version so that the logs are
meaningful. This also helps if a kernel address is in some slub debug
report so we can figure out that the object is referencing itself.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 mm/slub.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index feda53ae62ba..87eeeed1f369 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -549,7 +549,7 @@ static void print_section(char *level, char *text, u8 *addr,
 			  unsigned int length)
 {
 	metadata_access_enable();
-	print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
+	print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_RAW_ADDRESS,
 			16, 1, addr, length, 1);
 	metadata_access_disable();
 }
@@ -650,7 +650,7 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	pr_err("Slab 0x%px objects=%u used=%u fp=0x%px flags=%#lx(%pGp)\n",
 	       page, page->objects, page->inuse, page->freelist,
 	       page->flags, &page->flags);
 
@@ -707,7 +707,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 
 	print_page_info(page);
 
-	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
+	pr_err("Object 0x%px @offset=%tu fp=0x%px\n\n",
 	       p, p - addr, get_freepointer(s, p));
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -777,7 +777,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 						void *from, void *to)
 {
-	slab_fix(s, "Restoring 0x%p-0x%p=0x%x\n", from, to - 1, data);
+	slab_fix(s, "Restoring 0x%px-0x%px=0x%x\n", from, to - 1, data);
 	memset(from, data, to - from);
 }
 
@@ -800,7 +800,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 		end--;
 
 	slab_bug(s, "%s overwritten", what);
-	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	pr_err("0x%px-0x%px @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
@@ -893,7 +893,7 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
-	slab_err(s, page, "Padding overwritten. 0x%p-0x%p @offset=%tu",
+	slab_err(s, page, "Padding overwritten. 0x%px-0x%px @offset=%tu",
 			fault, end - 1, fault - start);
 	print_section(KERN_ERR, "Padding ", pad, remainder);
 
@@ -1041,7 +1041,7 @@ static void trace(struct kmem_cache *s, struct page *page, void *object,
 								int alloc)
 {
 	if (s->flags & SLAB_TRACE) {
-		pr_info("TRACE %s %s 0x%p inuse=%d fp=0x%p\n",
+		pr_info("TRACE %s %s 0x%px inuse=%d fp=0x%px\n",
 			s->name,
 			alloc ? "alloc" : "free",
 			object, page->inuse,
@@ -1186,7 +1186,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 		struct page *page, void *object, unsigned long addr)
 {
 	if (!check_valid_pointer(s, page, object)) {
-		slab_err(s, page, "Invalid object pointer 0x%p", object);
+		slab_err(s, page, "Invalid object pointer 0x%px", object);
 		return 0;
 	}
 
@@ -1200,10 +1200,10 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 
 	if (unlikely(s != page->slab_cache)) {
 		if (!PageSlab(page)) {
-			slab_err(s, page, "Attempt to free object(0x%p) outside of slab",
+			slab_err(s, page, "Attempt to free object(0x%px) outside of slab",
 				 object);
 		} else if (!page->slab_cache) {
-			pr_err("SLUB <none>: no slab for object 0x%p.\n",
+			pr_err("SLUB <none>: no slab for object 0x%px.\n",
 			       object);
 			dump_stack();
 		} else
@@ -1263,7 +1263,7 @@ static noinline int free_debug_processing(
 	slab_unlock(page);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	if (!ret)
-		slab_fix(s, "Object at 0x%p not freed", object);
+		slab_fix(s, "Object at 0x%px not freed", object);
 	return ret;
 }
 
@@ -3908,7 +3908,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	for_each_object(p, s, addr, page->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), map)) {
-			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
+			pr_err("Object 0x%px @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
 	}
-- 
https://chromeos.dev

