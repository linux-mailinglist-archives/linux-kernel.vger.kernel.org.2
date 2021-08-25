Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC003F7CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhHYUDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhHYUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:02:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985ACC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:02:13 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n24so552901ion.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNxxVhiR1+voUK1H9WsDHS3laxNpVdBw3hSCKXm8Xpo=;
        b=m/2DnAFMByvXGaU+RM65ZGFo3fjcnLNrj1WDfqsy0NMHNW6HRmkJSa60qwznpcp5VX
         hgZmDqpJOxpkf3Hyj7Vw6hVi9aDZZpjJi7BQeqVy8uFaTR3jtcLA3Eyl8MA7saKwDBOO
         K3Rc+ykJRqagSUr34/RlpLO8F7aBRlHAmt0dn7TkvzLsOWLgeIIeuwaOtG/KY73S1QXj
         x2dFXZiKsUTJ77ZJP1FbRGHw9TjubLX5WHKLMT066OuWLsQ8M8qrUrOQgftGFRmJBYEX
         AzV68U/5u32W5BOA7Yu+K43C0VF21hTF25Tff2pCKiXNcJ7zoy6NOiNqnEiY9w3YL9qL
         ctJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNxxVhiR1+voUK1H9WsDHS3laxNpVdBw3hSCKXm8Xpo=;
        b=SffTVtUy/2dhyEccdC/N2W4wjuiPpHPYGqroYTKCUBuPH4uiWdz96UmyFuQ6D9Kl/9
         Jnk8SuUI0cRdgXz8PjTdKbmTeKxSZIQdttsgX0USc1dyvbBoHBwJ43GPh8vrViyb6y74
         Dp1hyuPouHKb73uz6EhP522K86Ky7O1A88iiAlzbGfw2mof4VLtSTQjFxN4O0BzEmPrp
         ZxGIC2sK9rFVkTABX4uTPGfVBANUD2+5ao7gAeTm+Gc7hlJ176WWICaPP9LjFrpqRPnH
         ChmJHcdjwsUfFNbgay40rpuRcRU3v1Ld1ouAWtupZGkL5pAjTK9zRvg/Iasak6ELu22G
         7q2Q==
X-Gm-Message-State: AOAM5303Uxo4FBjm+wuN77XQbTTV4J2vvzrzcpAHkvWrWpcNWRx7TTgN
        JwN20Y2HadEggs7A0RIjdpGCqvmeWb2FocLM0bI=
X-Google-Smtp-Source: ABdhPJxnkWzzAQCQCqmIWDMi2WUN42Lb6RvKGvVeTLhg+esvzOx7gaOVUJjzi/Awgh9Rn5LOmq3g1ozNVJIYRcPRxFc=
X-Received: by 2002:a6b:f416:: with SMTP id i22mr177674iog.162.1629921730223;
 Wed, 25 Aug 2021 13:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
 <20210726060855.108250-2-pankaj.gupta.linux@gmail.com> <CAPcyv4inCFFXmg0r5+h0O6cADpt9HdboVDEL00XX-wGroy-7LQ@mail.gmail.com>
In-Reply-To: <CAPcyv4inCFFXmg0r5+h0O6cADpt9HdboVDEL00XX-wGroy-7LQ@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 25 Aug 2021 22:01:59 +0200
Message-ID: <CAM9Jb+hqPBFUh9X4sKb9TUGXX1P0mC1xcuCNQx1BYvAvoP9uQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] virtio-pmem: Async virtio-pmem flush
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>, David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the review. Please see my reply inline.

