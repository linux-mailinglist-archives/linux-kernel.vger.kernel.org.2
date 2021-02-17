Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034631DC10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhBQPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhBQPOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:14:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567BE64E0F;
        Wed, 17 Feb 2021 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613574840;
        bh=iuGVjuKWREQmg5b0jXBrhxg0JwV/UXkNKH+uGyjfB4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgjbStb7sKQsQEjJxHr4lJLy+VyKRrN8Dn3hNIu84UGs/mDeKHl83wv7t4Z5WsvXi
         bvCjkL/NBrSfoVNie+tAF+5rlNtNwLVr/juvExtfhR5rSI8PeGx/P+m2VYvZtUth5L
         wMg5u78s4or77/TxtD7dIusJ9rp2YlJh/DATdxLU=
Date:   Wed, 17 Feb 2021 16:13:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: fix when iov_iter_count() returns 0 in tty_write()
Message-ID: <YC0ytokrZPUitjVS@kroah.com>
References: <20210217144347.2962551-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217144347.2962551-1-snovitoll@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 08:43:47PM +0600, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNING in iov_iter_revert[1] when iov_iter_count() returns 0,
> therefore INT_MAX is passed to iov_iter_revert() causing > MAX_RW_COUNT
> warning.
> 
> static inline ssize_t do_tty_write()
> {
> ..
> 	size_t count = iov_iter_count(from);
> ..
> 		size_t size = count;
> 		if (ret != size)
> 			iov_iter_revert(from, size-ret);
> 
> [1] WARNING: lib/iov_iter.c:1090
> Call Trace:
>  do_tty_write drivers/tty/tty_io.c:967 [inline]
>  file_tty_write.constprop.0+0x55f/0x8f0 drivers/tty/tty_io.c:1048
>  call_write_iter include/linux/fs.h:1901 [inline]
>  new_sync_write+0x426/0x650 fs/read_write.c:518
>  vfs_write+0x791/0xa30 fs/read_write.c:605
>  ksys_write+0x12d/0x250 fs/read_write.c:658
> 
> Fixes: 494e63ee9c("tty: implement write_iter")

Nit, you need a ' ' before your '(' character here, otherwise the
linux-next scripts will complain.

> Reported-by: syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  drivers/tty/tty_io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 816e709afa56..8d6d579ecc3b 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -905,6 +905,9 @@ static inline ssize_t do_tty_write(
>  	ssize_t ret, written = 0;
>  	unsigned int chunk;
>  
> +	if (!count)
> +		return -EINVAL;

According to the man page for write(2), I think this is the wrong error
value to return, unless that is the value that was returned on kernels
before the commit listed above.

Can you verify this?

thanks,

greg k-h
