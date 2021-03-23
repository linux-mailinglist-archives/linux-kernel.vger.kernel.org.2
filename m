Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE16345F83
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhCWNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231698AbhCWNSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F1B761925;
        Tue, 23 Mar 2021 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616505534;
        bh=Vs7PdDT7Zq32DdrSGItgF4jCKR5j3s25JM4aU1qJMaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lh8Jft0EnLBcj3gRmzp0I22GXzBoPBTmJFCTj7w6Ug3clmG1qOEo8spX5BPdMLKlA
         5jERiCWFI1O2+QGkKmdIOnPRS8kWgsQs++WDWHxptbnIaoK+oioOU82Y/PWk/SDdoY
         Q4xyG37XO37oBT3uGnXXLKQ3TFsORA9dIeKsH1cM=
Date:   Tue, 23 Mar 2021 14:18:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhishek C <astro.abhishek02@gmail.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com, surenb@google.com,
        bkkarthik@pesu.pes.edu, linux-kernel@vger.kernel.org,
        hridya@google.com, arve@android.com, joel@joelfernandes.org,
        maco@android.com, christian@brauner.io
Subject: Re: [PATCH] drivers: android: binder.c: Fix indentation of
 multi-line comment
Message-ID: <YFnqu9b20whmRJNh@kroah.com>
References: <20210313161655.mu64qezxog4ghibq@astroabhi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313161655.mu64qezxog4ghibq@astroabhi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 09:46:55PM +0530, Abhishek C wrote:
> Fixed alignment of multi-line comment.
> Added a * for each line of the comment.
> 
> Signed-off-by: Abhishek C <astro.abhishek02@gmail.com>
> ---
>  drivers/android/binder.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56a..700719c58147 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4617,8 +4617,9 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	unsigned int size = _IOC_SIZE(cmd);
>  	void __user *ubuf = (void __user *)arg;
>  
> -	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
> -			proc->pid, current->pid, cmd, arg);*/
> +	/* pr_info("binder_ioctl: %d:%d %x %lx\n",
> +	 * proc->pid, current->pid, cmd, arg);
> +	 */

This looks like left-over debugging code, and as-is, is formatted
properly.

Why not just delete it entirely?  If someone needs debugging code, they
can add it back in.

thanks,

greg k-h
