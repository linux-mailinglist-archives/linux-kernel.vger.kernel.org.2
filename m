Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8A4311AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhJRH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhJRH7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:59:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AECFF60E76;
        Mon, 18 Oct 2021 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634543847;
        bh=wizAlz3nkzwk1hhzFyfhTjq3YJTZcPcoMIebpmvCLu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/f4aW3unDdT8GlzNEw/RQ+Ddk6bp9mLbJIW23NRg8eHvca2eH6SmmBzgihck6KMy
         fsGaUtFbzZoJTQGT7nPQOcrj4nF7XVBK757ChWAKx9MDySmB2aQT3zntHttBQ+YR+U
         WWBpF0y6ZBb4AbLi8pc1+SbfG8fzCYmTnmK82i6nL45Dwa171uOyz3IUI4JN//0NNe
         mHMZ7Z5bM4BB+lKsiEglv6NhMTEdqAqZbpccxpw+YfOERWCmQEbEC9MQ5TrMmyo+Qq
         DO//whpovw0TIGaF7L7fKKMQwNXv+dy47NMMnZ0+WsH3Q094YArH31OrP5/dDQTNeu
         0nCOsGlxck2Fw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mcNWI-0002e0-50; Mon, 18 Oct 2021 09:57:18 +0200
Date:   Mon, 18 Oct 2021 09:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: Fix possible memleak in
 keyspan_port_probe()
Message-ID: <YW0o3hv6mG+NQ3f5@hovoldconsulting.com>
References: <20211015085543.1203011-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015085543.1203011-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:55:43PM +0800, Wang Hai wrote:
> I got memory leak as follows when doing fault injection test:
> 
> unreferenced object 0xffff888258228440 (size 64):
>   comm "kworker/7:2", pid 2005, jiffies 4294989509 (age 824.540s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8167939c>] slab_post_alloc_hook+0x9c/0x490
>     [<ffffffff8167f627>] kmem_cache_alloc_trace+0x1f7/0x470
>     [<ffffffffa02ac0e4>] keyspan_port_probe+0xa4/0x5d0 [keyspan]
>     [<ffffffffa0294c07>] usb_serial_device_probe+0x97/0x1d0 [usbserial]
>     [<ffffffff82b50ca7>] really_probe+0x167/0x460
>     [<ffffffff82b51099>] __driver_probe_device+0xf9/0x180
>     [<ffffffff82b51173>] driver_probe_device+0x53/0x130
>     [<ffffffff82b516f5>] __device_attach_driver+0x105/0x130
>     [<ffffffff82b4cfe9>] bus_for_each_drv+0x129/0x190
>     [<ffffffff82b50a69>] __device_attach+0x1c9/0x270
>     [<ffffffff82b518d0>] device_initial_probe+0x20/0x30
>     [<ffffffff82b4f062>] bus_probe_device+0x142/0x160
>     [<ffffffff82b4a4e9>] device_add+0x829/0x1300
>     [<ffffffffa0295fda>] usb_serial_probe.cold+0xc9b/0x14ac [usbserial]
>     [<ffffffffa02266aa>] usb_probe_interface+0x1aa/0x3c0 [usbcore]
>     [<ffffffff82b50ca7>] really_probe+0x167/0x460
> 
> If it fails to allocate memory for an out_buffer[i] or in_buffer[i],
> the previously allocated memory for out_buffer or in_buffer needs to
> be freed on the error handling path, otherwise a memory leak will result.
> 
> Fixes: bad41a5bf177 ("USB: keyspan: fix port DMA-buffer allocations")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: rename error labels

Thanks for the update. Now applied with a slightly amended commit
message:

	USB: serial: keyspan: fix memleak on probe errors

	...

	If keyspan_port_probe() fails...

Johan
