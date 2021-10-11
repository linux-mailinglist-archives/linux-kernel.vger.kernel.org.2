Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D045942881B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhJKHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233968AbhJKHwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:52:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E07A26056B;
        Mon, 11 Oct 2021 07:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633938651;
        bh=vt7hRSEJ/0j6nnL0nAsAkucQu7qYINTLidXoFkkX8H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03kI/vJq8v0Fr4+YlBZSP3b1eiAK5wyNwFWqcJ2uT3iYc4OVlSx6q2FJRrcGgaMjG
         x8e6FVVMW0rjscAUltRdOhb0O5/aRi+DRAXLCt9O7Q0wqc1Ig8u/dBnMt4uD7BsunS
         3twPggK2Dqn/ub3BboZRS7AuZ1wUB441CIYYiKag=
Date:   Mon, 11 Oct 2021 09:50:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     jirislaby@kernel.org, baolin.wang@linux.alibaba.com,
        linux-kernel@vger.kernel.org, zhuo.song@linux.alibaba.com,
        zhangliguang@linux.alibaba.com
Subject: Re: [PATCH] tty: tty_buffer: Fix the softlockup issue in
 flush_to_ldisc
Message-ID: <YWPs13XFRCLl+ewj@kroah.com>
References: <1632971498-57869-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YVVNSS/+RInLPpx/@kroah.com>
 <a4229d29-a512-2dee-1989-9bc2ac10ed55@linux.alibaba.com>
 <YWLoQAg/lyHjq8pz@kroah.com>
 <fd0099ab-2f64-3184-015e-7b7c02db3b1d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd0099ab-2f64-3184-015e-7b7c02db3b1d@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:42:38PM +0800, guanghui.fgh wrote:
