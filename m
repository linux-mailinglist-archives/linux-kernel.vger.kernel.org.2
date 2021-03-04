Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F932D754
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhCDQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236338AbhCDQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614873743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyhQgjgYAeNA8irgyR25lH7TE7Jy6HFJBHARivwr8OM=;
        b=eITCDthcFk11rrAdm1vGyQJTfX73pYZkYGdRkcNgCjV+/JCSSPD1CKvBUlp47yAj2bV8A3
        241ie2XvhsMY8Ug9KbYJHnnG6eT7wr3+RqGR81+5kz9PhEogomoHiFDpJ/KaRptbqDiShn
        A9EOyWCXFosnk7kel2s+oy9x7juE8ak=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-JI8DxupePjmiTTuYawnOgg-1; Thu, 04 Mar 2021 11:02:20 -0500
X-MC-Unique: JI8DxupePjmiTTuYawnOgg-1
Received: by mail-qk1-f199.google.com with SMTP id h126so23419624qkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JyhQgjgYAeNA8irgyR25lH7TE7Jy6HFJBHARivwr8OM=;
        b=iylwrd7UVzEGcIOaGxKMH2pVVb4xgHLPXCluK45w9tLWyhO3iduHvNF0diHU/MubVb
         M3NL/qyFNoKHO5v+wjmIuTAr2UisgzhTvwOOR4Yn3u//jgyFy2wByu4pEHUMKMBSTI7r
         CFXJIEgQ4M/VooqX8nt9PE6mnQDeQuq+rQQuzrWqD9jL8HgdppIZ7379BhQx9OXJ54OV
         Zm3nE4MTCGfGB+8XMSrMUcgVK/FK14BC1vyVI/HIgqh3vX2FM6tuT4CwJ2jSonYs6MLb
         AgTdrx0tk8i7cxPRd9kOnweZTfjD0iGM/9H8DAgRbDenkbrrfh2CZkIxPvvjVt6JMowO
         6FPA==
X-Gm-Message-State: AOAM532FaFqeHCM0Fe9Je6rKt79SpX2W44DFqphSuWxACEu0mk1cFbOf
        gO0tCLJxyNweeRDJYU64kZmB6eBOPnB/t8g9BnWJAvGuqPAjbHdsZEemEomYDF/jwaaIFP+wPCQ
        DnHaKPz9kI6C98iJvftzF6fzj
X-Received: by 2002:ac8:5bcb:: with SMTP id b11mr4636466qtb.310.1614873740294;
        Thu, 04 Mar 2021 08:02:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5Lyy/zDh1+PpGE8wHcCei1D2bsSt5aapooa52RLuVDDDwjzid/TcvOdpJbcc/4ZwrtzyVzg==
X-Received: by 2002:ac8:5bcb:: with SMTP id b11mr4636430qtb.310.1614873740014;
        Thu, 04 Mar 2021 08:02:20 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id e5sm4763214qtq.1.2021.03.04.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:02:19 -0800 (PST)
Date:   Thu, 4 Mar 2021 11:02:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-man@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 2/4] userfaultfd.2: Add write-protect mode
Message-ID: <20210304160217.GZ397383@xz-x1>
References: <20210304015947.517713-1-peterx@redhat.com>
 <20210304015947.517713-3-peterx@redhat.com>
 <YECCY8MzqAvE44e4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YECCY8MzqAvE44e4@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 08:46:59AM +0200, Mike Rapoport wrote:
