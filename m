Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9B415565
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhIWCUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238859AbhIWCUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632363517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2cVpCaYgqZbzYwtdNEOswMkSLXpY9PVp/jLh/csEpFo=;
        b=U75QLraiCSNxikF1hZ/raa6lSGp1gOqfRFEDLKXbDTlbj4YocAXo5Jd5xB8SVBAuJ6Q+s2
        N2+ZbeyM3zX+LiXohkzNrVGNx8pRtm+YHYKdUTQDsKxBB3Cx7t4gGCUncdicc0Qkt5yy2c
        F6nRFUOlyTvfFmCe/BnDt8VxNwlfs50=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-70a11aeXPTOsIsqLzE6pqw-1; Wed, 22 Sep 2021 22:18:34 -0400
X-MC-Unique: 70a11aeXPTOsIsqLzE6pqw-1
Received: by mail-qk1-f198.google.com with SMTP id bi14-20020a05620a318e00b00432f0915dd6so15430906qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 19:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2cVpCaYgqZbzYwtdNEOswMkSLXpY9PVp/jLh/csEpFo=;
        b=LBdnYIqO+MLNmnmeOI3z4SN32mYhKWELozFcuNzqe7qouQ841S4TdkA9HQUBaeN7JN
         W1xYbqGHa1RXEUDN+x8Jtg9DDeVK4J4mJnMU5HJJ/qEitFQC+19cwIdCKg/j23+LGOFz
         MZ6QM7v1ko1bhhU0EcDDhXjoZKvQ882sU3ytMqpJf8zwrcwnCck3DsqL+jsvQKz18601
         f7CXqIvV5qv5Mx9tqK0fqmJ/NF0aoWDg5+yL63PNLjH8BNoOF7UeYrqzWMBLahUyZyAq
         IGuOnh/eVjwOi/mr/vuXmEyXhLvR6Q4bz4055jaBZiaEa5cXVqXj0TvzY5OdU3O28wqR
         r7KA==
X-Gm-Message-State: AOAM530DuEt2y/EuYIDZwkAbi/FQ6SMC3AqG8mN805IclX4w/LM2NAbt
        4puFPj5Y/oAozHXsYjpmYPTx9Vsn2oZhelbZcNWSRDFX7ZXsEZcpvlgoO36dWi6o5kwaJhZ6ivY
        oy1Ezuk+mkds4bhWCFax1U+Ir
X-Received: by 2002:a05:620a:2808:: with SMTP id f8mr2571535qkp.462.1632363513704;
        Wed, 22 Sep 2021 19:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlWKEomkNcSfL1zxNzyEwWsyoxVCE9PwBsK+sraVKUMgitw9v/5atWt01lAjrCJG+b28U41w==
X-Received: by 2002:a05:620a:2808:: with SMTP id f8mr2571520qkp.462.1632363513395;
        Wed, 22 Sep 2021 19:18:33 -0700 (PDT)
Received: from xz-m1.local ([2607:fea8:56a2:9100:b17b:78a:bb8a:9b0f])
        by smtp.gmail.com with ESMTPSA id j184sm3300321qkd.74.2021.09.22.19.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:18:32 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:18:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUvj9r3Y954pYPnf@xz-m1.local>
References: <20210922175156.130228-1-peterx@redhat.com>
 <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
 <YUueOUfoamxOvEyO@t490s>
 <24224366-293a-879-95db-f69abcb0cb70@google.com>
 <YUu/6lWX92WLUzpt@t490s>
 <472a3497-ba70-ac6b-5828-bc5c4c93e9ab@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hOe13WIugokcaN/t"
Content-Disposition: inline
In-Reply-To: <472a3497-ba70-ac6b-5828-bc5c4c93e9ab@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOe13WIugokcaN/t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Sep 22, 2021 at 06:22:45PM -0700, Hugh Dickins wrote:
> No, I think I misunderstood you before: thanks for re-explaining.
> (And Axel's !userfaultfd_minor() check before calling do_fault_around()
> plays an important part in making sure that it does reach shmem_fault().)

Still thanks for confirming this, Hugh.

Said that, Axel, I didn't mean I'm against doing something similar like
uffd-wp; it's just a heads-up that maybe you won't find a reproducer with real
issues with minor mode.

Even if I think minor mode should be fine with current code, we could still
choose to disable khugepaged from removing the pmd for VM_UFFD_MINOR vmas, just
like what we'll do with VM_UFFD_WP.  At least it can still reduce false
positives.

So far in my local branch I queued the patch which I attached, that's required
for uffd-wp shmem afaict.  If you think minor mode would like that too, I can
post it separately with minor mode added in.

Note that it's slightly different from what I pasted in reply to Yang Shi - I
made it slightly more complicated just to make sure there's no race.  I
mentioned the possible race (I think) in the commit log.

Let me know your preference.

Thanks,

-- 
Peter Xu

--hOe13WIugokcaN/t
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=patch

From 989d36914ac144177e17f9aacbf2785bb8f21420 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 22 Sep 2021 16:23:33 -0400
Subject: [PATCH] mm/khugepaged: Don't recycle vma pgtable if uffd-wp
 registered

When we're trying to collapse a 2M huge shmem page, don't retract pgtable pmd
page if it's registered with uffd-wp, because that pgtable could have pte
markers installed.  Recycling of that pgtable means we'll lose the pte markers.
That could cause data loss for an uffd-wp enabled application on shmem.

Instead of disabling khugepaged on these files, simply skip retracting these
special VMAs, then the page cache can still be merged into a huge thp, and
other mm/vma can still map the range of file with a huge thp when proper.

Note that checking VM_UFFD_WP needs to be done with mmap_sem held for write,
that avoids race like:

         khugepaged                             user thread
         ==========                             ===========
     check VM_UFFD_WP, not set
                                       UFFDIO_REGISTER with uffd-wp on shmem
                                       wr-protect some pages (install markers)
     take mmap_sem write lock
     erase pmd and free pmd page
      --> pte markers are dropped unnoticed!

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/khugepaged.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc579f724..23e1d03156b3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1451,6 +1451,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
 		return;
 
+	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
+	if (userfaultfd_wp(vma))
+		return;
+
 	hpage = find_lock_page(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
 	if (!hpage)
@@ -1591,7 +1595,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * reverse order. Trylock is a way to avoid deadlock.
 		 */
 		if (mmap_write_trylock(mm)) {
-			if (!khugepaged_test_exit(mm)) {
+			/*
+			 * When a vma is registered with uffd-wp, we can't
+			 * recycle the pmd pgtable because there can be pte
+			 * markers installed.  Skip it only, so the rest mm/vma
+			 * can still have the same file mapped hugely, however
+			 * it'll always mapped in small page size for uffd-wp
+			 * registered ranges.
+			 */
+			if (!khugepaged_test_exit(mm) && !userfaultfd_wp(vma)) {
 				spinlock_t *ptl = pmd_lock(mm, pmd);
 				/* assume page table is clear */
 				_pmd = pmdp_collapse_flush(vma, addr, pmd);
-- 
2.31.1


--hOe13WIugokcaN/t--

