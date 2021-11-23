Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B879E459929
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhKWAc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhKWAc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637627389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jhcOB8BH8KnNqvuiAnlE7QM1O3rOBhzq7Gqgyf6Q30M=;
        b=THsCUFTBBdhiXIIeCGBFebADFKARsrux0zUHFLn4uo9sjgVGq0CoPM/3wO1KE6d1aCJF46
        WY4LJBnzTXvrDGEX3JCA8UcvaiOMnZLi7NLqRmjQlHxpIz0mX5ecCG/w2RaBQBkbzaD2OT
        /nnTd/hflAPq+PbLYxkI0DgjFgFcZMc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-IAZX5zLZPKyfTtdu8ErZAA-1; Mon, 22 Nov 2021 19:29:48 -0500
X-MC-Unique: IAZX5zLZPKyfTtdu8ErZAA-1
Received: by mail-pg1-f197.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so7004511pgo.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 16:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhcOB8BH8KnNqvuiAnlE7QM1O3rOBhzq7Gqgyf6Q30M=;
        b=6dOXG9Bc/ilc/zGpfoBYxqmJOt4hsftZNq2J4RbgUEPIqEU5yWbc2+71cPtS2pDqHg
         seO6vF01pJ3Ho/9rJ2jLBhxRztbMVoSuQFyzVBnH/0T06zGR6/cu/lJjFdov4JYb4TKQ
         8w4x5ievFvmDY230i/0aDnqmNnTEEnedaU02y1DXircrtGnlPMlQ2VHj7I789v0bLjxb
         7E7Ib++tQYj/tEgktR0HpUIPg3+X43i9KjGfLfK3hqx7VYrqTo/atLh5mwBFGsN8M/n6
         HK0zUfhZdnSOM6PbW5e2dhoAMfUgNUgh2sdN1ZbqQPdDGkLgrRUFK6gRY7J+FaZglCHn
         5h7w==
X-Gm-Message-State: AOAM5306Hy1JQbvLTSRwTtld49jpoixrHlrT3ez+fGktiVmx6R5QePUl
        lDqQSb9NDrpIvdXZ7wxn13iD1d0ZD1TyphPBELp9I8vANeOEzzG7dmnqXyUCMyVFg5DnNtCDI2r
        XMfqEsE8ykPd+tMA+nN3xZ/KL
X-Received: by 2002:a17:902:d2cd:b0:141:fbe2:b658 with SMTP id n13-20020a170902d2cd00b00141fbe2b658mr1640060plc.49.1637627387235;
        Mon, 22 Nov 2021 16:29:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpmetXUOw/FjelCYN18jFCDbKx5Mx0EYWYDFcq013NXXWYI7dgU9YbVVZp1nzeyUp9MIPV2Q==
X-Received: by 2002:a17:902:d2cd:b0:141:fbe2:b658 with SMTP id n13-20020a170902d2cd00b00141fbe2b658mr1640015plc.49.1637627386936;
        Mon, 22 Nov 2021 16:29:46 -0800 (PST)
Received: from xz-m1.local ([191.101.132.71])
        by smtp.gmail.com with ESMTPSA id e18sm7083261pgl.50.2021.11.22.16.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:29:46 -0800 (PST)
Date:   Tue, 23 Nov 2021 08:29:38 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YZw18r7w4GRAmFwV@xz-m1.local>
References: <20211117194855.398455-1-almasrymina@google.com>
 <YZWfhsMtH8KUaEqO@xz-m1.local>
 <CAHS8izPKm3jFjpwtGwcF=UVnxYhZFkJ-NZKOyV+gjPDvzi5reQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izPKm3jFjpwtGwcF=UVnxYhZFkJ-NZKOyV+gjPDvzi5reQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:00:19PM -0800, Mina Almasry wrote:
