Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66D33CB639
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhGPKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238809AbhGPKpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626432134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYv2Aol5Hptlza4XzCigRKb4M7GsMoM5cZVrcTu70PQ=;
        b=KONg+0p7EcGvEiIo25z6zIUXusijP0poCUQqudf+C2NO2jJJX/RarejFXny03oqXVSGo6P
        B7brB2NzVnnoZ0obyC+bNwIesE0suTTmdHydxPi9Osp9ZfH6ru+LFue8tZcC1Lb1yRT8N1
        5h5XZMdKLSqU/klshKSn7T9W+HFMOps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-cY1zEBD4NcGFDboNVED5bw-1; Fri, 16 Jul 2021 06:42:13 -0400
X-MC-Unique: cY1zEBD4NcGFDboNVED5bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CFC8030B5;
        Fri, 16 Jul 2021 10:42:11 +0000 (UTC)
Received: from T590 (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 622B6752A0;
        Fri, 16 Jul 2021 10:41:57 +0000 (UTC)
Date:   Fri, 16 Jul 2021 18:41:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YPFicCW90Jse4oms@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <81322754.HEIg0oD171@natalenko.name>
 <YPFSUfG+fMITAH01@T590>
 <2455133.St5lIfLNcX@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2455133.St5lIfLNcX@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:03:43PM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> On pátek 16. července 2021 11:33:05 CEST Ming Lei wrote:
> > Can you test the following patch?
> 
> Sure, building it at the moment, and will give it a try. Also please see my 
> comments and questions below.
> 
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 727955918563..673a634eadd9 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -2361,6 +2361,9 @@ static int bfq_request_merge(struct request_queue *q,
> > struct request **req, __rq = bfq_find_rq_fmerge(bfqd, bio, q);
> >  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
> >  		*req = __rq;
> > +
> > +		if (blk_discard_mergable(__rq))
> > +			return ELEVATOR_DISCARD_MERGE;
> >  		return ELEVATOR_FRONT_MERGE;
> >  	}
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index a11b3b53717e..f8707ff7e2fc 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -705,22 +705,6 @@ static void blk_account_io_merge_request(struct request
> > *req) }
> >  }
> > 
> > -/*
> > - * Two cases of handling DISCARD merge:
> > - * If max_discard_segments > 1, the driver takes every bio
> > - * as a range and send them to controller together. The ranges
> > - * needn't to be contiguous.
> > - * Otherwise, the bios/requests will be handled as same as
> > - * others which should be contiguous.
> > - */
> > -static inline bool blk_discard_mergable(struct request *req)
> > -{
> > -	if (req_op(req) == REQ_OP_DISCARD &&
> > -	    queue_max_discard_segments(req->q) > 1)
> > -		return true;
> > -	return false;
> > -}
> > -
> >  static enum elv_merge blk_try_req_merge(struct request *req,
> >  					struct request *next)
> >  {
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 52ada14cfe45..a5fe2615ec0f 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -336,6 +336,9 @@ enum elv_merge elv_merge(struct request_queue *q, struct
> > request **req, __rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
> >  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
> >  		*req = __rq;
> > +
> > +		if (blk_discard_mergable(__rq))
> > +			return ELEVATOR_DISCARD_MERGE;
> >  		return ELEVATOR_BACK_MERGE;
> >  	}
> > 
> > diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> > index 6f612e6dc82b..294be0c0db65 100644
> > --- a/block/mq-deadline-main.c
> > +++ b/block/mq-deadline-main.c
> 
> I had to adjust this against v5.13 because there's no mq-deadline-main.c, only 
> mq-deadline.c (due to Bart series, I assume). I hope this is fine as the patch 
> applies cleanly.
> 
> > @@ -677,6 +677,8 @@ static int dd_request_merge(struct request_queue *q,
> > struct request **rq,
> > 
> >  		if (elv_bio_merge_ok(__rq, bio)) {
> >  			*rq = __rq;
> > +			if (blk_discard_mergable(__rq))
> > +				return ELEVATOR_DISCARD_MERGE;
> >  			return ELEVATOR_FRONT_MERGE;
> >  		}
> >  	}
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 3177181c4326..87f00292fd7a 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1521,6 +1521,22 @@ static inline int
> > queue_limit_discard_alignment(struct queue_limits *lim, sector return
> > offset << SECTOR_SHIFT;
> >  }
> > 
> > +/*
> > + * Two cases of handling DISCARD merge:
> > + * If max_discard_segments > 1, the driver takes every bio
> > + * as a range and send them to controller together. The ranges
> > + * needn't to be contiguous.
> > + * Otherwise, the bios/requests will be handled as same as
> > + * others which should be contiguous.
> > + */
> > +static inline bool blk_discard_mergable(struct request *req)
> > +{
> > +	if (req_op(req) == REQ_OP_DISCARD &&
> > +	    queue_max_discard_segments(req->q) > 1)
> > +		return true;
> > +	return false;
> > +}
> > +
> >  static inline int bdev_discard_alignment(struct block_device *bdev)
> >  {
> >  	struct request_queue *q = bdev_get_queue(bdev);
> 
> Do I understand correctly that this will be something like:
> 
> Fixes: 2705dfb209 ("block: fix discard request merge")
> 
> ?
> 
> Because as the bisection progresses, I've bumped into this commit only. 
> Without it the issue is not reproducible, at least so far.

It could be.

So can you just test v5.14-rc1?


Thanks,
Ming

