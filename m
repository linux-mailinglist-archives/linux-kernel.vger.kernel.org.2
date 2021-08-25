Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72AB3F7E30
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhHYWJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhHYWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:09:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F85C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:08:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y11so841520pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NZNUzkwqV8FV6bts50PDqCVbYsdeI9DWpW3UuuSetQ=;
        b=H9bYH617YjERR4qzzuhHKRD1sRRQFu+Q1Jh64kJ1djlfDal40fY+iY87u0l9uJoll9
         qKsSebVBrXVCpOAl8hvLF4LtB9qq5pdwDXayqDjbt2sUyexsxQbLG62BB3WNpfD87xZG
         IVyDddf9ZPTBcoPNghKtAs9E6jlQ28nDWusY81EErhC9J7IxJxP7uwjAdgVMD8py+u1P
         nxTuWeiGOBc+Tfc1qeRQ2kq5o5K9WUw6NdaVl+u6l7blBulIUS1a0b8Q01jOTrYRv73M
         znQKQv6MK8THCvnQOstYHUHj9L24gqn6pk51HjKJEQG0bWnijVmLYjUAaUC1yNQfLkfP
         bq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NZNUzkwqV8FV6bts50PDqCVbYsdeI9DWpW3UuuSetQ=;
        b=IUTCdwRhhKG42xwhjaDFiNMl6n4e20vOhPLaBv2ouwj4dgIDw5l1K7oUomrzKdsR64
         MOSaa2hWNRgLh7Bs/l9IeExij4CgLzrw+TSgS69HYMcvSh76bLIi/P6A7KkrN747WhyM
         /rs+mZKGIig1wwm5i3Uf1ggOQw+hpj5OH7VARAcY5bIm7JERQ5SO1C4/dX7T7T046uYt
         Buzk3y8czsP4pXYdw8f70TUcCGoojr6Fw3b80YuIbVAnVRCrkZofyawyUTQV2E97r2qH
         1naBIjCWnbP/Icdx8ls5j3MBN9z1KKynwyS5ygBZwr8ps0Ok4H6fwHrhGwonzUWuO05j
         iUnQ==
X-Gm-Message-State: AOAM532eM7lfjLdH4+XzPASzUQfDJAsNwQwOV+Qiqkxe24tzZ+qtX/bN
        xcgurxt+1ECEFA2AEis8/NbNy6qmnh1zhfrQIGYf3A==
X-Google-Smtp-Source: ABdhPJw2KP0i89pMalH0wosmc6VWGByLDHoPtHP3Rvh3Nqhuz6fCxv+quhVvh9yLawfYIETYtZ7Iyp0W5bbg6cwoq38=
X-Received: by 2002:a65:6642:: with SMTP id z2mr353069pgv.240.1629929320968;
 Wed, 25 Aug 2021 15:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
 <20210726060855.108250-2-pankaj.gupta.linux@gmail.com> <CAPcyv4inCFFXmg0r5+h0O6cADpt9HdboVDEL00XX-wGroy-7LQ@mail.gmail.com>
 <CAM9Jb+hqPBFUh9X4sKb9TUGXX1P0mC1xcuCNQx1BYvAvoP9uQg@mail.gmail.com>
 <CAPcyv4gUG1-y1u0ZyUkSGXg0eER_oTdexb8n-CYgb_rURvr8LA@mail.gmail.com> <CALzYo32AnNzENe414GDVivaF5wXQ7azaysBYkN9wHVYEW27NPw@mail.gmail.com>
In-Reply-To: <CALzYo32AnNzENe414GDVivaF5wXQ7azaysBYkN9wHVYEW27NPw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 15:08:30 -0700
Message-ID: <CAPcyv4idY7GDYjXsvjduQ4rjfKo-qDgQoj5r6=Rr9poXqHEzeg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] virtio-pmem: Async virtio-pmem flush
To:     Pankaj Gupta <pankaj.gupta@ionos.com>
Cc:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>, David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 3:01 PM Pankaj Gupta <pankaj.gupta@ionos.com> wrote:
>
> > > Hi Dan,
> > >
> > > Thank you for the review. Please see my reply inline.
> > >
> > > > > Implement asynchronous flush for virtio pmem using work queue
> > > > > to solve the preflush ordering issue. Also, coalesce the flush
> > > > > requests when a flush is already in process.
> > > > >
> > > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> > > > > ---
> > > > >  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
> > > > >  drivers/nvdimm/virtio_pmem.c | 10 ++++-
> > > > >  drivers/nvdimm/virtio_pmem.h | 14 +++++++
> > > > >  3 files changed, 79 insertions(+), 17 deletions(-)
> > > > >
> > > > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > > > index 10351d5b49fa..61b655b583be 100644
> > > > > --- a/drivers/nvdimm/nd_virtio.c
> > > > > +++ b/drivers/nvdimm/nd_virtio.c
> > > > > @@ -97,29 +97,69 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> > > > >         return err;
> > > > >  };
> > > > >
> > > > > +static void submit_async_flush(struct work_struct *ws);
> > > > > +
> > > > >  /* The asynchronous flush callback function */
> > > > >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > > > >  {
> > > > > -       /*
> > > > > -        * Create child bio for asynchronous flush and chain with
> > > > > -        * parent bio. Otherwise directly call nd_region flush.
> > > > > +       /* queue asynchronous flush and coalesce the flush requests */
> > > > > +       struct virtio_device *vdev = nd_region->provider_data;
> > > > > +       struct virtio_pmem *vpmem  = vdev->priv;
> > > > > +       ktime_t req_start = ktime_get_boottime();
> > > > > +
> > > > > +       spin_lock_irq(&vpmem->lock);
> > > > > +       /* flush requests wait until ongoing flush completes,
> > > > > +        * hence coalescing all the pending requests.
> > > > >          */
> > > > > -       if (bio && bio->bi_iter.bi_sector != -1) {
> > > > > -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > > > > -
> > > > > -               if (!child)
> > > > > -                       return -ENOMEM;
> > > > > -               bio_copy_dev(child, bio);
> > > > > -               child->bi_opf = REQ_PREFLUSH;
> > > > > -               child->bi_iter.bi_sector = -1;
> > > > > -               bio_chain(child, bio);
> > > > > -               submit_bio(child);
> > > > > -               return 0;
> > > > > +       wait_event_lock_irq(vpmem->sb_wait,
> > > > > +                           !vpmem->flush_bio ||
> > > > > +                           ktime_before(req_start, vpmem->prev_flush_start),
> > > > > +                           vpmem->lock);
> > > > > +       /* new request after previous flush is completed */
> > > > > +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> > > > > +               WARN_ON(vpmem->flush_bio);
> > > > > +               vpmem->flush_bio = bio;
> > > > > +               bio = NULL;
> > > > > +       }
> > > >
> > > > Why the dance with ->prev_flush_start vs just calling queue_work()
> > > > again. queue_work() is naturally coalescing in that if the last work
> > > > request has not started execution another queue attempt will be
> > > > dropped.
> > >
> > > How parent flush request will know when corresponding flush is completed?
> >
> > The eventual bio_endio() is what signals upper layers that the flush
> > completed...
> >
> >
> > Hold on... it's been so long that I forgot that you are copying
> > md_flush_request() here. It would help immensely if that was mentioned
> > in the changelog and at a minimum have a comment in the code that this
> > was copied from md. In fact it would be extra helpful if you
>
> My bad. I only mentioned this in the cover letter.

Yeah, sorry about that. Having come back to this after so long I just
decided to jump straight into the patches, but even if I had read that
cover I still would have given the feedback that md_flush_request()
heritage should also be noted with a comment in the code.