> 
> 在 2021/10/10 21:18, Greg KH 写道:
> > On Fri, Oct 08, 2021 at 03:50:15PM +0800, guanghui.fgh wrote:
> > > 在 2021/9/30 13:38, Greg KH 写道:
> > > > On Thu, Sep 30, 2021 at 11:11:38AM +0800, Guanghui Feng wrote:
> > > > > When I run ltp testcase(ltp/testcases/kernel/pty/pty04.c) with arm64, there is a soft lockup,
> > > > > which look like this one:
> > > > > 
> > > > >     watchdog: BUG: soft lockup - CPU#41 stuck for 67s! [kworker/u192:2:106867]
> > > > >     CPU: 41 PID: 106867 Comm: kworker/u192:2 Kdump: loaded Tainted: G           OE     5.10.23 #1
> > > > >     Hardware name: H3C R4960 G3/BC82AMDDA, BIOS 1.70 01/07/2021
> > > > >     Workqueue: events_unbound flush_to_ldisc
> > > > >     pstate: 00c00009 (nzcv daif +PAN +UAO -TCO BTYPE=--)
> > > > >     pc : slip_unesc+0x80/0x214 [slip]
> > > > >     lr : slip_receive_buf+0x84/0x100 [slip]
> > > > >     sp : ffff80005274bce0
> > > > >     x29: ffff80005274bce0 x28: 0000000000000000
> > > > >     x27: ffff00525626fcc8 x26: ffff800011921078
> > > > >     x25: 0000000000000000 x24: 0000000000000004
> > > > >     x23: ffff00402b4059c0 x22: ffff00402b405940
> > > > >     x21: ffff205d87b81e21 x20: ffff205d87b81b9b
> > > > >     x19: 0000000000000000 x18: 0000000000000000
> > > > >     x17: 0000000000000000 x16: 0000000000000000
> > > > >     x15: 0000000000000000 x14: 5f5f5f5f5f5f5f5f
> > > > >     x13: 5f5f5f5f5f5f5f5f x12: 5f5f5f5f5f5f5f5f
> > > > >     x11: 5f5f5f5f5f5f5f5f x10: 5f5f5f5f5f5f5f5f
> > > > >     x9 : ffff8000097d7628 x8 : ffff205d87b85e20
> > > > >     x7 : 0000000000000000 x6 : 0000000000000001
> > > > >     x5 : ffff8000097dc008 x4 : ffff8000097d75a4
> > > > >     x3 : ffff205d87b81e1f x2 : 0000000000000005
> > > > >     x1 : 000000000000005f x0 : ffff00402b405940
> > > > >     Call trace:
> > > > >      slip_unesc+0x80/0x214 [slip]
> > > > >      tty_ldisc_receive_buf+0x64/0x80
> > > > >      tty_port_default_receive_buf+0x50/0x90
> > > > >      flush_to_ldisc+0xbc/0x110
> > > > >      process_one_work+0x1d4/0x4b0
> > > > >      worker_thread+0x180/0x430
> > > > >      kthread+0x11c/0x120
> > > > >     Kernel panic - not syncing: softlockup: hung tasks
> > > > >     CPU: 41 PID: 106867 Comm: kworker/u192:2 Kdump: loaded Tainted: G           OEL    5.10.23 #1
> > > > >     Hardware name: H3C R4960 G3/BC82AMDDA, BIOS 1.70 01/07/2021
> > > > >     Workqueue: events_unbound flush_to_ldisc
> > > > >     Call trace:
> > > > >      dump_backtrace+0x0/0x1ec
> > > > >      show_stack+0x24/0x30
> > > > >      dump_stack+0xd0/0x128
> > > > >      panic+0x15c/0x374
> > > > >      watchdog_timer_fn+0x2b8/0x304
> > > > >      __run_hrtimer+0x88/0x2c0
> > > > >      __hrtimer_run_queues+0xa4/0x120
> > > > >      hrtimer_interrupt+0xfc/0x270
> > > > >      arch_timer_handler_phys+0x40/0x50
> > > > >      handle_percpu_devid_irq+0x94/0x220
> > > > >      __handle_domain_irq+0x88/0xf0
> > > > >      gic_handle_irq+0x84/0xfc
> > > > >      el1_irq+0xc8/0x180
> > > > >      slip_unesc+0x80/0x214 [slip]
> > > > >      tty_ldisc_receive_buf+0x64/0x80
> > > > >      tty_port_default_receive_buf+0x50/0x90
> > > > >      flush_to_ldisc+0xbc/0x110
> > > > >      process_one_work+0x1d4/0x4b0
> > > > >      worker_thread+0x180/0x430
> > > > >      kthread+0x11c/0x120
> > > > >     SMP: stopping secondary CPUs
> > > > > 
> > > > > In the testcase pty04, there are multple processes and we only pay close attention to the
> > > > > first three actually. The first process call the write syscall to send data to the pty master
> > > > > with all one's strength(tty_write->file_tty_write->do_tty_write->n_tty_write call chain).
> > > > > The second process call the read syscall to receive data by the pty slave(with PF_PACKET socket).
> > > > > The third process will wait a moment in which the first two processes will do there work and then
> > > > > it call ioctl to hangup the pty pair which will cease the first two process read/write to the pty.
> > > > > Before hangup the pty, the first process send data to the pty buffhead with high speed. At the same
> > > > > time if the workqueue is waken up, the workqueue will do the flush_to_ldisc to pop data from pty
> > > > > master's buffhead to line discipline in a loop until there is no more data left without any on one's
> > > > > own schedule which will result in doing work in flush_to_ldisc for a long time. As kernel configured
> > > > > without CONFIG_PREEMPT, there maybe occurs softlockup in the flush_to_ldisc. So I add cond_resched
> > > > > in the flush_to_ldisc while loop to avoid it.
> > > > Please properly wrap your changelog text at 72 columns.
> > > When I run ltp testcase(ltp/testcases/kernel/pty/pty04.c) with arm64, there is a soft lockup,
> > > which look like this one:
> > > Call trace:
> > >     dump_backtrace+0x0/0x1ec
> > >     show_stack+0x24/0x30
> > >     dump_stack+0xd0/0x128
> > >     panic+0x15c/0x374
> > >     watchdog_timer_fn+0x2b8/0x304
> > >     __run_hrtimer+0x88/0x2c0
> > >     __hrtimer_run_queues+0xa4/0x120
> > >     hrtimer_interrupt+0xfc/0x270
> > >     arch_timer_handler_phys+0x40/0x50
> > >     handle_percpu_devid_irq+0x94/0x220
> > >     __handle_domain_irq+0x88/0xf0
> > >     gic_handle_irq+0x84/0xfc
> > >     el1_irq+0xc8/0x180
> > >     slip_unesc+0x80/0x214 [slip]
> > >     tty_ldisc_receive_buf+0x64/0x80
> > >     tty_port_default_receive_buf+0x50/0x90
> > >     flush_to_ldisc+0xbc/0x110
> > >     process_one_work+0x1d4/0x4b0
> > >     worker_thread+0x180/0x430
> > >     kthread+0x11c/0x120
> > > 
> > > In the testcase pty04, The first process call the write syscall to send data to the pty master.
> > > At the same time if the workqueue is waken up, the workqueue will do the flush_to_ldisc to pop data
> > > in a loop until there is no more data left which will result in doing work in flush_to_ldisc for a
> > > long time. As kernel configured without CONFIG_PREEMPT, there maybe occurs softlockup in the flush_to_ldisc.
> > Is this a "real" test for something that you have seen in a normal
> > workload?  ltp is known for having buggy/confusing tests in it in the
> > past, you might wish to consult with the authors of that test.
> 
> Firstly, thanks for your response.
> 
> I have check the ltp pty testcase. At the same time, I find the pty
> softlockup in arm64, and it is similar to others.
> 
> https://github.com/victronenergy/venus/issues/350
> 
> https://groups.google.com/g/syzkaller-lts-bugs/c/SpkH8yH26js/m/3aifBl_GAwAJ

Hm, ok, can you please resubmit this based on the changes discussed in
thread and I will re-review it again.

thanks,

greg k-h
