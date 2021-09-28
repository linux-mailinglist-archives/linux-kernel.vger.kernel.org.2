Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D341B888
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbhI1Unh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242758AbhI1Unf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632861715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jBAm38dwxejV13EKa37YtYOLD3eWnXj6fegh8i3dws=;
        b=TCmNhzhJIDp+RWK9J8D/uuY8feQCBW1SvyGxCHTs4rMZfSGqu9x+aH0Sbp6CdeUWKSxa0W
        UZABLG6CF72QbbtPrvwQfyrgYBtcNYe/ul0OtzSf7ZLcz1k0w7VjNCEXk6NE3ycfFu7AX0
        unU1PKimeWN1hGyoiypXABXtOPIMVY4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-ksNYxm9JNP-1HweBUFoh5Q-1; Tue, 28 Sep 2021 16:41:54 -0400
X-MC-Unique: ksNYxm9JNP-1HweBUFoh5Q-1
Received: by mail-wm1-f72.google.com with SMTP id c77-20020a1c9a50000000b0030d06638a56so1223976wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jBAm38dwxejV13EKa37YtYOLD3eWnXj6fegh8i3dws=;
        b=BbvnlcuAAMRrX0DU9CvBT5xmBhn3afxexZ8yDlVnBbIGWD78wdJD3KXPK8rojBhHMD
         000AVuJXnceSu+D4W3GAeBPot1gQM77c/PF2Dwej7QcuPWuLQSIuj/whzHw/2hgucoGj
         Z+2mfS83OY1pYmmmQcjArJqvRtP41bo0t7NByo5/x5O9F9jU4g6/NeC4C+kHHoeUw5ev
         PxFsyV72QAGsRdKQMx7OHIyp7q73zmwVfWehfY8MPIlt3BXr6gXFqfcNCzFM5QYhLoW9
         wKh1s0+1Ot5m4AyysUTICX1rMJWGfxE7da7jdnKkMmRkrCy4DQdKbZ7Y8zqUnHfcha7b
         FRJA==
X-Gm-Message-State: AOAM533dX4t7cPESs/lGMTRspBw4nCVhnkykZO9Hlqfg0O7Iww6gZEnz
        RnFikvt3Y2K2tIPfjwUJ1ohtNsKTiCCUL0svFdHcD9PYne3QjObhpP7BJQ55KyOx0Qq9VzLBeLD
        Qy/hE9meowEfHy+sItdYwi3Hp5VTaqAQ8dXDH7np2
X-Received: by 2002:adf:fe11:: with SMTP id n17mr2531998wrr.134.1632861713037;
        Tue, 28 Sep 2021 13:41:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ3DYdqCR9Z5PcqKHy1xm32GHNEUBLV2gDJNFBOzxHyUdTS2vH5aXkMEboVTXvHTdpTp6sggiL9+bBSwcUm1A=
X-Received: by 2002:adf:fe11:: with SMTP id n17mr2531978wrr.134.1632861712811;
 Tue, 28 Sep 2021 13:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-4-agruenba@redhat.com>
 <CAL3q7H7PdBTuK28tN=3fGUyTP9wJU8Ydrq35YtNsfA_3xRQhzQ@mail.gmail.com>
 <CAHc6FU7rbdJxeuvoz0jov5y_GH_B4AtjkDnbNyOxeeNc1Zw5+A@mail.gmail.com> <YVNE4HGKPb7bw+En@casper.infradead.org>
In-Reply-To: <YVNE4HGKPb7bw+En@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Sep 2021 22:41:41 +0200
Message-ID: <CAHc6FU47kX=P2VhjAxk-7hqiKoEHUMMzbC-8vRYfWXUVs9zAtQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/19] gup: Turn fault_in_pages_{readable,writeable}
 into fault_in_{readable,writeable}
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fdmanana@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Tue, Sep 28, 2021 at 6:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Sep 28, 2021 at 05:02:43PM +0200, Andreas Gruenbacher wrote:
> > On Fri, Sep 3, 2021 at 4:57 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > > On Fri, Aug 27, 2021 at 5:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > > +size_t fault_in_writeable(char __user *uaddr, size_t size)
> > > > +{
> > > > +       char __user *start = uaddr, *end;
> > > > +
> > > > +       if (unlikely(size == 0))
> > > > +               return 0;
> > > > +       if (!PAGE_ALIGNED(uaddr)) {
> > > > +               if (unlikely(__put_user(0, uaddr) != 0))
> > > > +                       return size;
> > > > +               uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
> > > > +       }
> > > > +       end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
> > > > +       if (unlikely(end < start))
> > > > +               end = NULL;
> > > > +       while (uaddr != end) {
> > > > +               if (unlikely(__put_user(0, uaddr) != 0))
> > > > +                       goto out;
> > > > +               uaddr += PAGE_SIZE;
> > >
> > > Won't we loop endlessly or corrupt some unwanted page when 'end' was
> > > set to NULL?
> >
> > What do you mean? We set 'end' to NULL when start + size < start
> > exactly so that the loop will stop when uaddr wraps around.
>
> But think about x86-64.  The virtual address space (unless you have 5
> level PTs) looks like:
>
> [0, 2^47)               userspace
> [2^47, 2^64 - 2^47)     hole
> [2^64 - 2^47, 2^64)     kernel space
>
> If we try to copy from the hole we'll get some kind of fault (I forget
> the details).  We have to stop at the top of userspace.

If you look at the before and after state of this patch,
fault_in_pages_readable and fault_in_pages_writeable did fail an
attempt to fault in a range that wraps with -EFAULT. That's sensible
for a function that returns an all-or-nothing result. We now want to
return how much of the range was (or wasn't) faulted in. We could do
that and still reject ranges that wrap outright. Or we could try to
fault in however much we reasonably can even if the range wraps. The
patch tries the latter, which is where the stopping at NULL is coming
from: when the range wraps, we *definitely* don't want to go any
further.

If the range extends into the hole, we'll get a failure from
__get_user or __put_user where that happens. That's entirely the
expected result, isn't it?

Thanks,
Andreas

