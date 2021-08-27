Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC85C3FA068
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhH0UQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhH0UQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630095325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HPb99jdBHWWwZoOoJx4DYlHRxXpqGr7CeJ8g3kuHA2w=;
        b=HmuUwoikKHgRCLWRS80tYjq/FOYmSYZY8UFkP2Z/0n06TGMJP0JTrGlxwmBTPJDYADAFey
        1eWSM1dFF2Jl5kOG8ErXz96nkeRPk9uarZADlHmyRtBZFctnn2yo8H7/06t5wPyqsqKQVR
        /TusHsBF8DB/hLwEUBQHQnq/4SJRkI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-OQw1AvAqO7u6dyLenyfxow-1; Fri, 27 Aug 2021 16:15:24 -0400
X-MC-Unique: OQw1AvAqO7u6dyLenyfxow-1
Received: by mail-wm1-f71.google.com with SMTP id b207-20020a1c80d8000000b002ea321114f7so1741998wmd.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPb99jdBHWWwZoOoJx4DYlHRxXpqGr7CeJ8g3kuHA2w=;
        b=G1AW6aHTOmb2Z2bVDTv19PFLHPHVf7kgBTtOfjR21/K0eu28t3powpfFqoXn00YOk+
         VvbvSHtcaYSKo9I2teRL1y4nUl7xYqyBzEKWtRq84G+wJvfqstgU+iM2FeF4f+8sr1I9
         0WDpOQj0KxeMTxIeyLGd10Skunv6DFoORTHXIk6mUdAk32Nvq5LR6hhRAxmaCT/wLN1Y
         Z8+7EVKQVGHcAwMatttnzxzSdwvx4wha1IvjKNRoyAnqpBzqE11Gg3EWRUrA9uay9FAL
         eYIRAAQxppkkIBnfcDTNbYloda2RJ+mNhfs7tcVWg1jX0evZPlkV6kx/m21XM3phpdku
         bzig==
X-Gm-Message-State: AOAM530DxoObplkr+5+yXHzRopftX4hoMq44GzMSEaeRINEuK+/q/KnN
        I+1cG7xtaB2bSX17XB7aXijnTaR5dxZiZVi+XTAXGNsFJ8QwrcgfGeQApyrC0vAOUwBrWWj01QY
        q+hZ4tMfkMudCwgrHDN6UQ+nAuvgT8zLx1O7bhMIx
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr12178838wrb.329.1630095323222;
        Fri, 27 Aug 2021 13:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQuLJGTZkuQZAWubDFIrgljQpy/a8esqpgEQ1rq5xrxLzns1d6V0QwGi6NICYdNz2zs1b+2fAkaDaaEjwYthk=
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr12178813wrb.329.1630095322929;
 Fri, 27 Aug 2021 13:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-17-agruenba@redhat.com>
 <20210827183018.GJ12664@magnolia>
In-Reply-To: <20210827183018.GJ12664@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 27 Aug 2021 22:15:11 +0200
Message-ID: <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 8:30 PM Darrick J. Wong <djwong@kernel.org> wrote:
> On Fri, Aug 27, 2021 at 06:49:23PM +0200, Andreas Gruenbacher wrote:
> > Add a done_before argument to iomap_dio_rw that indicates how much of
> > the request has already been transferred.  When the request succeeds, we
> > report that done_before additional bytes were tranferred.  This is
> > useful for finishing a request asynchronously when part of the request
> > has already been completed synchronously.
> >
> > We'll use that to allow iomap_dio_rw to be used with page faults
> > disabled: when a page fault occurs while submitting a request, we
> > synchronously complete the part of the request that has already been
> > submitted.  The caller can then take care of the page fault and call
> > iomap_dio_rw again for the rest of the request, passing in the number of
> > bytes already tranferred.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/btrfs/file.c       |  5 +++--
> >  fs/ext4/file.c        |  5 +++--
> >  fs/gfs2/file.c        |  4 ++--
> >  fs/iomap/direct-io.c  | 11 ++++++++---
> >  fs/xfs/xfs_file.c     |  6 +++---
> >  fs/zonefs/super.c     |  4 ++--
> >  include/linux/iomap.h |  4 ++--
> >  7 files changed, 23 insertions(+), 16 deletions(-)
> >
>
> <snip to the interesting parts>
>
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index ba88fe51b77a..dcf9a2b4381f 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -31,6 +31,7 @@ struct iomap_dio {
> >       atomic_t                ref;
> >       unsigned                flags;
> >       int                     error;
> > +     size_t                  done_before;
> >       bool                    wait_for_completion;
> >
> >       union {
> > @@ -126,6 +127,9 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >       if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> >               ret = generic_write_sync(iocb, ret);
> >
> > +     if (ret > 0)
> > +             ret += dio->done_before;
>
> Pardon my ignorance since this is the first time I've had a crack at
> this patchset, but why is it necessary to carry the "bytes copied"
> count from the /previous/ iomap_dio_rw call all the way through to dio
> completion of the current call?

Consider the following situation:

 * A user submits an asynchronous read request.

 * The first page of the buffer is in memory, but the following
   pages are not. This isn't uncommon for consecutive reads
   into freshly allocated memory.

 * iomap_dio_rw writes into the first page. Then it
   hits the next page which is missing, so it returns a partial
   result, synchronously.

 * We then fault in the remaining pages and call iomap_dio_rw
   for the rest of the request.

 * The rest of the request completes asynchronously.

Does that answer your question?

Thanks,
Andreas

