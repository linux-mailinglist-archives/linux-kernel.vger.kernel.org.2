Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF0A3F7DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhHYVvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:51:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D10C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:50:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so5033228pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gljV3X+X4bcwcQ/X8uaiX4fSjzUiwO9jzr2JlYeYJ/Q=;
        b=eIe+Cu5Qjp2Vl97D+4LwgaQOmHr58x6p4ed/bciRqULxLtcx+2DM2xenPiGmP64ooH
         4UQzFmoIRwN4M53n04lIeG0eArNxM/c0W/+N6WjA1XsRO4ED16HGXVEmnSuHTOm9Tybr
         eKX0jaL/wKY3vItRJcMJtO1Q52ODeKQFJeUQYvQI5Srj4UxjW8yZypx7SBMqFzBoJ2pV
         wxee9r5NzwLqys+VSSp7Z7tvw7QvCwk2IkBip6QfpHwFqMZ/Ts+PQoWNveYheRbsJVoi
         loXfNAFtuRcW7kUeTXZcatz8UV/LM+vDtbayO4Wd4ztixnYrOY1k6JDWTw5UM5OFakv2
         90TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gljV3X+X4bcwcQ/X8uaiX4fSjzUiwO9jzr2JlYeYJ/Q=;
        b=MqHtIzP0XkjViSSRHqBcY1IHGJzUMDvDx+yJA6QbRda/BxQWvVYdKmYS4BYTUW2L5a
         vuJXrX2kXtjfwNxvyvlYOe20r/N7BzuQj1hvx1n1lG8UkxoK7xBG/ry8jM4d4yjR2Gcg
         SnQHwb9C82xEZywn94MGjcIDV/Epi2yToc8ZGKWTP6i23eMW+WNsuph92V2jUpZDmvq4
         hrcjWhdtr0bPWzawpuYlwfrJtwUvOtlt9ZNVeCSZiwRFYpppa8ckxkZ27eJILWBHArog
         f/b4pQXhXvj4d4ICiMSBKg5OpcIL6srWlicBuO6jKJRJka70Aqs8vh/zaGKzOyDqUjIl
         gp2w==
X-Gm-Message-State: AOAM53171axyqHOSjMzGTlBERfvZWxtkO6hw5/FOzziF3Fn7Ovc0Lo7l
        bmuRPvoZoqNPgJnDsLWoU9JSejVH+hzF+mbhneJZtJ0ukGrQYg==
X-Google-Smtp-Source: ABdhPJwoEKzFBbH3OVx9BphGbywbL+BVEhVsHKGJpbnIABdGEF8xoAhf7jkbiVSsY9kNWunFvIKniut7EFRcHCGA1qI=
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr4259027pji.149.1629928233668;
 Wed, 25 Aug 2021 14:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
 <20210726060855.108250-2-pankaj.gupta.linux@gmail.com> <CAPcyv4inCFFXmg0r5+h0O6cADpt9HdboVDEL00XX-wGroy-7LQ@mail.gmail.com>
 <CAM9Jb+hqPBFUh9X4sKb9TUGXX1P0mC1xcuCNQx1BYvAvoP9uQg@mail.gmail.com>
In-Reply-To: <CAM9Jb+hqPBFUh9X4sKb9TUGXX1P0mC1xcuCNQx1BYvAvoP9uQg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 14:50:22 -0700
Message-ID: <CAPcyv4gUG1-y1u0ZyUkSGXg0eER_oTdexb8n-CYgb_rURvr8LA@mail.gmail.com>
Subject: Re: [RFC v2 1/2] virtio-pmem: Async virtio-pmem flush
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
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

On Wed, Aug 25, 2021 at 1:02 PM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> Hi Dan,
>
> Thank you for the review. Please see my reply inline.
>
> > > Implement asynchronous flush for virtio pmem using work queue
> > > to solve the preflush ordering issue. Also, coalesce the flush
> > > requests when a flush is already in process.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> > > ---
> > >  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
> > >  drivers/nvdimm/virtio_pmem.c | 10 ++++-
> > >  drivers/nvdimm/virtio_pmem.h | 14 +++++++
> > >  3 files changed, 79 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > index 10351d5b49fa..61b655b583be 100644
> > > --- a/drivers/nvdimm/nd_virtio.c
> > > +++ b/drivers/nvdimm/nd_virtio.c
> > > @@ -97,29 +97,69 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> > >         return err;
> > >  };
> > >
> > > +static void submit_async_flush(struct work_struct *ws);
> > > +
> > >  /* The asynchronous flush callback function */
> > >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > >  {
> > > -       /*
> > > -        * Create child bio for asynchronous flush and chain with
> > > -        * parent bio. Otherwise directly call nd_region flush.
> > > +       /* queue asynchronous flush and coalesce the flush requests */
> > > +       struct virtio_device *vdev = nd_region->provider_data;
> > > +       struct virtio_pmem *vpmem  = vdev->priv;
> > > +       ktime_t req_start = ktime_get_boottime();
> > > +
> > > +       spin_lock_irq(&vpmem->lock);
> > > +       /* flush requests wait until ongoing flush completes,
> > > +        * hence coalescing all the pending requests.
> > >          */
> > > -       if (bio && bio->bi_iter.bi_sector != -1) {
> > > -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > > -
> > > -               if (!child)
> > > -                       return -ENOMEM;
> > > -               bio_copy_dev(child, bio);
> > > -               child->bi_opf = REQ_PREFLUSH;
> > > -               child->bi_iter.bi_sector = -1;
> > > -               bio_chain(child, bio);
> > > -               submit_bio(child);
> > > -               return 0;
> > > +       wait_event_lock_irq(vpmem->sb_wait,
> > > +                           !vpmem->flush_bio ||
> > > +                           ktime_before(req_start, vpmem->prev_flush_start),
> > > +                           vpmem->lock);
> > > +       /* new request after previous flush is completed */
> > > +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> > > +               WARN_ON(vpmem->flush_bio);
> > > +               vpmem->flush_bio = bio;
> > > +               bio = NULL;
> > > +       }
> >
> > Why the dance with ->prev_flush_start vs just calling queue_work()
> > again. queue_work() is naturally coalescing in that if the last work
> > request has not started execution another queue attempt will be
> > dropped.
>
> How parent flush request will know when corresponding flush is completed?

The eventual bio_endio() is what signals upper layers that the flush
completed...


Hold on... it's been so long that I forgot that you are copying
md_flush_request() here. It would help immensely if that was mentioned
in the changelog and at a minimum have a comment in the code that this
was copied from md. In fact it would be extra helpful if you
refactored a common helper that bio based block drivers could share
for implementing flush handling, but that can come later.

Let me go re-review this with respect to whether the md case is fully
applicable here.
