Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793623A2499
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:40:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:38:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z4so17122833qts.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=sJXaknDNqIwNp1rWQgx+PfiGckf+KTxU5H8H8+f9QU0=;
        b=b1XjZwsGuZXQBj/2tSNWtimTETxoUPqdgZyvsNvx8vkkjvIi8Ygjkp1bT84QOB3lNJ
         ixcBPLAR/OAzhh7P3V0jtbZh1ooj6X0xFHLsy7KQXcbQ8aOSQ6l5kFOJe3AOYcBv3NqT
         E7KEwyIfiR+iWAyTglS9872q46W0IfZLa0SZYfNtlhT4vzUpAaLa4jBB11OLKKxErsCz
         AUCWU0p9KNTvh9jcrLiiaQLay/yDLrASCVHxeq4MehjsqX2LfiSe0CDrQJRsXa/g5jgy
         b4/ByIHtTGaaggP1grvtIyVnLQrgK0I/cXPR2CZPovkVvpl3KwUUFq2Epp/oDGC+1osu
         yznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=sJXaknDNqIwNp1rWQgx+PfiGckf+KTxU5H8H8+f9QU0=;
        b=bVnxRqdqfODlSE6s1OitbSuGMlA4yli1fgx+UwEpKN80w/t4Vt8bhoMabQ0goBvuY2
         cCBZfp39ioOw0GMEnP/CJc8tB72ogvQayu/bKAZse7VCJOjjg5y7P/PPTzlS5QQGiY2K
         LBXfUbOeGYp9l0g3BnLBBRkVmIj6BzUS20Vo+ST+xaCcB73+lrdeTkS2BRHGIQs+L+Sh
         B2zGjmhq2d5aypBkicmHB6RlTYdS1eSZcPtYLo2w/2JeGVMk0LA/Rx8Eap+kuGdKN3TJ
         rsSTDJahYxQip1IEfUhdC32Trk8bP/ZA8QWdICko289I9lqP6AhsZz9MJm5rbMT2KW9D
         3x0Q==
X-Gm-Message-State: AOAM533tzduX/fT9ASufKMsnZoUuExJtyVNojcutUbvP1ZN1k30YbtPc
        HOQaV80pvFBJTTtDeZRvBIHR7Q==
X-Google-Smtp-Source: ABdhPJy5ZcKX50ID5llLhv4bLtcmcu81J9Dm4F8WNmXVszglwbobG1CeiGKZ+cv2mz2wkusrlKG8cg==
X-Received: by 2002:ac8:4ccf:: with SMTP id l15mr3701125qtv.174.1623307094084;
        Wed, 09 Jun 2021 23:38:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c20sm1716101qtm.52.2021.06.09.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:38:13 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:38:11 -0700 (PDT)
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
Subject: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <594c1f0-d396-5346-1f36-606872cddb18@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
have a multi-word pmd entry, for which READ_ONCE() is not good enough.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 7c0504641fb8..973c3c4e72cc 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	pud = pud_offset(p4d, pvmw->address);
 	if (!pud_present(*pud))
 		return false;
+
 	pvmw->pmd = pmd_offset(pud, pvmw->address);
 	/*
 	 * Make sure the pmd value isn't cached in a register by the
 	 * compiler and used as a stale value after we've observed a
 	 * subsequent update.
 	 */
-	pmde = READ_ONCE(*pvmw->pmd);
+	pmde = pmd_read_atomic(pvmw->pmd);
+	barrier();
+
 	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 		if (likely(pmd_trans_huge(*pvmw->pmd))) {
-- 
2.26.2

