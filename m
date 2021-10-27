Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCD43BF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhJ0CLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237733AbhJ0CLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635300553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qcm5Q4Ovs8CHRPn2mWRVm4wu22bHWN0cLhSQGwpxEDE=;
        b=UIDPLLwqa4jPs+GctzvRwZrO2OsHeFgrIYKF9kPG93P+3tbvvc9BR4VDn4/63OBrNP0azt
        +uG/lvTkkMnoyhTTQoOIxq6bgdHe6V13rrBi1uVE+Ai2TjthFmQfydqEVJXeWJQgJt6alf
        e7aTbZcBDIowJNQtGgsFO0C0Nh2LGQI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-UVMeNFSvNtyJBDAviMG1Vg-1; Tue, 26 Oct 2021 22:09:12 -0400
X-MC-Unique: UVMeNFSvNtyJBDAviMG1Vg-1
Received: by mail-pf1-f197.google.com with SMTP id w13-20020a62dd0d000000b0047bce3ae63bso735046pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qcm5Q4Ovs8CHRPn2mWRVm4wu22bHWN0cLhSQGwpxEDE=;
        b=7Eqx/5uf25uDqIO4Fave4qrNKXYtriMIDHA001AaLBHUiHH0fkFp8jxL4pR62px56U
         /4YMZ+JyCK7P5Izj0u5mgACSW8dZV2TVIeOUuKsepVXww/fmWZXlQhlRNHXzeP9nRvde
         WW2UczsAvStar/Ec7p+xRVpZOxP/1Wlj6EmgKGWt9q9PKuQkpwPQPNC59cKvuo137usF
         iRa/MEe6+fUO1RXC8etXONCXHBz3lkhOdMylFmb8aG1iZ6BBWvqLX7ph/rGzXPOAmIbm
         anG4N7DnioUwURWeI/q6Rqna/GaufGGVWO+nbxTSlYbmr5EvT+BzwrRC/F2p3Y6XkuRF
         sRhQ==
X-Gm-Message-State: AOAM533cl/WomNY19xMzs5NQVq3hPBB3K8roBs6shg4zIwfJJq0JOFvN
        ECljw+7R8jyuGvhrdEAamQudSB3xoYU9r222B6gv/XUY2AYSxIyFT08A+hOcHnDFwuAKcnZ4+wb
        EtPSSkmJTavWPS9HdhTo0sbI4
X-Received: by 2002:a05:6a00:23d5:b0:47c:236d:65b4 with SMTP id g21-20020a056a0023d500b0047c236d65b4mr2581991pfc.52.1635300550859;
        Tue, 26 Oct 2021 19:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOhUbOwgnNQ/gXrlZ5/SKrkDBkzTfSumNM5GaK2aTsmco/xZazNKgSrwS9NnkH+OZ6m7FM6w==
X-Received: by 2002:a05:6a00:23d5:b0:47c:236d:65b4 with SMTP id g21-20020a056a0023d500b0047c236d65b4mr2581919pfc.52.1635300549857;
        Tue, 26 Oct 2021 19:09:09 -0700 (PDT)
Received: from xz-m1.local ([191.101.132.60])
        by smtp.gmail.com with ESMTPSA id z8sm20508403pgc.53.2021.10.26.19.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:09:08 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:09:03 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Matt Mackall <mpm@selenic.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <YXi0v9DHCl+aiogP@xz-m1.local>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
 <20211004143228.GA1545442@u2004>
 <20211026232736.GA2704541@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026232736.GA2704541@u2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 08:27:36AM +0900, Naoya Horiguchi wrote:
