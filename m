Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732B9314A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBIIjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhBIIjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:39:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC2664DE8;
        Tue,  9 Feb 2021 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612859940;
        bh=8fytPU3zJcLBLMRd9bq+zgCRdOowwJBrd8hM6uHsRKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB/p5Ae0Pk0hk/yGesVDbVNustludG2NHk58SUYPQY4WH3G16nTdZuJqINzZ07zjH
         BvP2sz0FBK9MAX2dOg1w2KjYp4vidQFOtGand974SocDK+YVfWLoushwF9P4FR/4PJ
         /NXdj1JoKc3FZAWb4kAX89iMantuUUFtZwdDZWyg=
Date:   Tue, 9 Feb 2021 09:38:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     arnd@arndb.de, alex.dewar90@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers/misc/vmw_vmci: restrict too big queue size in
 qp_host_alloc_queue
Message-ID: <YCJKIVhNS4N4glUa@kroah.com>
References: <20210206053409.1972270-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206053409.1972270-1-snovitoll@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 11:34:09AM +0600, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
> when num_pages is 0x100001, giving queue_size + queue_page_size
> bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
> condition.
> 
> queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.
> 
> 
> FYI, I've also noticed in vmci_queue_pair.c other SLAB allocations with no
> length check that might exceed KMALLOC_MAX_SIZE as well,
> but syzbot doesn't have reproduces for them.
> 
> in qp_alloc_ppn_set():
> 	produce_ppns =
> 	    kmalloc_array(num_produce_pages, sizeof(*produce_ppns),
> 			  GFP_KERNEL);
> [..]
> 	consume_ppns =
> 	    kmalloc_array(num_consume_pages, sizeof(*consume_ppns),
> 			  GFP_KERNEL);
> [..]
> in qp_alloc_hypercall():
> 	msg_size = sizeof(*alloc_msg) +
> 	    (size_t) entry->num_ppns * ppn_size;
> 	alloc_msg = kmalloc(msg_size, GFP_KERNEL);
> [..]
> in qp_broker_create():
> 	entry->local_mem = kcalloc(QPE_NUM_PAGES(entry->qp),
> 					   PAGE_SIZE, GFP_KERNEL);
> 
> [1]
> Call Trace:
>  alloc_pages include/linux/gfp.h:547 [inline]
>  kmalloc_order+0x40/0x130 mm/slab_common.c:837
>  kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
>  kmalloc_large include/linux/slab.h:481 [inline]
>  __kmalloc+0x257/0x330 mm/slub.c:3959
>  kmalloc include/linux/slab.h:557 [inline]
>  kzalloc include/linux/slab.h:682 [inline]
>  qp_host_alloc_queue drivers/misc/vmw_vmci/vmci_queue_pair.c:540 [inline]
>  qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1351 [inline]
>  qp_broker_alloc+0x936/0x2740 drivers/misc/vmw_vmci/vmci_queue_pair.c:1739
> 
> Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index c49065887e8f..f6af406fda80 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -537,6 +537,11 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
>  
>  	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
>  
> +	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
> +		pr_warn("too big queue to allocate\n");

As this is controllable by userspace, you just provided a way to flood
the kernel logs.

Please make this a dev_dbg() call instead, if you really want to see it.
Otherwise just return NULL, no need to report anything, right?

thanks,

greg k-h
