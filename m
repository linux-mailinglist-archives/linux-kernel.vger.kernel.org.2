Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170D445E6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358210AbhKZESQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbhKZEQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637899976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaA5Hc6qxaqzZYkeRafG4dNVzHGTwgjEF0vky65xwRs=;
        b=NADOgh28GSXEBi2Kxncsh6oOBuzYm4FvFmZiueND+Cj3Y1DkeadFQF2E+OlgbyCFyIroW3
        zrdwD3OXuxKs9T4kXXLiM+wfQQwCfqlmwPTT5aMyt6/HMSSbTg3KVBjXRtLQJ50vq93T6y
        7YtGUTFck/GpLdHM7N8C1SgvkLJGqyk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-233-IOVUYVCgNVqXtCCjjITquw-1; Thu, 25 Nov 2021 23:12:55 -0500
X-MC-Unique: IOVUYVCgNVqXtCCjjITquw-1
Received: by mail-pf1-f197.google.com with SMTP id c6-20020aa781c6000000b004a4fcdf1d6dso4655009pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FaA5Hc6qxaqzZYkeRafG4dNVzHGTwgjEF0vky65xwRs=;
        b=SJtDsoh7ys6/nntmynIaVcnHpJZEkb0b01utNHqukXV5oW8W88LpH1vKq681bqUDQv
         skUOoUXW7PJyRWcHGchue12G72tLa2EXb6zPT9VR5s0BWI7hUXWfeKUFJOo7jj4WtjFt
         SlcXtqAi1NYSD60nwgbaXrbRc6AhPb/7lx+VYxJ4Tb8ABJN0b9gfIoi6WOKjjhknb0DQ
         X1yLRNU2CA0rFMWz8ZIYStzOZ8Xv5scLM3thOIhNwZRhT+GhUBScCUkVD8qK0/UoOamr
         wW+pdoHvLPNu/4tRWE9UNkpm47bbY0y6aRGGw0aOfV5NR18Y8ZylgDlU8ZEK+aDgWY18
         LM8g==
X-Gm-Message-State: AOAM530DVu01KBljRIjmkIh+o8boDfzjcNQ0xNwWBDg4sA6Y2uHf74oh
        aHvWYe15Sb/ILFrt08QA8pOaneLluGjaN83ifIonF+BkXQqBl7FQHQ/rqe79RI7Vf3/rRUh08ci
        OqwGADavkcXSVKCtRUokcC4pM
X-Received: by 2002:a63:ea51:: with SMTP id l17mr19137968pgk.363.1637899973628;
        Thu, 25 Nov 2021 20:12:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQkGzCPtwUNossXL3Z5QyhMzDRCODUjel1GfgWU8bdNCvVroqzxSBb2IERuSpyruw3MoBCtw==
X-Received: by 2002:a63:ea51:: with SMTP id l17mr19137942pgk.363.1637899973317;
        Thu, 25 Nov 2021 20:12:53 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id w17sm5006610pfu.58.2021.11.25.20.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 20:12:52 -0800 (PST)
Date:   Fri, 26 Nov 2021 12:12:45 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YaBevbuNuR+ToJ1o@xz-m1.local>
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local>
 <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 07:21:54PM -0800, Shakeel Butt wrote:
> On Thu, Nov 25, 2021 at 2:24 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
> > > > Do we have a performance evaluation how much overhead is added e.g., for
> > > > a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
> > > > covers the whole THP?
> > >
> > > I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> > > x86 for both settings you suggested. I don't see any statistically
> > > significant difference with and without the patch. Let me know if you
> > > want me to try something else.
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
> 
> Thanks for making me rerun this and yes indeed I had a very silly bug in the
> benchmark code (i.e. madvise the same page for the whole loop) and this is
> indeed several times slower than without the patch (sorry David for misleading
> you).
> 
> To better understand what is happening, I profiled the benchmark:
> 
> -   31.27%     0.01%  dontneed  [kernel.kallsyms]  [k] zap_page_range_sync
>    - 31.27% zap_page_range_sync
>       - 30.25% split_local_deferred_list
>          - 30.16% split_huge_page_to_list
>             - 21.05% try_to_migrate
>                + rmap_walk_anon
>             - 7.47% remove_migration_ptes
>                + 7.34% rmap_walk_locked
>       + 1.02% zap_page_range_details

Makes sense, thanks for verifying it, Shakeel.  I forgot it'll also walk
itself.

I believe this effect will be exaggerated when the mapping is shared,
e.g. shmem file thp between processes.  What's worse is that when one process
DONTNEED one 4k page, all the rest mms will need to split the huge pmd without
even being noticed, so that's a direct suffer from perf degrade.

> 
> The overhead is not due to copying page flags but rather due to two rmap walks.
> I don't think this much overhead is justified for current users of MADV_DONTNEED
> and munmap. I have to rethink the approach.

Some side notes: I digged out the old MADV_COLLAPSE proposal right after I
thought about MADV_SPLIT (or any of its variance):

https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/

My memory was that there's some issue to be solved so that was blocked, however
when I read the thread it sounds like the list was mostly reaching a consensus
on considering MADV_COLLAPSE being beneficial.  Still copying DavidR in case I
missed something important.

If we think MADV_COLLAPSE can help to implement an userspace (and more
importantly, data-aware) khugepaged, then MADV_SPLIT can be the other side of
kcompactd, perhaps.

That's probably a bit off topic of this specific discussion on the specific use
case, but so far it seems all reasonable and discussable.

-- 
Peter Xu

