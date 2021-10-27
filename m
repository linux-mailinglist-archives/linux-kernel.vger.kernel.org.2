Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A363043C375
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhJ0HF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhJ0HFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635318179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qB9orfXP+TkYZdjN8fPxJ9xOGGgP6qLWhKClCfaJ4yI=;
        b=AmazSm7sezt0wNxW5AZz1/fuH4q73MbLYZQ0BisRG/oWmrzIpdi0rOkq97QUfI5oqBvisc
        qRHWktWupOWjPdXmgdIPqnAYUmzzhf5FnBa3qTYKV3+XKgq4ozPL4vsekByomxb9iW1JqI
        75rzchZ5vSOaVrWiwjNYjbZVhWwjh8o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-gCCGtBVkOQWvMiRNfyldUg-1; Wed, 27 Oct 2021 03:02:57 -0400
X-MC-Unique: gCCGtBVkOQWvMiRNfyldUg-1
Received: by mail-pj1-f69.google.com with SMTP id x13-20020a17090a1f8d00b001a285b9f2cbso1080993pja.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qB9orfXP+TkYZdjN8fPxJ9xOGGgP6qLWhKClCfaJ4yI=;
        b=3BT4fiHt205lQB8/1UmtBUHRK1TcEA8nGDYej8cgUNBjfMHxbK2N9zNiok3oO3TeE5
         r15x/dgKr6qma9G32t5lKZccbAKkNLebicjjQZ+drneWG7ZT6PwfHa5YCg+wuRwdVfln
         XbB6BnVygcGjoaSPZsFvQODvh6Hex8ulfmu0CHbCtbl3s8DO6S16rExnxEl2KedH2alW
         DAurNM05uG6h0bQdUtQ2fjLcqON2jFBhV4Z6UpBWdQh0Rb62+RMFQmlczaTz/FLnt9LB
         S2sKTQUOWKCtkN4JQbftifXBWVz67euTfqE3Od8uyg6Nx7wGL/MV0P9v3qA4sq3dDLIv
         6Spg==
X-Gm-Message-State: AOAM530jbYVfdGjmF0+x9613l+rvn+LrtBLK1OiLrElyuLfkmJ68PtPn
        +NZ9SWAnPo8mWyjv2Z8qfUEbQJHgndxG64NaMrNIftBQ135TY5FZEkk3MYg0sURIsqa60UytS+0
        2sMj0XIPqCAW2yCXzoB5LDh0L
X-Received: by 2002:a17:902:bf07:b0:138:e32d:9f2e with SMTP id bi7-20020a170902bf0700b00138e32d9f2emr26381772plb.59.1635318176272;
        Wed, 27 Oct 2021 00:02:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj8yFGhnsS+4GZ1/fmPMutaQvdaiMx+A6FlZd6RDjUhri7Fa4t/+UHfKlHyka9dZlqzsk0RQ==
X-Received: by 2002:a17:902:bf07:b0:138:e32d:9f2e with SMTP id bi7-20020a170902bf0700b00138e32d9f2emr26381729plb.59.1635318175861;
        Wed, 27 Oct 2021 00:02:55 -0700 (PDT)
Received: from xz-m1.local ([191.101.132.60])
        by smtp.gmail.com with ESMTPSA id f17sm11497916pfv.69.2021.10.27.00.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:02:55 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:02:49 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <YXj5mTFBnuJS3tvT@xz-m1.local>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
 <20211004143228.GA1545442@u2004>
 <20211026232736.GA2704541@u2004>
 <YXi0v9DHCl+aiogP@xz-m1.local>
 <20211027064513.GA2717516@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027064513.GA2717516@u2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 03:45:13PM +0900, Naoya Horiguchi wrote:
