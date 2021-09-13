Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68077408952
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhIMKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234958AbhIMKtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED28760F6F;
        Mon, 13 Sep 2021 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631530072;
        bh=8kcuxVPalHGvYq4SPR3oLOhdx4N7EXhYTPJfVE9hDXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4jNPDy/TrsTn8SwUMIut9LkHUNarVZ0zF5ZKHBcCjs2+3Tttb1QrUZEBzQqUU/+G
         piqBCJLHqHa2ENEzDCjesLv7KpnoVOSoHvktOKU2bEPj0L0SFqas3usVw4l7BWy5QU
         iTaDl4WmIT8ueON18RH+6LsUvOqSQA2ILOYP6szM=
Date:   Mon, 13 Sep 2021 12:47:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, oswalpalash@gmail.com,
        sudipm.mukherjee@gmail.com,
        syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com,
        viro@zeniv.linux.org.uk, stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring: reexpand under-reexpanded iters" has been added
 to the 5.13-stable tree
Message-ID: <YT8sVh7+Vr+fmVnC@kroah.com>
References: <1631526315154131@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631526315154131@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:45:15AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring: reexpand under-reexpanded iters
> 
> to the 5.13-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-reexpand-under-reexpanded-iters.patch
> and it can be found in the queue-5.13 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 89c2b3b74918200e46699338d7bcc19b1ea12110 Mon Sep 17 00:00:00 2001
> From: Pavel Begunkov <asml.silence@gmail.com>
> Date: Mon, 23 Aug 2021 11:18:45 +0100
> Subject: io_uring: reexpand under-reexpanded iters
> 
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> commit 89c2b3b74918200e46699338d7bcc19b1ea12110 upstream.
> 
> [   74.211232] BUG: KASAN: stack-out-of-bounds in iov_iter_revert+0x809/0x900
> [   74.212778] Read of size 8 at addr ffff888025dc78b8 by task
> syz-executor.0/828
> [   74.214756] CPU: 0 PID: 828 Comm: syz-executor.0 Not tainted
> 5.14.0-rc3-next-20210730 #1
> [   74.216525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   74.219033] Call Trace:
> [   74.219683]  dump_stack_lvl+0x8b/0xb3
> [   74.220706]  print_address_description.constprop.0+0x1f/0x140
> [   74.224226]  kasan_report.cold+0x7f/0x11b
> [   74.226085]  iov_iter_revert+0x809/0x900
> [   74.227960]  io_write+0x57d/0xe40
> [   74.232647]  io_issue_sqe+0x4da/0x6a80
> [   74.242578]  __io_queue_sqe+0x1ac/0xe60
> [   74.245358]  io_submit_sqes+0x3f6e/0x76a0
> [   74.248207]  __do_sys_io_uring_enter+0x90c/0x1a20
> [   74.257167]  do_syscall_64+0x3b/0x90
> [   74.257984]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> old_size = iov_iter_count();
> ...
> iov_iter_revert(old_size - iov_iter_count());
> 
> If iov_iter_revert() is done base on the initial size as above, and the
> iter is truncated and not reexpanded in the middle, it miscalculates
> borders causing problems. This trace is due to no one reexpanding after
> generic_write_checks().
> 
> Now iters store how many bytes has been truncated, so reexpand them to
> the initial state right before reverting.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Palash Oswal <oswalpalash@gmail.com>
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Reported-and-tested-by: syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/io_uring.c |    2 ++
>  1 file changed, 2 insertions(+)
> 

No, sorry, this breaks the build, now dropping.

greg k-h
