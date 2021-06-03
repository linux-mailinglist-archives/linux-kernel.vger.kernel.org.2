Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28C9399B85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFCH1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:27:25 -0400
Received: from verein.lst.de ([213.95.11.211]:60726 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFCH1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:27:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E9B96736F; Thu,  3 Jun 2021 09:25:37 +0200 (CEST)
Date:   Thu, 3 Jun 2021 09:25:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: reset disk to the mpath node also when
 requeuing
Message-ID: <20210603072537.GA4718@lst.de>
References: <20210602130039.122879-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602130039.122879-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:00:39PM +0200, Daniel Wagner wrote:
> +	struct bio *b;
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  	int srcu_idx;
>  
> @@ -324,6 +325,8 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>  		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
>  
>  		spin_lock_irq(&head->requeue_lock);
> +		for (b = bio; b; b = b->bi_next)
> +			bio_set_dev(b, head->disk->part0);
>  		bio_list_add(&head->requeue_list, bio);
>  		spin_unlock_irq(&head->requeue_lock);
>  	} else {

I can't see why we'd need this hunk.  bio->bi_bdev should have never been
changed to start with in this path.

> @@ -435,11 +438,6 @@ static void nvme_requeue_work(struct work_struct *work)
>  		next = bio->bi_next;
>  		bio->bi_next = NULL;
>  
> -		/*
> -		 * Reset disk to the mpath node and resubmit to select a new
> -		 * path.
> -		 */
> -		bio_set_dev(bio, head->disk->part0);
>  		submit_bio_noacct(bio);
>  	}

This hunk looks fine.
