Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C6C3F7B84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbhHYR0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhHYR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:26:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE353C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:25:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t1so427220pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj7GUDQcswnsxUUBQiJcqcPuahUiS9pendzNxfz9P+E=;
        b=WJ/UrbpI0YJkC285XB8Nlg+fhssrNyru45tAxB634992PgM1oeVP/qPL2yHU5VIoUT
         oOZWXbg8si8Xf3he/NjPajcLKGZp5/CHiDHYC9pRa+W+3PiLh1RrG2GZ9ino7csx2/PB
         l1xnsMxxpeUT5l1rcp9ZWBCgsx2zclm6S2eUW7voqyi22BxQOEAF0D6huJp9fLuMo/Qt
         YGLrcsVOUBXa9cSOTBK1GtWfc5qMculhTAk8QoOYpEKUqefikS9ypUhLHKkF8/paqNx/
         KJ17YxHwGYtpPlpqSuZ+kLfQVCrxodpYPTXj/XKmOS8nuD6wJLjVD1BFOQzNCvuh2lYE
         q+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj7GUDQcswnsxUUBQiJcqcPuahUiS9pendzNxfz9P+E=;
        b=HJSHCZ6RZb8/Whz746/peod1vCIGsOAy8JUHXrLwTyTb1PFCStc2vr88Gi4qWWN3YO
         tNnb8fk8LmCn8Xi5+kB7oOwvFF7xBXXfRy4GPLO9D3uDU3ovfrUJ3C2wRd2d7EdTx73Y
         cE32aBvgYPgn+7XyVzAPg5tS5Lh/9D62kKTe4ZBfSqbr0+nkTvX/XPw8c4Px9E4cdSoQ
         ywFX5vs2bip9cChKqdgaFyKOpVS5TVUWbEY4Nc/VXhAwTZRfgBMiSOue3DY+x39c6z5X
         HUZ8+7KsIP+2Domfm/KTHUXkFuOum8hrZ+ftEL6YoPHMrOh+HNFJ7AyZAYABSXYXpssI
         fLsA==
X-Gm-Message-State: AOAM533R1znQ4s6X0YcwHEGxwEu95rFcfOe5ne7WUUa/tseat5OZdPO7
        vOXS2Nd1OTKSBqGwG1h06LUG+WVbuYkI0aKqbHdA8g==
X-Google-Smtp-Source: ABdhPJzjYgw77mxlVRuaXmQjnnSMYS1lOq6aES/ohqV+ity7k3w2NEUk6h5kSv/M+prVDmvdnlXGhanbUQBL7U+UQgU=
X-Received: by 2002:a05:6a00:9a4:b0:3e2:f6d0:c926 with SMTP id
 u36-20020a056a0009a400b003e2f6d0c926mr38613921pfg.31.1629912351396; Wed, 25
 Aug 2021 10:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com> <20210726060855.108250-2-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20210726060855.108250-2-pankaj.gupta.linux@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 10:25:40 -0700
Message-ID: <CAPcyv4inCFFXmg0r5+h0O6cADpt9HdboVDEL00XX-wGroy-7LQ@mail.gmail.com>
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

On Sun, Jul 25, 2021 at 11:09 PM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> From: Pankaj Gupta <pankaj.gupta@ionos.com>
>
> Implement asynchronous flush for virtio pmem using work queue
> to solve the preflush ordering issue. Also, coalesce the flush
> requests when a flush is already in process.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> ---
>  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
>  drivers/nvdimm/virtio_pmem.c | 10 ++++-
>  drivers/nvdimm/virtio_pmem.h | 14 +++++++
>  3 files changed, 79 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 10351d5b49fa..61b655b583be 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -97,29 +97,69 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>         return err;
>  };
>
> +static void submit_async_flush(struct work_struct *ws);
> +
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> -       /*
> -        * Create child bio for asynchronous flush and chain with
> -        * parent bio. Otherwise directly call nd_region flush.
> +       /* queue asynchronous flush and coalesce the flush requests */
> +       struct virtio_device *vdev = nd_region->provider_data;
> +       struct virtio_pmem *vpmem  = vdev->priv;
> +       ktime_t req_start = ktime_get_boottime();
> +
> +       spin_lock_irq(&vpmem->lock);
> +       /* flush requests wait until ongoing flush completes,
> +        * hence coalescing all the pending requests.
>          */
> -       if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> -
> -               if (!child)
> -                       return -ENOMEM;
> -               bio_copy_dev(child, bio);
> -               child->bi_opf = REQ_PREFLUSH;
> -               child->bi_iter.bi_sector = -1;
> -               bio_chain(child, bio);
> -               submit_bio(child);
> -               return 0;
> +       wait_event_lock_irq(vpmem->sb_wait,
> +                           !vpmem->flush_bio ||
> +                           ktime_before(req_start, vpmem->prev_flush_start),
> +                           vpmem->lock);
> +       /* new request after previous flush is completed */
> +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> +               WARN_ON(vpmem->flush_bio);
> +               vpmem->flush_bio = bio;
> +               bio = NULL;
> +       }

Why the dance with ->prev_flush_start vs just calling queue_work()
again. queue_work() is naturally coalescing in that if the last work
request has not started execution another queue attempt will be
dropped.

> +       spin_unlock_irq(&vpmem->lock);
> +
> +       if (!bio) {
> +               INIT_WORK(&vpmem->flush_work, submit_async_flush);

I expect this only needs to be initialized once at driver init time.

> +               queue_work(vpmem->pmem_wq, &vpmem->flush_work);
> +               return 1;
> +       }
> +
> +       /* flush completed in other context while we waited */
> +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> +               bio->bi_opf &= ~REQ_PREFLUSH;
> +               submit_bio(bio);
> +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> +               bio->bi_opf &= ~REQ_FUA;
> +               bio_endio(bio);

It's not clear to me how this happens, shouldn't all flush completions
be driven from the work completion?

>         }
> -       if (virtio_pmem_flush(nd_region))
> -               return -EIO;
>
>         return 0;
>  };
>  EXPORT_SYMBOL_GPL(async_pmem_flush);
> +
> +static void submit_async_flush(struct work_struct *ws)
> +{
> +       struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
> +       struct bio *bio = vpmem->flush_bio;
> +
> +       vpmem->start_flush = ktime_get_boottime();
> +       bio->bi_status = errno_to_blk_status(virtio_pmem_flush(vpmem->nd_region));
> +       vpmem->prev_flush_start = vpmem->start_flush;
> +       vpmem->flush_bio = NULL;
> +       wake_up(&vpmem->sb_wait);
> +
> +       /* Submit parent bio only for PREFLUSH */
> +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> +               bio->bi_opf &= ~REQ_PREFLUSH;
> +               submit_bio(bio);
> +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> +               bio->bi_opf &= ~REQ_FUA;
> +               bio_endio(bio);
> +       }

Shouldn't the wait_event_lock_irq() be here rather than in
async_pmem_flush()? That will cause the workqueue to back up and flush
requests to coalesce.

> +}
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 726c7354d465..56780a6140c7 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
>                 return PTR_ERR(vpmem->req_vq);
>
>         spin_lock_init(&vpmem->pmem_lock);
> +       spin_lock_init(&vpmem->lock);

Why 2 locks?
