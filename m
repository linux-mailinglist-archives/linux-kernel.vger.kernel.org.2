Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDFC4016B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhIFHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:06:32 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33196 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbhIFHG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:29 -0400
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 656A025B849;
        Mon,  6 Sep 2021 17:05:23 +1000 (AEST)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id BFFF641AB; Mon,  6 Sep 2021 09:05:21 +0200 (CEST)
Date:   Mon, 6 Sep 2021 09:05:21 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, Jay Lan <jlan@sgi.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] ia64: Make num_rsvd_regions static
Message-ID: <20210906070521.GC19281@vergenet.net>
References: <cover.1629884459.git.geert+renesas@glider.be>
 <a377b5437e3e9da93d02f996fe06a2b956cb0990.1629884459.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a377b5437e3e9da93d02f996fe06a2b956cb0990.1629884459.git.geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:48:29PM +0200, Geert Uytterhoeven wrote:
> Commit f62800992e5917f2 ("ia64: switch to NO_BOOTMEM") removed the last
> user of num_rsvd_regions outside arch/ia64/kernel/setup.c.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/ia64/include/asm/meminit.h | 1 -
>  arch/ia64/kernel/setup.c        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/meminit.h b/arch/ia64/include/asm/meminit.h
> index 2738f62b5f989492..f1d5bf2ba847a135 100644
> --- a/arch/ia64/include/asm/meminit.h
> +++ b/arch/ia64/include/asm/meminit.h
> @@ -29,7 +29,6 @@ struct rsvd_region {
>  };
>  
>  extern struct rsvd_region rsvd_region[IA64_MAX_RSVD_REGIONS + 1];
> -extern int num_rsvd_regions;
>  
>  extern void find_memory (void);
>  extern void reserve_memory (void);
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index 5e6ee8939092a2df..31fb84de2d21469a 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -131,7 +131,7 @@ unsigned long ia64_cache_stride_shift = ~0;
>   * We use a special marker for the end of memory and it uses the extra (+1) slot
>   */
>  struct rsvd_region rsvd_region[IA64_MAX_RSVD_REGIONS + 1] __initdata;
> -int num_rsvd_regions __initdata;
> +static int num_rsvd_regions __initdata;
>  
>  
>  /*
> -- 
> 2.25.1
> 
