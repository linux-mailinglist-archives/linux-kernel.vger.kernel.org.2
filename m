Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3651839250B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhE0Ctq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhE0Ctp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:49:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:48:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d16so2492115pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWx+OpCJ4rmuZE/Novcm4YkSd9BZdaQy71xHN9zFsao=;
        b=gkNTUeHU0Oz/4A7/7lrXStSVLbfy0HORatcJ+/A9JgrmvUrbc9wUpDRb27/1TURNAy
         K1wGYk73NBabCOl59C0WW1oiXYdkQsxgMuCX6QFfNTGX2zm8ZsXPT7c8SF1Vjki6Sd77
         Z+gKcWdyyx4ppllxMBHnyDJ8oEONoTArBXOzX3zheJJQ6Vb/yGbO76eqxoOuS4xNKgBN
         3maBY1dnui5HZJoW+H/tMtj8RWimCa3xDzbwYPlktY4gwtrQkgAs0iepa07YuYalFeYx
         I/yIp2ntbScDhNR+L41ET6/Q5bvuUHCzdt4OdtoWfFDWdez/jNk2n1/71Nh0CHuO4rw5
         XZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWx+OpCJ4rmuZE/Novcm4YkSd9BZdaQy71xHN9zFsao=;
        b=Qv1MBBwl9ir7SBiajfOFreV1ablag4fM095QxaXhZ0fGM7Bm69kiwVApH/dZzsnM30
         NDiWL8jFnJ2adSYxKLVGJZVWl5eZjpC+NRI8x8Zi6DB5S8ovsd5xNVB9DZdhuWJu36uY
         pEm2sDzCiF39AkK3eJSp5GPxmcjvOhS57jx/y5Ak6V55xeT3Vp4CsjXlYRIVMG94a0QD
         w/dY2wQPjKS+tQP7XaIyF/rpcHG85lZLJ+XjG1fNP9I6nHdng0isRwtPLqfjaXIxBKvp
         n9OXl1j/wuGoG3uNChoSvc6njxnKRCiU2/aUjA8hbxvNgWzjBrgMuoKCKMyHPoBpqAqG
         RDVg==
X-Gm-Message-State: AOAM532auUkHrJju0RLI2vB/w2hL1r28BEj+1EG4/LKbdxhCtvFwSuAF
        Z4U0/32zk3udYLtYQFiYqQppXmRJ1Wzd6TDAr18fECVrOjRjJQ==
X-Google-Smtp-Source: ABdhPJxghayE1dn+evykauwejO/vJ/Kzt5OpRkvBbNztO1rZe/JIDryuivbzRx17L/OETeoyUArQUXTt1qzoXweexpI=
X-Received: by 2002:a05:6a00:c86:b029:2e9:3041:162f with SMTP id
 a6-20020a056a000c86b02902e93041162fmr1533796pfv.78.1622083691247; Wed, 26 May
 2021 19:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com> <CAMZfGtVUvtCCEHN_V8iE4m9FAmiz9e5Z1CNNvnetXsrEwAVzgQ@mail.gmail.com>
 <1485e64d-e794-c24e-9688-51b0c1bc1340@oracle.com> <CAHS8izN+-GVOp5cowjkT9WBXYf9Xg6BThWin8tWoKg2ZGFia0Q@mail.gmail.com>
In-Reply-To: <CAHS8izN+-GVOp5cowjkT9WBXYf9Xg6BThWin8tWoKg2ZGFia0Q@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 26 May 2021 19:48:00 -0700
Message-ID: <CAHS8izNDTv37XvowTD2SfFSe3kmVDGGbRBRVAQaJ2UMy42ho_g@mail.gmail.com>
Subject: Re: [External] [PATCH 0/2] Track reserve map changes to restore on error
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 4:19 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Wed, May 26, 2021 at 10:17 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 5/25/21 8:19 PM, Muchun Song wrote:
> > > On Wed, May 26, 2021 at 7:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >>
> > >> Here is a modification to the reservation tracking for fixup on errors.
> > >> It is a more general change, but should work for the hugetlb_mcopy_pte_atomic
> > >> case as well.
> > >>
> > >> Perhaps use this as a prerequisite for your fix(es)?  Pretty sure this
> > >> will eliminate the need for the call to hugetlb_unreserve_pages.
> > >
> > > Hi Mike,
> > >
> > > It seems like someone is fixing a bug, right? Maybe a link should be
> > > placed in the cover letter so that someone can know what issue
> > > we are facing.
> > >
> >
> > Thanks Muchun,
> >
> > I wanted to first see if these patches would work in the code Mina is
> > modifying.  If this works for Mina, then a more formal patch and request
> > for inclusion will be sent.
> >
>
> So a quick test: I apply my patche and yours on top of linus/master,
> and I remove the hugetlb_unreserve_pages() call that triggered this
> conversation, and run the userfaultfd test, resv_huge_pages underflows
> again, so it seems on the surface this doesn't quite work as is.
>
> Not quite sure what to do off the top of my head. I think I will try
> to debug why the 3 patches don't work together and I will fix either
> your patch or mine. I haven't taken a deep look yet; I just ran a
> quick test.
>

Ok found the issue. With the setup I described above, the
hugetlb_shared test case passes:

./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10 2
/tmp/kokonut_test/huge/userfaultfd_test && echo test success

The non-shared test case is the one that underflows:

./tools/testing/selftests/vm/userfaultfd hugetlb 10 2
/tmp/kokonut_test/huge/userfaultfd_test && echo test success

I've debugged a bit, and this messy hunk 'fixes' the underflow with
the non-shared case. (Sorry for the messiness).

@@ -2329,17 +2340,14 @@ void restore_reserve_on_error(struct hstate
*h, struct vm_area_struct *vma,
                                 */
                                SetHPageRestoreRsvCnt(page);
                } else {
-                       rc = vma_needs_reservation(h, vma, address);
-                       if (rc < 0)
-                               /*
-                                * See above comment about rare out of
-                                * memory condition.
-                                */
-                               SetHPageRestoreRsvCnt(page);
-                       else if (rc)
-                               vma_add_reservation(h, vma, address);
-                       else
-                               vma_end_reservation(h, vma, address);
+                       resv = inode_resv_map(vma->vm_file->f_mapping->host);
+                       if (resv) {
+                               int chg = region_del(resv, idx, idx+1);
+                               VM_BUG_ON(chg);
+                       }

The reason being is that on page allocation we region_add() an entry
into the resv_map regardless of whether this is a shared mapping or
not (vma_needs_reservation() + vma_commit_reservation(), which amounts
to region_add() at the end of the day).

To unroll back this change on error, we need to region_del() the region_add().

The code removed above doesn't end up calling region_del(), because
vma_needs_reservation() returns 0, because region_chg() sees there is
an entry in the resv_map, and returns 0.

The VM_BUG_ON() is just because I'm not sure how to handle that error.

> > I believe this issue has existed since the introduction of hugetlb
> > reservations in v2.6.18.  Since the bug only shows up when we take error
> > paths, the issue may not have been observed.  Mina found a similar issue
> > in an error path which could also expose this issue.
> > --
> > Mike Kravetz
