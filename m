Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2755D35F119
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhDNJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:55:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231615AbhDNJzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0743CAD09;
        Wed, 14 Apr 2021 09:54:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BA2B41F2B5F; Wed, 14 Apr 2021 11:54:55 +0200 (CEST)
Date:   Wed, 14 Apr 2021 11:54:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bfq: silence lockdep for bfqd/ioc lock inversion
Message-ID: <20210414095455.GA29760@quack2.suse.cz>
References: <20210319060015.3979352-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319060015.3979352-1-khazhy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-03-21 23:00:15, Khazhismel Kumykov wrote:
> lockdep warns of circular locking due to inversion between
> bfq_insert_requests and bfq_exit_icq. If we end freeing a request when
> merging, we *may* grab an ioc->lock if that request is the last refcount
> to that ioc. bfq_bio_merge also potentially could have this ordering.
> bfq_exit_icq, conversely, grabs bfqd but is always called with ioc->lock
> held.
> 
> bfq_exit_icq may either be called from put_io_context_active with ioc
> refcount raised, ioc_release_fn after the last refcount was already
> dropped, or ioc_clear_queue, which is only called while queue is
> quiesced or exiting, so the inverted orderings should never conflict.
> 
> Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as
> an extra scheduler")
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

I've just hit the same lockdep complaint. When looking at this another
option to solve this complaint seemed to be to modify bfq_bio_merge() like:

        ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 
+       spin_unlock_irq(&bfqd->lock);
        if (free)
                blk_mq_free_request(free);
-       spin_unlock_irq(&bfqd->lock);

        return ret;

to release request outside of bfqd->lock. Because AFAICT there's no good
reason why we are actually freeing the request under bfqd->lock. And it
would seem a bit safer than annotating-away the lockdep complaint (as much
as I don't see a problem with your analysis). Paolo?

								Honza
> ---
>  block/bfq-iosched.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Noticed this lockdep running xfstests (generic/464) on top of a bfq
> block device. I was also able to tease it out w/ binary trying to issue
> requests that would end up merging while rapidly swapping the active
> scheduler. As far as I could see, the deadlock would not actually occur,
> so this patch opts to change lock class for the inverted case.
> 
> bfqd -> ioc :
> [ 2995.524557] __lock_acquire+0x18f5/0x2660
> [ 2995.524562] lock_acquire+0xb4/0x3a0
> [ 2995.524565] _raw_spin_lock_irqsave+0x3f/0x60
> [ 2995.524569] put_io_context+0x33/0x90. �-> ioc->lock grabbed
> [ 2995.524573] blk_mq_free_request+0x51/0x140
> [ 2995.524577] blk_put_request+0xe/0x10
> [ 2995.524580] blk_attempt_req_merge+0x1d/0x30
> [ 2995.524585] elv_attempt_insert_merge+0x56/0xa0
> [ 2995.524590] blk_mq_sched_try_insert_merge+0x4b/0x60
> [ 2995.524595] bfq_insert_requests+0x9e/0x18c0. � �-> bfqd->lock grabbed
> [ 2995.524598] blk_mq_sched_insert_requests+0xd6/0x2b0
> [ 2995.524602] blk_mq_flush_plug_list+0x154/0x280
> [ 2995.524606] blk_finish_plug+0x40/0x60
> [ 2995.524609] ext4_writepages+0x696/0x1320
> [ 2995.524614] do_writepages+0x1c/0x80
> [ 2995.524621] __filemap_fdatawrite_range+0xd7/0x120
> [ 2995.524625] sync_file_range+0xac/0xf0
> [ 2995.524642] __x64_sys_sync_file_range+0x44/0x70
> [ 2995.524646] do_syscall_64+0x31/0x40
> [ 2995.524649] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> ioc -> bfqd
> [ 2995.524490] _raw_spin_lock_irqsave+0x3f/0x60
> [ 2995.524498] bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
> [ 2995.524512] put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
> [ 2995.524516] exit_io_context+0x48/0x50
> [ 2995.524519] do_exit+0x7e9/0xdd0
> [ 2995.524526] do_group_exit+0x54/0xc0
> [ 2995.524530] __x64_sys_exit_group+0x18/0x20
> [ 2995.524534] do_syscall_64+0x31/0x40
> [ 2995.524537] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Another trace where we grab ioc -> bfqd through bfq_exit_icq is when
> changing elevator
> � � � � � � � �-> #1 (&(&bfqd->lock)->rlock){-.-.}:
> [ �646.890820] � � � �lock_acquire+0x9b/0x140
> [ �646.894868] � � � �_raw_spin_lock_irqsave+0x3b/0x50
> [ �646.899707] � � � �bfq_exit_icq_bfqq+0x47/0x1f0
> [ �646.904196] � � � �bfq_exit_icq+0x21/0x30
> [ �646.908160] � � � �ioc_destroy_icq+0xf3/0x130
> [ �646.912466] � � � �ioc_clear_queue+0xb8/0x140
> [ �646.916771] � � � �elevator_switch_mq+0xa4/0x3c0
> [ �646.921333] � � � �elevator_switch+0x5f/0x340
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 95586137194e..cb50ac0ffe80 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5027,7 +5027,14 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>  	if (bfqq && bfqd) {
>  		unsigned long flags;
>  
> -		spin_lock_irqsave(&bfqd->lock, flags);
> +		/* bfq_exit_icq is usually called with ioc->lock held, which is
> +		 * inverse order from elsewhere, which may grab ioc->lock
> +		 * under bfqd->lock if we merge requests and drop the last ioc
> +		 * refcount. Since exit_icq is either called with a refcount,
> +		 * or with queue quiesced, use a differnet lock class to
> +		 * silence lockdep
> +		 */
> +		spin_lock_irqsave_nested(&bfqd->lock, flags, 1);
>  		bfqq->bic = NULL;
>  		bfq_exit_bfqq(bfqd, bfqq);
>  		bic_set_bfqq(bic, NULL, is_sync);
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
