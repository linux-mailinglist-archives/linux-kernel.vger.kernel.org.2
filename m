Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF342400A1C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbhIDGdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237120AbhIDGdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:33:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86B086054E;
        Sat,  4 Sep 2021 06:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630737132;
        bh=ZPixSAawQQqPuj5uTZ0OeL9TEp8tDj5LW5EOE0Smepc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/MIbhKDeLeoLRvVQQfgo9+2BdYnw8uaZ2zrYxmKYhibNiR8YwL9k1hUtLOrhSwx5
         bXqqacppUMaTthPvrFxtBiLNj1Rb4sN0lA7ZcS+KOqvfc7rtX50JFHHkNWZast4wF9
         Jrr9smC8vjzWfotZEC1Wid5NuxHXwKthyFA0BQGg=
Date:   Sat, 4 Sep 2021 08:32:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiazi Li <jqqlijiazi@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiazi Li <lijiazi@xiaomi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: init list head only when needed
Message-ID: <YTMS6cIGLwqxA0t9@kroah.com>
References: <853e8529c18c4a71c36b49f9598961fbc3f39682.1628921932.git.lijiazi@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853e8529c18c4a71c36b49f9598961fbc3f39682.1628921932.git.lijiazi@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:12:32PM +0800, Jiazi Li wrote:
> If a module successfully registers a misc device.
> Then, due to some bugs, use same address register misc device
> again, init list head will corrupt misc_list, resulting in oops
> when using misc_list.

Then fix those bugs that try to register the misc device more than once?

Does that happen in any in-kernel drivers or is this just a failure of
external drivers that are not submitted to the kernel tree?

> In this scenario, do not init list head, if registration is
> successful, init list head is also not required.
> 
> Signed-off-by: Jiazi Li <lijiazi@xiaomi.com>
> ---
>  drivers/char/misc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index ca5141e..2451640 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -176,7 +176,6 @@ int misc_register(struct miscdevice *misc)
>  	int err = 0;
>  	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
>  
> -	INIT_LIST_HEAD(&misc->list);
>  
>  	mutex_lock(&misc_mtx);
>  
> @@ -185,7 +184,7 @@ int misc_register(struct miscdevice *misc)
>  
>  		if (i >= DYNAMIC_MINORS) {
>  			err = -EBUSY;
> -			goto out;
> +			goto err2;
>  		}
>  		misc->minor = DYNAMIC_MINORS - i - 1;
>  		set_bit(i, misc_minors);
> @@ -195,7 +194,13 @@ int misc_register(struct miscdevice *misc)
>  		list_for_each_entry(c, &misc_list, list) {
>  			if (c->minor == misc->minor) {
>  				err = -EBUSY;
> -				goto out;
> +				/*
> +				 * if module use same address double register,
> +				 * init list will corrupt misc_list

I do not understand the text here at all, sorry.

thanks,

greg k-h
