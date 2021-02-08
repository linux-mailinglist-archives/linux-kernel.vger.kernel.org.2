Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11931405B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhBHUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235892AbhBHS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612810697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z552II2iY7BYWfkaIB5xZqJZQyV+he+lkpb3Svc6M2g=;
        b=J4k+2NNrmHhtDKoK/RwqDG5XLznl5gxNvLOx7XIZDW6Ui1GKpLpvlq2o5kD6sgA0+r0wuy
        k1mjpoHjoh48CkNwCGJcya8ykJgJKVmrwkqpKJpZUUJAFfSkz2Caa9DEhy4cZEoDpGJ08h
        ujI+I66FqSORx/EgrxkCJYGx5V03Xm0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-T0Rv-nKuP9aTY0qou97LUA-1; Mon, 08 Feb 2021 13:58:15 -0500
X-MC-Unique: T0Rv-nKuP9aTY0qou97LUA-1
Received: by mail-ot1-f72.google.com with SMTP id o29so2319147ote.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z552II2iY7BYWfkaIB5xZqJZQyV+he+lkpb3Svc6M2g=;
        b=mRtUlKgbvWoxrxakXna5yY2bBXk2/cJeOMGC639JGMPf8vbBoa45klFnq7zV62DQfR
         fy23+B1JnzZDhOF5N8HJGjj0Aw27MGQgcz39haDWJ4jWT8D+IRjq7FfcXaX0MYqDIcC/
         dk+vhwhSgI188YQayeCVz3fFHaM3nyHKJTGkHDlHUB+J1Ai1hukXAACfm3V0mYcZmo00
         YdpYevl6cz1LB3YmCEZAEC87EXEzt/XG61mtPp3D97RLOIFpexlmzy3v/rgAqUIcJ6ev
         TaCoAVTj9ZBunzntcQLpZ83snpYtBpsF2EbBCr5NU9Nn30QadZ8P3rQIWA7kUXmAZvBg
         +17g==
X-Gm-Message-State: AOAM531Vfz0Tc5Z1BZ0YXvrUpSTEz8XiQWD4au1IR0XkV2JHlFI970cQ
        Zaat8TIpuMgfA9GVzNZaYW3bEftmvdZHZSZ/falrnUyAjdJ57BjHWroBXuzqqx2FKB+OxNmIjwO
        oE5s/3l2eqywLdjfL/IokqUeG6W+5SZidWqnV+26i
X-Received: by 2002:aca:5249:: with SMTP id g70mr139272oib.68.1612810695049;
        Mon, 08 Feb 2021 10:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPH5wtYwnU+wpUUXoLKqxQQE07ThxdHnis1/JNZmkYb1uiooNuYLTsJu5bFhs1FY6h/DyorVv7iZ0rHkJ8zzE=
X-Received: by 2002:aca:5249:: with SMTP id g70mr139264oib.68.1612810694886;
 Mon, 08 Feb 2021 10:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20210201164850.391332-1-djeffery@redhat.com> <20210204022740.GB1108591@T590>
 <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
In-Reply-To: <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Mon, 8 Feb 2021 13:58:04 -0500
Message-ID: <CA+RJvhyNymmqyQdZ=7hT0abP7eHz6UX0zapHbdFQesahJrRCLQ@mail.gmail.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        David Jeffery <djeffery@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, when you get a moment, could you take a quick look at this one for ack?

On Thu, Feb 4, 2021 at 11:49 AM Laurence Oberman <loberman@redhat.com> wrote:
>
> On Thu, 2021-02-04 at 10:27 +0800, Ming Lei wrote:
> > On Mon, Feb 01, 2021 at 11:48:50AM -0500, David Jeffery wrote:
> > > When a stacked block device inserts a request into another block
> > > device
> > > using blk_insert_cloned_request, the request's nr_phys_segments
> > > field gets
> > > recalculated by a call to blk_recalc_rq_segments in
> > > blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not
> > > know how to
> > > handle multi-segment discards. For disk types which can handle
> > > multi-segment discards like nvme, this results in discard requests
> > > which
> > > claim a single segment when it should report several, triggering a
> > > warning
> > > in nvme and causing nvme to fail the discard from the invalid
> > > state.
> > >
> > >  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700
> > > nvme_setup_discard+0x170/0x1e0 [nvme_core]
> > >  ...
> > >  nvme_setup_cmd+0x217/0x270 [nvme_core]
> > >  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
> > >  __blk_mq_try_issue_directly+0xe7/0x1b0
> > >  blk_mq_request_issue_directly+0x41/0x70
> > >  ? blk_account_io_start+0x40/0x50
> > >  dm_mq_queue_rq+0x200/0x3e0
> > >  blk_mq_dispatch_rq_list+0x10a/0x7d0
> > >  ? __sbitmap_queue_get+0x25/0x90
> > >  ? elv_rb_del+0x1f/0x30
> > >  ? deadline_remove_request+0x55/0xb0
> > >  ? dd_dispatch_request+0x181/0x210
> > >  __blk_mq_do_dispatch_sched+0x144/0x290
> > >  ? bio_attempt_discard_merge+0x134/0x1f0
> > >  __blk_mq_sched_dispatch_requests+0x129/0x180
> > >  blk_mq_sched_dispatch_requests+0x30/0x60
> > >  __blk_mq_run_hw_queue+0x47/0xe0
> > >  __blk_mq_delay_run_hw_queue+0x15b/0x170
> > >  blk_mq_sched_insert_requests+0x68/0xe0
> > >  blk_mq_flush_plug_list+0xf0/0x170
> > >  blk_finish_plug+0x36/0x50
> > >  xlog_cil_committed+0x19f/0x290 [xfs]
> > >  xlog_cil_process_committed+0x57/0x80 [xfs]
> > >  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
> > >  xlog_ioend_work+0x2f/0x80 [xfs]
> > >  process_one_work+0x1b6/0x350
> > >  worker_thread+0x53/0x3e0
> > >  ? process_one_work+0x350/0x350
> > >  kthread+0x11b/0x140
> > >  ? __kthread_bind_mask+0x60/0x60
> > >  ret_from_fork+0x22/0x30
> > >
> > > This patch fixes blk_recalc_rq_segments to be aware of devices
> > > which can
> > > have multi-segment discards. It calculates the correct discard
> > > segment
> > > count by counting the number of bio as each discard bio is
> > > considered its
> > > own segment.
> > >
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > ---
> > >  block/blk-merge.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > index 808768f6b174..fe7358bd5d09 100644
> > > --- a/block/blk-merge.c
> > > +++ b/block/blk-merge.c
> > > @@ -382,6 +382,13 @@ unsigned int blk_recalc_rq_segments(struct
> > > request *rq)
> > >
> > >     switch (bio_op(rq->bio)) {
> > >     case REQ_OP_DISCARD:
> > > +           if (queue_max_discard_segments(rq->q) > 1) {
> > > +                   struct bio *bio = rq->bio;
> > > +                   for_each_bio(bio)
> > > +                           nr_phys_segs++;
> > > +                   return nr_phys_segs;
> > > +           }
> > > +           /* fall through */
> > >     case REQ_OP_SECURE_ERASE:
> > >     case REQ_OP_WRITE_ZEROES:
> > >             return 0;
> >
> > blk_rq_nr_discard_segments() always returns >=1 segments, so no
> > similar
> > issue in case of single range discard.
> >
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> >
> > And it can be thought as:
> >
> > Fixes: 1e739730c5b9 ("block: optionally merge discontiguous discard
> > bios into a single request")
> >
> >
>
> Great, can we get enough acks and push this through its urgent for me
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
>

