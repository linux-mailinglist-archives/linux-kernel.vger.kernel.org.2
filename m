Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237EF41D2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbhI3FkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348054AbhI3FkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2827B617E4;
        Thu, 30 Sep 2021 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632980301;
        bh=ektgEbwMsZtMwKGt44UyjSatUKke20NODsVIVMli95U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCMlSl/+t8WSE1HGf4gNs36pgpNdrCb2uQsKVr6PCuKUA/mHL2ls6d4fvvMAaE3fm
         d+MoTaFiXpNnAZh9haGnvW+pZS5Agjn8VUNy34oYFzVlVnLxnUxNioDJKInHYD9+xT
         mfJDBss81Fj/t7RKewjoHMsljgpORyDLCaf1px7A=
Date:   Thu, 30 Sep 2021 07:38:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     jirislaby@kernel.org, baolin.wang@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: tty_buffer: Fix the softlockup issue in
 flush_to_ldisc
Message-ID: <YVVNSS/+RInLPpx/@kroah.com>
References: <1632971498-57869-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632971498-57869-1-git-send-email-guanghuifeng@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:11:38AM +0800, Guanghui Feng wrote:
> When I run ltp testcase(ltp/testcases/kernel/pty/pty04.c) with arm64, there is a soft lockup,
> which look like this one:
> 
>   watchdog: BUG: soft lockup - CPU#41 stuck for 67s! [kworker/u192:2:106867]
>   CPU: 41 PID: 106867 Comm: kworker/u192:2 Kdump: loaded Tainted: G           OE     5.10.23 #1
>   Hardware name: H3C R4960 G3/BC82AMDDA, BIOS 1.70 01/07/2021
>   Workqueue: events_unbound flush_to_ldisc
>   pstate: 00c00009 (nzcv daif +PAN +UAO -TCO BTYPE=--)
>   pc : slip_unesc+0x80/0x214 [slip]
>   lr : slip_receive_buf+0x84/0x100 [slip]
>   sp : ffff80005274bce0
>   x29: ffff80005274bce0 x28: 0000000000000000
>   x27: ffff00525626fcc8 x26: ffff800011921078
>   x25: 0000000000000000 x24: 0000000000000004
>   x23: ffff00402b4059c0 x22: ffff00402b405940
>   x21: ffff205d87b81e21 x20: ffff205d87b81b9b
>   x19: 0000000000000000 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: 0000000000000000 x14: 5f5f5f5f5f5f5f5f
>   x13: 5f5f5f5f5f5f5f5f x12: 5f5f5f5f5f5f5f5f
>   x11: 5f5f5f5f5f5f5f5f x10: 5f5f5f5f5f5f5f5f
>   x9 : ffff8000097d7628 x8 : ffff205d87b85e20
>   x7 : 0000000000000000 x6 : 0000000000000001
>   x5 : ffff8000097dc008 x4 : ffff8000097d75a4
>   x3 : ffff205d87b81e1f x2 : 0000000000000005
>   x1 : 000000000000005f x0 : ffff00402b405940
>   Call trace:
>    slip_unesc+0x80/0x214 [slip]
>    tty_ldisc_receive_buf+0x64/0x80
>    tty_port_default_receive_buf+0x50/0x90
>    flush_to_ldisc+0xbc/0x110
>    process_one_work+0x1d4/0x4b0
>    worker_thread+0x180/0x430
>    kthread+0x11c/0x120
>   Kernel panic - not syncing: softlockup: hung tasks
>   CPU: 41 PID: 106867 Comm: kworker/u192:2 Kdump: loaded Tainted: G           OEL    5.10.23 #1
>   Hardware name: H3C R4960 G3/BC82AMDDA, BIOS 1.70 01/07/2021
>   Workqueue: events_unbound flush_to_ldisc
>   Call trace:
>    dump_backtrace+0x0/0x1ec
>    show_stack+0x24/0x30
>    dump_stack+0xd0/0x128
>    panic+0x15c/0x374
>    watchdog_timer_fn+0x2b8/0x304
>    __run_hrtimer+0x88/0x2c0
>    __hrtimer_run_queues+0xa4/0x120
>    hrtimer_interrupt+0xfc/0x270
>    arch_timer_handler_phys+0x40/0x50
>    handle_percpu_devid_irq+0x94/0x220
>    __handle_domain_irq+0x88/0xf0
>    gic_handle_irq+0x84/0xfc
>    el1_irq+0xc8/0x180
>    slip_unesc+0x80/0x214 [slip]
>    tty_ldisc_receive_buf+0x64/0x80
>    tty_port_default_receive_buf+0x50/0x90
>    flush_to_ldisc+0xbc/0x110
>    process_one_work+0x1d4/0x4b0
>    worker_thread+0x180/0x430
>    kthread+0x11c/0x120
>   SMP: stopping secondary CPUs
> 
> In the testcase pty04, there are multple processes and we only pay close attention to the
> first three actually. The first process call the write syscall to send data to the pty master
> with all one's strength(tty_write->file_tty_write->do_tty_write->n_tty_write call chain).
> The second process call the read syscall to receive data by the pty slave(with PF_PACKET socket).
> The third process will wait a moment in which the first two processes will do there work and then
> it call ioctl to hangup the pty pair which will cease the first two process read/write to the pty.
> Before hangup the pty, the first process send data to the pty buffhead with high speed. At the same
> time if the workqueue is waken up, the workqueue will do the flush_to_ldisc to pop data from pty
> master's buffhead to line discipline in a loop until there is no more data left without any on one's
> own schedule which will result in doing work in flush_to_ldisc for a long time. As kernel configured
> without CONFIG_PREEMPT, there maybe occurs softlockup in the flush_to_ldisc. So I add cond_resched
> in the flush_to_ldisc while loop to avoid it.

Please properly wrap your changelog text at 72 columns.


> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/tty/tty_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index bd2d915..77b92f9 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -534,6 +534,7 @@ static void flush_to_ldisc(struct work_struct *work)
>  		if (!count)
>  			break;
>  		head->read += count;
> +		cond_resched();

This is almost never the correct solution for fixing a problem in the
kernel anymore.

And if it is, it needs to be documented really really well.  I think you
just slowed down the overall throughput of a tty device by adding this
call, so are you sure you didn't break something?

And why are you not running with a preempt kernel here?  What prevents
that from being enabled to solve issues like this?

Also, having only one CPU burning through a network workload like this
seems correct to me, why would you want the CPU to stop handling the
data being sent to it like this?  You have at least 40 other ones to do
other things here :)

thanks,

greg k-h
