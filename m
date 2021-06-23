Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933EB3B146F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFWHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWHQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D08A160725;
        Wed, 23 Jun 2021 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624432472;
        bh=cL82jgFrO5OvOFCoEVcEy+AdDkurz27Zn7mHLIL3rW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqCv6rOc1KTEuv4tTym7glrlnlIT6icmD4qXMVEmx2uTU0c7VuM+OYiToP9890XE2
         jxbjrjrCRpxj4rqoJoWwj2/haeVSQ7KcBNV5mP/EqrnqhJ9Wr9uZZjCZdnuK37zzgU
         Ip7v/mTSjDBIeH5skj1Q1NFHd/QrhusyI4v8xq8U=
Date:   Wed, 23 Jun 2021 09:14:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wubian <wubian@uniontech.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Fix bus error that access memory mapped by physical
Message-ID: <YNLfVX5YVWouP1qD@kroah.com>
References: <20210623065214.4525-1-wubian@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623065214.4525-1-wubian@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:52:14PM +0800, wubian wrote:
> On the arm64, register the uio driver and map a physical space
> on the pci device to user space, then use memset write data to
> the address space, a bus error will occur. This error is due to
> the dc instruction(cache operation) used in the assembly of memset,
> uio mapping physical memory will call pgprot_noncached() to set
> non-cached and non-buffered, while pgprot_writecombine() has fewer
> restrictions. It does not prohibit write buffer, so replacing
> pgprot_noncached() with pgprot_writecombine() can solve this problem.
> 
> Signed-off-by: wubian <wubian@uniontech.com>
> ---
>  drivers/uio/uio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index ea96e319c8a0..09b04b20fa30 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -739,7 +739,11 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
>  
>  	vma->vm_ops = &uio_physical_vm_ops;
>  	if (idev->info->mem[mi].memtype == UIO_MEM_PHYS)
> +#if defined(CONFIG_ARM64)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +#else
>  		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +#endif

This feels really wrong, shouldn't stuff like this be handled in the
platform itself and not in the driver?

And why is ARM64 special here?  Why not other arches?  What is odd about
this platform?  We almost never want to use #if in .c files, why is it
ok to do that here?

And is this a bugfix?  If so, what commit does it fix?  Should it go to
stable kernels, and if so, how far back?

I need more information here :)

thanks,

greg k-h
