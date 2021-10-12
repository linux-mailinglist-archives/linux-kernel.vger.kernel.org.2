Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF942B001
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhJLXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhJLXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634080478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMX1RCgjLsc80uuaghFh+qKGN+Vea72Az+9OruRUp/Y=;
        b=fmlcoRSrMHPiy1vUO2YSuN7KrPC6gb9Qp+zzOCGv5DzaNcCULU5O3I0+ayGiQRA7eTNdBC
        Vrz2f8ZflcZNBBNaImQ3Hahir/DzvZOOQWK0bAaaxcFlrHu/z9Pt3ks9YLTwttcw33UaSM
        C25l86BAZUdAL9OISoILa8ZPTGSQCi4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-wnskFc5PODSIeGAog8m2cQ-1; Tue, 12 Oct 2021 19:14:36 -0400
X-MC-Unique: wnskFc5PODSIeGAog8m2cQ-1
Received: by mail-pj1-f70.google.com with SMTP id l10-20020a17090ac58a00b001a04b92a5d4so535084pjt.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lMX1RCgjLsc80uuaghFh+qKGN+Vea72Az+9OruRUp/Y=;
        b=5fVJ5PH0x2GpZ5esMHc1Bk14/D5iFUF0V8eqFXcTmWYZ3+RrhyGdCOpiLMB/N6cM+3
         X1KguZCtgY0Yg0kro/Fphuv9JgVLjXBFeGLIASPIx0S0hkxSB2an1u9Nqx/KNZ7iI9X9
         i8PfioF8QoPJ9ioN0EC/nHsFJ0kv421GdK7VPES/bNG4kDmPvlKnIN+wH1Ud9o2CISBt
         FI2WzEN2ZKL2hAlaevLkdqERk8xTPsjoI6fGQg2UfT6JXp0n+KLe6Di3lyWYjQkGDoLS
         sP4fKWEvl4CnAMvk1K19cM4auUlzSLpcYWyvlYRbJvjbBu+dhGqeBglk8IKtw3Up6eVg
         vH6Q==
X-Gm-Message-State: AOAM531mlULfjO+VBMaxDzFKQnEMBPoz/sHecZVzTJX+PC8u66CU0/BJ
        2eh5L5gf3i853UHqytOgET/bFHWNtbwglR/FIlKKulgHf5ZfH0mmbB5E6bY6doG5RkWV5qQYt1a
        CAUu/T8kz/swlXTyMglKepTT2
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr9304243pjv.39.1634080475674;
        Tue, 12 Oct 2021 16:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD84tRalPfxJ0XICA7oxDcEM8MgCjTy+nG79fuR+rkEH0egiiU/ayCQez8eEcAziRW2/6wNQ==
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr9304200pjv.39.1634080475260;
        Tue, 12 Oct 2021 16:14:35 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o189sm12408129pfd.203.2021.10.12.16.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:14:34 -0700 (PDT)
Date:   Wed, 13 Oct 2021 07:14:17 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Message-ID: <YWYWyUMcgoAJqi3V@t490s>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
 <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
 <YVQbMREcRaCbUaUv@dhcp22.suse.cz>
 <E8456D5C-4FCD-46E4-B6F8-771076243D7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E8456D5C-4FCD-46E4-B6F8-771076243D7E@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:31:25AM -0700, Nadav Amit wrote:
> 
> 
> > On Sep 29, 2021, at 12:52 AM, Michal Hocko <mhocko@suse.com> wrote:
> > 
> > On Mon 27-09-21 12:12:46, Nadav Amit wrote:
> >> 
> >>> On Sep 27, 2021, at 5:16 AM, Michal Hocko <mhocko@suse.com> wrote:
> >>> 
> >>> On Mon 27-09-21 05:00:11, Nadav Amit wrote:
> >>> [...]
> >>>> The manager is notified on memory regions that it should monitor
> >>>> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these regions
> >>>> using the remote-userfaultfd that you saw on the second thread. When it wants
> >>>> to reclaim (anonymous) memory, it:
> >>>> 
> >>>> 1. Uses UFFD-WP to protect that memory (and for this matter I got a vectored
> >>>>  UFFD-WP to do so efficiently, a patch which I did not send yet).
> >>>> 2. Calls process_vm_readv() to read that memory of that process.
> >>>> 3. Write it back to “swap”.
> >>>> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
> >>> 
> >>> Why cannot you use MADV_PAGEOUT/MADV_COLD for this usecase?
> >> 
> >> Providing hints to the kernel takes you so far to a certain extent.
> >> The kernel does not want to (for a good reason) to be completely
> >> configurable when it comes to reclaim and prefetch policies. Doing
> >> so from userspace allows you to be fully configurable.
> > 
> > I am sorry but I do not follow. Your scenario is describing a user
> > space driven reclaim. Something that MADV_{COLD,PAGEOUT} have been
> > designed for. What are you missing in the existing functionality?
> 
> Using MADV_COLD/MADV_PAGEOUT does not allow userspace to control
> many aspects of paging out memory:
> 
> 1. Writeback: writeback ahead of time, dynamic clustering, etc.
> 2. Batching (regardless, MADV_PAGEOUT does pretty bad batching job
>    on non-contiguous memory).
> 3. No guarantee the page is actually reclaimed (e.g., writeback)
>    and the time it takes place.
> 4. I/O stack for swapping - you must use kernel I/O stack (FUSE
>    as non-performant as it is cannot be used for swap AFAIK).
> 5. Other operations (e.g., locking, working set tracking) that
>    might not be necessary or interfere.
> 
> In addition, the use of MADV_COLD/MADV_PAGEOUT prevents the use
> of userfaultfd to trap page-faults and react accordingly, so you
> are also prevented from:
> 
> 6. Having your own custom prefetching policy in response to #PF.
> 
> There are additional use-cases I can try to formalize in which
> MADV_COLD/MADV_PAGEOUT is insufficient. But the main difference
> is pretty clear, I think: one is a hint that only applied to
> page reclamation. The other enables the direct control of
> userspace over (almost) all aspects of paging.
> 
> As I suggested before, if it is preferred, this can be a UFFD
> IOCTL instead of process_madvise() behavior, thereby lowering
> the risk of a misuse.

(Sorry to join so late..)

Yeah I'm wondering whether that could add one extra layer of security.  But as
you mentioned, we've already have process_vm_writev(), then it's indeed not
strong reason to reject process_madvise(DONTNEED) too, it seems.

Not sure whether you're aware of the umap project from LLNL:

  https://github.com/LLNL/umap

From what I can tell, that's really doing very similar thing as what you
proposed here, but it's just a local version of things.  IOW in umap the
DONTNEED can be done locally with madvise() already in the umap maintained
threads.  That close the need to introduce the new process_madvise() interface
and it's definitely safer as it's per-mm and per-task.

I think you mentioned above that the tracee program will need to cooperate in
this case, I'm wondering whether some solution like umap would be fine too as
that also requires cooperation of the tracee program, it's just that the
cooperation may be slightly more than your solution but frankly I think that's
still trivial and before I understand the details of your solution I can't
really tell..

E.g. for a program to use umap, I think it needs to replace mmap() to umap()
where we want the buffers to be managed by umap library rather than the kernel,
then link against the umap library should work.  If the remote solution you're
proposing requires similar (or even more complicated) cooperation, then it'll
be controversial whether that can be done per-mm just like how umap designed
and used.  So IMHO it'll be great to share more details on those parts if umap
cannot satisfy the current need - IMHO it satisfies all the features you
described on fully customized pageout and page faulting in, it's just done in a
single mm.

Thanks,

-- 
Peter Xu

