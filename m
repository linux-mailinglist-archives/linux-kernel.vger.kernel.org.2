Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D445A0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhKWLE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:04:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhKWLEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:04:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE326608FB;
        Tue, 23 Nov 2021 11:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637665307;
        bh=iDqFyOwPdHWzq2na5F/rnkbyZouQO1JgAfFvLO3FUFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtNkm54N7xKIIbEYxTxWc2qR8kfSq+4ScIlwPf3G4ZJv3hEOc3rJZ2tl1ofy8CkKr
         jYai9xU79jyA+JaxfUh/DZIrLUFs4UfQuxFg/cwW53mzwoVTTyTrBMVfEGcV1t3YO2
         JGHKVC16kz3HMzSAspibfUz7oXNSd7FAAJCcNUn8=
Date:   Tue, 23 Nov 2021 12:01:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajith P V <ajithpv.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: remove all warning messages
Message-ID: <YZzKGKuLuvCG/0zN@kroah.com>
References: <20211123100934.13189-1-ajithpv.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123100934.13189-1-ajithpv.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:39:34PM +0530, Ajith P V wrote:
> Remove all warning messages found by checkpatch.pl script
> 
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ---
>  drivers/android/binder.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 49fb74196d02..a58cfd39f3ea 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1933,7 +1933,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
>  		case BINDER_TYPE_FD: {
>  			/*
>  			 * No need to close the file here since user-space
> -			 * closes it for for successfully delivered
> +			 * closes it for successfully delivered
>  			 * transactions. For transactions that weren't
>  			 * delivered, the new fd was never allocated so
>  			 * there is no need to close and the fput on the
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
>  	    waitqueue_active(&thread->wait)) {
>  		wake_up_poll(&thread->wait, EPOLLHUP | POLLFREE);
>  	}
> @@ -4436,7 +4438,7 @@ static int binder_thread_release(struct binder_proc *proc,
>  
>  	/*
>  	 * This is needed to avoid races between wake_up_poll() above and
> -	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
> +	 * ep_remove_waitqueue() called for other reasons (eg the epoll file
>  	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
>  	 * lock, so we can be sure it's done after calling synchronize_rcu().
>  	 */
> @@ -4752,8 +4754,9 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	unsigned int size = _IOC_SIZE(cmd);
>  	void __user *ubuf = (void __user *)arg;
>  
> -	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
> -			proc->pid, current->pid, cmd, arg);*/
> +	/* pr_info("binder_ioctl: %d:%d %x %lx\n",
> +	 *		proc->pid, current->pid, cmd, arg);
> +	 */
>  
>  	binder_selftest_alloc(&proc->alloc);
>  
> @@ -5982,8 +5985,8 @@ static int __init binder_init(void)
>  	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
>  	    strcmp(binder_devices_param, "") != 0) {
>  		/*
> -		* Copy the module_parameter string, because we don't want to
> -		* tokenize it in-place.
> +		 * Copy the module_parameter string, because we don't want to
> +		 * tokenize it in-place.
>  		 */
>  		device_names = kstrdup(binder_devices_param, GFP_KERNEL);
>  		if (!device_names) {
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
