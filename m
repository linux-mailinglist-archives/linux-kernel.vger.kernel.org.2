Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63543F9916
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 14:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbhH0Mkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0Mka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:40:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1EC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 05:39:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l2so5971288lfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSCVAOdTzS6of67hqwXXSt/v4Q5zwDeqrRZRMqtOo4o=;
        b=e1H4CnN0oVEEbKadjd940jNGpQ+4i9Is62sT4sD9RRPkpJVz//9sGynYDjUvr7qOqY
         9+KZGi3nY6T3oO/klS2IhsDOR1ubpDzwNM0mGlITPJknlP/5lu5G+jOGUB8w4yh375z8
         uUKOkX9MsDLDLQ+nCmgyS3p0++5c4UvqcciD12MAtYATXCJUM2KDAOYv7LLHK5YGTNiZ
         7xe/lJg6+6fUoeLam6qlFtW4PTe5pGiTyAbnQ628L/BHbe+2n/o+7BiK1VLvKMxMTRTW
         tuaOlJ3+A/24VY84DEXxONhu+KShaH4VqtEyFcis1ZvpKPS4XD4TF7G5IF0XmsA+xZMS
         hlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSCVAOdTzS6of67hqwXXSt/v4Q5zwDeqrRZRMqtOo4o=;
        b=BYSklynCyteVimAA3QdOdFHfan3WAxV7FLkACKoDVSwxnbk0Nxg+DRC7L3Z12npWJF
         JVp9faY59ooa+7jyYtP4hBPUA5rchUEzhX4pJSaT4jETmzgdsyjlYBvHUcpfUyTmsvII
         V2ko0xt91bb+60ZTaKULrjCJpzvPPJVprXLloTK+jW1+1D1a+8t8NtQr/xFiMYnf2t8V
         k69X7gXeYJaOh/xBNmUzZ780HH72ns1J5+OoDdHGe7afCVeFrfUZI0dkLOCM/+lo/jZm
         hYTD7XlPv8s3o0suiVzb46Xi0yudcXZqKDo8eL9GTMgVCY+67+m1RD3oOrbjsKeBc2kV
         2C/A==
X-Gm-Message-State: AOAM531KqyQuMUGq6PtjguJs3EWGAq+JePfwLLigTF7H1RxUO1OimjF3
        ovNCXamENB7X+C+s+BYnDhP4UW3yeHc6BqpuJP4iFQ==
X-Google-Smtp-Source: ABdhPJxb8nP92sVAh62cKernHOP1MWRfQb68gcojS0Hh9rRTVhgY8RCAwZxU1/qQehPnXDTY0/jHdLv2Pp4Pb8OtBtE=
X-Received: by 2002:a19:5f0d:: with SMTP id t13mr6558353lfb.229.1630067979561;
 Fri, 27 Aug 2021 05:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
 <20210726060855.108250-2-pankaj.gupta.linux@gmail.com> <CAPcyv4inCFFXmg0r5+h0O6cADpt9HdboVDEL00XX-wGroy-7LQ@mail.gmail.com>
 <CAM9Jb+hqPBFUh9X4sKb9TUGXX1P0mC1xcuCNQx1BYvAvoP9uQg@mail.gmail.com>
 <CAPcyv4gUG1-y1u0ZyUkSGXg0eER_oTdexb8n-CYgb_rURvr8LA@mail.gmail.com>
 <CALzYo32AnNzENe414GDVivaF5wXQ7azaysBYkN9wHVYEW27NPw@mail.gmail.com> <CAPcyv4idY7GDYjXsvjduQ4rjfKo-qDgQoj5r6=Rr9poXqHEzeg@mail.gmail.com>
In-Reply-To: <CAPcyv4idY7GDYjXsvjduQ4rjfKo-qDgQoj5r6=Rr9poXqHEzeg@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta@ionos.com>
Date:   Fri, 27 Aug 2021 14:39:28 +0200
Message-ID: <CALzYo315CXhcO2Dph010WazWBYkaAeEuGdjUFDnJcsVBDa5LNQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] virtio-pmem: Async virtio-pmem flush
To:     Dan Williams <dan.j.williams@intel.com>
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