> On Wed, Nov 17, 2021 at 4:34 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Mina,
> >
> > On Wed, Nov 17, 2021 at 11:48:54AM -0800, Mina Almasry wrote:
> > > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > > address is currently mapped by a transparent huge page or not.  Example
> > > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > > mount for example), for a performance critical region of memory.  The
> > > userspace may want to query whether the kernel is actually backing this
> > > memory by hugepages or not.
> > >
> > > PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
> > > level and the underlying page is a transparent huge page.
> > >
> > > A few options were considered:
> > > 1. Add /proc/pid/pageflags that exports the same info as
> > >    /proc/kpageflags.  This is not appropriate because many kpageflags are
> > >    inappropriate to expose to userspace processes.
> > > 2. Simply get this info from the existing /proc/pid/smaps interface.
> > >    There are a couple of issues with that:
> > >    1. /proc/pid/smaps output is human readable and unfriendly to
> > >       programatically parse.
> > >    2. /proc/pid/smaps is slow.  The cost of reading /proc/pid/smaps into
> > >       userspace buffers is about ~800us per call, and this doesn't
> > >       include parsing the output to get the information you need. The
> > >       cost of querying 1 virt address in /proc/pid/pagemaps however is
> > >       around 5-7us.
> >
> > This does not seem to be fair...  Should the "800us" value relevant to the
> > process memory size being mapped?  As smaps requires walking the whole memory
> > range and provides all stat info including THP accountings.
> >
> > While querying 1 virt address can only account 1 single THP at most.
> >
> > It means if we want to do all THP accounting for the whole range from pagemap
> > we need multiple read()s, right?  The fair comparison should compare the sum of
> > all the read()s on the virt addr we care to a single smap call.
> >
> > And it's hard to be fair too, IMHO, because all these depend on size of mm.
> >
> > Smaps is, logically, faster because of two things:
> >
> >   - Smaps needs only one syscall for whatever memory range (so one
> >     user->kernel->user switch).
> >
> >     Comparing to pagemap use case of yours, you'll need to read 1 virt address
> >     for each PMD, so when the PMD mapped size is huge, it could turn out that
> >     smaps is faster even counting in the parsing time of smaps output.
> >
> >   - Smaps knows how to handle things in PMD level without looping into PTEs:
> >     see smaps_pmd_entry().
> >
> >     Smaps will not duplicate the PMD entry into 512 PTE entries, because smaps
> >     is doing statistic (and that's exaxtly what your use case wants!), while
> >     pagemap is defined in 4K page size even for huge mappings because the
> >     structure is defined upon the offset of the pagemap fd; that's why it needs
> >     to duplicate the 2M entry into 512 same ones; even if they're not really so
> >     meaningful.
> >
> > That's also why I tried to propose the interface of smaps to allow querying
> > partial of the memory range, because IMHO it solves the exact problem you're
> > describing and it'll also be in the most efficient way, meanwhile I think it
> > expose all the rest smaps data too besides THP accountings so it could help
> > more than thp accountings.
> >
> > So again, no objection on this simple and working patch, but perhaps rephrasing
> > the 2nd bullet as: "smaps is slow because it must read the whole memory range
> > rather than a small range we care"?
> >
> 
> Sure thing, added in v7.
> 
> If I'm coming across as resisting a range-based smaps, I don't mean
> to. I think it addresses my use case. I'm just warning/pointing out
> that:
> 1. It'll be a large(r than 2 line) patch and probably an added kernel
> interface, and I'm not sure my use case is an acceptable justification
> to do that given the problem can be equally addressed very simply like
> I'm adding here, but if it is an acceptable justification then I'm
> fine with a range-based smaps.
> 2. I'm not 100% sure what the performance would be like. But I can
> protype it and let you know if I have any issues with the performance.
> I just need to know what interface you're envisioning for this.

Not sure whether an ioctl upon the smaps procfs file can work.

> 
> I'll upload a v7 with the commit message change, and let me know what you think!

Yeah that's the only thing I'm asking for now, and sorry to be picky.  Thanks.

-- 
Peter Xu

