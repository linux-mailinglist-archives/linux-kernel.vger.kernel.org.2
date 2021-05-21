Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E156138C1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhEUIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhEUIea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:34:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 282A961057;
        Fri, 21 May 2021 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621585987;
        bh=r3Y3Irt9vc3+emkU/7FWi7UErj+yI949Tb/d7fnwJWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tasH7JTpAWWMCy0emzTHLlX5NmK2P/IovEp4Y6VF1BI9IRIfIiXrHZTkUVRzLxEZQ
         2IwibHFSopkjaFf8GBYxGccSayIMpNrWuB0K/HPaEwD0zx5XJpaFhHP3AzgMt2zemr
         Rx9VCH+qhlp/T6qi73kU5DKfM321gL4++K2zCO58=
Date:   Fri, 21 May 2021 10:33:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gao Yan <gao.yanB@h3c.com>
Cc:     jirislaby@kernel.org, paulus@samba.org, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove unnecessary disc_data_lock in ppp line
 discipline
Message-ID: <YKdwQYgsl4wwGB0s@kroah.com>
References: <20210521075726.20568-1-gao.yanB@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521075726.20568-1-gao.yanB@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:57:26PM +0800, Gao Yan wrote:
> In tty layer, it use tty->ldisc_sem(using tty_ldisc_ref_wait and
> tty_ldisc_deref) to proect tty_ldisc_ops.
> 
> So I think tty->ldisc_sem can also protect tty->disc_data;
> For examlpe, When cpu A is running ppp_synctty_ioctl that hold
> the tty->ldisc_sem, at the same time  if cpu B calls ppp_synctty_close,
> it will wait until cpu A release tty->ldisc_sem.
> 
> So I think it is unnecessary to define additional disc_data_lock;
> 
> cpu A                           cpu B
> tty_ioctl                       tty_reopen
>  ->hold tty->ldisc_sem            ->hold tty->ldisc_sem(write), failed
>  ->ld->ops->ioctl                 ->wait...
>  ->release tty->ldisc_sem         ->wait...OK,hold tty->ldisc_sem
>                                     ->tty_ldisc_reinit
>                                       ->tty_ldisc_close
>                                         ->ld->ops->close
> 
> Signed-off-by: Gao Yan <gao.yanB@h3c.com>
> ---
>  drivers/net/ppp/ppp_async.c   | 11 ++---------
>  drivers/net/ppp/ppp_synctty.c | 11 ++---------
>  2 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
> index 8b41aa3fb..7bc4846f5 100644
> --- a/drivers/net/ppp/ppp_async.c
> +++ b/drivers/net/ppp/ppp_async.c
> @@ -127,17 +127,13 @@ static const struct ppp_channel_ops async_ops = {
>   * FIXME: this is no longer true. The _close path for the ldisc is
>   * now guaranteed to be sane.
>   */
> -static DEFINE_RWLOCK(disc_data_lock);
>  
>  static struct asyncppp *ap_get(struct tty_struct *tty)
>  {
> -	struct asyncppp *ap;
> +	struct asyncppp *ap = tty->disc_data;
>  
> -	read_lock(&disc_data_lock);
> -	ap = tty->disc_data;
>  	if (ap != NULL)
>  		refcount_inc(&ap->refcnt);
> -	read_unlock(&disc_data_lock);
>  	return ap;
>  }
>  
> @@ -214,12 +210,9 @@ ppp_asynctty_open(struct tty_struct *tty)
>  static void
>  ppp_asynctty_close(struct tty_struct *tty)
>  {
> -	struct asyncppp *ap;
> +	struct asyncppp *ap = tty->disc_data;
>  
> -	write_lock_irq(&disc_data_lock);
> -	ap = tty->disc_data;
>  	tty->disc_data = NULL;
> -	write_unlock_irq(&disc_data_lock);
>  	if (!ap)
>  		return;
>  
> diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
> index 576b6a93b..812f309c5 100644
> --- a/drivers/net/ppp/ppp_synctty.c
> +++ b/drivers/net/ppp/ppp_synctty.c
> @@ -129,17 +129,13 @@ ppp_print_buffer (const char *name, const __u8 *buf, int count)
>   *
>   * FIXME: Fixed in tty_io nowadays.
>   */
> -static DEFINE_RWLOCK(disc_data_lock);
>  
>  static struct syncppp *sp_get(struct tty_struct *tty)
>  {
> -	struct syncppp *ap;
> +	struct syncppp *ap = tty->disc_data;
>  
> -	read_lock(&disc_data_lock);
> -	ap = tty->disc_data;
>  	if (ap != NULL)
>  		refcount_inc(&ap->refcnt);
> -	read_unlock(&disc_data_lock);
>  	return ap;
>  }
>  
> @@ -213,12 +209,9 @@ ppp_sync_open(struct tty_struct *tty)
>  static void
>  ppp_sync_close(struct tty_struct *tty)
>  {
> -	struct syncppp *ap;
> +	struct syncppp *ap = tty->disc_data;
>  
> -	write_lock_irq(&disc_data_lock);
> -	ap = tty->disc_data;
>  	tty->disc_data = NULL;
> -	write_unlock_irq(&disc_data_lock);
>  	if (!ap)
>  		return;
>  
> -- 
> 2.17.1
> 

So removing this lock is ok?

How did you test this?  Is there anything wrong with keeping the
existing lock?  Does it show up in a real-world workload as being a
problem?  Unconstested locks should be almost a no-op.

thanks,

greg k-h
