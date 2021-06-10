Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B813A248D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJGgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:36:52 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3DCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:34:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c124so26296808qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pGCwo0otsY+1TNpTEy0P02naUBtXpTOD+IdeOTLcTwE=;
        b=lhPqqonl51gMi2Y5qmIjfHtlL9DeApoXuasczVJ23S+iGW2PmFNNYItqWpfLH7MhZ4
         tVUlRtMBckVtYWTfO4DQfuc6RAOI7KFG6ogHzngJvwQfijIa0reDXsTc5nFZ85mfHrtc
         tTIp3DP5ZAdekIFoTHFbqzZHtD/3BeHN/SwIg5s5jF0lrhMnpRyHAV8ndVZPwr7+MFzl
         D/VqCz4s5wU4VpJQvp8gp6PmoM8o014bXIulyrzJaseBUHPQCbeU0DU/yhbSWW3BpGNL
         O/n3mhNqbCzVYV7fx3t6RLDhmfHZ0ATmPxZBeFcJ8tMbU8zN6fU0BOtmvkk2oYTpTiCi
         o2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pGCwo0otsY+1TNpTEy0P02naUBtXpTOD+IdeOTLcTwE=;
        b=iWhbvI0YgMbbOV3Bv3EiaP3aI7J3yhivTGqYxdbYyw8zzdVbomfYLI8RaPQHrtX/M6
         1FuRnLbeYpfr3z9s/OJVPCGD+zmpAqA5pxapoEZ5rr8gYYc5Az1HEeQUhJ0Z73sCTvas
         cLl9H/wtwpRon2kNutPRnWJx8v90S99ETXG1854iIvhnqMvHeYZJSM8IMQ5DRGhRNZot
         1tf8RvgimN8JSGNvh0m5pjQu5W4vU9euIu7lsgQj0edJpVdLsLYLSb8os0uWRery1amv
         azQm++KZVHm7izBH0OKmYrgNuiTUe15LKd7nwWrbtKSViGZmISKisKQICS8WWGgt26N1
         8j8g==
X-Gm-Message-State: AOAM532BxVjmqMtgXJFX3vFFsvKtxNU3UxwJvCmeIkGY/7XZ7RE51vGq
        JuzCElUsUv6Sr0HCun3FmmQlbg==
X-Google-Smtp-Source: ABdhPJx795mENXThcbrSF3SFHQ7mxH7leIj6hOSzSyIIAiXcTG/9Yj4OerHKB8IVGGrOX291lJY05Q==
X-Received: by 2002:a37:438d:: with SMTP id q135mr3166885qka.478.1623306882954;
        Wed, 09 Jun 2021 23:34:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b2sm1692660qkd.1.2021.06.09.23.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:34:42 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:34:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] mm: page_vma_mapped_walk(): use page for pvmw->page
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: sometimes the local copy of pvwm->page was
used, sometimes pvmw->page itself: use the local copy "page" throughout.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e37bd43904af..a6dbf714ca15 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -156,7 +156,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pte)
 		goto next_pte;
 
-	if (unlikely(PageHuge(pvmw->page))) {
+	if (unlikely(PageHuge(page))) {
 		/* when pud is not present, pte will be NULL */
 		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
 		if (!pvmw->pte)
@@ -217,8 +217,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 * cannot return prematurely, while zap_huge_pmd() has
 		 * cleared *pmd but not decremented compound_mapcount().
 		 */
-		if ((pvmw->flags & PVMW_SYNC) &&
-		    PageTransCompound(pvmw->page)) {
+		if ((pvmw->flags & PVMW_SYNC) && PageTransCompound(page)) {
 			spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
 			spin_unlock(ptl);
@@ -234,9 +233,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return true;
 next_pte:
 		/* Seek to next pte only makes sense for THP */
-		if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
+		if (!PageTransHuge(page) || PageHuge(page))
 			return not_found(pvmw);
-		end = vma_address_end(pvmw->page, pvmw->vma);
+		end = vma_address_end(page, pvmw->vma);
 		do {
 			pvmw->address += PAGE_SIZE;
 			if (pvmw->address >= end)
-- 
2.26.2

