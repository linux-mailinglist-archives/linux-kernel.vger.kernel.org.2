Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729DF3BF09D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhGGULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:11:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9998C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:08:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s24so4882544oiw.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=AEUjbJEHgjwZH84O8/yOmL96IkupdJt703GIG/Lw/Sw=;
        b=aIfEXDg7X8c6i6RMt2XjPCogxnvkLnZWUZiLZ79qAP2eZuzQiThqTe/Wt23LFK/d7N
         k5hF8xQNkmVcxNu3wCGxN8L3VJungjMW9tWj0G+iUEcY6hZlHdjRSKfQzIIf+z+y9Jzh
         QNficFcQho0jB2dIVnAssiHtmbwVSgh8cAQI56fRqelW/syOtyiwPFHRwF9M86BFkIFW
         QvQXm/BAjmg/ClC5HPMT/QsmFc1D5/6INGIn9IUq4Yq2yLZOr+9X116mQy+W8Hzar+qh
         QieIJ96JHJlqH6Wnxd7BDUWPkIvipTfS9+3awv6YTUQ438T23gxjXb/F2y3VlzRa5z/j
         ZgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=AEUjbJEHgjwZH84O8/yOmL96IkupdJt703GIG/Lw/Sw=;
        b=YTqV+CcJbmtsh4bF0atJgLtOFU7e5YaOy+td7AfhRnpkf3KVkL4n65n3dO37WFccun
         EnNMWfE5k7tUQ50rYl/UzzMjMIXfsSDW2WJB58vOZgQrrN78s3iAHIbcLUca/bmTWwX3
         OAWNjI7p7XfVcQ0ZuYezXu7PmYGNqZ7DBQkhpxPztOACWvWXPknXFF/QkL/S+JvWCrDk
         3q/zpMyNhK6TuSCJe2QTo+vsQUq0XIc8+me2nnLzbGe2cHHSDI0SeKoOdt8U1SAg8/f+
         R5LGn2XRpoBmsGx+S6VxAOPiJDR1AHLNL0ibc4wEGD4iZIObOvp2CBHFvbcOPssck9zE
         KBIg==
X-Gm-Message-State: AOAM533VBe7vXgihSC3cJ9oiPQ3RIDnd86sh86zqMwUJNT/50Hop/ot7
        mjsH9tDRnb6AntMq+z+v0XMoOQ==
X-Google-Smtp-Source: ABdhPJwtImQxt1QzEcdZdsVyVe8aD+gMiqiWoksjK7o9JOc9vBTzXLdVlrO6UFB4z710wRyFTr0zXQ==
X-Received: by 2002:aca:db44:: with SMTP id s65mr11399367oig.139.1625688536945;
        Wed, 07 Jul 2021 13:08:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 25sm3729500oir.58.2021.07.07.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:08:56 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:08:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/4] mm/rmap: fix old bug: munlocking THP missed other
 mlocks
In-Reply-To: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
Message-ID: <cfa154c-d595-406-eb7d-eb9df730f944@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel recovers in due course from missing Mlocked pages: but there
was no point in calling page_mlock() (formerly known as try_to_munlock())
on a THP, because nothing got done even when it was found to be mapped in
another VM_LOCKED vma.

It's true that we need to be careful: Mlocked accounting of pte-mapped
THPs is too difficult (so consistently avoided); but Mlocked accounting
of only-pmd-mapped THPs is supposed to work, even when multiple mappings
are mlocked and munlocked or munmapped.  Refine the tests.

There is already a VM_BUG_ON_PAGE(PageDoubleMap) in page_mlock(), so
page_mlock_one() does not even have to worry about that complication.

(I said the kernel recovers: but would page reclaim be likely to split
THP before rediscovering that it's VM_LOCKED? I've not followed that up.)

Fixes: 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 746013e282c3..0e83c3be8568 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1442,8 +1442,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK)) {
 			if (vma->vm_flags & VM_LOCKED) {
-				/* PTE-mapped THP are never mlocked */
-				if (!PageTransCompound(page)) {
+				/* PTE-mapped THP are never marked as mlocked */
+				if (!PageTransCompound(page) ||
+				    (PageHead(page) && !PageDoubleMap(page))) {
 					/*
 					 * Holding pte lock, we do *not* need
 					 * mmap_lock here
@@ -1984,9 +1985,11 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 		 * munlock_vma_pages_range().
 		 */
 		if (vma->vm_flags & VM_LOCKED) {
-			/* PTE-mapped THP are never mlocked */
-			if (!PageTransCompound(page))
-				mlock_vma_page(page);
+			/*
+			 * PTE-mapped THP are never marked as mlocked, but
+			 * this function is never called when PageDoubleMap().
+			 */
+			mlock_vma_page(page);
 			page_vma_mapped_walk_done(&pvmw);
 		}
 
-- 
2.26.2

