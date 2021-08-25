Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66B23F77E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhHYPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231975AbhHYPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629903586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRZCtiV3z6cRWw9u9XN9sEEharOLHBZt749Jk4I09bU=;
        b=DlXUmshCskdRwOhgwZ6zP14NO0RgJFjwd4ulNYi9ZTTlyQkudNL5FSAyFSz7i+jEAAQCQA
        sAb7NuhgaDOpDUtu5MP4DPi/7zRkZ1/uwlBE0WbjrNV5mE+mpgmBY1AAdCOK4C0W9dikyt
        DdBIsD7+zIDWlWNP/KS5Ri6EpOJtESE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-AvbsNcgTNGCDuVotmjgy-w-1; Wed, 25 Aug 2021 10:59:45 -0400
X-MC-Unique: AvbsNcgTNGCDuVotmjgy-w-1
Received: by mail-qv1-f70.google.com with SMTP id u8-20020a0cee88000000b00363b89e1c50so14338789qvr.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRZCtiV3z6cRWw9u9XN9sEEharOLHBZt749Jk4I09bU=;
        b=XAINqidMYuIM2LFkolqzFLYYZPzCMC4caxv9uRgYtIQccNzVr1n/dYXzUkz5Nml+BB
         CD2bcEGgHzvO+5etCZ7RXcVCogLsztl/B7A4gm4n+6H9OgZEURZG2ny7YdmS4jk9qxXs
         CvOOvmp2BbVdXtAwJ5uyMXUljZd871LRMa+mLhT01VxKar94l9fazks8XdPVntDBGJ+0
         Bb1042sycKAj1g8O8sUGwWrOZDdtBfGUixsY3XsObzbz8MDizlVeMOFbQyFIWUtEdAjv
         kg/K5yQIoAzoda0TasL5zes6OlrbCZV2NxFuDps1IEaFfmpc1CJfo+ZKPbwOqmy5Ql49
         A30g==
X-Gm-Message-State: AOAM530myUVlM9lcqjAYpJojnLGe8tjU42FCJ3T6Ew7Mvr1m8oZRkhMm
        Uotsh80PJ/SbxXOBEpCdxqn0PVlIo4x6/y5kXwtxA8Y/ANMgkSD/2rBwFulARZCt8S1XH/YSV/o
        KNWXYJzYBmWyv5zNacaKEF5KC
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr45398715qvb.0.1629903584984;
        Wed, 25 Aug 2021 07:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE5UlNgNAukNSbYfT1e35y2UK0COzFVME7eD5VLdbKng+wpKAshxd8lNUUpIKhTwET6nrvkg==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr45398676qvb.0.1629903584622;
        Wed, 25 Aug 2021 07:59:44 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::d413])
        by smtp.gmail.com with ESMTPSA id a15sm877922qtp.19.2021.08.25.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:59:44 -0700 (PDT)
Date:   Wed, 25 Aug 2021 10:59:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>,
        Chris Riches <chris.riches@nutanix.com>
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <YSZa3gcmc3ShEaUQ@t490s>
References: <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com>
 <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
 <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
 <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
 <5766d353-6ff8-fdfa-f8f9-764e8de9b5aa@redhat.com>
 <B130B700-B3DB-4D07-A632-73030BCBC715@nutanix.com>
 <YR/+gfL8RCP8XoB1@t490s>
 <53EBB3A1-06C0-418A-B20E-5BFD5212D7C3@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53EBB3A1-06C0-418A-B20E-5BFD5212D7C3@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:40:13PM +0000, Tiberiu Georgescu wrote:
> Hello Peter, sorry for the late reply,

Hi, Tiberiu,

No worries on that.

> 
> > On Fri, Aug 20, 2021 at 04:49:58PM +0000, Tiberiu Georgescu wrote:
> >> Firstly, I am worried lseek with the SEEK_HOLE flag would page in pages from
> >> swap, so using it would be a direct factor on its own output. If people are working
> >> on Live Migration, this would not be ideal. I am not 100% sure this is how lseek
> >> works, so please feel free to contradict me, but I think it would swap in some
> >> of the pages that it seeks through, if not all, to figure out when to stop. Unless it
> >> leverages the page cache somehow, or an internal bitmap.
> > 
> > It shouldn't.  Man page is clear on that:
> > 
> >       SEEK_DATA
> >              Adjust the file offset to the next location in the file greater
> >              than or equal to offset containing data.  If offset points to
> >              data, then the file offset is set to offset.
> 
> Ok, I got to test it out and you are right. lseek does not swap in pages. That is
> great news.
> > 
> > Again, I think your requirement is different from CRIU, so I think mincore() is
> > the right thing for you.
> > 
> >> 
> >> Secondly, mincore() could return some "false positives" for this particular use
> >> case. That is because it returns flag=1 for pages which are still in the swap
> >> cache, so the output becomes ambiguous.
> > 
> > I don't think so; mincore() should return flag=0 if it's either in swap cache
> > or even got dropped from it.  I think its name/doc also shows that in the fact
> > that "as long as it's not in RAM, the flag is cleared".  That's why I think
> > that should indeed be what you're looking for, if swp entry can be ignored.
> > More below on that.
> 
> By saying there are "false positives", I do not mean that the mincore() would
> not work as expected, only that its definition is a little more subtle than that. And
> that it does not suit our needs entirely by itself.
> 
> I tested mincore() compared to the pagemap, and I discovered that there are
> more flags set to 1 (not necessarily contiguous) compared to the pages pagemap 
> was reporting as present. By also looking through the code, I could only conclude
> that pages in the swap cache were considered "still in RAM", so were set to 1 as
> well. When looking into what the swap cache does, it makes sense.

