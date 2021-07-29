Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7B3DA03D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhG2J3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235488AbhG2J3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627550978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QU04D4AFtIumGhlAE34vrZ8TeIMsBn0CApcJIeHb9PI=;
        b=AsUCZZBK5GcySSFxn6wjkQ8lXRHW6NF3U6mSro4xQ2m2UhOD7QvVv3vMMDb+KH5IgR+KZX
        aEyRIgdiTxqfqD5sze5WGyrygv+oZ6VUIEQBs0dveTYrDbWiysnhaQKf57LjvVkMALyoHe
        VddqGBmyiePWPdTGdIZdw2LWd7MX9HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-_xf3uillNICG3oRRPdDC8A-1; Thu, 29 Jul 2021 05:29:37 -0400
X-MC-Unique: _xf3uillNICG3oRRPdDC8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022B8801AEB;
        Thu, 29 Jul 2021 09:29:35 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA16560877;
        Thu, 29 Jul 2021 09:29:24 +0000 (UTC)
Date:   Thu, 29 Jul 2021 17:29:25 +0800
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
Message-ID: <YQJ09eaGIssStGXt@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <3180854.nXyytZ0Y3r@natalenko.name>
 <YQF9YRSdRc+eVD1c@T590>
 <4560968.zrxKzTJTGe@natalenko.name>
 <YQIhfwP2z+DGWOxV@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YQIhfwP2z+DGWOxV@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:33:33AM +0800, Ming Lei wrote:
> On Wed, Jul 28, 2021 at 06:38:36PM +0200, Oleksandr Natalenko wrote:
> > Hello.
> > 
> > On středa 28. července 2021 17:53:05 CEST Ming Lei wrote:
> > > Can you collect debug log by applying the following patch against the
> > > last one?
> > 
> > Yes, please see below.
> > 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 8780e4aa9df2..fbd8a68c619b 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -828,6 +828,24 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
> > > cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
> > >  }
> > > 
> > > +static inline void blk_dump_rq(const struct request *req)
> > > +{
> > > +	struct bio *bio;
> > > +	int i = 0;
> > > +
> > > +	printk("dump req %p(f:%x, seg: %d)\n", req, req->cmd_flags,
> > > +			req->nr_phys_segments);
> > > +
> > > +	__rq_for_each_bio(bio, req) {
> > > +		printk("%d-%p: %hx/%hx %llu %u\n",
> > > +                       i++, bio,
> > > +                       bio->bi_flags, bio->bi_opf,
> > > +                       (unsigned long long)bio->bi_iter.bi_sector,
> > > +                       bio->bi_iter.bi_size>>9);
> > > +	}
> > > +}
> > > +
> > > +
> > >  static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request
> > > *req, struct nvme_command *cmnd)
> > >  {
> > > @@ -868,6 +886,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
> > > *ns, struct request *req, }
> > > 
> > >  	if (WARN_ON_ONCE(n != segments)) {
> > > +		printk("%s: ranges %u segments %u\n", __func__, n, segments);
> > > +		blk_dump_rq(req);
> > >  		if (virt_to_page(range) == ns->ctrl->discard_page)
> > >  			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
> > >  		else
> > 
> > ```
> > WARNING: CPU: 17 PID: 821 at drivers/nvme/host/core.c:868 nvme_setup_discard+0x1c6/0x220
> > …
> > CPU: 17 PID: 821 Comm: kworker/17:1H Not tainted 5.13.0-pf4 #1
> > Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 3601 05/26/2021
> > Workqueue: kblockd blk_mq_run_work_fn
> > RIP: 0010:nvme_setup_discard+0x1c6/0x220
> > Code: 8b a0 40 0b 00 00 4c 2b 25 f7 ff d7 00 49 c1 fc 06 49 c1 e4 0c 4c 03 25 f8 ff d7 00 4c 89 e5 48 85 d2 0f 85 9b fe ff ff 31 d2 <0f> 0b 48 c7 c6 e0 a8 10 8b 41 0f b7 cd 48 c7 c7 af 09 40 8b e8 14
> > RSP: 0018:ffffafa884517bf0 EFLAGS: 00010297
> > RAX: ffff91602f5b20d0 RBX: ffff915e05743c00 RCX: 0000000000080000
> > RDX: 000000000000000f RSI: 0000000028445c00 RDI: 000000000000000f
> > RBP: ffff91602f5b2000 R08: 000000000b366000 R09: ffff91602f5b2000
> > R10: 000000000000002d R11: fefefefefefefeff R12: ffff91602f5b2000
> > R13: 000000000000000e R14: ffff915e18c77000 R15: ffff915e18c77148
> > FS:  0000000000000000(0000) GS:ffff91650ee40000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00001c90b36879a8 CR3: 000000010d18c000 CR4: 0000000000350ee0
> > Call Trace:
> >  nvme_setup_cmd+0x2e4/0x6a0
> >  nvme_queue_rq+0x79/0xc90
> >  blk_mq_dispatch_rq_list+0x15c/0x810
> >  __blk_mq_do_dispatch_sched+0xca/0x320
> >  __blk_mq_sched_dispatch_requests+0x14d/0x190
> >  blk_mq_sched_dispatch_requests+0x2f/0x60
> >  blk_mq_run_work_fn+0x43/0xc0
> >  process_one_work+0x24e/0x430
> >  worker_thread+0x54/0x4d0
> >  kthread+0x1b3/0x1e0
> >  ret_from_fork+0x22/0x30
> > ---[ end trace bd51917eae1d7201 ]---
> > nvme_setup_discard: ranges 15 segments 14
> > dump req 000000002c6a085b(f:3, seg: 14)
> > 0-000000002c3297c7: f80/3 675773440 1024
> > 1-0000000098edb2a8: b80/3 188319744 1024
> > 2-00000000f58e3b18: b80/3 675775488 1024
> > 3-00000000f6670c5a: b80/3 188129280 2048
> > 4-00000000ea371a88: b80/3 675585024 2048
> > 5-00000000e9cec043: b80/3 188140544 2048
> > 6-000000006e1126e6: b80/3 675596288 2048
> > 7-000000009466f937: b80/3 188327936 2048
> > 8-000000003c9e2ccd: b80/3 675783680 2048
> > 9-00000000ab322c68: b80/3 188329984 2048
> 
> 188329984 = 188327936 + 2048
> 
> > 10-00000000eb2b3fb6: b80/3 675785728 2048
> 
> 675785728 = 675783680 + 2048
> 
> Seems the adjacent bios are cut by coming discard
> range.
> 
> Looks it isn't mature to support mixed discard IO merge(
> traditional io merge vs. multi-range merge), I will post
> the previous patch for fixing this issue.

The reason is the following lines of code:

#define rq_hash_key(rq)         (blk_rq_pos(rq) + blk_rq_sectors(rq))

if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)

...

The current block merge code thinks that all bios in one request is physically
continuous, so we can't support mixed merge for multi-range discard request simply.


Thanks,
Ming

