Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1ED38BCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhEUD3r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 23:29:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236848AbhEUD3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:29:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 539FFAB64;
        Fri, 21 May 2021 03:28:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Austin Kim" <austindh.kim@gmail.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        austindh.kim@gmail.com
Subject: Re: [PATCH] kernfs: move return value check after kmalloc()
In-reply-to: <20210521025525.GA1379@raspberrypi>
References: <20210521025525.GA1379@raspberrypi>
Date:   Fri, 21 May 2021 13:28:17 +1000
Message-id: <162156769760.19062.15467223033723371296@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Austin Kim wrote:
> With 414985ae23c0 ("sysfs, kernfs: move file core code to fs/kernfs/file.c"),
> 'return -ENOMEM' is executed when kmalloc() returns NULL.
> 
> Since 'commit 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc
> files use the buffer.")', 'return -ENOMEM' statement is not properly located.
> 
> Fix it by moving 'return -ENOMEM' after return from kmalloc().

I don't think there is anything to "fix" here.  The current code is
correct.
The difference between the current code and your new code is purely a
difference in style.  I don't object to your change, but only if it is
presented as a style improvement.  It is not a code fix.

NeilBrown


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
> 
