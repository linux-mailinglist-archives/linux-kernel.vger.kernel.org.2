Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A767415155
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhIVUY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237381AbhIVUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632342205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVbeoTaMblrjpDgFDVGvCcjBz8Qir6DmYn1S2zIAe9c=;
        b=WdT/M2t/R124jM9CMyYPyIsz//XRJloFuBj/XhsTxrwn1szlQj/veOBNx5wn9bvNSXmjUR
        kIfZC1JMA5ia6qRwJBCOe6hfFvAozbdhLySzLuUAOI+nyaK0bkL/o2pgcpllcmX4fyjOLd
        1+oEAi3FE9Ake3ClP43Jz8jae494M7k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-0_OK4HZXNku3TNvn61lA3w-1; Wed, 22 Sep 2021 16:23:24 -0400
X-MC-Unique: 0_OK4HZXNku3TNvn61lA3w-1
Received: by mail-qt1-f199.google.com with SMTP id 7-20020ac85907000000b002a5391eff67so11593793qty.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVbeoTaMblrjpDgFDVGvCcjBz8Qir6DmYn1S2zIAe9c=;
        b=AUsj7nZ1v/4MWkhnEFG92R6Xd/UvVID6QY/UbAQ5bqfvLmMGzuTWhQeIgsa19zFM1p
         J/AaTE+N9WZX6LS6mTHKQkPMn2aZ01cQQXeDL6oFru8JGeEJu9Aq3jmHayr17YFLqBvN
         u8TOyMmL8P6Xfn22FJ49+4x47XwWTwg265b5JLij5mCHWylR1z7DJbIPtr45RR2VP9rL
         3h7s9nGmxITLzbrYiHjqwiV2tpQppeso4Eugqu3yhP+3z4I1J6bjccwo/ozIOPquGAWB
         xLE0ZLa3j0j4rB/y+26E3La2t4KObjOvmzCmMuLc65UkhsPQ4PpD6Qvdile51aHYpfPX
         NUQQ==
X-Gm-Message-State: AOAM530OKPH6R3oJvoG3Kgv/gf6Rvd/hFTu11BlrzuAm8gO3IFYEYAOC
        g3mXP48A23DyKYqG7mgijm5qZyG71HcvWVBKQO8U+TpJXGEGQNdLtY8e3z1/yzm2pBDiGJ9Z6Dh
        XLnPv+den2jMvOHcz2XSZJvoB
X-Received: by 2002:ac8:1e93:: with SMTP id c19mr1313224qtm.60.1632342203844;
        Wed, 22 Sep 2021 13:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcOXxTuN0eQjzkMusH8rj1CjLqI2bazEFBAGq+lK7mxZ3BQ0khzrCDQUBODpcRcwUbqrb7wA==
X-Received: by 2002:ac8:1e93:: with SMTP id c19mr1313193qtm.60.1632342203556;
        Wed, 22 Sep 2021 13:23:23 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id d9sm2565059qko.111.2021.09.22.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:23:23 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:23:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUuQuRwKj66lBwMv@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
 <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com>
 <YUt833H6eaYFyHXD@t490s>
 <CAHbLzkq7kTdEC6ADJRAxXBEOYhsjR8E9uiEFCYFmtA5cD5fMhA@mail.gmail.com>
 <YUuMXCFbj1mmOKec@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUuMXCFbj1mmOKec@t490s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:04:44PM -0400, Peter Xu wrote:
> On Wed, Sep 22, 2021 at 12:29:35PM -0700, Yang Shi wrote:
> > khugepqged does remove the pgtables. Please check out
> > retract_page_tables(). The pmd will be cleared and the ptes will be
> > freed otherwise the collapsed THP won't get PMD mapped by later
> > access.
> 
> Indeed.
> 
> I should probably still properly disable khugepaged for at least VM_SHARED &&
> VM_UFFD_WP, then I'd keep the anonymous && minor mode behavior untouched.
> 
> The other problem is even if current mm/vma doesn't have UFFD_WP registered,
> some other mm/vma could have UFFD_WP enabled there that mapped the same file.
> Checking that up within retract_page_tables() on all VMAs seems to be a bit too
> late.
> 
> Checking it early may not trivially work too - I can walk the vma interval tree
> at the entry of khugepaged_scan_file(), making sure no vma has UFFD_WP set.
> However I don't see how it'll stop some of the vma from having UFFD_WP
> registered later after that point but before retract_page_tables().
> 
> I'll need to think about it, but thanks for the input, Yang.  That's a very
> important point.

Perhaps I need something like this:

---8<---
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc579f724..c63e957336d1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1583,6 +1583,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
                pmd = mm_find_pmd(mm, addr);
                if (!pmd)
                        continue;
+               /*
+                * When a vma is registered with uffd-wp, we can't recycle the
+                * pmd pgtable because there can be pte markers installed.
+                * Skip it only, so the rest mm/vma can still have the same
+                * file mapped hugely, however it'll always mapped in small
+                * page size for uffd-wp registered ranges.
+                */
+               if (userfaultfd_wp(vma))
+                       continue;
                /*
                 * We need exclusive mmap_lock to retract page table.
                 *
---8<---

I won't post a v2 because then that patch will be shmem-only and uffd-wp-only.
I'll keep it with the upcoming series I'm going to post to support shmem.

Thanks,

-- 
Peter Xu

