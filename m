Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EB447B92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhKHIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231540AbhKHIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636358967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgsP2D/U785AZZ4OWNC0oeuaIP53xpD7zZSOQpLOs1M=;
        b=T0tUxg0nGOlZpU8vXUhk+wGBA3h+HXvoAxG8IzMYqvVnP6mz4L0nGDyFAjv4t+qUkoWSNT
        m0Hev9a8PHNdH2/xuu03GF0dWpWcXBZGmQfXBNsaMUhNwVK9jOfteMu1Fai8QXEaMp+r+r
        nrQhwe3wkdy4nCwRGP2Z248FjaoWZlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-uAHDxr4-PlKuCJC8RLv1KA-1; Mon, 08 Nov 2021 03:09:22 -0500
X-MC-Unique: uAHDxr4-PlKuCJC8RLv1KA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DC6D9128A;
        Mon,  8 Nov 2021 08:09:21 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 279125F4ED;
        Mon,  8 Nov 2021 08:09:00 +0000 (UTC)
Date:   Mon, 8 Nov 2021 16:08:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2] blk-mq: don't free tags if the tag_set is used
 by other device in queue initialztion
Message-ID: <YYjbFypVI0xFvMya@T590>
References: <20211108074019.1058843-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108074019.1058843-1-yebin10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 03:40:19PM +0800, Ye Bin wrote:
> We got UAF report on v5.10 as follows:
> [ 1446.674930] ==================================================================
> [ 1446.675970] BUG: KASAN: use-after-free in blk_mq_get_driver_tag+0x9a4/0xa90
> [ 1446.676902] Read of size 8 at addr ffff8880185afd10 by task kworker/1:2/12348
> [ 1446.677851]
> [ 1446.678073] CPU: 1 PID: 12348 Comm: kworker/1:2 Not tainted 5.10.0-10177-gc9c81b1e346a #2
> [ 1446.679168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 1446.680692] Workqueue: kthrotld blk_throtl_dispatch_work_fn
> [ 1446.681448] Call Trace:
> [ 1446.681800]  dump_stack+0x9b/0xce
> [ 1446.682916]  print_address_description.constprop.6+0x3e/0x60
> [ 1446.685999]  kasan_report.cold.9+0x22/0x3a
> [ 1446.687186]  blk_mq_get_driver_tag+0x9a4/0xa90
> [ 1446.687785]  blk_mq_dispatch_rq_list+0x21a/0x1d40
> [ 1446.692576]  __blk_mq_do_dispatch_sched+0x394/0x830
> [ 1446.695758]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
> [ 1446.698279]  blk_mq_sched_dispatch_requests+0xdf/0x140
> [ 1446.698967]  __blk_mq_run_hw_queue+0xc0/0x270
> [ 1446.699561]  __blk_mq_delay_run_hw_queue+0x4cc/0x550
> [ 1446.701407]  blk_mq_run_hw_queue+0x13b/0x2b0
> [ 1446.702593]  blk_mq_sched_insert_requests+0x1de/0x390
> [ 1446.703309]  blk_mq_flush_plug_list+0x4b4/0x760
> [ 1446.705408]  blk_flush_plug_list+0x2c5/0x480
> [ 1446.708471]  blk_finish_plug+0x55/0xa0
> [ 1446.708980]  blk_throtl_dispatch_work_fn+0x23b/0x2e0
> [ 1446.711236]  process_one_work+0x6d4/0xfe0
> [ 1446.711778]  worker_thread+0x91/0xc80
> [ 1446.713400]  kthread+0x32d/0x3f0
> [ 1446.714362]  ret_from_fork+0x1f/0x30
> [ 1446.714846]
> [ 1446.715062] Allocated by task 1:
> [ 1446.715509]  kasan_save_stack+0x19/0x40
> [ 1446.716026]  __kasan_kmalloc.constprop.1+0xc1/0xd0
> [ 1446.716673]  blk_mq_init_tags+0x6d/0x330
> [ 1446.717207]  blk_mq_alloc_rq_map+0x50/0x1c0
> [ 1446.717769]  __blk_mq_alloc_map_and_request+0xe5/0x320
> [ 1446.718459]  blk_mq_alloc_tag_set+0x679/0xdc0
> [ 1446.719050]  scsi_add_host_with_dma.cold.3+0xa0/0x5db
> [ 1446.719736]  virtscsi_probe+0x7bf/0xbd0
> [ 1446.720265]  virtio_dev_probe+0x402/0x6c0
> [ 1446.720808]  really_probe+0x276/0xde0
> [ 1446.721320]  driver_probe_device+0x267/0x3d0
> [ 1446.721892]  device_driver_attach+0xfe/0x140
> [ 1446.722491]  __driver_attach+0x13a/0x2c0
> [ 1446.723037]  bus_for_each_dev+0x146/0x1c0
> [ 1446.723603]  bus_add_driver+0x3fc/0x680
> [ 1446.724145]  driver_register+0x1c0/0x400
> [ 1446.724693]  init+0xa2/0xe8
> [ 1446.725091]  do_one_initcall+0x9e/0x310
> [ 1446.725626]  kernel_init_freeable+0xc56/0xcb9
> [ 1446.726231]  kernel_init+0x11/0x198
> [ 1446.726714]  ret_from_fork+0x1f/0x30
> [ 1446.727212]
> [ 1446.727433] Freed by task 26992:
> [ 1446.727882]  kasan_save_stack+0x19/0x40
> [ 1446.728420]  kasan_set_track+0x1c/0x30
> [ 1446.728943]  kasan_set_free_info+0x1b/0x30
> [ 1446.729517]  __kasan_slab_free+0x111/0x160
> [ 1446.730084]  kfree+0xb8/0x520
> [ 1446.730507]  blk_mq_free_map_and_requests+0x10b/0x1b0
> [ 1446.731206]  blk_mq_realloc_hw_ctxs+0x8cb/0x15b0
> [ 1446.731844]  blk_mq_init_allocated_queue+0x374/0x1380
> [ 1446.732540]  blk_mq_init_queue_data+0x7f/0xd0
> [ 1446.733155]  scsi_mq_alloc_queue+0x45/0x170
> [ 1446.733730]  scsi_alloc_sdev+0x73c/0xb20
> [ 1446.734281]  scsi_probe_and_add_lun+0x9a6/0x2d90
> [ 1446.734916]  __scsi_scan_target+0x208/0xc50
> [ 1446.735500]  scsi_scan_channel.part.3+0x113/0x170
> [ 1446.736149]  scsi_scan_host_selected+0x25a/0x360
> [ 1446.736783]  store_scan+0x290/0x2d0
> [ 1446.737275]  dev_attr_store+0x55/0x80
> [ 1446.737782]  sysfs_kf_write+0x132/0x190
> [ 1446.738313]  kernfs_fop_write_iter+0x319/0x4b0
> [ 1446.738921]  new_sync_write+0x40e/0x5c0
> [ 1446.739429]  vfs_write+0x519/0x720
> [ 1446.739877]  ksys_write+0xf8/0x1f0
> [ 1446.740332]  do_syscall_64+0x2d/0x40
> [ 1446.740802]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1446.741462]
> [ 1446.741670] The buggy address belongs to the object at ffff8880185afd00
> [ 1446.741670]  which belongs to the cache kmalloc-256 of size 256
> [ 1446.743276] The buggy address is located 16 bytes inside of
> [ 1446.743276]  256-byte region [ffff8880185afd00, ffff8880185afe00)
> [ 1446.744765] The buggy address belongs to the page:
> [ 1446.745416] page:ffffea0000616b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x185ac
> [ 1446.746694] head:ffffea0000616b00 order:2 compound_mapcount:0 compound_pincount:0
> [ 1446.747719] flags: 0x1fffff80010200(slab|head)
> [ 1446.748337] raw: 001fffff80010200 ffffea00006a3208 ffffea000061bf08 ffff88801004f240
> [ 1446.749404] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> [ 1446.750455] page dumped because: kasan: bad access detected
> [ 1446.751227]
> [ 1446.751445] Memory state around the buggy address:
> [ 1446.752102]  ffff8880185afc00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1446.753090]  ffff8880185afc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1446.754079] >ffff8880185afd00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1446.755065]                          ^
> [ 1446.755589]  ffff8880185afd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 1446.756574]  ffff8880185afe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1446.757566] ==================================================================
> 
> Flag 'BLK_MQ_F_TAG_QUEUE_SHARED' will be set if the second device on the
> same host initializes it's queue successfully. However, if the second
> device failed to allocate memory in blk_mq_alloc_and_init_hctx() from
> blk_mq_realloc_hw_ctxs() from blk_mq_init_allocated_queue(),
> __blk_mq_free_map_and_rqs() will be called on error path, and if
> 'BLK_MQ_TAG_HCTX_SHARED' is not set, 'tag_set->tags' will be freed
> while it's still used by the first device.
> 
> To fix this issue we move release newly allocated hardware context from
> blk_mq_realloc_hw_ctxs to __blk_mq_update_nr_hw_queues. As there is needn't to
> release hardware context in blk_mq_init_allocated_queue.
> 
> Fixes: 868f2f0b7206 ("blk-mq: dynamic h/w context count")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 205d2ca40393..091158aa5416 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3605,7 +3605,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx = hctxs[j];
>  
>  		if (hctx) {
> -			__blk_mq_free_map_and_rqs(set, j);
>  			blk_mq_exit_hctx(q, set, hctx, j);
>  			hctxs[j] = NULL;
>  		}
> @@ -4113,8 +4112,13 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_realloc_hw_ctxs(set, q);
>  		if (q->nr_hw_queues != set->nr_hw_queues) {
> +			int i = prev_nr_hw_queues;
> +
>  			pr_warn("Increasing nr_hw_queues to %d fails, fallback to %d\n",
>  					nr_hw_queues, prev_nr_hw_queues);
> +			for (; i < set->nr_hw_queues; i++)
> +				__blk_mq_free_map_and_rqs(set, i);
> +
>  			set->nr_hw_queues = prev_nr_hw_queues;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

