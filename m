Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FC42CEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJMXML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhJMXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634166606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3Zz1NdgJbuZO9PMLIHdfhxYur45mnDl/uZ4E3qmW6c=;
        b=QIx5pKOca4ASbdXms4E1Ei7m9gmiCx/0pkc/Z3NiZFJDUqykvDD8fIDUKIsZnyaPBIcTBs
        +EKCl1UtiLk2gxHrsxYT/gg8IMbr42u5syq2sMTbkgCwtgYCr0WHFfc35x1SG66muC/acI
        h9mSBffOmO5aBM/QGwPAFSS+UiJXRek=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-h-IuqCHmPCS4kW28Y33m9g-1; Wed, 13 Oct 2021 19:10:04 -0400
X-MC-Unique: h-IuqCHmPCS4kW28Y33m9g-1
Received: by mail-pg1-f198.google.com with SMTP id w5-20020a654105000000b002692534afceso1266220pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U3Zz1NdgJbuZO9PMLIHdfhxYur45mnDl/uZ4E3qmW6c=;
        b=wrMcnU8EtMKoB0rmGekx1DeQ4Rnew9t2HHeVmMp8o/3xl7tttAp5z7HqVMktgYL0NE
         LTnV6WCOZaUSNO5RG35N95m5O+JjlatygtqjFjdA3D2vY7OG6WFbEHq8t4Gpgk2z5z4+
         45HmneVnnITwS9zu4ERnIZTBxR6WAmR9lPYh+xoar0/SDdLR2xWVQPKigQ+Yl+3yfnTT
         kbt05s+Xh8AyTzbBxZfveF74DFC37oN6yak/tCAxfrKfEkf51D94D9d1M0QIvY0PzUdW
         CiJbAii7ROOVwNYHktWCyaCXQq9egjK6BMDgRmFnV/4DaL1b3liAgnvu9d4jw5ClL/WW
         pwoA==
X-Gm-Message-State: AOAM532CtfE3jOeayuAKECPYEHPoPw5IaksopXL5gdCAW/vVP/oACnjH
        psWpYIExWKXKa6aQN5gnX1ik+O2sCfAPr/9ZMVNkLH0HHpFcs+BgZdDPNSLVHLVse20zhAKBtDl
        3Zi0QGW/DCvQiY4pNtUW14vD2
X-Received: by 2002:a63:3548:: with SMTP id c69mr1598463pga.111.1634166603645;
        Wed, 13 Oct 2021 16:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQwv2/BAw9goLcSL27J9xHo4b1sI1wMi4h7Z9mOjN0qKfNPkjPSjFHu2enqHTgE0pRpUDipA==
X-Received: by 2002:a63:3548:: with SMTP id c69mr1598436pga.111.1634166603237;
        Wed, 13 Oct 2021 16:10:03 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nu16sm501375pjb.56.2021.10.13.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 16:10:02 -0700 (PDT)
Date:   Thu, 14 Oct 2021 07:09:54 +0800
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
Message-ID: <YWdnQmxGT51T1DMl@t490s>
References: <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
 <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
 <YVQbMREcRaCbUaUv@dhcp22.suse.cz>
 <E8456D5C-4FCD-46E4-B6F8-771076243D7E@gmail.com>
 <YWYWyUMcgoAJqi3V@t490s>
 <595A6581-86CF-4372-98AF-532DF65186C6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <595A6581-86CF-4372-98AF-532DF65186C6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 08:47:11AM -0700, Nadav Amit wrote:
