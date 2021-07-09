Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E28E3C1DA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGICx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 22:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhGICxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 22:53:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 19:50:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so7945914otq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MwaOWtEym8nCXwyHmi2S0bKX8uQfDz4h1Y9F3kJtM7g=;
        b=LItYAZCA/tB6YBa8MmeXx/skxiw8M9mhyu5+BVO5Xd9D1QpUqbybHYRGMQftQmt40X
         SAgI8J7jCyr7ksOybF144mdyQhEkYnZD54yTQ3qZkcDmgjXzZ8ookpaZSWmHITxU4fDB
         opKkBLCVOyy8RFdfkqvxslOvnaNJXFMJgCOMFlnFT1qEIkB7RjQLHmBbTZk/m4fUPM5/
         /xlg20rBkyodyjJv3CjuRbPAqH5TjmwX71xj7khcv9ixRW6APaxUEubUajhZ6+emlHJH
         ie7eSL9l2b5Z0ooiYn5X/VwbMICmU/pHSEkRBBXCAuTN5FsU50J7nLDwMH0hSH98yGXA
         DD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MwaOWtEym8nCXwyHmi2S0bKX8uQfDz4h1Y9F3kJtM7g=;
        b=HpnZuvXCUZ+T+GZwAShIb4d3I6QPIaC5wmJTDgt+9upPSQJAMVHLZcpV1A8vMeinyK
         drxvpxSC0Dwa3fOj4uMfeBcxZx88YiKHRqF25g6xYhTI3hrrLzy9ItO9T27a7UW9jokV
         p9hrXbwVlLd0UaDFCO5i98ptY/SolnSx+AmyUP0kPppT1hwqEE1jUhIHI+rHZacyCSdH
         IkxQwn7mbv2mOdRfRlxNlFEymjn0fd5rXCd55st5ZrnHwFs19NKlLsUkAR5iKLzCBaCZ
         pSNtbD9dK6aON6Yy2Bc7IabJRQc3p2XuNngfXzBG8Q/W25a8Cs84JSkzWheodnrUUUGC
         eDfQ==
X-Gm-Message-State: AOAM533nOMep8WrrEK+aTbJY0gB9BmVTCStX4mDnPNVz71trgnIir0IA
        8nX3VZcqJojBUmsjPpk1N4tc6Q==
X-Google-Smtp-Source: ABdhPJzCBsJc9yDbXcCOLkUkY0CuiN56cSI554/8flO/vr93Ml88UfxmeKHuH5qM4hLb+4w++sOC/Q==
X-Received: by 2002:a05:6830:409d:: with SMTP id x29mr18170259ott.189.1625799041155;
        Thu, 08 Jul 2021 19:50:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z5sm938657oib.14.2021.07.08.19.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 19:50:40 -0700 (PDT)
Date:   Thu, 8 Jul 2021 19:50:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/rmap: fix old bug: munlocking THP missed other
 mlocks
In-Reply-To: <20210708135811.775drqgwkwc76vcb@box.shutemov.name>
Message-ID: <6c4d46aa-4d73-76a7-bcce-a09024768f63@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <cfa154c-d595-406-eb7d-eb9df730f944@google.com> <20210708135811.775drqgwkwc76vcb@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2021, Kirill A. Shutemov wrote:
> On Wed, Jul 07, 2021 at 01:08:53PM -0700, Hugh Dickins wrote:
> > The kernel recovers in due course from missing Mlocked pages: but there
> > was no point in calling page_mlock() (formerly known as try_to_munlock())
> > on a THP, because nothing got done even when it was found to be mapped in
> > another VM_LOCKED vma.
> > 
> > It's true that we need to be careful: Mlocked accounting of pte-mapped
> > THPs is too difficult (so consistently avoided); but Mlocked accounting
> > of only-pmd-mapped THPs is supposed to work, even when multiple mappings
> > are mlocked and munlocked or munmapped.  Refine the tests.
> 
> Well, that's true that it should be fine to mlock only-pmd-mapped THPs,
> but the refined check doesn't gurantee that the page is not mapped with
> PTEs. !PageDoubleMap(page) only guarantees that the page in not mapped
> with both PMDs and PTEs at the same time. For anon pages, we clear the
> flag when the last PMD mapping is gone and only PTEs left.
> 
> Do I miss some detail here? Maybe we exclude anon pages here somehow?
> I don't see it.

