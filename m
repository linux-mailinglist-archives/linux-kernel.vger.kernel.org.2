Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF23EB18B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhHMHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhHMHd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:33:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86E4960720;
        Fri, 13 Aug 2021 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628840012;
        bh=/Ez7HIp0+x6gkQ+AXt7EEyRoY2iUgGHXpwEagk1RKCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzTtsDLO6hrRf1Kjf1f+mnW0PKeqBbHHUQDaGx/+IcI7qjKN63ucgw3OZw+qeNTdr
         eAiF7XUSphEMaUqwI24TgogVna/wL0nWwDNYbH5ggprJAovLp1MH/4m4GtlDz7jv1S
         CA/wuFx+U6ggIhw5FH5h0WjviZknlKjFn2NeAlQc=
Date:   Fri, 13 Aug 2021 09:33:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     jirislaby@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: Fix data race between tiocsti() and flush_to_ldisc()
Message-ID: <YRYgSZwivcPPMhrS@kroah.com>
References: <20210807190513.3810821-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807190513.3810821-1-phind.uet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 03:05:13AM +0800, Nguyen Dinh Phi wrote:
> The ops->receive_buf() may be accessed concurrently from these two
> functions.  If the driver flushes data to the line discipline
> receive_buf() method while tiocsti() is using the ops->receive_buf(),
> the data race will happen.
> 
> For example:
> tty_ioctl                       |tty_ldisc_receive_buf
>  ->tioctsi                      | ->tty_port_default_receive_buf
>                                 |  ->tty_ldisc_receive_buf
>    ->hci_uart_tty_receive       |   ->hci_uart_tty_receive
>     ->h4_recv                   |    ->h4_recv
> 
> In this case, the h4 receive buffer will be overwritten by the
> latecomer, and it cause a memory leak.

That looks to be a bug in the h4 code, if the receive_buf() call can not
be run at the same time, it should have a lock in it, right?

> Hence, change tioctsi() function to use the exclusive lock interface
> from tty_buffer to avoid the data race.

Where is the lock being grabbed from the other receive_buf() call path
to ensure that the lock is always needed here?

> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
> ---
>  drivers/tty/tty_io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e8532006e960..746fe13a2054 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2307,8 +2307,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
>  	ld = tty_ldisc_ref_wait(tty);
>  	if (!ld)
>  		return -EIO;
> +	tty_buffer_lock_exclusive(tty->port);
>  	if (ld->ops->receive_buf)
>  		ld->ops->receive_buf(tty, &ch, &mbz, 1);
> +	tty_buffer_unlock_exclusive(tty->port);

Did this fix the syzbot reported issue?

thanks,

greg k-h
