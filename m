Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF213419AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCSKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhCSKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:13:29 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9771BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:29 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 19so7524564ilj.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGnXsS0yyyDbPQIbsDlem74w/lBqbAQTEjcNoC1ZgT0=;
        b=UOpu8GIV7PLceiPZTQ15dbRbiTwlLvVureKOpFDN26Q6vFVPtCTBUcTBRi+Zg9/u71
         v/WvO/hjn8KQxAriyr9YRmYX7jOP6iFqI0RujF+QXPlUcp/lte+oyEUCy972ncVe7l0g
         i6d2tKvDQ+wurX0zu0JT9DwG4HrGT0XiFMdfvLb/Xoj+F7nuE2rlzqbz+ZeUqky4XzmL
         VoaWB937GVR3F0wy4NezX+1UpaEuPNBB9KKbHvVBZr7LPSntDTeo7Kj2TplVfol6m1pe
         UeprY38L+9TdhVujRMC5Rrwnv1y2UGYwxTUf8ZoCKS5srIJDPajKREnF6RdSY9VT8FkB
         +Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGnXsS0yyyDbPQIbsDlem74w/lBqbAQTEjcNoC1ZgT0=;
        b=uYoaqfQcHQJ+jhTUQa110du2X3coiWsU7vwWTM5ctget8eYedYAJcRx1O64h5dH8xf
         OXj5n8sajJL/H6wz08W0GsB78SJAkSA+eg0fDrWnMteGDlIXl/xui8RBXroHDghcuiEY
         Z2442MgZWEKvNifnSkaPVUs8UZfrcb7sn+GDH99J4tJ9+xWqECqsKE9/2C0ox35AB2ht
         VCgZ/rM/TPC8QK8M/m7eA6rZuaCPTZDaBV7eOFRFMeT5awyWowCfu9CfFKaiGUzfc8j3
         PnSDy9vykEm3orqbwfMZB1UWeohp8JW1y9MeeqkvA0ovMb/ZDRAvzBwP9YgFChJ6mjxU
         GTUA==
X-Gm-Message-State: AOAM531/dO0+GwybjYSo07TOT65h9t7uVxn258Tk1IaVMoYz9pElfqMP
        BfKpYQDrcQxaZ57MNV5XdkQ=
X-Google-Smtp-Source: ABdhPJwvAUFAkfEirQktpQp4H/rEaYYwQ7hmnDsZ7tGUMVrm7Cw8DfJAynl2u9KXbmezhTDCfzbO4g==
X-Received: by 2002:a05:6e02:968:: with SMTP id q8mr2238151ilt.31.1616148809127;
        Fri, 19 Mar 2021 03:13:29 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id v19sm2372827ilj.60.2021.03.19.03.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 03:13:28 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 resend 2/3] mm, slub: don't combine pr_err with INFO
Date:   Fri, 19 Mar 2021 18:12:45 +0800
Message-Id: <20210319101246.73513-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210319101246.73513-1-laoar.shao@gmail.com>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
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
Acked-by: David Rientjes <rientjes@google.com>
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

