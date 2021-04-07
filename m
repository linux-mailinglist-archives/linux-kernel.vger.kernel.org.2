Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B4C356F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbhDGOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233599AbhDGOs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:48:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E09CA61260;
        Wed,  7 Apr 2021 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617806896;
        bh=s4YHVX6I4KFaEOaDuE91HtM/xl0oR/OIQH9ovTk2uTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J47mtbpE/V6HL4mHsYSe3PvbrSQzJG+3zVxK30e8SQmcjs9R+3SrbnPtMMYsuk/pb
         i8oJcirGFKFeA9ouXJMX6YZKqesYThRHIwWv2AlxWWmq76mU2jpVOrx/W/VdM7boMK
         M8XTFhMNqw5wOonW3co4XkYKEzTVo0/ABVf7vDOU=
Date:   Wed, 7 Apr 2021 16:48:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barney Goette <barneygoette@gmail.com>
Cc:     arve@android.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: android: ashmem: Fixed a const coding style
 issue
Message-ID: <YG3GLQA1O3b0w0RY@kroah.com>
References: <20210407143502.3414-1-barneygoette@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407143502.3414-1-barneygoette@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:35:02AM -0500, Barney Goette wrote:
> Fixed a coding style issue.
> Reported by checkpatch.
> 
> Signed-off-by: Barney Goette <barneygoette@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index d66a64e42273..7854fd410efa 100644
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
> 2.25.1

Why did you not test-build your patch before sending it out?

Always do so.

thanks,

greg k-h
