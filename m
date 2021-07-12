Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB43C4172
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhGLDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhGLDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:13:56 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9ADC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 20:11:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so17400207otp.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=rW1zjeWytPoYSJ40qDYC+bDE3SJVtauEVGMHk7JHx7Q=;
        b=GH0fIXaJ7JlQrOMD+qRd9KSrlldoEV5wJtHO4+/GN8S3BuOhe7U3Oc2f3bHz2zosHM
         AVdKqfHClq46SSHc3Z1Z5idqU9esgfztT2zaStLGasb6mEv+6L/Goj9r82q0Pw6HK7kd
         Se4iKBuKW2o1q2SykjSbEmd5fAEFq8ck2SQEKtCvDPnvE3XbptnStu+RiiCm7/XRIRPx
         D53CwCcGodj+HuYcgdyg53Ybe0nfKtd6M0nVBLdhVl/ZSSMp73RzdDrXR+lsG4QbgTui
         joRLDloxQFjri0XsXgc6YXM1kmdSjdyVXmvytyiUhV0WWUZ9GbB3G9nB5B01RW1zZlW0
         BMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=rW1zjeWytPoYSJ40qDYC+bDE3SJVtauEVGMHk7JHx7Q=;
        b=RQ7TT56DHkI0fY1JibyOhykJp0twzzxQpsPLfVVBKh+PQjb+LY3fMdUS26Tpak29ZA
         caIHBmaQvv3lPXuX34OEzBRLEPBKqmjHNlU6S54rcnWpROtfdnGLqMwnCAowmZ13M6ZT
         J//RdIaFYgJVXrLMzWOdvTBVahefN+sTEgsB8qX4RwFtTCFGlpNYiqUf/jRHQC6E5ExQ
         O70Qx0GiL27KuQZMlwFYAP8wolxzJG21gzjXhhlDXBkikqtfLvLr+PN2TeXEoHQmVovf
         DmqrlHiFl4UEWgZtHeAeHzXf9Sc5GQwzLN5hAU9KIEWwD6W85gXNnNWnCDq8eR+z/uqv
         EI4A==
X-Gm-Message-State: AOAM532G7mko5vnJqGv2rVsvMXxo/d4vljLzE+uREfbRp9p087Yvn+ha
        G9klyhJwQit+5deWL7wCh6+PKQ==
X-Google-Smtp-Source: ABdhPJy3F/F7jKHrUzEaWcTrPNBN3wOK2PB4rBXEhvJ/i83LVYBAtnoCSY3M+BB9TTAeYMQJjnDhXQ==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr35286026ote.90.1626059467933;
        Sun, 11 Jul 2021 20:11:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y26sm785217oot.7.2021.07.11.20.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 20:11:07 -0700 (PDT)
Date:   Sun, 11 Jul 2021 20:10:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 5.14-rc1] mm/rmap: fix munlocking Anon THP with mlocked
 ptes
Message-ID: <5a98cd9-6965-6379-37a-33448ba62a31@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks to Kirill for reminding that PageDoubleMap cannot be relied on
to warn of pte mappings in the Anon THP case; and a scan of subpages does
not seem appropriate here.  Note how follow_trans_huge_pmd() does not even
mark an Anon THP as mlocked when compound_mapcount != 1: multiple mlocking
of Anon THP is avoided, so simply return from page_mlock() in this case.

Link: https://lore.kernel.org/lkml/cfa154c-d595-406-eb7d-eb9df730f944@google.com/
Fixes: d9770fcc1c0c ("mm/rmap: fix old bug: munlocking THP missed other mlocks")
Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
Linus, thanks a lot for last-minute hoovering up those four mm/rmap
patches, with 3/4 fixing the syzbot and 0day reports on munlocking ...

BUT

... the version of 2/4 in 5.14-rc1 is defective (PageDoubleMap is a
confusing flag which behaves differently on anon and file), Kirill had
spotted that, and what he Acked was the v2 which went into mmotm, rather
than the first version I posted.  This patch here converts the v1 in rc1
into the v2 Acked by Kirill.

What will go wrong with v1 in?  I don't actually know: nothing terrible,
can only affect people splitting and mlocking anon THPs, maybe nobody and
nobot will notice, maybe some VM_BUG_ONs or "Bad page"s will turn up.
I'll be on the lookout to point reporters to this fix (more lines than
strictly necessary, because it removes a level of indentation).

And sorry for putting 2/4 before the more urgent 3/4, but I couldn't
tell what to do in 3/4, without first fixing the older bug in 2/4.

Hugh

 mm/rmap.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

--- 5.14-rc1/mm/rmap.c
+++ linux/mm/rmap.c
@@ -1440,21 +1440,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/*
 		 * If the page is mlock()d, we cannot swap it out.
 		 */
-		if (!(flags & TTU_IGNORE_MLOCK)) {
-			if (vma->vm_flags & VM_LOCKED) {
-				/* PTE-mapped THP are never marked as mlocked */
-				if (!PageTransCompound(page) ||
-				    (PageHead(page) && !PageDoubleMap(page))) {
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
@@ -1986,8 +1985,10 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 		 */
 		if (vma->vm_flags & VM_LOCKED) {
 			/*
-			 * PTE-mapped THP are never marked as mlocked, but
-			 * this function is never called when PageDoubleMap().
+			 * PTE-mapped THP are never marked as mlocked; but
+			 * this function is never called on a DoubleMap THP,
+			 * nor on an Anon THP (which may still be PTE-mapped
+			 * after DoubleMap was cleared).
 			 */
 			mlock_vma_page(page);
 			/*
@@ -2022,6 +2023,10 @@ void page_mlock(struct page *page)
 	VM_BUG_ON_PAGE(!PageLocked(page) || PageLRU(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
 
+	/* Anon THP are only marked as mlocked when singly mapped */
+	if (PageTransCompound(page) && PageAnon(page))
+		return;
+
 	rmap_walk(page, &rwc);
 }
 
