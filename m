Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7BE3F6B99
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhHXWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhHXWOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:14:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD789C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:13:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so15248593pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2xpgVmxaRDEeNxf6Ahsf4OjLrfQgqJMHlbxtbe8c4g=;
        b=jiwpbiI6KttoYyaVaxg+Hj9lPlxy5GHsH/mnsSR8g1xY4A1zxKY6QZLq1IB+jACffE
         pbj2KayjMx1PpbdR9eqsxdhx1vybPkKh0FKmm1LNt9cNNyIY+9CxJ5tGeaA/6nBB0E4y
         C4d3zadBoR14iOC+VrMA4QzP9Q8pid9gP4ogttqA2kiTtNr5aFq6Jl8xU67E6EPIkeD9
         HWmrDetFskp8cmaKf5ah/zL34RIU2iBxge+laO6nu9et8kiY6lL2CUZECchqXHQwsF0F
         M3ARYfOQ2hLU66gurbvwfXkYcgfMfdIv4Ma15LaUOP4K6vGna2tsSDFOBmbhYAzGR2El
         aL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2xpgVmxaRDEeNxf6Ahsf4OjLrfQgqJMHlbxtbe8c4g=;
        b=dgxq+ioY04N6VZvQI4w+JxpIlvoczDdam8yLBY7/5CfDF4hZMsf1Kg2DoQqpARDzZZ
         z12envFHxYJjvIVnSCZs9z2L1oQNRYBtvdp0zrq0+yUSHPaI/cnTwwNlQT5srwgO4C+m
         aVD9KXbDafishz8fU1eKmkPqzzVZVzvJ4DZHEQrzHsVWUskobhqfLk1R0C1sxihrwjxf
         2D9VegGAOU2MFuKH5oE10jqPgQZeeEMdE4/0xokxW71hkrsJ/eFR+ab5EghqAzPntatQ
         gwQbIPXlM+GAnnTE/cIMFQFGSH5dlCBzOdor9HqPMrRvFMwiefLwySYHcGTGcLroFoEZ
         XD7g==
X-Gm-Message-State: AOAM532hCe8t8zLrZh2kmgWwUzvYqGRXi1zlVyrxvedMv2aHOxsFI8So
        Fm5JBaPB6zUhkB41OOgs/Ug=
X-Google-Smtp-Source: ABdhPJzqHbdKkYKaqeJm3Grcj/GXM7StHWVOFs6cPBn+YyvlFPsx+ECtqhl32qElb2bkEn4E+R6DVg==
X-Received: by 2002:a17:90a:f285:: with SMTP id fs5mr6596427pjb.148.1629843205424;
        Tue, 24 Aug 2021 15:13:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id z65sm1748123pjj.43.2021.08.24.15.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:13:24 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, hughd@google.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hwpoison: deal with page cache THP
Date:   Tue, 24 Aug 2021 15:13:22 -0700
Message-Id: <20210824221322.7663-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently hwpoison doesn't handle page cache THP, just give up and return
error.  It is just because the hwpoison THP support was added before
page cache THP was supported.

Handling page cache THP is simple, they could be offlined by splitting THP,
just like anonymous THP.

The question is how to distinguish them with allocating and freeing THP
which can't be handled by hwpoison properly.  It seems page->mapping is a
good indicator, both anonymous page and file page have it populated, but
it won't be populated until the page is added to rmap or page cache, in
other word, instantiated.  If page->mapping is populated it is
definitely not in allocating or freeing.

The later get_page_unless_zero() could serialize against page free
paths.

Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 60df8fcd0444..caa0b0c1f5b8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1149,13 +1149,16 @@ static int __get_hwpoison_page(struct page *page)
 
 	if (PageTransHuge(head)) {
 		/*
-		 * Non anonymous thp exists only in allocation/free time. We
-		 * can't handle such a case correctly, so let's give it up.
-		 * This should be better than triggering BUG_ON when kernel
-		 * tries to touch the "partially handled" page.
+		 * We can't handle allocating or freeing THPs, so let's give
+		 * it up. This should be better than triggering BUG_ON when
+		 * kernel tries to touch the "partially handled" page.
+		 *
+		 * page->mapping won't be initialized until the page is added
+		 * to rmap or page cache.  Use this as an indicator for if
+		 * this is an instantiated page.
 		 */
-		if (!PageAnon(head)) {
-			pr_err("Memory failure: %#lx: non anonymous thp\n",
+		if (!head->mapping) {
+			pr_err("Memory failure: %#lx: non instantiated thp\n",
 				page_to_pfn(page));
 			return 0;
 		}
@@ -1414,12 +1417,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 static int try_to_split_thp_page(struct page *page, const char *msg)
 {
 	lock_page(page);
-	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+	if (!page->mapping || unlikely(split_huge_page(page))) {
 		unsigned long pfn = page_to_pfn(page);
 
 		unlock_page(page);
-		if (!PageAnon(page))
-			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
+		if (!page->mapping)
+			pr_info("%s: %#lx: not instantiated thp\n", msg, pfn);
 		else
 			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
 		put_page(page);
-- 
2.26.2

