Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8232BB67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446402AbhCCMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238129AbhCCHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:15:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F364E64ED4;
        Wed,  3 Mar 2021 07:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614755655;
        bh=20Cl48DRvMwy2OE345MXY2fQfXpiGBWIqaXxZ1H4Y70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h12ydsbTN+SxQu77TyBX8P+5E539ZbZSHsrfj0F/yGf+nXIyZIiTjAH5kyhVR3EtR
         rQ+BK9N1POyeMr0c9t50L5DowqlNCgCack9rPg2nWCzGqkLwd/DQMs/2VSDazw7+jr
         UMzL9vvimj83djq0/o6K38cMYnXppRKg4wbv/qX8=
Date:   Wed, 3 Mar 2021 08:14:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Wang <li.wang@windriver.com>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: keyboard, fix uninitialized variables warning
Message-ID: <YD83RFqtKVB2pA9H@kroah.com>
References: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 12:59:32PM +0800, Li Wang wrote:
> drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return ret;
>          ^~~
> kernel-source/drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   kfree(kbs);
>   ^~~~~~~~~~
> 
> Signed-off-by: Li Wang <li.wang@windriver.com>
> ---
>  drivers/tty/vt/keyboard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 7763862..3e73d55 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2049,8 +2049,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  {
>  	unsigned char kb_func;
>  	unsigned long flags;
> -	char *kbs;
> -	int ret;
> +	char *kbs = NULL;
> +	int ret = -EINVAL;
>  
>  	if (get_user(kb_func, &user_kdgkb->kb_func))
>  		return -EFAULT;

What compiler is providing these "warnings"?

Turns out it is impossible to hit, so this isn't actually fixing
anything...

thanks,

greg k-h
