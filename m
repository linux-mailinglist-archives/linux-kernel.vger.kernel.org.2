Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92341002D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbhIQUGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhIQUGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18D11611C3;
        Fri, 17 Sep 2021 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631909091;
        bh=mEyjE0OtAQmdOBy6JF1uWMiaz+LsaQ2TOO9N0GzD4q8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TwffbNS4RL5k7jgYAk9bPvqGar9gPSXlDk7tGrFRJS6vG73q/79FwFr4xCCJNw66u
         faPcb3eKXbUXcWv89rMvuYi/3EqZIZqPynZ0WV/pN974Hj6SuS9OvfoEUzia0kGSgw
         mzsjR/DoMpf7tw4UA3fGaUygmCF//mPQMFR0RSwEkTVgEGfu0fJtHyKA2mJa1p15cL
         7iBAO8W5stpj5jk+KUlDxzg1MU6JehWVMawg6sskx2DvAncMAwMtsqXL9ioGWwOMYY
         VslTVrm1j8TiDQ36VTupNVotaWGVYguVOhI/f4EI09U3JMvFkddeor/0PdlCclJ7XV
         T6eyo4p4Y6/pA==
Date:   Fri, 17 Sep 2021 13:04:50 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "hch@lst.de" <hch@lst.de>, Konrad Wilk <konrad.wilk@oracle.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/4] swiotlb-xen: ensure to issue well-formed
 XENMEM_exchange requests
In-Reply-To: <7b3998e3-1233-4e5a-89ec-d740e77eb166@suse.com>
Message-ID: <alpine.DEB.2.21.2109171304380.21985@sstabellini-ThinkPad-T480s>
References: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com> <7b3998e3-1233-4e5a-89ec-d740e77eb166@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021, Jan Beulich wrote:
> While the hypervisor hasn't been enforcing this, we would still better
> avoid issuing requests with GFNs not aligned to the requested order.
> Instead of altering the value also in the call to panic(), drop it
> there for being static and hence easy to determine without being part
> of the panic message.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> I question how useful it is to wrap "bytes" in PAGE_ALIGN(), when it is
> a multiple of a segment's size anyway (or at least was supposed to be,
> prior to "swiotlb-xen: maintain slab count properly"). But that's
> perhaps yet another separate patch.
> ---
> v2: Drop logging of alignment. Wrap lines.
> 
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -230,10 +230,11 @@ retry:
>  	/*
>  	 * Get IO TLB memory from any location.
>  	 */
> -	start = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
> +	start = memblock_alloc(PAGE_ALIGN(bytes),
> +			       IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  	if (!start)
> -		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -		      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
> +		panic("%s: Failed to allocate %lu bytes\n",
> +		      __func__, PAGE_ALIGN(bytes));
>  
>  	/*
>  	 * And replace that memory with pages under 4GB.
> 