> On Wed, Mar 03, 2021 at 08:59:45PM -0500, Peter Xu wrote:
> > Write-protect mode is supported starting from Linux 5.7.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  man2/userfaultfd.2 | 88 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 86 insertions(+), 2 deletions(-)
> > 
> > diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> > index 2d14effc6..8e1602d62 100644
> > --- a/man2/userfaultfd.2
> > +++ b/man2/userfaultfd.2
> > @@ -78,6 +78,28 @@ all memory ranges that were registered with the object are unregistered
> >  and unread events are flushed.
> >  .\"
> >  .PP
> > +Currently, userfaultfd supports two modes of registration:
> > +.TP
> > +.BR UFFDIO_REGISTER_MODE_MISSING
> > +When registered with
> > +.BR UFFDIO_REGISTER_MODE_MISSING
> > +mode, the userspace will receive a page fault message when a missing page is
> > +accessed.  The faulted thread will be stopped from execution until the page
> > +fault is resolved from the userspace by either an
> > +.BR UFFDIO_COPY
> > +or an
> > +.BR UFFDIO_ZEROPAGE
> > +ioctl.
> > +.TP
> > +.BR UFFDIO_REGISTER_MODE_WP
> > +When registered with
> > +.BR UFFDIO_REGISTER_MODE_WP
> > +mode, the userspace will receive a page fault message when a write-protected
> > +page is written.  The faulted thread will be stopped from execution until the
> > +userspace un-write-protect the page using an
> > +.BR UFFDIO_WRITEPROTECT
> > +ioctl.
> > +.PP
> 
> I'd add a sentence about combining the modes together. Something like
> 
> "Both modes can be enabled together for the same memory range"

I mentioned it below [1].  However I agree it's indeed making more sense to
mention it when listing the modes, especially knowing that the 3rd minor mode
is coming.  I think I'll keep both, assuming a bit more verbose is still
acceptable in man pages, but changed to:

"Multiple modes can be enabled at the same time for the same memory range."

> 
> >  Since Linux 4.14, userfaultfd page fault message can selectively embed fault
> >  thread ID information into the fault message.  One needs to enable this feature
> >  explicitly using the
> > @@ -143,6 +165,16 @@ single threaded non-cooperative userfaultfd manager implementations.
> >  .\" and limitations remaining in 4.11
> >  .\" Maybe it's worth adding a dedicated sub-section...
> >  .\"
> > +.PP
> > +Starting from Linux 5.7, userfaultfd is able to do synchronous page dirty
> > +tracking using the new write-protection register mode.  One should check
> > +against the feature bit
> > +.B UFFD_FEATURE_PAGEFAULT_FLAG_WP
> > +before using this feature.  Similar to the original userfaultfd missing mode,
> > +the write-protect mode will generate an userfaultfd message when the protected
> > +page is written.  The user needs to resolve the page fault by unprotecting the
> > +faulted page and kick the faulted thread to continue.  For more information,
> > +please read the "Userfaultfd write-protect mode" section below.
> >  .SS Userfaultfd operation
> >  After the userfaultfd object is created with
> >  .BR userfaultfd (),
> > @@ -218,6 +250,54 @@ userfaultfd can be used only with anonymous private memory mappings.
> >  Since Linux 4.11,
> >  userfaultfd can be also used with hugetlbfs and shared memory mappings.
> >  .\"
> > +.SS Userfaultfd write-protect mode
> > +Since Linux 5.7, userfaultfd started to support write-protect mode.  The user
> 
> Maybe s/started to support/supports/

Sure.

> 
> > +needs to first check availability of this feature using
> > +.BR UFFDIO_API
> > +ioctl against the feature bit
> > +.BR UFFD_FEATURE_PAGEFAULT_FLAG_WP .
> > +.PP
> > +To register with userfaultfd write-protect mode, the user needs to send the
> > +.BR UFFDIO_REGISTER
> > +ioctl with mode
> > +.BR UFFDIO_REGISTER_MODE_WP
> > +set.  Note that it's legal to monitor the same memory range with multiple
> > +modes.  For example, the user can do
> > +.BR UFFDIO_REGISTER
> > +with the mode set to
> > +.BR UFFDIO_REGISTER_MODE_MISSING\ |\ UFFDIO_REGISTER_MODE_WP.

[1]

Thanks,

-- 
Peter Xu

