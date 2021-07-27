Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228B93D7412
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhG0LOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236318AbhG0LOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627384442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afrSbaGGjeeVykwqXymNzbcEw/D8kWccnFVpP7E5Guw=;
        b=ej9DgGZ9d+PoFi/f2r8vB/M/mnLAXhtHdUgtalgc4GFNVbiNUzG0Lah7+P7B14EUGLGL2+
        5/hMvVbPCeyzjHvpk4JxnT8YY/VauD45Urn1NjL4MeA61DVWrQCASdXDR6FdkRDk3UGGUL
        gJVkh4E+IfWQ7v58BbkirBVdp4tW2rc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-gpvx7ylEMrCZ-6aPNDkaxg-1; Tue, 27 Jul 2021 07:14:00 -0400
X-MC-Unique: gpvx7ylEMrCZ-6aPNDkaxg-1
Received: by mail-wr1-f70.google.com with SMTP id f6-20020adfe9060000b0290153abe88c2dso1595400wrm.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afrSbaGGjeeVykwqXymNzbcEw/D8kWccnFVpP7E5Guw=;
        b=fROZoGYZpwpAdlbjjlLK9O45WFgP9EmprTas9hofpOUvuuYnTc6oEolX41i42Q9rHH
         Mx/g9mQ56yD+NahDzVfMBOr8HKV6vSZbuR4jt9pfhNbLE7ukMkFoe36uLIjQdiGOdDJ/
         VAI2wOWf/YRcwV6qpBWhE4194OI85O2J6Z1ccTcHHqYwzv+7Z26lcTuTtVBl9BaM206P
         UCselasYw1+XVQMO7zjUQXK0XHDmis24XExkEpfSb6lRpgfiwMnxXUPjoLzbWh4INtud
         ACtkdZujBswrlFk8SJmBTU+AQLzpde1ft9e+7ZwxzvUC4vw5TIKWPg//Ggt71JokewqC
         vfmg==
X-Gm-Message-State: AOAM531zS2/XyKtdxc5ZlYm5TcifH25sJPtVmh0oURZt4ZfuRrkGOzQn
        34lFnsKK4LhPoz5/oL89qyP0QGOscz0aMowuNAYpQzCa0oO9SPMCdpcofkqn4ogNuwYW7DSLxaX
        AaygBzZy6BySuc0jo1k4QQIpZF3bnYzPDlD8BkGs/
X-Received: by 2002:a1c:2282:: with SMTP id i124mr21633323wmi.166.1627384439576;
        Tue, 27 Jul 2021 04:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzfklfZGsBuVC9rf1FJG+V3aLBjS+SfsovPyqckWGhLMBFH25HVSmfqV0mFgBo9h9VeIN01a4/gyJ0JOvSo60=
X-Received: by 2002:a1c:2282:: with SMTP id i124mr21633303wmi.166.1627384439403;
 Tue, 27 Jul 2021 04:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com> <03e0541400e946cf87bc285198b82491@AcuMS.aculab.com>
In-Reply-To: <03e0541400e946cf87bc285198b82491@AcuMS.aculab.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 27 Jul 2021 13:13:47 +0200
Message-ID: <CAHc6FU4N7vz+jfoUSa45Mr_F0Ht0_PXroWoc5UNkMgFmpKLaNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:30 AM David Laight <David.Laight@aculab.com> wrote:
> From: Linus Torvalds
> > Sent: 24 July 2021 20:53
> >
> > On Sat, Jul 24, 2021 at 12:35 PM Andreas Gruenbacher
> > <agruenba@redhat.com> wrote:
> > >
> > > +int iov_iter_fault_in_writeable(const struct iov_iter *i, size_t bytes)
> > > +{
> > ...
> > > +                       if (fault_in_user_pages(start, len, true) != len)
> > > +                               return -EFAULT;
> >
> > Looking at this once more, I think this is likely wrong.
> >
> > Why?
> >
> > Because any user can/should only care about at least *part* of the
> > area being writable.
> >
> > Imagine that you're doing a large read. If the *first* page is
> > writable, you should still return the partial read, not -EFAULT.
>
> My 2c...
>
> Is it actually worth doing any more than ensuring the first byte
> of the buffer is paged in before entering the block that has
> to disable page faults?

We definitely do want to process as many pages as we can, especially
if allocations are involved during a write.

> Most of the all the pages are present so the IO completes.

That's not guaranteed. There are cases in which none of the pages are
present, and then there are cases in which only the first page is
present (for example, because of a previous access that wasn't page
aligned).

> The pages can always get unmapped (due to page pressure or
> another application thread unmapping them) so there needs
> to be a retry loop.
> Given the cost of actually faulting in a page going around
> the outer loop may not matter.
> Indeed, if an application has just mmap()ed in a very large
> file and is then doing a write() from it then it is quite
> likely that the pages got unmapped!
>
> Clearly there needs to be extra code to ensure progress is made.
> This might actually require the use of 'bounce buffers'
> for really problematic user requests.

I'm not sure if repeated unmapping of the pages that we've just
faulted in is going to be a problem (in terms of preventing progress).
But a suitable heuristic might be to shrink the fault-in "window" on
each retry until it's only one page.

> I also wonder what actually happens for pipes and fifos.
> IIRC reads and write of up to PIPE_MAX (typically 4096)
> are expected to be atomic.
> This should be true even if there are page faults part way
> through the copy_to/from_user().
>
> It has to be said I can't see any reference to PIPE_MAX
> in the linux man pages, but I'm sure it is in the POSIX/TOG
> spec.
>
>         David

Thanks,
Andreas

