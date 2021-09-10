Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9A4073B5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhIJXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhIJXL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDA0611F0;
        Fri, 10 Sep 2021 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631315447;
        bh=v1M29iLRAqXSSDeBk/51fpGq9pHOSqcyUCgaAF8VAks=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CBNorB/E8eA4w72YHFfKWHdfNeYfLRgu481B0NG49YWlcZNiRl21G0kW8qFKFcUyl
         9+1kpAGY7w8oqTJXqHar70mSo6y7vvVMwf7rC2Mk1N09IZ1bVCCRvRD/kUC346aqAa
         ezIHSfK8Z+DPikcCY9NF05wUXu7vYkK5kRCziaAISfQ0iSlzJtuRXpQUUfM0Z1amIt
         mQqUgGgDJu42/YOhnHZECQ49308v1jTikLOlIli5MrOL4oP17VizTYxYK07OKeKiHl
         sGzGSELnh5pTLmCHqp3KosfbvXmqJGn8XTWiQPV354xR4Tj/kC3O0e7N/hHRruUe0I
         PYgQ3ysxxAHMQ==
Date:   Fri, 10 Sep 2021 16:10:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 03/12] swiotlb-xen: maintain slab count properly
In-Reply-To: <dc054cb0-bec4-4db0-fc06-c9fc957b6e66@suse.com>
Message-ID: <alpine.DEB.2.21.2109101610380.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <dc054cb0-bec4-4db0-fc06-c9fc957b6e66@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> Generic swiotlb code makes sure to keep the slab count a multiple of the
> number of slabs per segment. Yet even without checking whether any such
> assumption is made elsewhere, it is easy to see that xen_swiotlb_fixup()
> might alter unrelated memory when calling xen_create_contiguous_region()
> for the last segment, when that's not a full one - the function acts on
> full order-N regions, not individual pages.
> 
> Align the slab count suitably when halving it for a retry. Add a build
> time check and a runtime one. Replace the no longer useful local
> variable "slabs" by an "order" one calculated just once, outside of the
> loop. Re-use "order" for calculating "dma_bits", and change the type of
> the latter as well as the one of "i" while touching this anyway.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -106,27 +106,26 @@ static int is_xen_swiotlb_buffer(struct
>  
>  static int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
>  {
> -	int i, rc;
> -	int dma_bits;
> +	int rc;
> +	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
> +	unsigned int i, dma_bits = order + PAGE_SHIFT;
>  	dma_addr_t dma_handle;
>  	phys_addr_t p = virt_to_phys(buf);
>  
> -	dma_bits = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT) + PAGE_SHIFT;
> +	BUILD_BUG_ON(IO_TLB_SEGSIZE & (IO_TLB_SEGSIZE - 1));
> +	BUG_ON(nslabs % IO_TLB_SEGSIZE);
>  
>  	i = 0;
>  	do {
> -		int slabs = min(nslabs - i, (unsigned long)IO_TLB_SEGSIZE);
> -
>  		do {
>  			rc = xen_create_contiguous_region(
> -				p + (i << IO_TLB_SHIFT),
> -				get_order(slabs << IO_TLB_SHIFT),
> +				p + (i << IO_TLB_SHIFT), order,
>  				dma_bits, &dma_handle);
>  		} while (rc && dma_bits++ < MAX_DMA_BITS);
>  		if (rc)
>  			return rc;
>  
> -		i += slabs;
> +		i += IO_TLB_SEGSIZE;
>  	} while (i < nslabs);
>  	return 0;
>  }
> @@ -210,7 +209,7 @@ retry:
>  error:
>  	if (repeat--) {
>  		/* Min is 2MB */
> -		nslabs = max(1024UL, (nslabs >> 1));
> +		nslabs = max(1024UL, ALIGN(nslabs >> 1, IO_TLB_SEGSIZE));
>  		bytes = nslabs << IO_TLB_SHIFT;
>  		pr_info("Lowering to %luMB\n", bytes >> 20);
>  		goto retry;
> @@ -245,7 +244,7 @@ retry:
>  		memblock_free(__pa(start), PAGE_ALIGN(bytes));
>  		if (repeat--) {
>  			/* Min is 2MB */
> -			nslabs = max(1024UL, (nslabs >> 1));
> +			nslabs = max(1024UL, ALIGN(nslabs >> 1, IO_TLB_SEGSIZE));
>  			bytes = nslabs << IO_TLB_SHIFT;
>  			pr_info("Lowering to %luMB\n", bytes >> 20);
>  			goto retry;
> 