Yes, you're right, Kirill: thanks a lot for catching that.
PageDoubleMap: certainly not my favourite page flag!

And now that I've seen follow_trans_huge_pmd(), its comments, and its
goto skip_mlock on a PageAnon with compound_mapcount != 1, the right
fix for page_mlock() seems to be to skip over Anon THP altogether.

Here's a v2 of just this patch (others remain good): what do you think?

[PATCH v2 2/4] mm/rmap: fix old bug: munlocking THP missed other mlocks

The kernel recovers in due course from missing Mlocked pages: but there
was no point in calling page_mlock() (formerly known as try_to_munlock())
on a THP, because nothing got done even when it was found to be mapped in
another VM_LOCKED vma.

It's true that we need to be careful: Mlocked accounting of pte-mapped
THPs is too difficult (so consistently avoided); but Mlocked accounting
of only-pmd-mapped file THPs is supposed to work, even when multiple
mappings are mlocked and munlocked or munmapped.  Refine the tests.

Many thanks to Kirill for reminding that PageDoubleMap cannot be relied on
to warn of pte mappings in the Anon THP case; and a scan of subpages does
not seem appropriate here.  Note how follow_trans_huge_pmd() does not even
mark an Anon THP as mlocked when compound_mapcount != 1: multiple mlocking
of Anon THP is avoided, so simply return from page_mlock() in this case.

I said the kernel recovers: but would page reclaim be likely to split THP
before rediscovering that it's VM_LOCKED?  Apparently so.  I have worked
on a fix for that, but it's a different issue, and not something to rush.
Whereas page_mlock_one() could not be reviewed without fixing this first.

Fixes: 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 746013e282c3..f1d4edf9c696 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1440,20 +1440,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/*
 		 * If the page is mlock()d, we cannot swap it out.
 		 */
-		if (!(flags & TTU_IGNORE_MLOCK)) {
-			if (vma->vm_flags & VM_LOCKED) {
-				/* PTE-mapped THP are never mlocked */
-				if (!PageTransCompound(page)) {
-					/*
-					 * Holding pte lock, we do *not* need
-					 * mmap_lock here
-					 */
-					mlock_vma_page(page);
-				}
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
-			}
+		if (!(flags & TTU_IGNORE_MLOCK) &&
+		    (vma->vm_flags & VM_LOCKED)) {
+			/*
+			 * PTE-mapped THP are never marked as mlocked: so do
+			 * not set it on a DoubleMap THP, nor on an Anon THP
+			 * (which may still be PTE-mapped after DoubleMap was
+			 * cleared).  But stop unmapping even in those cases.
+			 */
+			if (!PageTransCompound(page) || (PageHead(page) &&
+			     !PageDoubleMap(page) && !PageAnon(page)))
+				mlock_vma_page(page);
+			page_vma_mapped_walk_done(&pvmw);
+			ret = false;
+			break;
 		}
 
 		/* Unexpected PMD-mapped THP? */
@@ -1984,9 +1984,13 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 		 * munlock_vma_pages_range().
 		 */
 		if (vma->vm_flags & VM_LOCKED) {
-			/* PTE-mapped THP are never mlocked */
-			if (!PageTransCompound(page))
-				mlock_vma_page(page);
+			/*
+			 * PTE-mapped THP are never marked as mlocked; but
+			 * this function is never called on a DoubleMap THP,
+			 * nor on an Anon THP (which may still be PTE-mapped
+			 * after DoubleMap was cleared).
+			 */
+			mlock_vma_page(page);
 			page_vma_mapped_walk_done(&pvmw);
 		}
 
@@ -2020,6 +2024,10 @@ void page_mlock(struct page *page)
 	VM_BUG_ON_PAGE(!PageLocked(page) || PageLRU(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
 
+	/* Anon THP are only marked as mlocked when singly mapped */
+	if (PageTransCompound(page) && PageAnon(page))
+		return;
+
 	rmap_walk(page, &rwc);
 }
 
-- 
2.26.2

