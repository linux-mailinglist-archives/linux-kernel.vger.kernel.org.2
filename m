Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0044446C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhKCRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhKCRNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC1361076;
        Wed,  3 Nov 2021 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635959475;
        bh=WsRWg5CcxOzuGYk3TbRj5+iaVwnIPkjCC9bWw72ciDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCfHjpJKYbewaAuNBwdCa9dT9LmiRfV1skX34KSobrsAEWSiiQqFGisTwJuJb8szj
         Y6lypsMVfM64KNySmd3Z7DsJFKFILfZ8MKF2MKP3uOGVbxHcsskko5kThWsqcaCBOo
         e5aNvioONzBbpDuW059nV8VL6AXRJ/Qt2Fd7UOYcf0wcFvy3i8h5HQjSGRiM1eM2xH
         jxiqKy+pt8w3rwDmgEjIs3EV4VSmfsjiACNkwM7rP2qcg80MnCdBLU0yH3xB+9l2S0
         W30FPVmnMa7l2tpfkU+JQSMpoZzqGgWTe5rcLym41agfRxoD3gj0QfLA2VnurSXCUq
         dIK4AqmFpGs0w==
Date:   Wed, 3 Nov 2021 19:11:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
Subject: Re: [PATCH v2] mm: Fix ERROR:do not initialise statics to 0 or NULL
 in memblock.c
Message-ID: <YYLCrAQnky9LM06s@kernel.org>
References: <20211103124523.10670-1-kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103124523.10670-1-kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 03, 2021 at 06:15:23PM +0530, Kushal Kothari wrote:
> Subject: mm: Fix ERROR:do not initialise statics to 0 or NULL in memblock.c

Please use mm/memblock: or just memblock: prefix for memblock patches.
Besides, this patch does not fix a real error, it's only style fixup, so
"Fix ERROR" should be omitted here.

> The default value of static variable is zero and bool is false so
> not need to set it here.
> This patch fixes this ERROR in memblock.c
> Error found with checkpatch.pl.

Again, this is not a real error in the code but rather a coding style
inconsistency. Please update the changelog text to reflect this.
 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
> 
> Changes in v2: Correct the subject line and remove <stdbool.h> which isn't
> necessary 
> 
>  mm/memblock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5c3503c98b2f..9e2b7c1dbd03 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -152,10 +152,10 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>  	} while (0)
>  
>  static int memblock_debug __initdata_memblock;
> -static bool system_has_some_mirror __initdata_memblock = false;
> +static bool system_has_some_mirror __initdata_memblock;
>  static int memblock_can_resize __initdata_memblock;
> -static int memblock_memory_in_slab __initdata_memblock = 0;
> -static int memblock_reserved_in_slab __initdata_memblock = 0;
> +static int memblock_memory_in_slab __initdata_memblock;
> +static int memblock_reserved_in_slab __initdata_memblock;
>  
>  static enum memblock_flags __init_memblock choose_memblock_flags(void)
>  {
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
