Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3A3D461E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhGXHHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 03:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234403AbhGXHHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 03:07:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D02E160E93;
        Sat, 24 Jul 2021 07:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627112859;
        bh=83jYqHd7Z3wZAPt5SDx4EmmdLiCWHkDxcjRrWNIZ0kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dV+JwbWV9suCiexF3CXkLJt4ap8IBg5xYeWS7BVIDBXUtK33/2VPwz9pSvQdHO1A3
         yIrHu3+n1ufzNNfG1igKzqVT1hcEH/iMlQUvkRPrv1HO9FmO4HHM/SaoH5vdLO75Xt
         82aiN+l4G+1Z9Kz8UTGFmXYa8xad5zeGCLzUMdP9E5ezcoOVBqOb4kWVXT59yaFEhG
         i4D04rUrLcpJ7HtUr13dBD0kkYLRCN0WmdAo3q9UC98qSWlbPf0QIr3JtqkWtNqMtA
         QZpyiVT0NIL/r+deATsBXLKcs9QG7X31C5TzhlzS1KQisaBB6aZjXeWW9cy28+fjEQ
         5+UMcZFUNjrJQ==
Date:   Sat, 24 Jul 2021 10:47:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] mm/sparse: clarify pgdat_to_phys
Message-ID: <YPvFlagk2Z/4ceS1@kernel.org>
References: <20210723123342.26406-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723123342.26406-1-miles.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 08:33:42PM +0800, Miles Chen wrote:
> Clarify pgdat_to_phys() by testing if
> pgdat == &contig_page_data when CONFIG_NUMA=n.
> 
> We only expect contig_page_data in such case, so we
> use &contig_page_data directly instead of pgdat.
> 
> No functional change intended when CONFIG_BUG_VM=n.
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
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> 
> --
> 
> Change since v1:
> Thanks for Mike's comment, check if pgdat == &contig_page_data,
> so it is clearer that we only expect contig_page_data when
> CONFIG_NUMA=n.
> 
> Change since v2:
> use VM_BUG_ON() to avoid runtime checking when CONFIG_BUG_VM=n
> ---
>  mm/sparse.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6326cdf36c4f..d13d831f88a5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -348,7 +348,8 @@ size_t mem_section_usage_size(void)
>  static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
>  {
>  #ifndef CONFIG_NUMA
> -	return __pa_symbol(pgdat);
> +	VM_BUG_ON(pgdat != &contig_page_data);
> +	return __pa_symbol(&contig_page_data);
>  #else
>  	return __pa(pgdat);
>  #endif
> -- 
> 2.18.0
> 

-- 
Sincerely yours,
Mike.
