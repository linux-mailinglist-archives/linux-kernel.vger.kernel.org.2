Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBBF314C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBIJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhBIJzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:55:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABFE364E79;
        Tue,  9 Feb 2021 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612864468;
        bh=+XvzaxdosEic4u2SHLlgNZI+5+0Yda1zcW851LvndHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiiGg12Xz22BcNq8r8gWbN3KrAeTxAskIfw428l8JHm26cxK4O6Itg+7ww4ICEYRq
         09z/7Z210ci9MBd+fwYyVQlvKowQxNkG2iWZ0sKVHWx+AjOYyNuzE2gE2/msKSL1TS
         rD7vSfEBP4ajskCca1nGLvZiQbHXzyx3oDBbicuE=
Date:   Tue, 9 Feb 2021 10:54:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     alex.dewar90@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] drivers/misc/vmw_vmci: restrict too big queue size in
Message-ID: <YCJb0Rc8ruCQIJMM@kroah.com>
References: <a10296cf-4545-c7f3-1d3c-31fbd05c3f6c@gmail.com>
 <20210209094525.2099687-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209094525.2099687-1-snovitoll@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 03:45:25PM +0600, Sabyrzhan Tasbolatov wrote:
> > syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
> > when num_pages is 0x100001, giving queue_size + queue_page_size
> > bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
> > condition.
> >
> > queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.
> >

Why is this "quoted"?

> Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> >>> As this is controllable by userspace, you just provided a way to flood
> >>> the kernel logs.
> >>>
> >>> Please make this a dev_dbg() call instead, if you really want to see it.
> >>> Otherwise just return NULL, no need to report anything, right?
> >> Thanks, removed pr_warn().
> 
> >Looks like you forgot to take out the opening brace.
> 
> Cringe moment. Sorry, should've checked it properly first.
> 
> v3: Removed opening brace.
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index ea16df73cde0..024dcdbd9d01 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -537,7 +537,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
>  
>  	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
>  
> -	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
> +	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE)
>  		return NULL;

This patch does not apply to the tree...

thanks,

greg k-h
