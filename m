Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A18380839
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhENLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhENLPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:15:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE68E613D3;
        Fri, 14 May 2021 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620990873;
        bh=aA79gpOGARxGV/IlCQvQu3pUm+YWNXEoAabdY5rOILU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJNP4OG7k3OQNxTHLFdksfPXYfZ8CBJKmyB/ZiNtZh56P3aMMTbJKYbdJ6ePwF6o8
         gsZxNGJjQbby7mrq5aBq5JCnkb+OTDl4CGeK8yrndP8APhcCxP6nd8opaiyObhgKAs
         GYmWn47RNoFOUhnMDujPMBhpV8NXg5ZYvRmuFE4w=
Date:   Fri, 14 May 2021 13:14:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] misc/uss720: fix memory leak in uss720_probe
Message-ID: <YJ5bllCkul/X+iNk@kroah.com>
References: <20210514110317.2041580-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514110317.2041580-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:03:17PM +0800, Dongliang Mu wrote:
> uss720_probe forgets to decrease the refcount of usbdev in uss720_probe.
> Fix this by decreasing the refcount of usbdev by usb_put_dev.
> 
> BUG: memory leak
> unreferenced object 0xffff888101113800 (size 2048):
>   comm "kworker/0:1", pid 7, jiffies 4294956777 (age 28.870s)
>   hex dump (first 32 bytes):
>     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
>     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
>   backtrace:
>     [<ffffffff82b8e822>] kmalloc include/linux/slab.h:554 [inline]
>     [<ffffffff82b8e822>] kzalloc include/linux/slab.h:684 [inline]
>     [<ffffffff82b8e822>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
>     [<ffffffff82b98441>] hub_port_connect drivers/usb/core/hub.c:5129 [inline]
>     [<ffffffff82b98441>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
>     [<ffffffff82b98441>] port_event drivers/usb/core/hub.c:5509 [inline]
>     [<ffffffff82b98441>] hub_event+0x1171/0x20c0 drivers/usb/core/hub.c:5591
>     [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
>     [<ffffffff81259b19>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
>     [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
>     [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/usb/misc/uss720.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> index b5d661644263..748139d26263 100644
> --- a/drivers/usb/misc/uss720.c
> +++ b/drivers/usb/misc/uss720.c
> @@ -736,6 +736,7 @@ static int uss720_probe(struct usb_interface *intf,
>  	parport_announce_port(pp);
>  
>  	usb_set_intfdata(intf, pp);
> +	usb_put_dev(usbdev);
>  	return 0;
>  
>  probe_abort:
> -- 
> 2.25.1
> 

Nice catch!