> > > > > > Implement asynchronous flush for virtio pmem using work queue
> > > > > > to solve the preflush ordering issue. Also, coalesce the flush
> > > > > > requests when a flush is already in process.
> > > > > >
> > > > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> > > > > > ---
> > > > > >  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
> > > > > >  drivers/nvdimm/virtio_pmem.c | 10 ++++-
> > > > > >  drivers/nvdimm/virtio_pmem.h | 14 +++++++
> > > > > >  3 files changed, 79 insertions(+), 17 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > > > > index 10351d5b49fa..61b655b583be 100644
> > > > > > --- a/drivers/nvdimm/nd_virtio.c
> > > > > > +++ b/drivers/nvdimm/nd_virtio.c
> > > > > > @@ -97,29 +97,69 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> > > > > >         return err;
> > > > > >  };
> > > > > >
> > > > > > +static void submit_async_flush(struct work_struct *ws);
> > > > > > +
> > > > > >  /* The asynchronous flush callback function */
> > > > > >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > > > > >  {
> > > > > > -       /*
> > > > > > -        * Create child bio for asynchronous flush and chain with
> > > > > > -        * parent bio. Otherwise directly call nd_region flush.
> > > > > > +       /* queue asynchronous flush and coalesce the flush requests */
> > > > > > +       struct virtio_device *vdev = nd_region->provider_data;
> > > > > > +       struct virtio_pmem *vpmem  = vdev->priv;
> > > > > > +       ktime_t req_start = ktime_get_boottime();
> > > > > > +
> > > > > > +       spin_lock_irq(&vpmem->lock);
> > > > > > +       /* flush requests wait until ongoing flush completes,
> > > > > > +        * hence coalescing all the pending requests.
> > > > > >          */
> > > > > > -       if (bio && bio->bi_iter.bi_sector != -1) {
> > > > > > -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > > > > > -
> > > > > > -               if (!child)
> > > > > > -                       return -ENOMEM;
> > > > > > -               bio_copy_dev(child, bio);
> > > > > > -               child->bi_opf = REQ_PREFLUSH;
> > > > > > -               child->bi_iter.bi_sector = -1;
> > > > > > -               bio_chain(child, bio);
> > > > > > -               submit_bio(child);
> > > > > > -               return 0;
> > > > > > +       wait_event_lock_irq(vpmem->sb_wait,
> > > > > > +                           !vpmem->flush_bio ||
> > > > > > +                           ktime_before(req_start, vpmem->prev_flush_start),
> > > > > > +                           vpmem->lock);
> > > > > > +       /* new request after previous flush is completed */
> > > > > > +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> > > > > > +               WARN_ON(vpmem->flush_bio);
> > > > > > +               vpmem->flush_bio = bio;
> > > > > > +               bio = NULL;
> > > > > > +       }
> > > > >
> > > > > Why the dance with ->prev_flush_start vs just calling queue_work()
> > > > > again. queue_work() is naturally coalescing in that if the last work
> > > > > request has not started execution another queue attempt will be
> > > > > dropped.
> > > >
> > > > How parent flush request will know when corresponding flush is completed?
> > >
> > > The eventual bio_endio() is what signals upper layers that the flush
> > > completed...
> > >
> > >
> > > Hold on... it's been so long that I forgot that you are copying
> > > md_flush_request() here. It would help immensely if that was mentioned
> > > in the changelog and at a minimum have a comment in the code that this
> > > was copied from md. In fact it would be extra helpful if you
> >
> > My bad. I only mentioned this in the cover letter.
>
> Yeah, sorry about that. Having come back to this after so long I just
> decided to jump straight into the patches, but even if I had read that
> cover I still would have given the feedback that md_flush_request()
> heritage should also be noted with a comment in the code.

Sure.

Thanks,
Pankaj
