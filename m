Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D04152A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhIVVWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238112AbhIVVWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632345661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sOtepVT3Qko/KYSQ2Yokm2u2avg1AOSms4eQPqswZk=;
        b=P1+SmEYTkdqWhFLW6smx+Q13Y4TRnyF0eH8F5lZp2H5Cl7JSqGHxXioUaNDKAMQGz5te9f
        LFFAdLk9kL89cimmT/e8EtAf+aJcpclR7ImmXimdwSUTcGu/YYAncGme1s9qErBXamJVS8
        onaKmqwxveLLGkw1tRS1vOEOSrRJ+Ow=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-mOfV8C1zNhajbDwHIJN_Lw-1; Wed, 22 Sep 2021 17:21:00 -0400
X-MC-Unique: mOfV8C1zNhajbDwHIJN_Lw-1
Received: by mail-qv1-f70.google.com with SMTP id j4-20020ad454c4000000b0037a900dda7aso14237455qvx.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sOtepVT3Qko/KYSQ2Yokm2u2avg1AOSms4eQPqswZk=;
        b=iQrM+N56sJGPAYC6D4QXYgna3J8xLcsmvw13OIYROrtFSB3Pw0BrXtLdqOWHH+IddD
         qZgx1jbkkD7iEYYSEZ3CavksnWs8TGmiZxRFBpfvQnQPiOEaox4xUJEmAJLOsYZqdSsH
         0ZT2df+RhgnM251YBDb/3alrHcwvJZPIRerKwuBV5My1l1VELAFS33HakECLWwRy/A+x
         D7ezTjBEU8JlOgAbrlde66/4/4Fcmq+dlwTccsQ9d+sDEkfTavBYqAdMr8oYfG3UPMX4
         MmIHsoq1ZDwbg/z1aBZ13Ocvb6dzmoEWh59GnJBYscIvx0cPHluV5LtpJ+eXbpPiscqu
         fl0Q==
X-Gm-Message-State: AOAM530b7tk5eyIockxa9KUfZZCI9T/nV8vVJizaXm1WyQeUzDZi2D5t
        CfNN9ySQdVT3ERmjf7sSuNHK7zndwGS96vGCfvYIi67yjbwQ8FcsHsSNtppfXGNGiW9QSEdo6+6
        Gf5MnS8WzKBKHnMe3Oe5+CNh4
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr1389120qkv.457.1632345660201;
        Wed, 22 Sep 2021 14:21:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvdMFhxEd+7cJQ3ko6ceS3YO5KGWFBstwMECwRCVDskLxbC+AYBT3ku6FsaSJboCWkdx2BBg==
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr1389083qkv.457.1632345659892;
        Wed, 22 Sep 2021 14:20:59 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id u12sm1831441qkk.109.2021.09.22.14.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:20:59 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:20:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUueOUfoamxOvEyO@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
 <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:49:42PM -0700, Axel Rasmussen wrote:
> Sorry for missing the other thread.

Heh, you didn't miss the other thread; I just posted both of the emails in a
few hours. :)

> 
> Unfortunately, I think shmem THP *doesn't* really work with minor
> faults, and what's worse, just checking the VMA flag isn't enough.

As I replied to myself (sorry to have done that), now I think minor mode is
fine, but let's see what else I've missed, which is possible...  Please see
below.

> 
> First, let me note the guarantee UFFD minor faults are trying to
> provide: for a given mapping, any minor fault (that is, pte_none() but
> a page is present in the page cache) must result in a minor userfault
> event. Furthermore, the only way the fault may be resolved (i.e., a
> PTE installed) is via a UFFDIO_CONTINUE ioctl from userspace.

Yes.

> 
> A typical use case for minor faults is, we have two mappings (i.e.,
> two VMAs), both pointing to the same underlying physical memory. It's
> typical for both to have MAP_SHARED. It's typical for one of these
> mappings to be fully faulted in (i.e., all of its PTEs exist), while
> the other one has some missing PTEs. The problem is, khugepaged might
> scan *either* of the two mappings. Say it picks the fully-faulted VMA:
> even if we set khugepaged_max_ptes_none to zero, it will still go
> ahead and collapse these pages - because *this* VMA has no missing
> PTEs.

Yes.

> 
> Why is this a problem? When we collapse, we install a PMD, for *all*
> VMAs which reference these pages. In other words, we might install
> PTEs for the other, minor-fault-registered mapping, and therefore
> userfaults will never trigger for some of those regions, even though
> userspace never UFFDIO_CONTINUE-ed them.

Nop - we don't install PMD for file-backed, do we?

Please see khugepaged_scan_pmd() - that one installs PMDs indeed, but it's
anonymous-only code.

Then please also see khugepaged_scan_file() - that one handles file-backed
(aka, shmem), and it does _not_ install pmd, afaict.  The installation is lazy.

Not installing pmd means uffd-minor can still trap any further faults just like
before, afaiu.

There's a very trivial detail that the pmd missing case will have a very slight
code path change when the next page fault happens: in __handle_mm_fault() we'll
first try to go into create_huge_pmd() once, however since shmem didn't provide
huge_fault(), we'll go the VM_FAULT_FALLBACK path, and things will go like
before when faulting on a small pte.  The next UFFDIO_CONTINUE will allocate
that missing pmd again, however it'll install a 4K page only.

> 
> I *think* the right place to check for this and solve it is in
> retract_page_tables(), and I have a patch which does this. I've been
> hesitant to send it though, as due to a lack of time and the
> complexity involved I haven't been able to write a clear reproducer
> program, which my patch clearly fixes. :/

Yes retract_page_tables() could drop pmd pgtable for minor fault, but IMHO it's
fine too as mentioned above.

Minor mode should only care about trapping the page fault when the next access
comes.  retract_page_tables() will wipe the pmd pgtable page, that's not fine
for uffd-wp, but IMHO that's still very fine for minor mode as it will keep
trapping the old missing ptes; the difference is it'll just generate even more
traps (rather than on the pte holes only, now it'll generate one message for
each 4k over the merged 2M).

As I mentioned in the other thread, I think that'll cause false positive minor
fault messages, but IMHO that's fine, and minor fault userspace should always
need to handle that.

I fully agree with you that a reproducer would be very nice to try.  So if my
understanding is correct, the reproducer won't really fail on minor mode in any
way, but it'll just need to be prepared to receive more messages than it should.

Thanks,

-- 
Peter Xu

