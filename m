Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398163A0B47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhFIEbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:31:00 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33354 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIEa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:30:58 -0400
Received: by mail-qk1-f170.google.com with SMTP id k4so22573478qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=PCG4uUwW8wS6xmpuPwkiV4oLkvnmo78CTRIwxQBRKgY=;
        b=ISnNRpCieQkW3oz7o/YjHabNZ0xWqccqSPmHG2RGMzDEDOX/VY1vdWkev1zuAu9bf4
         CLBMxrS/rDZwTQBTqOikREGr5+eRpWpzswMhSU2FKiuUohrvuxpQQbpkKqLgnACpFngy
         wotrtTqMXRz2IeWNPzl82lj2T5/EugCK8bQ1l8yifOMTdDOtYr5PVIA3A6gIe1EonP0n
         jIdGAnfNvldffzBciY3ibTHeza+5sC+rNLcfxLUQ+8oJzpa+8/C30RtBUeju8jOv4WAl
         3Sy5Kbu9hdOcMeLwP1ffxx4YX8lSWJ5uBZ4BzmkwrcffJTiGoA1jYlNtz8L5lTxQnLNR
         UkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=PCG4uUwW8wS6xmpuPwkiV4oLkvnmo78CTRIwxQBRKgY=;
        b=o6aKgYFNvy+m0Cd0z5VvQCnay7DFs1pKyMys9ZLaF9kNquZ+7rih7uB5gUpgsEoUxv
         bh6pt1hfqb4OKEzqWdoRcNDY4XqU4fT9aF5r7HxORiY5CC6oj7lM+626WDih1dUu6mHj
         73L2m/z3m5OfRdKT1sX5pT289ioby7Q57PPWjrCPZTfAAfY9ssO4QUQNG6RaumoVKnEG
         ptyWBo2Fl7upeCc1djt+krjzDBlz0t5QIJwx1rIibsxmbREj+vnmpvV9DHSsZaCO9f7H
         drtuKNQbtd8dO6R0LJoCI8jGgAFPqvzxv64TEy0cFyrNS6cQ0AisD0+eArnkBj5y7AdF
         wAzg==
X-Gm-Message-State: AOAM532GBrswRP17+R1n4vzcjqOOmG37tb5Tj/zLKNVIR8ECv36Rl69p
        OLaZK6Km63Zlm7DxTELzTz22JA==
X-Google-Smtp-Source: ABdhPJxXZMNVnAh0LFgldc9dyfNSXHSfAHtXSYWJqsucG866iZ2oHmbpoSnB8lX2SgUmBPKcL7ZXYA==
X-Received: by 2002:a37:911:: with SMTP id 17mr22703936qkj.436.1623212868622;
        Tue, 08 Jun 2021 21:27:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h4sm12175706qti.0.2021.06.08.21.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:27:48 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:27:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] mm/thp: remap_page() is only needed on anonymous
 THP
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <f987bc44-f28e-688d-2424-b4722153ed8@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THP splitting's unmap_page() only sets TTU_SPLIT_FREEZE when PageAnon,
and migration entries are only inserted when TTU_MIGRATION (unused here)
or TTU_SPLIT_FREEZE is set: so it's just a waste of time for remap_page()
to search for migration entries to remove when !PageAnon.

Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6d2a0119fc58..319a1a078451 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2355,6 +2355,7 @@ static void unmap_page(struct page *page)
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
+	/* If TTU_SPLIT_FREEZE is ever extended to file, update remap_page() */
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
@@ -2366,6 +2367,10 @@ static void unmap_page(struct page *page)
 static void remap_page(struct page *page, unsigned int nr)
 {
 	int i;
+
+	/* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
+	if (!PageAnon(page))
+		return;
 	if (PageTransHuge(page)) {
 		remove_migration_ptes(page, page, true);
 	} else {
-- 
2.26.2

