Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90173AC8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFRKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFRKZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:25:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05E3361159;
        Fri, 18 Jun 2021 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624011802;
        bh=1ZxM0FCMwZiZghnpuKtTVnbmtQtc1YYDd9NZGwlFpFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1W6vyZoSBAzSTkWS0wOYbBIg/Im0WwpOf6bKl5rB8OP6GFC9KMgPkw/eeMzF/ciJb
         fF46LcniH39Hh22MSaVob/xpHsnZrUeph+8WYIeIys6v9Gju4c69MzPCJHLIyLy9JL
         UgHb0ADE67tnbQGdyKbMb6FKLCojIH4s9i1BNaxw=
Date:   Fri, 18 Jun 2021 12:23:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liuhailong <liuhailong@oppo.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: add size field in procfs fdinfo
Message-ID: <YMx0GIRQmpRC7pdQ@kroah.com>
References: <20210618095035.32410-1-liuhailong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618095035.32410-1-liuhailong@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 05:50:35PM +0800, liuhailong wrote:
> add this information to help user to find ashmem problem.
> 
> ashmem leak scenario:
> -000|fd = ashmem_create_region
> -001|mmap and pagefault
> -002|munmap
> -003|forget close(fd) <---- which lead to ashmem leak
> 
> Signed-off-by: liuhailong <liuhailong@oppo.com>
> ---
>  drivers/staging/android/ashmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index d66a64e42273..ee2fd75111d8 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -894,6 +894,8 @@ static void ashmem_show_fdinfo(struct seq_file *m, struct file *file)
>  		seq_printf(m, "name:\t%s\n",
>  			   asma->name + ASHMEM_NAME_PREFIX_LEN);
>  
> +	seq_printf(m, "size:\t%zu\n", asma->size);
> +
>  	mutex_unlock(&ashmem_mutex);
>  }
>  #endif
> -- 
> 2.30.2
> 
> 

As you are changing a user-facing proc file, what tools will break now
that you have added a new line?

What tools do you use to look at this file and what has been modified to
handle the change?

thanks,

greg k-h
