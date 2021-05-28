Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C33946B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhE1Rzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhE1Rzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:55:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86030C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:54:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f22so3850932pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zX9y6MPWlnZXxy5C+bxFxm0M+cmWizjNoRY22aXGCvk=;
        b=HkpKu7AQ2h4w1EQzRjpuCfIGbTM+bM0karGp5YXM2ZDRYo1qSytAK5pVq9JXW+VFEX
         ZCc69ulBB/LCzEN+kKFWKxZDfnhOSgEpKjpGlBm5+enzTw2jybXWx7UdzQK26tBrQmvj
         w2DY2JlwpFJFnRo8qR4P8r+VhPf9OfnPuAZ5FcKSbIzL1qj8jkUd2LzNgQSmZOOHAyEK
         vLSUeKfcbru+95hgCvy0q4+91VH/N3Lp0wYopC5wL7gwP0UjgwfXCkiAAZSxDqWlQddD
         C0SQspC2CyQUTocwy7iFuctpCnGxKdmDfMDMDNIdSfoZ1wRpIu7L/mLDMG+Nl1l24aSY
         Py6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zX9y6MPWlnZXxy5C+bxFxm0M+cmWizjNoRY22aXGCvk=;
        b=EYoxqfYXyJDxD9ZXdokAOOuIO+wbNyEr7mk40M6JvTX3TmtadrOV2sfp7NAMkwTS7S
         Pb/3JILWkrNWEjbd4fGePwm1hzlvUeM82w2rUzasmCdYkhFA6vWAZg/EEMLuVuFvkeX1
         My9eQ7rp7KAFywLIXJdinwhTJ0OlZCONop5VG8+pkrUT/6oVVq09ALgk/GMf+tb2Xg0s
         0Jz+sqbhKfvsKtj5/UglglkXp5KgHLTbS1uRcEtXUcPzxEsI0H9tr/C0SgXjAdqnmVcN
         jPedeAZJi4qepWLbCEIPpFX4MLM2RBx5oKim8x7h6kLUyrpWrEGRfKK3zvtbM16pz+dg
         JCAA==
X-Gm-Message-State: AOAM5320jSKGEDUCLOSQcqjLtlrvRL1G4RYTR5hkL3qynrnL134xnPdW
        wx4961ClWqqTV10DHms+ojE=
X-Google-Smtp-Source: ABdhPJxiLD9sWTINf7n0WvcZmjynRqPs6QaJpvfx4v8xxn68piKFViC8EijmF2+R0U/HPuQt8/b2wA==
X-Received: by 2002:a65:4d4e:: with SMTP id j14mr36424pgt.343.1622224446965;
        Fri, 28 May 2021 10:54:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id a129sm585079pfa.118.2021.05.28.10.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:54:05 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, willy@infradead.org, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: dump_page: print total mapcount for compound page
Date:   Fri, 28 May 2021 10:54:03 -0700
Message-Id: <20210528175403.4506-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total mapcount is a useful information for debugging, but we can't
call total_mapcount() directly since it calls some assertions which may
be triggered as commit 6dc5ea16c86f ("mm,
dump_page: do not crash with bad compound_mapcount()") met.

We could implement yet another implementation for dump_page() but
it has the limitation when individual mapcount of subpages is corrupted.

Actually the total mapcount could be decoded from refcount, pincount and
compound mapcount although it may be not very precise due to some
transient references.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
I think we are on the same page that the total mapcount is useful
information and it would be ideal to print this information when dumpping
page if possible.  But how to implement it safely seems controversial.
Some ideas and potential problems have been discussed by
https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2105261733110.16920@eggly.anvils/.

So I prepared this patch to show a possible approach to get some
feedback.  The same thing could be decoded by the reader of page dump
as well by using the same formula used by this patch.  However it sounds
more convenient to have kernel do the math.
 
 mm/debug.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index e73fe0a8ec3d..129efcfcaf79 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -54,8 +54,13 @@ static void __dump_page(struct page *page)
 	 * inaccuracy here due to racing.
 	 */
 	bool page_cma = is_migrate_cma_page(page);
-	int mapcount;
+	int mapcount, total_mapcount;
+	int nr;
+	int refcount;
+	int pincount = 0;
+	int comp_mapcnt;
 	char *type = "";
+	bool is_slab = PageSlab(head);
 
 	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
 		/*
@@ -82,22 +87,40 @@ static void __dump_page(struct page *page)
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
+	mapcount = is_slab ? 0 : page_mapcount(page);
+
+	refcount = page_ref_count(head);
 
 	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
-			page, page_ref_count(head), mapcount, mapping,
+			page, refcount, mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
+		comp_mapcnt = head_compound_mapcount(head);
 		if (hpage_pincount_available(page)) {
+			pincount = head_compound_pincount(head);
 			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
 					head, compound_order(head),
-					head_compound_mapcount(head),
-					head_compound_pincount(head));
+					comp_mapcnt, pincount);
 		} else {
 			pr_warn("head:%p order:%u compound_mapcount:%d\n",
 					head, compound_order(head),
-					head_compound_mapcount(head));
+					comp_mapcnt);
+		}
+
+		nr = compound_nr(head);
+		if (is_slab)
+			total_mapcount = 0;
+		else if (PageHuge(head))
+			total_mapcount = comp_mapcnt;
+		else {
+			if (mapping) {
+				if (!PageAnon(head))
+					nr = nr * (comp_mapcnt + 1) - comp_mapcnt;
+			} else
+				nr = 0;
+			total_mapcount = refcount - pincount - nr;
 		}
+		pr_warn("total_mapcount(estimated):%d\n", total_mapcount);
 	}
 
 #ifdef CONFIG_MEMCG
-- 
2.26.2