> On Wed, Oct 27, 2021 at 10:09:03AM +0800, Peter Xu wrote:
> > On Wed, Oct 27, 2021 at 08:27:36AM +0900, Naoya Horiguchi wrote:
> > > On Mon, Oct 04, 2021 at 11:32:28PM +0900, Naoya Horiguchi wrote:
> > > > On Mon, Oct 04, 2021 at 01:55:30PM +0200, David Hildenbrand wrote:
> > > > > On 04.10.21 13:50, Naoya Horiguchi wrote:
> > > ...
> > > > > >
> > > > > > Hwpoison entry for hugepage is also exposed by this patch. The below
> > > > > > example shows how pagemap is visible in the case where a memory error
> > > > > > hit a hugepage mapped to a process.
> > > > > >
> > > > > >      $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
> > > > > >      voffset offset  len     flags
> > > > > >      700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
> > > > > >      700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
> > > > > >      700000200       12f800  1       __________B________X_______________f______w_
> > > > > >      700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
> > > > > >      700000202       12f802  1fe     __________B________X_______________f______w_
> > > > > >
> > > > > > The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
> > > > > > flag) are considered as hwpoison entries.  So all pages in 2MB range
> > > > > > are inaccessible from the process.  We can get actual error location
> > > > > > by page-types in physical address mode.
> > > > > >
> > > > > >      $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
> > > > > >      offset  len     flags
> > > > > >      12f800  1       __________B_________________________________
> > > > > >      12f801  1       ___________________X________________________
> > > > > >      12f802  1fe     __________B_________________________________
> > > > > >
> > > > > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > > > > ---
> > > > > >   fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
> > > > > >   include/linux/swapops.h | 13 +++++++++++++
> > > > > >   tools/vm/page-types.c   |  7 ++++++-
> > > > > >   3 files changed, 51 insertions(+), 10 deletions(-)
> > > > >
> > > > >
> > > > > Please also update the documentation located at
> > > > >
> > > > > Documentation/admin-guide/mm/pagemap.rst
> > > >
> > > > I will do this in the next post.
> > > 
> > > Reading the document, I found that swap type is already exported so we
> > > could identify hwpoison entry with it (without new PM_HWPOISON bit).
> > > One problem is that the format of swap types (like SWP_HWPOISON) depends
> > > on a few config macros like CONFIG_DEVICE_PRIVATE and CONFIG_MIGRATION,
> > > so we also need to export how the swap type field is interpreted.
> > 
> > I had similar question before.. though it was more on the generic swap entries
> > not the special ones yet.
> > 
> > The thing is I don't know how the userspace could interpret normal swap device
> > indexes out of reading pagemap, say if we have two swap devices with "swapon
> > -s" then I've no idea how do we know which device has which swap type index
> > allocated.  That seems to be a similar question asked above on special swap
> > types - the interface seems to be incomplete, if not unused at all.
> > 
> > AFAIU the information on "this page is swapped out to device X on offset Y" is
> > not reliable too, because the pagein/pageout from kernel is transparent to the
> > userspace and not under control of userspace at all.  IOW, if the user reads
> > that swap entry, then reads data upon the disk of that offset out and put it
> > somewhere else, then it means the data read could already be old if kernel
> > paged in the page after userspace reading the pagemap but before it reading the
> > disk, and I don't see any way to make it right unless the userspace could stop
> > the kernel from page-in a swap entry.  That's why I really wonder whether we
> > should expose normal swap entry at all, as I don't know how it could be helpful
> > and used in the 100% right way.
> 
> Thank you for the feedback.
> 
> I think that a process interested in controlling swap-in/out behavior in its own
> typically calls mincore() to get current status and madvise() to trigger swap-in/out.
> That's not 100% solution for the same reason, but it mostly works well because
> calling madvise(MADV_PAGEOUT) to already swapped out is not a big issue (although
> some CPU/memory resource is wasted, but the amount of the waste is small if the
> returned info is new enough). 
> So my point is that the concern around information newness might be more generic
> issue rather than just for pagemap.  If we need 100% accurate in-kernel info,
> maybe it had better be done in kernel (or some cooler stuff like eBPF)?

I fully agree the solution you mentioned with mincore() and madvise(), that is
very sane and working approach.  Though IMHO the major thing I wanted to point
out is for generic swap devices we exposed (disk_index, disk_offset) tuple as
the swap entry (besides "whether this page is swapped out or not"; that's
PM_SWAP, and as you mentioned people'll need to rely on mincore() to make it
right for shmem), though to use it we need to either record the index/offset or
read/write data from it.  However none of them will make sense, IMHO..  So I
think exposing PM_SWAP makes sense, not the swap entries on swap devices.

> 
> > 
> > Special swap entries seem a bit different - at least for is_pfn_swap_entry()
> > typed swap entries we can still expose the PFN which might be helpful, which I
> > can't tell.
> 
> I'm one who think it helpful for testing, although I know testing might not be
> considered as a real usecase.

I think testing is valid use case too.

> 
> > 
> > I used to send an email to Matt Mackall <mpm@selenic.com> and Dave Hansen
> > <dave.hansen@linux.intel.com> asking about above but didn't get a reply. Ccing
> > again this time with the list copied.
> > 
> > > 
> > > I thought of adding new interfaces for example under /sys/kernel/mm/swap/type_format/,
> > > which shows info like below (assuming that all CONFIG_{DEVICE_PRIVATE,MIGRATION,MEMORY_FAILURE}
> > > is enabled):
> > > 
> > >   $ ls /sys/kernel/mm/swap/type_format/
> > >   hwpoison
> > >   migration_read
> > >   migration_write
> > >   device_write
> > >   device_read
> > >   device_exclusive_write
> > >   device_exclusive_read
> > >   
> > >   $ cat /sys/kernel/mm/swap/type_format/hwpoison
> > >   25
> > >   
> > >   $ cat /sys/kernel/mm/swap/type_format/device_write
> > >   28
> > > 
> > > Does it make sense or any better approach?
> > 
> > Then I'm wondering whether we care about the rest of the normal swap devices
> > too with pagemap so do we need to expose some information there too (only if
> > there's a real use case, though..)?  Or... should we just don't expose swap
> > entries at all, at least generic swap entries?  We can still expose things like
> > hwpoison via PM_* bits well defined in that case.
> 
> I didn't think about normal swap devices for no reason. I'm OK to stop exposing
> normal swap device part.  I don't have strong option yet about which approach
> (in swaptype or PM_HWPOISON) I'll suggest next (so wait a little more for feedback).

No strong opinion here too. It's just that the new interface proposed reminded
me that it's partially complete if considering we're also exposing swap entries
on swap devices, so the types didn't cover those entries.  However it's more
like a pure question because I never figured out how those entries will work
anyway.  I'd be willing to know whether Dave Hanson would comment on this.

While the PM_HWPOISON approach looks always sane to me.

Thanks,

-- 
Peter Xu

