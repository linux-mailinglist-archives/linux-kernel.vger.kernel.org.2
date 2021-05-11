Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBE37A485
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhEKKZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhEKKZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EB6861925;
        Tue, 11 May 2021 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620728672;
        bh=QPi/4JREEub+I52UusvRvWuByBiB9nL2Qf7HR+Iz/s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyBCKtx7QPexdaDfKF3f3rdZuVA1eWJFUX1JFvkZfz1gGnGsk55n77MuWE0tKLhQ+
         I7dBfeMdQ3g9jmwKbJ1/PgG9/vBeFDXzyATNHvRaEBw4qCKl8B7PAKMnoiouJD4dgj
         qDG32y1eG1rYxiS3ZgS8KWb3xClICWxKciLoM/oKaoBCW6nGV/CEvKOYEsaGlOWHLw
         HN09XJ6aahZpMHaw9z1IQ6tMYD4qvZHm0q7c9Ym/NyYL12VHBiwx81+LVYKo0Py4f7
         o7zUTyG8SBfSVEz3YEOhPCue2N1bCLcgOu3vVyXivSWJtsMLgF6M1cGd6N6Ngt4QCb
         enKHa7QPtGfPg==
Date:   Tue, 11 May 2021 13:24:25 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm/sparse: fix check_usemap_section_nr warnings
Message-ID: <YJpbWVrgJFLRpzl3@kernel.org>
References: <20210511093114.15123-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511093114.15123-1-miles.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 05:31:14PM +0800, Miles Chen wrote:
> In current implementation of node_data, if CONFIG_NEED_MULTIPLE_NODES=y,
> node_data is allocated by kzmalloc. If CONFIG_NEED_MULTIPLE_NODES=n,
> we use a global variable named "contig_page_data".
> 
> If CONFIG_DEBUG_VIRTUAL is not enabled. __pa() can handle both kzalloc and
> symbol cases. But if CONFIG_DEBUG_VIRTUAL is set, we will have the
> "virt_to_phys used for non-linear address" warning when booting.

Maybe we'll just allocate pgdat for CONFIG_NEED_MULTIPLE_NODES=n (which is
essentially !NUMA) case in, say, free_area_init()?
 
> To fix it, create a small function to handle both translation.
> 
> Warning message:
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] virt_to_phys used for non-linear address: (____ptrval____) (contig_page_data+0x0/0x1c00)
> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x58/0x68
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.13.0-rc1-00074-g1140ab592e2e #3
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> [    0.000000] pc : __virt_to_phys+0x58/0x68
> [    0.000000] lr : __virt_to_phys+0x54/0x68
> [    0.000000] sp : ffff800011833e70
> [    0.000000] x29: ffff800011833e70 x28: 00000000418a0018 x27: 0000000000000000
> [    0.000000] x26: 000000000000000a x25: ffff800011b70000 x24: ffff800011b70000
> [    0.000000] x23: fffffc0001c00000 x22: ffff800011b70000 x21: 0000000047ffffb0
> [    0.000000] x20: 0000000000000008 x19: ffff800011b082c0 x18: ffffffffffffffff
> [    0.000000] x17: 0000000000000000 x16: ffff800011833bf9 x15: 0000000000000004
> [    0.000000] x14: 0000000000000fff x13: ffff80001186a548 x12: 0000000000000000
> [    0.000000] x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000000
> [    0.000000] x8 : ffff8000115c9000 x7 : 737520737968705f x6 : ffff800011b62ef8
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> [    0.000000] x2 : 0000000000000000 x1 : ffff80001159585e x0 : 0000000000000058
> [    0.000000] Call trace:
> [    0.000000]  __virt_to_phys+0x58/0x68
> [    0.000000]  check_usemap_section_nr+0x50/0xfc
> [    0.000000]  sparse_init_nid+0x1ac/0x28c
> [    0.000000]  sparse_init+0x1c4/0x1e0
> [    0.000000]  bootmem_init+0x60/0x90
> [    0.000000]  setup_arch+0x184/0x1f0
> [    0.000000]  start_kernel+0x78/0x488
> [    0.000000] ---[ end trace f68728a0d3053b60 ]---
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  mm/sparse.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b2ada9dc00cb..55c18aff3e42 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -344,6 +344,15 @@ size_t mem_section_usage_size(void)
>  	return sizeof(struct mem_section_usage) + usemap_size();
>  }
>  
> +static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
> +{
> +#ifndef CONFIG_NEED_MULTIPLE_NODES
> +	return __pa_symbol(pgdat);
> +#else
> +	return __pa(pgdat);
> +#endif
> +}
> +
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  static struct mem_section_usage * __init
>  sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> @@ -362,7 +371,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
>  	 * from the same section as the pgdat where possible to avoid
>  	 * this problem.
>  	 */
> -	goal = __pa(pgdat) & (PAGE_SECTION_MASK << PAGE_SHIFT);
> +	goal = pgdat_to_phys(pgdat) & (PAGE_SECTION_MASK << PAGE_SHIFT);
>  	limit = goal + (1UL << PA_SECTION_SHIFT);
>  	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
>  again:
> @@ -390,7 +399,7 @@ static void __init check_usemap_section_nr(int nid,
>  	}
>  
>  	usemap_snr = pfn_to_section_nr(__pa(usage) >> PAGE_SHIFT);
> -	pgdat_snr = pfn_to_section_nr(__pa(pgdat) >> PAGE_SHIFT);
> +	pgdat_snr = pfn_to_section_nr(pgdat_to_phys(pgdat) >> PAGE_SHIFT);
>  	if (usemap_snr == pgdat_snr)
>  		return;
>  
> -- 
> 2.18.0

-- 
Sincerely yours,
Mike.
