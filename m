Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD03238FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhBXItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhBXIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:48:55 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:48:15 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e10so1132306qtx.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iQC24H6FmEMhCM9apOO1cR+h9/mESKofrx3gZbNKH9k=;
        b=bBb/YdGZTYUk5+UFoHDVe+ct98GpwwKfxczlzY9JPxOGE3HcSFfQzPLYkF7MVzYhZU
         Vc6ginFPSQuN96o9OZMPaDcQEI5+s0aMsYnPR4xuAWtOfGoCIf7uH24yt/pjcsmST3qo
         0DL4XVC0UoYm6eIlLqR3cZUoUe9JLc9cjY5xuLRAcWywxy3FW7D3w9nd1kvKxVN6JhU6
         4LE3M2DqSmaHpimL/MBaM/heY/3dWqrcm3NOD10LhF+Zhs3vNYyLCMeh83+t+e8Q5Ax+
         OPBcnkhjQzS1h6CjaPy80i76mz8C9eWrpJytqpdAD7EDdqaPyNrOkjYQAzYYGX3vaVM8
         MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iQC24H6FmEMhCM9apOO1cR+h9/mESKofrx3gZbNKH9k=;
        b=VZT7IulxSFtrjvsMYxwstp8zm2nkoBFZwnxBQLPM6vSlULaVVr3NdtH/7Oh0vYMabU
         yArTCNcrG+lR2gat6LMXxd9ppwY5lJHoBbnCYg6NoX2deb5z7vFvtYe4IQWpi/XBEVJs
         WmkI6wFjGo3NIVs790yyQrJxg8o5jCQpPAFhBd82phT+GeAbqejXwqQpkYe3IpnoaHod
         Z2BByXWNlTAkcK73zPOFkC+SzSTpn4c2BprDS0wQ8YXpQ/J7HX3+WP0NiHZJO+wRrQOa
         IJbVAX1FoTEtIiR+fIE9038IkFnYyEJKSiajcLf2Q5nZbozwD7u/r91cU4eta3w6SiQW
         i2YQ==
X-Gm-Message-State: AOAM533cd/Je/ATEL2mWNKA676OH1VBhQuYdjQemAI7RARmpXoxdweeZ
        63YIyRIEaLjPHm75Iw3J1UioX64bBj0=
X-Google-Smtp-Source: ABdhPJwOcC6i9orq+rsl5Yj5GVp1uIFiAz2tDUDCOP04AyJOvdv3LemeIGhkgcTfrug/xzNg60FTIr9epZ0=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:e588:e0b1:9ba0:55be])
 (user=yuzhao job=sendgmr) by 2002:a0c:b20d:: with SMTP id x13mr29074445qvd.19.1614156494319;
 Wed, 24 Feb 2021 00:48:14 -0800 (PST)
Date:   Wed, 24 Feb 2021 01:48:07 -0700
In-Reply-To: <20210122220600.906146-11-yuzhao@google.com>
Message-Id: <20210224084807.2179942-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-11-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] mm: test page->flags directly in page_lru()
From:   Yu Zhao <yuzhao@google.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz
Cc:     alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, willy@infradead.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently page_lru() uses Page{Active,Unevictable} to determine which
lru list a page belongs to. Page{Active,Unevictable} contain
compound_head() and therefore page_lru() essentially tests
PG_{active,unevictable} against compound_head(page)->flags. Once an
lru list is determined, page->lru, rather than
compound_head(page)->lru, will be added to or deleted from it.

Though not bug, having compound_head() in page_lru() increases the
size of vmlinux by O(KB) because page_lru() is inlined many places.
And removing compound_head() entirely from Page{Active,Unevictable}
may not be the best option (for the moment) either because there
may be other cases that need compound_head(). This patch makes
page_lru() and __clear_page_lru_flags(), which are used immediately
before and after operations on page->lru, test
PG_{active,unevictable} directly against page->flags instead.

scripts/bloat-o-meter results before and after the entire series:
  Glang: add/remove: 0/1 grow/shrink: 7/10 up/down: 191/-1189 (-998)
  GCC: add/remove: 0/1 grow/shrink: 9/9 up/down: 1010/-783 (227)

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..1b8df9e6f63f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -46,14 +46,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageLRU(page), page);
 
-	__ClearPageLRU(page);
-
 	/* this shouldn't happen, so leave the flags to bad_page() */
-	if (PageActive(page) && PageUnevictable(page))
+	if ((page->flags & (BIT(PG_active) | BIT(PG_unevictable))) ==
+	    (BIT(PG_active) | BIT(PG_unevictable)))
 		return;
 
-	__ClearPageActive(page);
-	__ClearPageUnevictable(page);
+	page->flags &= ~(BIT(PG_lru) | BIT(PG_active) | BIT(PG_unevictable));
 }
 
 /**
@@ -65,18 +63,13 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
  */
 static __always_inline enum lru_list page_lru(struct page *page)
 {
-	enum lru_list lru;
+	unsigned long flags = READ_ONCE(page->flags);
 
 	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
 
-	if (PageUnevictable(page))
-		return LRU_UNEVICTABLE;
-
-	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
-	if (PageActive(page))
-		lru += LRU_ACTIVE;
-
-	return lru;
+	/* test page->flags directly to avoid unnecessary compound_head() */
+	return (flags & BIT(PG_unevictable)) ? LRU_UNEVICTABLE :
+	       (LRU_FILE * !(flags & BIT(PG_swapbacked)) + !!(flags & BIT(PG_active)));
 }
 
 static __always_inline void add_page_to_lru_list(struct page *page,
-- 
2.30.0.617.g56c4b15f3c-goog

