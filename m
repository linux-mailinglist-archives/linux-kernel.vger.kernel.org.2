Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88831C027
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBORKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhBOPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:53:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBBC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx20so4159607pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3e9p58enmPrHBj/qg6RhNzmlmUNgPoZWys+AfRFnkts=;
        b=RnWdyHBEmyUOIzHTTr0e0/OcEI4j2IT49LUcBBXYa/fsvM9ONHWMAwC2ek2w5jT1ne
         XjkgbNP4o5aj+ps3vJPS01bxUiSEebUfH1A2OUPv/7+gL92Jekmx0M7y/H9fyBp9N2TW
         IppdiI7upRht+jJOSaxlOgTVz9H4UCu/2gyo/tl+Lve+AXGXv/R9ZxNUbKJ4b2/l5aAS
         NZ5FKnJzptAXI1862MlAStC0MifUhGqqTxdr9wWvKcirpK1M2w3XQKSeS/6q1QUDSNRZ
         2ssx74blDE7G6YilTwd76L+P43mdDv+ZoyASCdklIcqWlTuhjEOpZPvsBhDYzwjl6YQV
         eVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3e9p58enmPrHBj/qg6RhNzmlmUNgPoZWys+AfRFnkts=;
        b=F2fh/JN4HUKlOUncIHKd0vsAp79h8M09jD3rGNYZoLlgdgLJqn0pQ0Z+xtMmgdtvoP
         eIT9SDQNkC1SEz2uM+9619kafh20y5lE0/VZLZeIZtfLGDOhjXS2c2Smc+VLYey55fny
         t7b0+6Bf30mLXGh9NSy4P2nfvceUao7CsSnCx1e3c/20Io7YrAPm8KvYwkNSq1gnrt70
         8kRkAtt7lHA+u+YN7B4nRgYQrh7hhBvy7rlVs6N33LRYYbxbgCgD46CeDW7Wf1b03adF
         4VnI3LkATUgifMBM50q/EO36v0QCzEFstyN51I27wGScqJ5ha0br+tMCrNYBMfR/en+v
         9qJA==
X-Gm-Message-State: AOAM533Q3PAg0kG5XUtwDE+R6jJxn/yHDVOz312cdq0e/kdErcSLqIdL
        IDhmrFUFOE3YlqqmzkezpXo=
X-Google-Smtp-Source: ABdhPJzs7iQp8Bu1myc2lzmtjCMtr7xo0mUxbPVeN24kaQ8+zyXdHKQ6o9EGAkDlxKD+0n+nSfGkEA==
X-Received: by 2002:a17:90a:4a0d:: with SMTP id e13mr16271613pjh.96.1613404394549;
        Mon, 15 Feb 2021 07:53:14 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i1sm19771215pfq.158.2021.02.15.07.53.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:53:14 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 2/3] mm, slub: don't combine pr_err with INFO
Date:   Mon, 15 Feb 2021 23:51:40 +0800
Message-Id: <20210215155141.47432-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210215155141.47432-1-laoar.shao@gmail.com>
References: <20210215155141.47432-1-laoar.shao@gmail.com>
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
index ddd429832577..d66a7ebd21fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -615,7 +615,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 	if (!t->addr)
 		return;
 
-	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
+	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
 #ifdef CONFIG_STACKTRACE
 	{
@@ -641,7 +641,7 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
 	       page, page->objects, page->inuse, page->freelist,
 	       page->flags, &page->flags);
 
@@ -698,7 +698,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 
 	print_page_info(page);
 
-	pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
+	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
 	       p, p - addr, get_freepointer(s, p));
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -791,7 +791,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 		end--;
 
 	slab_bug(s, "%s overwritten", what);
-	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
@@ -3855,7 +3855,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	for_each_object(p, s, addr, page->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), map)) {
-			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
+			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
 	}
-- 
2.18.2

