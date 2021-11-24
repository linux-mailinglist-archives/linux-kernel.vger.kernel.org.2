Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223A845B7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhKXJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhKXJrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:47:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17DE46069B;
        Wed, 24 Nov 2021 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637747077;
        bh=yjmE72mC/OKs8klU+reGLhMZMZTytz5A/I1NSuw/ILU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgWB9mWgK3Y/EI/vSu7+5y2AU4FvrWAg1Nau2ksBBPLNNBbd9vxPXmj2GzT7NZrtT
         T9dDq76Xw7Q6y/zT20kRlN9lpy6TNE2T43fThidghwXVHtJVa5xvSZV6dLke9xhqyO
         e4Jvg0CPNjYvz/MlilGHRwXFAsMzwXn7lEb6HUA4=
Date:   Wed, 24 Nov 2021 10:44:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajith P V <ajithpv.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: reframe comment to avoid warning
Message-ID: <YZ4JgD0Xp8a+ch4j@kroah.com>
References: <20211124093002.9795-1-ajithpv.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124093002.9795-1-ajithpv.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 03:00:02PM +0530, Ajith P V wrote:
> binder.c file comment produce warning with checkpatch as below:
> WARNING: waitqueue_active without comment
> 
> Placing the waitqueue_active comment just above waitqueue_active() avoid
> this warning.
> 
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ---
>  drivers/android/binder.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 49fb74196d02..e1695535f252 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4424,10 +4424,12 @@ static int binder_thread_release(struct binder_proc *proc,
>  	/*
>  	 * If this thread used poll, make sure we remove the waitqueue
>  	 * from any epoll data structures holding it with POLLFREE.
> -	 * waitqueue_active() is safe to use here because we're holding
> -	 * the inner lock.
>  	 */
>  	if ((thread->looper & BINDER_LOOPER_STATE_POLL) &&
> +	    /*
> +	     * waitqueue_active() is safe to use here because we're holding
> +	     * the inner lock.
> +	     */

No, never comment _inside_ a if statement, that is not worth it.

checkpatch is a perl script that provides hints, there is no reason you
have to always follow it exactly. :)

thanks,

greg k-h
