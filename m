Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1063D373F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhEEQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233857AbhEEQWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C46A2610EA;
        Wed,  5 May 2021 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620231698;
        bh=iUs9aQzvjk97+EzOnm9O6b///njeOHG8EK0O6Pu/QNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysnvVskGothBkZ8w1wqNXqWLXTjyBFTEPmFWyZu3IDyEQZPgOBdH3O2apSw6BL0RX
         Fz/B4VO+Atj5ITbe9Rlyt0XB3UMbkhYFfFFVQzHKrg3XddUR3xhXNQl+sYX4VZ5XpF
         psaao1xyLGQfZDhvyLgyvNStuYpo2PDGBIb/Llh8=
Date:   Wed, 5 May 2021 18:21:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Vorwerk <alec@vc-celle.de>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: make file_operations struct const
Message-ID: <YJLGEFi1pENXIpk5@kroah.com>
References: <20210505161015.10278-1-alec@vc-celle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505161015.10278-1-alec@vc-celle.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 06:10:15PM +0200, Alexander Vorwerk wrote:
> Fix the following type of checkpatch warning:
> "WARNING: struct file_operations should normally be const"
> 
> Signed-off-by: Alexander Vorwerk <alec@vc-celle.de>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 8ee4320a5dc6..8ff2794b08e3 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> -- 
> 2.17.1
> 
> 

Always test build your patches before sending them out.  Any specific
reason why you didn't do that here?

thanks,

greg k-h