Please see mincore_page():

	/*
	 * When tmpfs swaps out a page from a file, any process mapping that
	 * file will not get a swp_entry_t in its pte, but rather it is like
	 * any other file mapping (ie. marked !present and faulted in with
	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
	 */
	page = find_get_incore_page(mapping, index);
	if (page) {
		present = PageUptodate(page);
		put_page(page);
	}

I think the "testing" means when swapped out, the page will be NULL. If it's
just the pte got zapped, the page will be returned.  The call stack should look
like:

  find_get_incore_page -> find_get_page -> pagecache_get_page(fgp_flags==0).

I think the fgp_flags guaranteed it, with no FGP_ENTRY.

Did you test mincore() without my patch (as my current patch will indeed cause
more 1's returned than it should)?  My guess is there's something else that
made your test read more 1's with mincore() than pagemap, but I have no solid
idea on that.

> 
> We could use mincore() and pagemap to find the pages in the swap cache.
> 
> In short, mincore() is not enough because it does not differentiate between
> present pages and swap-cache entries, as both are in RAM, but the latter
> is also in swap. It can be used with other tools to get more specific information
> though, so it is useful.
> > 
> > Note that my series is as you mentioned missing the changes to support
> > mincore() (otherwise I'll know the existance of it!).  It'll be trivial to add
> > that, but let's see whether mincore() will satisfy your need.
> 
> We are currently trying to make use of all tools that we have learned of so far
> during our discussions (lseek, map_files, even mincore) to get the information
> that we need about swap pages. In theory, for many of our use cases, a
> combination of 2 or 3 should be enough.
> 
> It is a little more convoluted than a simple pagemap call, but it can be more
> versatile (using lseek to skip multiple unallocated pages). As to whether the swap
> bit (and more) should be eventually added on the pagemap, maybe this topic
> makes more sense to continue on the Documentation thread.
> > 
> > [...]
> > 
> >> It is possible for the swap device to be network attached and shared, so multiple
> >> hosts would need to understand its content. Then it is no longer internal to one
> >> kernel only.
> >> 
> >> By being swap-aware, we can skip swapped-out pages during migration (to prevent IO and potential thrashing), and transfer those pages in another way that
> >> is zero-copy.
> > 
> > That sounds reasonable, but I'm not aware of any user-API that exposes swap
> > entries to userspace, or is there one?
> 
> Good question. AFAIK, the swap device can be retrieved by using the swap type,
> which is part of the swap entry. During our discussions, I was always assuming
> that, if the pagemap entry kept track of the swap offset, it would keep track of the
> swap type and, conversely, the swap device as well. Sorry if I haven't made this
> assumption clear until now.
> 
> So we were relying on the pagemap to expose swap entry information. Seeing it
> works for private pages, we thought it made sense to have worked on shared pages as well.
> > 
> > I.e., how do you know which swap device is which?  How do you guarantee the
> > kernel swp entry information won't change along with time?
> 
> I don't think we can guarantee it unless we halt the guest.

Yes, halting the guest helps, though then performance start to matter because
all time consumed in either pagemap or mincore() will be counted in as downtime
of the VM live migration, and it's not "live" at all during this period.

I'm not sure how it was done with private mappings before, because I thought
that's a pre-requisite knowledge to decide whether we should migrate a page or
not, but I might have missed something.  We can stop vm, sample, start vm, but
it could become hiccups in the guest too, or otherwise contribute to downtime
when src/dst vm switches.

> But QEMU does most
> migration work in pre-copy using a best-effort approach anyway.
> 
> So, having a way to retrieve temporary, but accurate information about swap
> entries (i.e. post-patch pagemap) should be enough to guarantee a smoother
> migration process. It is intended to be repeated, unless there is no change
> between iterations.

The kernel will allocate swap device index which will be assigned as swp_type,
right?  If there're multiple swap devices, how do you know which swp_entry is
located on which device?  I wanted to look for that info in "swapon -s" but I
didn't.  Or maybe that solution only works if there's only one swap device?

Besides, I also still have a question on the accuracy. If there's no formal way
for userspace to interact with the kernel, I'm wondering how to guarantee the
page will be kept swapped out, and data located on the swap device will always
be the latest?  Because IMHO the kernel can swap in pages as wish, even if it's
not accessed from the userspace.  After all, all these operations should be
transparent to userspace.

One example in my mind is we do have page fault-around enabled for shmem, so
that even if the VM is stopped, its pages can be faulted in if (unluckily, in
this case, though) some page near the swapped out page got faulted in - it
could be some qemu malloc()ed region that (again, unluckily) was allocated to
have a virtual address very close to the mmap()ed guest memories.

I am not sure whether it's a real problem, e.g., even if some page swapped in
during guest halted for some reason, if no one is writting to that page, at
least the data on the page will still be identical to the one located on the
swap device.  However I think that still sounds too tricky, and maybe fragile.

Thanks,

-- 
Peter Xu

