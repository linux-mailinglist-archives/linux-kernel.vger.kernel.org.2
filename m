Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D374073BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhIJXQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhIJXQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:16:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F03D7611F0;
        Fri, 10 Sep 2021 23:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631315700;
        bh=vJNj/V5gr36eIctaJUoPC89yjzCT0LnaEG2pV27VBPs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OI1DCVnn0xilrmUuSWEetAwLMWahluaHTMFEFvR8u5WMW2j7EIqzKwJ1N7d0t7d9s
         lYU8f6PgKS0MbktKeEwQcp2NeQbCMka68x6vdCQJAxBgj5AB7oop0aZViU2IW7L0mU
         kjXLlPVNGTZUzphhrE7aW0f5RxAbNfdRlIU9s3TPG9EyPE/lphthLrGBoTcKxVf5qJ
         3qSS6+CG2hoIvDciSe5YChDwDXz8taSyLT+YuVrM48k0MqfpcyRDr0oNmqYLnqP32/
         bdsjTZMimIT1AGxLbKLfK+ZwPPntd/e60jOiTtXUOJs8McLFOwdZ5ePp1lk0G0l2XK
         7YoiB+BS5ab5g==
Date:   Fri, 10 Sep 2021 16:14:59 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 04/12] swiotlb-xen: ensure to issue well-formed
 XENMEM_exchange requests
In-Reply-To: <397bf325-f81e-e104-6142-e8c9c4955475@suse.com>
Message-ID: <alpine.DEB.2.21.2109101613130.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <397bf325-f81e-e104-6142-e8c9c4955475@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> While the hypervisor hasn't been enforcing this, we would still better
> avoid issuing requests with GFNs not aligned to the requested order.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
> I wonder how useful it is to include the alignment in the panic()
> message.

Not very useful given that it is static. I don't mind either way but you
can go ahead and remove it if you prefer (and it would make the line
shorter.)


> I further wonder how useful it is to wrap "bytes" in
> PAGE_ALIGN(), when it is a multiple of a segment's size anyway (or at
> least was supposed to be, prior to "swiotlb-xen: maintain slab count
> properly").

This one I would keep, to make sure to print out the same amount passed
to memblock_alloc.


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -231,10 +231,10 @@ retry:
>  	/*
>  	 * Get IO TLB memory from any location.
>  	 */
> -	start = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
> +	start = memblock_alloc(PAGE_ALIGN(bytes), IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  	if (!start)
> -		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -		      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
> +		panic("%s: Failed to allocate %lu bytes align=%#x\n",
> +		      __func__, PAGE_ALIGN(bytes), IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  
>  	/*
>  	 * And replace that memory with pages under 4GB.
> 
