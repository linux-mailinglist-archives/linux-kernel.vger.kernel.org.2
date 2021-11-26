Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5045E666
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359068AbhKZC53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:57:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357924AbhKZCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637895135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NAtupCiuM9VvZ3rxyt0oJqhO9XUhiUEr3+tz1tYqaI=;
        b=IxVvyQa0d2r98Say6zaK/u7fB5Qcmh7PPwFl9RA6yYpp7nW8KjOOC9Skda/FDUGMLJSZEW
        iH47Ph8romB2bwA8rkw+64omvX+1y6V6We6dl44ZwNeiMv3bso+g0CUY8D2/ua9ROURQ6f
        CEta1WPR69aKoBSjX5j9N1x4U0o+F7Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-zmDCXMCXN7-nuO5Z5mvuCw-1; Thu, 25 Nov 2021 21:52:13 -0500
X-MC-Unique: zmDCXMCXN7-nuO5Z5mvuCw-1
Received: by mail-pj1-f69.google.com with SMTP id x3-20020a17090a1f8300b001a285b9f2cbso2545608pja.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7NAtupCiuM9VvZ3rxyt0oJqhO9XUhiUEr3+tz1tYqaI=;
        b=ZBT/OxqyPd00id2cBVuBf0hdjf0H9CpR4OxwmklogJt4fIFBkm6Ody5B/HpaqNrACf
         V4MyJQZD5RkKOijssKyQ5bx5NMSmaX+kp7viFQOI//pZOxRHIHbXWUtaCsy1e73NxSHk
         j8M97J3FANgoA9NeSZzj2E5sthJFXxc0zRM+U7sLoUINms9VLyLjo+t882OYFHo2lkWy
         DuK45cYGXauD03OhXEAfg/rKP5YSK1jjb4mG/TGXQPjcvWvbDFTaG1BHf0f0DAfYIYDd
         LQxc6WxDyPGeLH6KBv+ijDWVi5qM4jKk/vPPzLLhCJ4GZW3OEh9G1Whf6ayx2obAwGA8
         muoA==
X-Gm-Message-State: AOAM532wQg8/zMBP6wBPzfhgvvvjqE9Qww1KIE2OxPraJ1VOKnmBVxHI
        X3WRry3M5gurDk9sC28D7cDsboUUMliDcQHMVsDv9VYLUkKsaRJrkpAsKtyW3woJpw/xkcvNw2k
        Pk0AtPvqCpfwlQMuV/crHFcVk
X-Received: by 2002:a17:90a:3b02:: with SMTP id d2mr12017200pjc.159.1637895132767;
        Thu, 25 Nov 2021 18:52:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwr7ObjzUv0d8fam68PI6oQi38QDuLoTypxe/RHmqNEV0b3R8kYYAP/nxEioLU/4qhsNLm1Hw==
X-Received: by 2002:a17:90a:3b02:: with SMTP id d2mr12017165pjc.159.1637895132422;
        Thu, 25 Nov 2021 18:52:12 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id f1sm5201818pfj.184.2021.11.25.18.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 18:52:11 -0800 (PST)
Date:   Fri, 26 Nov 2021 10:52:05 +0800
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YaBL1Ti+XnzG+fdK@xz-m1.local>
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local>
 <57d649c8-fe13-17cd-8819-2cd93500a79c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57d649c8-fe13-17cd-8819-2cd93500a79c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:32:08AM +0100, David Hildenbrand wrote:
> On 25.11.21 11:24, Peter Xu wrote:
> > On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
> >>> Do we have a performance evaluation how much overhead is added e.g., for
> >>> a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
> >>> covers the whole THP?
> >>
> >> I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> >> x86 for both settings you suggested. I don't see any statistically
> >> significant difference with and without the patch. Let me know if you
> >> want me to try something else.
> > 
> > I'm a bit surprised that sync split thp didn't bring any extra overhead.
> > 
> > "unmap whole thp" is understandable from that pov, because afaict that won't
> > even trigger any thp split anyway even delayed, if this is the simplest case
> > that only this process mapped this thp, and it mapped once.
> > 
> > For "unmap 4k upon thp" IIUC that's the worst case and zapping 4k should be
> > fast; while what I don't understand since thp split requires all hand-made work
> > for copying thp flags into small pages and so on, so I thought there should at
> > least be some overhead measured.  Shakeel, could there be something overlooked
> > in the test, or maybe it's me that overlooked?
> > 
> > I had the same concern as what Kirill/Matthew raised in the other thread - I'm
> > worried proactively splitting simply because any 4k page is zapped might
> > quickly free up 2m thps in the system and I'm not sure whether it'll exaggerate
> > the defragmentation of the system memory in general.  I'm also not sure whether
> > that's ideal for some very common workload that frequently uses DONTNEED to
> > proactively drop some pages.
> 
> The pageblock corresponding to the THP is movable. So (unless we start
> spilling unmovable allocations into movable pageblocks) we'd only place
> movable allocations in there. Compaction will be able to migrate to
> re-create a free THP.
> 
> In contrast I think, compaction will happily skip over the THP and
> ignore it, because it has no clue that the THP could be repurposed by
> split+migrate (at least I am not aware of code that does it).
> 
> Unless I am missing something, with the above in mind it could make
> sense to split as soon as possible, even before we're under memory
> pressure -- for example, for proactive compaction.
> 
> [proactive compaction could try splitting first as well I think]

But we can't rely on proactive compaction for rapid operations, because it's
still adding overhead to the overall system by split+merge, right?

+compaction_proactiveness
+========================
+ ...
+Note that compaction has a non-trivial system-wide impact as pages
+belonging to different processes are moved around, which could also lead
+to latency spikes in unsuspecting applications. The kernel employs
+various heuristics to avoid wasting CPU cycles if it detects that
+proactive compaction is not being effective.

Delaying split makes sense to me because after all the kernel is not aware of
the userspace's preference, so the best thing is to do nothing until necessary.

Proactively split thps in dontneed/unmap added an assumption that the userspace
wants to break the pages by default.  It's 100% true for Shakeel's use case,
but I'm not sure whether it may always be true.  That's why I thought maybe a
new interface is more proper, so we at least won't break anyone by accident.

-- 
Peter Xu

