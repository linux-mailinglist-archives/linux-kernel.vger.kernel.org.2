Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07D38BD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 06:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhEUElI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 00:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239163AbhEUElH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 00:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79DC161261;
        Fri, 21 May 2021 04:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621571984;
        bh=LIXtOlzou89RhBkeHHOcUBK4LV9zHewt22Q/WA5LUm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDh77wLLV88u+gdWd0xTEl0KdZloBBLcCu7NyCgMPOy7OnFlWfUTZPNXP+O/pBuyA
         4ziBo/uB76Elsn0QfYpExrXr5m90e5TnUvzSIB9XLwVuN3kClSDEN5PSuO0e0nnMRR
         SXHj/+QnDiIkH0gsx3gyMDaay0nJIbmPN2nhE+CU=
Date:   Fri, 21 May 2021 06:39:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     tj@kernel.org, neilb@suse.de, linux-kernel@vger.kernel.org,
        austin.kim@lge.com
Subject: Re: [PATCH] kernfs: move return value check after kmalloc()
Message-ID: <YKc5jLVhw8+Oy165@kroah.com>
References: <20210521025525.GA1379@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521025525.GA1379@raspberrypi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:55:25AM +0100, Austin Kim wrote:
> With 414985ae23c0 ("sysfs, kernfs: move file core code to fs/kernfs/file.c"),
> 'return -ENOMEM' is executed when kmalloc() returns NULL.
> 
> Since 'commit 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc
> files use the buffer.")', 'return -ENOMEM' statement is not properly located.
> 
> Fix it by moving 'return -ENOMEM' after return from kmalloc().
> 
> Fixes: 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc files use the buffer.")
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  fs/kernfs/file.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index c75719312147..c5e2429af836 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -191,10 +191,11 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	buf = of->prealloc_buf;
>  	if (buf)
>  		mutex_lock(&of->prealloc_mutex);
> -	else
> +	else {
>  		buf = kmalloc(len, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +		if (!buf)
> +			return -ENOMEM;
> +	}
>  
>  	/*
>  	 * @of->mutex nests outside active ref and is used both to ensure that
> -- 
> 2.20.1
> 

Like Neil said, I don't see the "bug" you are fixing here.  What is
currently wrong with the existing code?

thanks,

greg k-h
