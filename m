Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B681387636
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbhERKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241341AbhERKNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:13:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6807611BF;
        Tue, 18 May 2021 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621332756;
        bh=mUXsR79wmLIkPRrRfbJYCzCHqZYq96n8PXBff+Lbslw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEGcix5mHkZX7LXPsFxD7YBlUTAN1b2dng5CXXe5sL0s5K0BKqJQ415ENIIoRiG2U
         qlZWCx9w8F//FWoQtrmXY7JfNA9/DxLxJQ0lT2YVUOCuJjaPVIRcIDMX9tgxJciHEu
         UnTkuWLNV9v8RYxIrP9TIo97FFcSo8ZLm7glGbTZ3hUd6qRBiYHJULJF1ANce9O9+3
         S7T4psKpNPNUGMbwNZBVrYIWkHTFttvX7gOoYdHys5ev28sEdUKUoYDberq1wDPBhC
         vg/9Ls/BBRjaU2LTvltkkLsBrow5339nXkpZATACv7sdmOeWz4JZ4FvqJAjMkLGZoD
         sQmqaAZtmYUFA==
Date:   Tue, 18 May 2021 13:12:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dongas86@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] mm/sparse: move mem_sections allocation out of
 memory_present()
Message-ID: <YKOTDumqMIFfqc+f@kernel.org>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-4-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517112044.233138-4-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 07:20:42PM +0800, Dong Aisheng wrote:
> The only path to call memory_present() is from memblocks_present().
> The struct mem_section **mem_section only needs to be initialized once,
> so no need put the initialization/allocation code in memory_present()
> which will be called multiple times for each section.
> 
> After moving, the 'unlikely' condition statement becomes to be
> meaningless as it's only initialized one time, so dropped as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  mm/sparse.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 98bfacc763da..df4418c12f04 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -254,19 +254,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>  {
>  	unsigned long pfn;
>  
> -#ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (unlikely(!mem_section)) {
> -		unsigned long size, align;
> -
> -		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> -		align = 1 << (INTERNODE_CACHE_SHIFT);
> -		mem_section = memblock_alloc(size, align);
> -		if (!mem_section)
> -			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -			      __func__, size, align);
> -	}
> -#endif

Maybe split this into a helper function and call it directly from
sparse_init()?

> -
>  	start &= PAGE_SECTION_MASK;
>  	mminit_validate_memmodel_limits(&start, &end);
>  	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> @@ -292,9 +279,19 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>   */
>  static void __init memblocks_present(void)
>  {
> +	unsigned long __maybe_unused size, align;
>  	unsigned long start, end;
>  	int i, nid;
>  
> +#ifdef CONFIG_SPARSEMEM_EXTREME
> +	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> +	align = 1 << (INTERNODE_CACHE_SHIFT);
> +	mem_section = memblock_alloc(size, align);
> +	if (!mem_section)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, size, align);
> +#endif
> +
>  	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
>  		memory_present(nid, start, end);
>  }
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
