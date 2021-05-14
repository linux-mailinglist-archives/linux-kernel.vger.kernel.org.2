Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75B3809B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhENMiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232712AbhENMh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:37:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BC57613AA;
        Fri, 14 May 2021 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620995805;
        bh=hyertDNlfhFKOOJ8yfd61vbbV9AbUCAAb5FsoMme4cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2M1F9MymaSYeIARmPHvk2g0g8q7tMtkxUdfSv6jfC+y0zgaQ/OXAronVhQMNEOmX
         9ejSVLY9N+uQHYW1n4XEnDMn74o7BcXY93Pr6XGRnFLvJaL3+kt+5lGKNgrEwmaNKo
         f5B4NS+MEdEpc79PtOV29fw+ZmYJ1byQPS6REs4Q=
Date:   Fri, 14 May 2021 14:36:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] misc/uss720: fix memory leak in uss720_probe
Message-ID: <YJ5u2oEjJyF+e0JU@kroah.com>
References: <20210514123425.6345-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514123425.6345-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 08:34:25PM +0800, Dongliang Mu wrote:
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
> Fixes: 0f36163d3abe ("usb: fix uss720 schedule with interrupts off")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/usb/misc/uss720.c | 1 +
>  1 file changed, 1 insertion(+)

What changed from v1?  That always goes below the --- line.

Please fix and send a v3.

thanks,

greg k-h
