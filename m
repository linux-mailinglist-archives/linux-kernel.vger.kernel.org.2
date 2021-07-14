Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50573C7B03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhGNB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237223AbhGNB0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:26:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0403361370;
        Wed, 14 Jul 2021 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626225837;
        bh=2OW+dl69IwJaUv/Dmdi8sG6wLihedmiyxIbS3TwfP04=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Q3qZdS2d4flDx1JSLjNZe47joSZ8PBHHE2iEbusngkyxL8Gkm33IKFBE22c9vYib5
         7JX4HwyUm4Ilyc/irup/kJuTMxx8RnYTSL1uDRk73cJYniNN5+7UvwQEIj7o2pEtvq
         6MXThixra3HZZ5Xv8tNwihJvoLA7pXLspeRn2Ww6VGGOvVQV5vstLzOUhEZ0TjIIJC
         XcJigFfxuMArpu1dlgu3ExFnVqoikjLLw61cTnFgCRo4Rju2HX84URuDHviWRNZG9T
         geGiIPCQs3uWcxJgJGoqlGrRjLqtPNsKvwLiXWyyGvWdHvZOOYcU6sVRM/PifcBpZl
         AvG51cEPzwg5g==
Date:   Tue, 13 Jul 2021 18:23:56 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Roman Skakun <rm.skakun@gmail.com>
cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc
 addresses
In-Reply-To: <20210622133414.132754-1-rm.skakun@gmail.com>
Message-ID: <alpine.DEB.2.21.2107131822040.23286@sstabellini-ThinkPad-T480s>
References: <20210616154436.GA7619@lst.de> <20210622133414.132754-1-rm.skakun@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021, Roman Skakun wrote:
> This commit is dedicated to fix incorrect conversion from
> cpu_addr to page address in cases when we get virtual
> address which allocated in the vmalloc range.
> As the result, virt_to_page() cannot convert this address
> properly and return incorrect page address.
> 
> Need to detect such cases and obtains the page address using
> vmalloc_to_page() instead.
> 
> Signed-off-by: Roman Skakun <roman_skakun@epam.com>
> Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
> ---
> Hey!
> Thanks for suggestions, Christoph!
> I updated the patch according to your advice.
> But, I'm so surprised because nobody catches this problem
> in the common code before. It looks a bit strange as for me. 
> 
> 
>  kernel/dma/ops_helpers.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
> index 910ae69cae77..782728d8a393 100644
> --- a/kernel/dma/ops_helpers.c
> +++ b/kernel/dma/ops_helpers.c
> @@ -5,6 +5,14 @@
>   */
>  #include <linux/dma-map-ops.h>
>  
> +static struct page *cpu_addr_to_page(void *cpu_addr)
> +{
> +	if (is_vmalloc_addr(cpu_addr))
> +		return vmalloc_to_page(cpu_addr);
> +	else
> +		return virt_to_page(cpu_addr);
> +}

We have the same thing in xen_swiotlb_free_coherent. Can we find a way
to call cpu_addr_to_page() from xen_swiotlb_free_coherent? Maybe we can
make cpu_addr_to_page non-static? No problem if it is too much trouble.


>  /*
>   * Create scatter-list for the already allocated DMA buffer.
>   */
> @@ -12,7 +20,7 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
>  		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		 unsigned long attrs)
>  {
> -	struct page *page = virt_to_page(cpu_addr);
> +	struct page *page = cpu_addr_to_page(cpu_addr);
>  	int ret;
>  
>  	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> @@ -43,7 +51,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>  		return -ENXIO;
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -			page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgoff,
> +			page_to_pfn(cpu_addr_to_page(cpu_addr)) + vma->vm_pgoff,
>  			user_count << PAGE_SHIFT, vma->vm_page_prot);
>  #else
>  	return -ENXIO;
> -- 
> 2.25.1
> 