> 
> 
> > On Oct 12, 2021, at 4:14 PM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Wed, Sep 29, 2021 at 11:31:25AM -0700, Nadav Amit wrote:
> >> 
> >> 
> >>> On Sep 29, 2021, at 12:52 AM, Michal Hocko <mhocko@suse.com> wrote:
> >>> 
> >>> On Mon 27-09-21 12:12:46, Nadav Amit wrote:
> >>>> 
> >>>>> On Sep 27, 2021, at 5:16 AM, Michal Hocko <mhocko@suse.com> wrote:
> >>>>> 
> >>>>> On Mon 27-09-21 05:00:11, Nadav Amit wrote:
> >>>>> [...]
> >>>>>> The manager is notified on memory regions that it should monitor
> >>>>>> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these regions
> >>>>>> using the remote-userfaultfd that you saw on the second thread. When it wants
> >>>>>> to reclaim (anonymous) memory, it:
> >>>>>> 
> >>>>>> 1. Uses UFFD-WP to protect that memory (and for this matter I got a vectored
> >>>>>> UFFD-WP to do so efficiently, a patch which I did not send yet).
> >>>>>> 2. Calls process_vm_readv() to read that memory of that process.
> >>>>>> 3. Write it back to “swap”.
> >>>>>> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
> >>>>> 
> >>>>> Why cannot you use MADV_PAGEOUT/MADV_COLD for this usecase?
> >>>> 
> >>>> Providing hints to the kernel takes you so far to a certain extent.
> >>>> The kernel does not want to (for a good reason) to be completely
> >>>> configurable when it comes to reclaim and prefetch policies. Doing
> >>>> so from userspace allows you to be fully configurable.
> >>> 
> >>> I am sorry but I do not follow. Your scenario is describing a user
> >>> space driven reclaim. Something that MADV_{COLD,PAGEOUT} have been
> >>> designed for. What are you missing in the existing functionality?
> >> 
> >> Using MADV_COLD/MADV_PAGEOUT does not allow userspace to control
> >> many aspects of paging out memory:
> >> 
> >> 1. Writeback: writeback ahead of time, dynamic clustering, etc.
> >> 2. Batching (regardless, MADV_PAGEOUT does pretty bad batching job
> >>  on non-contiguous memory).
> >> 3. No guarantee the page is actually reclaimed (e.g., writeback)
> >>  and the time it takes place.
> >> 4. I/O stack for swapping - you must use kernel I/O stack (FUSE
> >>  as non-performant as it is cannot be used for swap AFAIK).
> >> 5. Other operations (e.g., locking, working set tracking) that
> >>  might not be necessary or interfere.
> >> 
> >> In addition, the use of MADV_COLD/MADV_PAGEOUT prevents the use
> >> of userfaultfd to trap page-faults and react accordingly, so you
> >> are also prevented from:
> >> 
> >> 6. Having your own custom prefetching policy in response to #PF.
> >> 
> >> There are additional use-cases I can try to formalize in which
> >> MADV_COLD/MADV_PAGEOUT is insufficient. But the main difference
> >> is pretty clear, I think: one is a hint that only applied to
> >> page reclamation. The other enables the direct control of
> >> userspace over (almost) all aspects of paging.
> >> 
> >> As I suggested before, if it is preferred, this can be a UFFD
> >> IOCTL instead of process_madvise() behavior, thereby lowering
> >> the risk of a misuse.
> > 
> > (Sorry to join so late..)
> > 
> > Yeah I'm wondering whether that could add one extra layer of security.  But as
> > you mentioned, we've already have process_vm_writev(), then it's indeed not
> > strong reason to reject process_madvise(DONTNEED) too, it seems.
> > 
> > Not sure whether you're aware of the umap project from LLNL:
> > 
> > https://github.com/LLNL/umap
> > 
> > From what I can tell, that's really doing very similar thing as what you
> > proposed here, but it's just a local version of things.  IOW in umap the
> > DONTNEED can be done locally with madvise() already in the umap maintained
> > threads.  That close the need to introduce the new process_madvise() interface
> > and it's definitely safer as it's per-mm and per-task.
> > 
> > I think you mentioned above that the tracee program will need to cooperate in
> > this case, I'm wondering whether some solution like umap would be fine too as
> > that also requires cooperation of the tracee program, it's just that the
> > cooperation may be slightly more than your solution but frankly I think that's
> > still trivial and before I understand the details of your solution I can't
> > really tell..
> > 
> > E.g. for a program to use umap, I think it needs to replace mmap() to umap()
> > where we want the buffers to be managed by umap library rather than the kernel,
> > then link against the umap library should work.  If the remote solution you're
> > proposing requires similar (or even more complicated) cooperation, then it'll
> > be controversial whether that can be done per-mm just like how umap designed
> > and used.  So IMHO it'll be great to share more details on those parts if umap
> > cannot satisfy the current need - IMHO it satisfies all the features you
> > described on fully customized pageout and page faulting in, it's just done in a
> > single mm.
> 
> Thanks for you feedback, Peter.
> 
> I am familiar with umap, perhaps not enough, but I am aware.
> 
> From my experience, the existing interfaces are not sufficient if you look
> for high performance (low overhead) solution for multiple processes. The
> level of cooperation that I mentioned is something that I mentioned
> preemptively to avoid unnecessary discussion, but I believe they can be
> resolved (I have just deferred handling them).
> 
> Specifically for performance, several new kernel features are needed, for
> instance, support for iouring with async operations, a vectored
> UFFDIO_WRITEPROTECT(V) which batches TLB flushes across VMAs and a
> vectored madvise(). Even if we talk on the context of a single mm, I
> cannot see umap being performant for low latency devices without those
> facilities.
> 
> Anyhow, I take your feedback and I will resend the patch for enabling
> MADV_DONTNEED with other patches once I am done. As for the TLB batching
> itself, I think it has an independent value - but I am not going to
> argue about it now if there is a pushback against it.

Fair enough.

Yes my comment was mostly about whether a remote interface is needed or can we
still do it locally (frankly I always wanted to have some remote interface to
manipulate uffd, but still anything like that should require some
justifications for sure).

I totally agree your rest works on either optimizing tlb (especially on the two
points Andrea mentioned for either reducing tlb for huge pmd change protection,
or pte promotions) and vectored interfaces sound reasonable, and they're
definitely separate issues comparing to this one.

Thanks,

-- 
Peter Xu