> On Mon, Oct 04, 2021 at 11:32:28PM +0900, Naoya Horiguchi wrote:
> > On Mon, Oct 04, 2021 at 01:55:30PM +0200, David Hildenbrand wrote:
> > > On 04.10.21 13:50, Naoya Horiguchi wrote:
> ...
> > > >
> > > > Hwpoison entry for hugepage is also exposed by this patch. The below
> > > > example shows how pagemap is visible in the case where a memory error
> > > > hit a hugepage mapped to a process.
> > > >
> > > >      $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
> > > >      voffset offset  len     flags
> > > >      700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
> > > >      700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
> > > >      700000200       12f800  1       __________B________X_______________f______w_
> > > >      700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
> > > >      700000202       12f802  1fe     __________B________X_______________f______w_
> > > >
> > > > The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
> > > > flag) are considered as hwpoison entries.  So all pages in 2MB range
> > > > are inaccessible from the process.  We can get actual error location
> > > > by page-types in physical address mode.
> > > >
> > > >      $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
> > > >      offset  len     flags
> > > >      12f800  1       __________B_________________________________
> > > >      12f801  1       ___________________X________________________
> > > >      12f802  1fe     __________B_________________________________
> > > >
> > > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > > ---
> > > >   fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
> > > >   include/linux/swapops.h | 13 +++++++++++++
> > > >   tools/vm/page-types.c   |  7 ++++++-
> > > >   3 files changed, 51 insertions(+), 10 deletions(-)
> > >
> > >
> > > Please also update the documentation located at
> > >
> > > Documentation/admin-guide/mm/pagemap.rst
> >
> > I will do this in the next post.
> 
> Reading the document, I found that swap type is already exported so we
> could identify hwpoison entry with it (without new PM_HWPOISON bit).
> One problem is that the format of swap types (like SWP_HWPOISON) depends
> on a few config macros like CONFIG_DEVICE_PRIVATE and CONFIG_MIGRATION,
> so we also need to export how the swap type field is interpreted.

I had similar question before.. though it was more on the generic swap entries
not the special ones yet.

The thing is I don't know how the userspace could interpret normal swap device
indexes out of reading pagemap, say if we have two swap devices with "swapon
-s" then I've no idea how do we know which device has which swap type index
allocated.  That seems to be a similar question asked above on special swap
types - the interface seems to be incomplete, if not unused at all.

AFAIU the information on "this page is swapped out to device X on offset Y" is
not reliable too, because the pagein/pageout from kernel is transparent to the
userspace and not under control of userspace at all.  IOW, if the user reads
that swap entry, then reads data upon the disk of that offset out and put it
somewhere else, then it means the data read could already be old if kernel
paged in the page after userspace reading the pagemap but before it reading the
disk, and I don't see any way to make it right unless the userspace could stop
the kernel from page-in a swap entry.  That's why I really wonder whether we
should expose normal swap entry at all, as I don't know how it could be helpful
and used in the 100% right way.

Special swap entries seem a bit different - at least for is_pfn_swap_entry()
typed swap entries we can still expose the PFN which might be helpful, which I
can't tell.

I used to send an email to Matt Mackall <mpm@selenic.com> and Dave Hansen
<dave.hansen@linux.intel.com> asking about above but didn't get a reply. Ccing
again this time with the list copied.

> 
> I thought of adding new interfaces for example under /sys/kernel/mm/swap/type_format/,
> which shows info like below (assuming that all CONFIG_{DEVICE_PRIVATE,MIGRATION,MEMORY_FAILURE}
> is enabled):
> 
>   $ ls /sys/kernel/mm/swap/type_format/
>   hwpoison
>   migration_read
>   migration_write
>   device_write
>   device_read
>   device_exclusive_write
>   device_exclusive_read
>   
>   $ cat /sys/kernel/mm/swap/type_format/hwpoison
>   25
>   
>   $ cat /sys/kernel/mm/swap/type_format/device_write
>   28
> 
> Does it make sense or any better approach?

Then I'm wondering whether we care about the rest of the normal swap devices
too with pagemap so do we need to expose some information there too (only if
there's a real use case, though..)?  Or... should we just don't expose swap
entries at all, at least generic swap entries?  We can still expose things like
hwpoison via PM_* bits well defined in that case.

Thanks,

-- 
Peter Xu

