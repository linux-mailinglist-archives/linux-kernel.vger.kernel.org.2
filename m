Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED640442E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 06:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhIIEGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 00:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhIIEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 00:06:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0BFC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 21:05:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v17so1179620ybs.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 21:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05Ca02pfZvMrXfNgNF9H2Jldx1Sa0htxtnSYmB+/GC4=;
        b=SgGkejg8RZ2dnBni6dl85OnH4iOIyLF/M6i7gPVENPUDCRUIk+yvWZAImRqtABeonR
         VAdcK4ErYk0Hk4/9PdgyesGnr6YgvqrA0/hkLVgH2AfKICiKuf7f54KkP1TVWkESDtWg
         z+AM6q2j2FivdWCjRrQWu8CopagTJZ+wu/IDCpTeB6qzZSMeREkeBaYCa08PHeb5g1xr
         VDcO2PkAKUPJo64vRLAAJJ7cQCiEVPDy//15HTO09nHUCz08onlbq/mpWC8VyTDqcAgA
         bpZ9oy79vhAOqkQmeThDkhPZp4PIUlv0Kncd+PBqELTtNT1RRckw3yN32Gj533cLWmvQ
         Su0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05Ca02pfZvMrXfNgNF9H2Jldx1Sa0htxtnSYmB+/GC4=;
        b=i0U0o/twNWBU6UOF6/+tT7b21CipM+ALtDtlZaZDfewaO/aqacKYA9hbBBmacve+6x
         rRLA65Gy6sWIFJF05j6JLyBT9jnpGlauYTr1Fh+/ZNGOw53EZt4HHDZ9qwnGQhHnIDA5
         Au4+Ddgn2bR50Le3mB06rx+ASYPYTAK19YvQXzID7BmwL5rBbolJ9yY+HiyhY4rJ0a+J
         egW0LQhAfG4gRlrvXhlA0kOnyRxf5ENXEj+C8y0ULK23V4R4FJAh6H1stL3ipWfkrzxj
         Y0BV+11HhPUU84mFj9AKi5MBJcsDKg65rmT8lDUBWyBRgM+zzKGPYuHJZEf3FZaKIAxP
         7Mpw==
X-Gm-Message-State: AOAM53221YrG+8MijHPnjiv+ktnb/ZFkQlwNMwQM5i2u7SWVfV3kr6EC
        2BS1QfiOGzMVdQLK3EFmEBeQkPtKljSp6Bs3SR5MqA==
X-Google-Smtp-Source: ABdhPJxuNY87tzok68GgeB3m1htJffEiGR2YFQ3UhtbaNUVg1oevrcc5jxFYrxHr29PrD7NwsKVz9p1BOps9N0WBCC0=
X-Received: by 2002:a25:d04a:: with SMTP id h71mr1243688ybg.418.1631160311597;
 Wed, 08 Sep 2021 21:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210902231813.3597709-1-surenb@google.com> <20210902231813.3597709-2-surenb@google.com>
 <YTZIGhbSTghbUay+@casper.infradead.org>
In-Reply-To: <YTZIGhbSTghbUay+@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 8 Sep 2021 21:05:00 -0700
Message-ID: <CAJuCfpEYOC+6FPmVzzV2od3H8vqWVCsb1hiu5CiDS0-hSg6cfQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 9:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 02, 2021 at 04:18:12PM -0700, Suren Baghdasaryan wrote:
> > On Android we heavily use a set of tools that use an extended version of
> > the logic covered in Documentation/vm/pagemap.txt to walk all pages mapped
> > in userspace and slice their usage by process, shared (COW) vs.  unique
> > mappings, backing, etc.  This can account for real physical memory usage
> > even in cases like fork without exec (which Android uses heavily to share
> > as many private COW pages as possible between processes), Kernel SamePage
> > Merging, and clean zero pages.  It produces a measurement of the pages
> > that only exist in that process (USS, for unique), and a measurement of
> > the physical memory usage of that process with the cost of shared pages
> > being evenly split between processes that share them (PSS).
> >
> > If all anonymous memory is indistinguishable then figuring out the real
> > physical memory usage (PSS) of each heap requires either a pagemap walking
> > tool that can understand the heap debugging of every layer, or for every
> > layer's heap debugging tools to implement the pagemap walking logic, in
> > which case it is hard to get a consistent view of memory across the whole
> > system.
> >
> > Tracking the information in userspace leads to all sorts of problems.
> > It either needs to be stored inside the process, which means every
> > process has to have an API to export its current heap information upon
> > request, or it has to be stored externally in a filesystem that
> > somebody needs to clean up on crashes.  It needs to be readable while
> > the process is still running, so it has to have some sort of
> > synchronization with every layer of userspace.  Efficiently tracking
> > the ranges requires reimplementing something like the kernel vma
> > trees, and linking to it from every layer of userspace.  It requires
> > more memory, more syscalls, more runtime cost, and more complexity to
> > separately track regions that the kernel is already tracking.
>
> I understand that the information is currently incoherent, but why is
> this the right way to make it coherent?  It would seem more useful to
> use something like one of the tracing mechanisms (eg ftrace, LTTng,
> whatever the current hotness is in userspace tracing) for the malloc
> library to log all the useful information, instead of injecting a subset
> of it into the kernel for userspace to read out again.

Sorry, for the delay with the response. I'm travelling and my internet
access is very patchy.

Just to clarify, your suggestion is to require userspace to log any
allocation using ftrace or a similar mechanism and then for the system
to parse these logs to calculate the memory usage for each process?
I didn't think much in this direction but I guess logging each
allocation in the system and periodically collecting that data would
be quite expensive both from memory usage and performance POV. I'll
need to think a bit more but these are to me the obvious downsides of
this approach.
