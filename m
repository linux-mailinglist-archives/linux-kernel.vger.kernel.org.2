Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4327D31AFBB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBNIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 03:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhBNIWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 03:22:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2237561494;
        Sun, 14 Feb 2021 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613290896;
        bh=CcC3t0obhI410jkBBGKMn3+V8mpeDf2g+FPZ4iPL3Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6Az8v3OCYkRltLEW4GWwEseg3nPX6X8KhoydssK6vgKFMa9CQQiC9OcrvethYoCa
         b0uLAf2YtnWdCciGT2aFzAxCe8bspiSFbBwDeI67jYtNdUaf9qXjeoIyeWR3j8jCSB
         K8qkS7HRUXjmRcIXWytTce1VVf2jqXacGvyGD5Jg=
Date:   Sun, 14 Feb 2021 09:21:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thais Camacho <thaiscamachoo@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org, Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword
Message-ID: <YCjdjdjcdXRUMhU/@kroah.com>
References: <20210214023136.8916-1-thaiscamachoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214023136.8916-1-thaiscamachoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 11:31:36PM -0300, Thais Camacho wrote:
> Warning found by checkpatch.pl script
> 
> Signed-off-by: Thais Camacho <thaiscamachoo@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 4789d36ddfd3..2cb665e0228c 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> -- 
> 2.20.1

Any specific reason why you did not test-build your change before
sending it to us?  Please always do so, otherwise it causes lots of
problems, and makes maintainers grumpy :)

thanks,

greg k-h
