Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7C408958
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbhIMKuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhIMKuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:50:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21E2160F6F;
        Mon, 13 Sep 2021 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631530130;
        bh=Wxaw+KP0V8UKDq+RA96HBy/jG1au4CAvk8EF76HP/lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7EYEyxcPig/i0OF1GT4Pfw7lNt0Z7laN1QVA40LZW+RVKTZmAYcSHWwcRFIZhU33
         MErTftZr5ilwKbewpFnB6r0KdXLalAOK31N8HCoKg+ixXKGqJ87OU4Vjxqh1HKWLAD
         3BLzvh5KLO7qSbwgNC/UjCm09CYqQa5r+tZ9f/yo=
Date:   Mon, 13 Sep 2021 12:48:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, oswalpalash@gmail.com,
        sudipm.mukherjee@gmail.com,
        syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com,
        viro@zeniv.linux.org.uk, stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring: reexpand under-reexpanded iters" has been added
 to the 5.14-stable tree
Message-ID: <YT8skKSjmYJQ7VS2@kroah.com>
References: <16315263357760@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16315263357760@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:45:35AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring: reexpand under-reexpanded iters
> 
> to the 5.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-reexpand-under-reexpanded-iters.patch
> and it can be found in the queue-5.14 subdirectory.
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
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3324,6 +3324,7 @@ static int io_read(struct io_kiocb *req,
>  		if (req->flags & REQ_F_NOWAIT)
>  			goto done;
>  		/* some cases will consume bytes even on error returns */
> +		iov_iter_reexpand(iter, iter->count + iter->truncated);
>  		iov_iter_revert(iter, io_size - iov_iter_count(iter));
>  		ret = 0;
>  	} else if (ret == -EIOCBQUEUED) {
> @@ -3463,6 +3464,7 @@ done:
>  	} else {
>  copy_iov:
>  		/* some cases will consume bytes even on error returns */
> +		iov_iter_reexpand(iter, iter->count + iter->truncated);
>  		iov_iter_revert(iter, io_size - iov_iter_count(iter));
>  		ret = io_setup_async_rw(req, iovec, inline_vecs, iter, false);
>  		return ret ?: -EAGAIN;
> 
> 
> Patches currently in stable-queue which might be from asml.silence@gmail.com are
> 
> queue-5.14/io_uring-limit-fixed-table-size-by-rlimit_nofile.patch
> queue-5.14/io_uring-reexpand-under-reexpanded-iters.patch
> queue-5.14/io_uring-fail-links-of-cancelled-timeouts.patch
> queue-5.14/bio-fix-page-leak-bio_add_hw_page-failure.patch

Also dropped from this queue.


