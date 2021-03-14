Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DC633A3A4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhCNIiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhCNIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:37:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB715C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:37:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s21so7230153pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/XIknGvLR84rGMdwQ6aEaAVPb5smu+oD8b3vQ4IM8k=;
        b=aDVxzuZ8IcYGLj1RSwLhewC5PmVWu0dlfJ/36dzgZF9bSceI+blRlOfPsfNSxxW6O/
         8Ocjs9Fhv41QkxDt382bCQmXHCpkRJTCrCtCLC+itFc1tbyflTQPJA/Y/k590GKgeKic
         aINjnFc+852JOxRUIGUoZPPOgVQOo41HsbdxjUWmxE/7GghWYlqigSXAOlaKBJ0GIMOF
         vPKeaxLpQcc2WMYuRZcY66ufiCsAgNT98rwfoyr7wfEpDRvbOqigR/2ac9lqVgS0E0Lx
         FWHyyPQ5gWtKmm6WbX7qxF8rzq+wjmzWsfSIBQRYMs/EuQN9PDARAgq4B0uXfydA9GGE
         oFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/XIknGvLR84rGMdwQ6aEaAVPb5smu+oD8b3vQ4IM8k=;
        b=KFnSOtABGQx3NapxnSeWBBp159EXNFEIU8cZ7mptiGijMeeQiCnMATZ/diXIklvqxw
         lNYUNRMM+ERpWD3dfK7IXQup/zUOo15R5jia4h8o2qf1hPFtlBAvJWCccRky62Wrt+QA
         kKaKot6Qb8HpzbV9GNbgLSkTMu885Lp8RF1xgtBvPXa3IyAdkFHnT5EHpTnd4Llw+3fT
         6Cvp9KDLOySfTZm1rAF2irMsTOcve1VD7EdexswUjW5dTjZeEgPHYjBcFzsv9nfAH0oI
         SW1pPLh8rvRIlaFPUWQsPOHoTTNi+6zpgTLIOcE3CgWnYEmMAYD33ATG2iiJg94CQxKI
         pygA==
X-Gm-Message-State: AOAM533lpEejVCly5630HeERET3gEjV+KRfsjheHiCVX1vOmNs9VmaFR
        bbeDejjseLQxXpFLXHQLsKk=
X-Google-Smtp-Source: ABdhPJzYICA0G5WYRTuswHJMdSVt3yyYJyCjLjSlEWppiO/c4hb0DLUOG9dnJfoMsAvVAQDIzepZog==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr7015003pjb.26.1615711071534;
        Sun, 14 Mar 2021 00:37:51 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id s28sm10462585pfd.155.2021.03.14.00.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 00:37:51 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 2/3] mm, slub: don't combine pr_err with INFO
Date:   Sun, 14 Mar 2021 16:37:16 +0800
Message-Id: <20210314083717.96380-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210314083717.96380-1-laoar.shao@gmail.com>
References: <20210314083717.96380-1-laoar.shao@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/slub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ed3f728c1367..7ed388077633 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -624,7 +624,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 	if (!t->addr)
 		return;
 
-	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
+	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
 #ifdef CONFIG_STACKTRACE
 	{
@@ -650,7 +650,7 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
 	       page, page->objects, page->inuse, page->freelist,
 	       page->flags, &page->flags);
 
@@ -707,7 +707,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 
 	print_page_info(page);
 
-	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
+	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
 	       p, p - addr, get_freepointer(s, p));
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -800,7 +800,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 		end--;
 
 	slab_bug(s, "%s overwritten", what);
-	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
@@ -3899,7 +3899,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	for_each_object(p, s, addr, page->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), map)) {
-			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
+			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
 	}
-- 
2.18.2

