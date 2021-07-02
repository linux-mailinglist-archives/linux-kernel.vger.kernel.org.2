Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622533BA0F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhGBNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhGBNNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:13:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 167E3613B1;
        Fri,  2 Jul 2021 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625231473;
        bh=VTOEMFLCdkiosprAyMGyX32cPkmxfgkO4zvLSKjrATU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrMCSVMH62c/ElTMpje1nVPi0IB9kFdzijtpw/IWTCM8LK6e2a06g17PKQsOVIhU4
         xmLFfpbF4eEbEJbRdTEdvxacBz2d//2/GdiVTDHjBpDreEhC5Y/xuPW6AGIyek+ozQ
         FF4MgLEu33racYiy2TZoXV/acUHG0dFUIi0rwyjh8q1029TNvoHc6emvI1OuwtTi/M
         CEbZ9ErgwsW9aGiW4wSx+XiHF8M4uQFs/X8CL3bAU7mjiHbLufEm1fyPbzvBXFR3Ir
         k9tPHmohsr6M2GGeDpBfBHUxANVAwLnoNl8wUsZrEsvi1HGL5ZLN3f/1DdWrpFTAW2
         gs6sV9d6JVfjQ==
Date:   Fri, 2 Jul 2021 16:11:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm/sparse: clarify pgdat_to_phys
Message-ID: <YN8QaoJuDP9Nr744@kernel.org>
References: <20210630092309.17654-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630092309.17654-1-miles.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 05:23:09PM +0800, Miles Chen wrote:
> clarify pgdat_to_phys() by wrapping pgdat_to_phys
> with CONFIG_NUMA. (the same config as contig_page_data)
> 
> No functional change intended.
> 
> Comment from Mark [1]:
> "
> ... and I reckon it'd be clearer and more robust to define
> pgdat_to_phys() in the same ifdefs as contig_page_data so
> that these, stay in-sync. e.g. have:
> 
> | #ifdef CONFIG_NUMA
> | #define pgdat_to_phys(x)	virt_to_phys(x)
> | #else /* CONFIG_NUMA */
> |
> | extern struct pglist_data contig_page_data;
> | ...
> | #define pgdat_to_phys(x)	__pa_symbol(&contig_page_data)
> |
> | #endif /* CONIFIG_NUMA */
> "
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20210615131902.GB47121@C02TD0UTHF1T.local/
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  mm/sparse.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7272f7a1449d..62c21ec28e33 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -344,14 +344,15 @@ size_t mem_section_usage_size(void)
>  	return sizeof(struct mem_section_usage) + usemap_size();
>  }
>  
> -static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
> -{
> -#ifndef CONFIG_NUMA
> -	return __pa_symbol(pgdat);
> -#else
> -	return __pa(pgdat);
> -#endif
> -}
> +#ifdef CONFIG_NUMA
> +#define pgdat_to_phys(pgdat) __pa(pgdat)
> +#else /* CONFIG_NUMA */
> +/*
> + * When !CONFIG_NUMA, we only expect pgdat == &contig_page_data,
> + * and use __pa_symbol().
> + */
> +#define pgdat_to_phys(pgdat) __pa_symbol(pgdat)
> +#endif /* CONFIG_NUMA */

I'm not sure a macro is better than a static inline.

Maybe we'd want to warn if pgdat passed to pgtat_to_phys() is not
&contig_page_data, e.g something like

static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
{
	if (!IS_ENABLED(CONFIG_NUMA)) {
		if (pgdat == &contig_page_data)
			return __pa_symbol(&contig_page_data);
		else
			pr_warn("Unexpected pglist_data pointer!\n");
	}
	
	return __pa(pgdat);
}
  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  static struct mem_section_usage * __init
> -- 
> 2.18.0
> 

-- 
Sincerely yours,
Mike.