> > Implement asynchronous flush for virtio pmem using work queue
> > to solve the preflush ordering issue. Also, coalesce the flush
> > requests when a flush is already in process.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> > ---
> >  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
> >  drivers/nvdimm/virtio_pmem.c | 10 ++++-
> >  drivers/nvdimm/virtio_pmem.h | 14 +++++++
> >  3 files changed, 79 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index 10351d5b49fa..61b655b583be 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -97,29 +97,69 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> >         return err;
> >  };
> >
> > +static void submit_async_flush(struct work_struct *ws);
> > +
> >  /* The asynchronous flush callback function */
> >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >  {
> > -       /*
> > -        * Create child bio for asynchronous flush and chain with
> > -        * parent bio. Otherwise directly call nd_region flush.
> > +       /* queue asynchronous flush and coalesce the flush requests */
> > +       struct virtio_device *vdev = nd_region->provider_data;
> > +       struct virtio_pmem *vpmem  = vdev->priv;
> > +       ktime_t req_start = ktime_get_boottime();
> > +
> > +       spin_lock_irq(&vpmem->lock);
> > +       /* flush requests wait until ongoing flush completes,
> > +        * hence coalescing all the pending requests.
> >          */
> > -       if (bio && bio->bi_iter.bi_sector != -1) {
> > -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > -
> > -               if (!child)
> > -                       return -ENOMEM;
> > -               bio_copy_dev(child, bio);
> > -               child->bi_opf = REQ_PREFLUSH;
> > -               child->bi_iter.bi_sector = -1;
> > -               bio_chain(child, bio);
> > -               submit_bio(child);
> > -               return 0;
> > +       wait_event_lock_irq(vpmem->sb_wait,
> > +                           !vpmem->flush_bio ||
> > +                           ktime_before(req_start, vpmem->prev_flush_start),
> > +                           vpmem->lock);
> > +       /* new request after previous flush is completed */
> > +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> > +               WARN_ON(vpmem->flush_bio);
> > +               vpmem->flush_bio = bio;
> > +               bio = NULL;
> > +       }
>
> Why the dance with ->prev_flush_start vs just calling queue_work()
> again. queue_work() is naturally coalescing in that if the last work
> request has not started execution another queue attempt will be
> dropped.

How parent flush request will know when corresponding flush is completed?

>
> > +       spin_unlock_irq(&vpmem->lock);
> > +
> > +       if (!bio) {
> > +               INIT_WORK(&vpmem->flush_work, submit_async_flush);
>
> I expect this only needs to be initialized once at driver init time.

yes, will fix this.
>
> > +               queue_work(vpmem->pmem_wq, &vpmem->flush_work);
> > +               return 1;
> > +       }
> > +
> > +       /* flush completed in other context while we waited */
> > +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> > +               bio->bi_opf &= ~REQ_PREFLUSH;
> > +               submit_bio(bio);
> > +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> > +               bio->bi_opf &= ~REQ_FUA;
> > +               bio_endio(bio);
>
> It's not clear to me how this happens, shouldn't all flush completions
> be driven from the work completion?

Requests should progress after notified by ongoing flush completion
event.

>
> >         }
> > -       if (virtio_pmem_flush(nd_region))
> > -               return -EIO;
> >
> >         return 0;
> >  };
> >  EXPORT_SYMBOL_GPL(async_pmem_flush);
> > +
> > +static void submit_async_flush(struct work_struct *ws)
> > +{
> > +       struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
> > +       struct bio *bio = vpmem->flush_bio;
> > +
> > +       vpmem->start_flush = ktime_get_boottime();
> > +       bio->bi_status = errno_to_blk_status(virtio_pmem_flush(vpmem->nd_region));
> > +       vpmem->prev_flush_start = vpmem->start_flush;
> > +       vpmem->flush_bio = NULL;
> > +       wake_up(&vpmem->sb_wait);
> > +
> > +       /* Submit parent bio only for PREFLUSH */
> > +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> > +               bio->bi_opf &= ~REQ_PREFLUSH;
> > +               submit_bio(bio);
> > +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> > +               bio->bi_opf &= ~REQ_FUA;
> > +               bio_endio(bio);
> > +       }
>
> Shouldn't the wait_event_lock_irq() be here rather than in
> async_pmem_flush()? That will cause the workqueue to back up and flush
> requests to coalesce.

but this is coalesced flush request?

> > +}
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > index 726c7354d465..56780a6140c7 100644
> > --- a/drivers/nvdimm/virtio_pmem.c
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
> >                 return PTR_ERR(vpmem->req_vq);
> >
> >         spin_lock_init(&vpmem->pmem_lock);
> > +       spin_lock_init(&vpmem->lock);
>
> Why 2 locks?

One lock is for work queue and other for virtio flush completion.

Thanks,
Pankaj
