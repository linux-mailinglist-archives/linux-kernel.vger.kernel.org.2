Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA536AC16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhDZGTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:19:17 -0400
Received: from foss.arm.com ([217.140.110.172]:56908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbhDZGTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:19:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB11131B;
        Sun, 25 Apr 2021 23:18:34 -0700 (PDT)
Received: from [10.163.75.66] (unknown [10.163.75.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA993F70D;
        Sun, 25 Apr 2021 23:18:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] mm/mmzone.h: simplify is_highmem_idx()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210423203811.1247508-1-rppt@kernel.org>
 <20210423203811.1247508-3-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <df17080c-8867-259e-5a09-1f0ec053f68e@arm.com>
Date:   Mon, 26 Apr 2021 11:49:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423203811.1247508-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/21 2:08 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There is a lot of historical ifdefery in is_highmem_idx() and its helper
> zone_movable_is_highmem() that was required because of two different paths
> for nodes and zones initialization that were selected at compile time.
> 
> Until commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP
> option") the movable_zone variable was only available for configurations
> that had CONFIG_HAVE_MEMBLOCK_NODE_MAP enabled so the test in
> zone_movable_is_highmem() used that variable only for such configurations.
> For other configurations the test checked if the index of ZONE_MOVABLE was
> greater by 1 than the index of ZONE_HIGMEM and then movable zone was
> considered a highmem zone. Needless to say, ZONE_MOVABLE - 1 equals
> ZONE_HIGMEM by definition when CONFIG_HIGHMEM=y.

Right with CONFIG_HIGHMEM is enabled, ZONE_MOVABLE = ZONE_HIGHMEM + 1 holds
always true from the very definition in enum zone_type { }.

> 
> Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
> made movable_zone variable always available. Since this variable is set to
> ZONE_HIGHMEM if CONFIG_HIGHMEM is enabled and highmem zone is populated, it
> is enough to check whether
> 
> 	zone_idx == ZONE_MOVABLE && movable_zone == ZONE_HIGMEM

Right. A small nit. s/HIGMEM/HIGHMEM

> 
> to test if zone index points to a highmem zone.

If the CONFIG_HIGHMEM is enabled but ZONE_HIGHMEM is not populated, then
movable_node would point to a zone below ZONE_HIGHMEM and is_highmem_idx()
would also return false.

> 
> Remove zone_movable_is_highmem() that is not used anywhere except
> is_highmem_idx() and use the test above in is_highmem_idx() instead.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/mmzone.h | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 3b2205741048..6a1ac643b65e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -968,22 +968,11 @@ static inline void zone_set_nid(struct zone *zone, int nid) {}
>  
>  extern int movable_zone;
>  
> -#ifdef CONFIG_HIGHMEM
> -static inline int zone_movable_is_highmem(void)
> -{
> -#ifdef CONFIG_NEED_MULTIPLE_NODES
> -	return movable_zone == ZONE_HIGHMEM;
> -#else
> -	return (ZONE_MOVABLE - 1) == ZONE_HIGHMEM;
> -#endif
> -}
> -#endif
> -
>  static inline int is_highmem_idx(enum zone_type idx)
>  {
>  #ifdef CONFIG_HIGHMEM
>  	return (idx == ZONE_HIGHMEM ||
> -		(idx == ZONE_MOVABLE && zone_movable_is_highmem()));
> +		(idx == ZONE_MOVABLE && movable_zone == ZONE_HIGHMEM));
>  #else
>  	return 0;
>  #endif
> 

LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
