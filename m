Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5077B371604
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhECNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:34:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:35622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232984AbhECNe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E04A9B118;
        Mon,  3 May 2021 13:33:32 +0000 (UTC)
Subject: Re: [PATCH] nvme-multipath: Reset bi_disk to ns head when failover
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210503125741.68117-1-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7ab943e0-5ac4-d370-0a15-3108f689e478@suse.de>
Date:   Mon, 3 May 2021 15:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210503125741.68117-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 2:57 PM, Daniel Wagner wrote:
> The path can be stale when we failover. If we don't reset the bdev to
> the ns head and the I/O finally completes in end_io() it will triggers
> a crash. By resetting the to ns head disk so that the submit path can
> map the request to an active path.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> The patch is against nvme-5.13.
> 
> [ 6552.155244] Call Trace:
> [ 6552.155251]  bio_endio+0x74/0x120
> [ 6552.155260]  nvme_ns_head_submit_bio+0x36f/0x3e0 [nvme_core]
> [ 6552.155266]  ? __switch_to_asm+0x34/0x70
> [ 6552.155269]  ? __switch_to_asm+0x40/0x70
> [ 6552.155271]  submit_bio_noacct+0x175/0x490
> [ 6552.155274]  ? __switch_to_asm+0x34/0x70
> [ 6552.155277]  ? __switch_to_asm+0x34/0x70
> [ 6552.155284]  ? nvme_requeue_work+0x5a/0x70 [nvme_core]
> [ 6552.155290]  nvme_requeue_work+0x5a/0x70 [nvme_core]
> [ 6552.155296]  process_one_work+0x1f4/0x3e0
> [ 6552.155299]  worker_thread+0x2d/0x3e0
> [ 6552.155302]  ? process_one_work+0x3e0/0x3e0
> [ 6552.155305]  kthread+0x10d/0x130
> [ 6552.155307]  ? kthread_park+0xa0/0xa0
> [ 6552.155311]  ret_from_fork+0x35/0x40
> 
>   drivers/nvme/host/multipath.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0d0de3433f37..0faf267faa58 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -69,7 +69,9 @@ void nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
>   	u16 status = nvme_req(req)->status & 0x7ff;
> +	struct block_device *bdev;
>   	unsigned long flags;
> +	struct bio *bio;
>   
>   	nvme_mpath_clear_current_path(ns);
>   
> @@ -83,9 +85,13 @@ void nvme_failover_req(struct request *req)
>   		queue_work(nvme_wq, &ns->ctrl->ana_work);
>   	}
>   
> +	bdev = bdget_disk(ns->head->disk, 0);
>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +	for (bio = req->bio; bio; bio = bio->bi_next)
> +		bio_set_dev(bio, bdev);
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +	bdput(bdev);
>   
>   	blk_mq_end_request(req, 0);
>   	kblockd_schedule_work(&ns->head->requeue_work);
> 
Maybe a WARN_ON(!bdev) after bdget_disk(), but otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
