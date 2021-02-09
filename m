Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D7314C21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBIJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhBIJtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:49:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0012164E77;
        Tue,  9 Feb 2021 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612864150;
        bh=nEewrMAUeYK4aam0HpuXalNokQ+rdLXp/Q8WccuvwhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUudAXejpLYwVGcnxiXdzL2Z3e9LsSxYOH0bdHHzartLohDlznMlhBARv9VIF+vtY
         9VRYXcndIyM6lZXQd+7eoO0j3goVesIrBH0FvaMfvRA69aPrfRM7PGMj0yRpyfKk4Q
         2xxg/uLGkB4Q2X+QNrEd4KG7by1fgehm9vtLCQ6U=
Date:   Tue, 9 Feb 2021 10:49:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     alex.dewar90@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] drivers/misc/vmw_vmci: restrict too big queue size in
Message-ID: <YCJak9a2WWRgiQWE@kroah.com>
References: <YCJKIVhNS4N4glUa@kroah.com>
 <20210209093101.2097627-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209093101.2097627-1-snovitoll@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 03:31:01PM +0600, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
> when num_pages is 0x100001, giving queue_size + queue_page_size
> bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
> condition.
> 
> queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.
> 
> Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> >As this is controllable by userspace, you just provided a way to flood
> >the kernel logs.
> >
> >Please make this a dev_dbg() call instead, if you really want to see it.
> >Otherwise just return NULL, no need to report anything, right?
> 
> Thanks, removed pr_warn().
> 
> v2: Removed pr_warn() to avoid flood from user-space
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index f6af406fda80..ea16df73cde0 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -538,9 +538,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
>  	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
>  
>  	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
> -		pr_warn("too big queue to allocate\n");
>  		return NULL;
> -	}
>  

This patch doesn't apply to the tree, you can't send me a patch that is
relative to your previous one, that doesn't work at all.

And also, test-build your patches always first, to not do so is a bit
rude to maintainers...

thanks,

greg k-h
