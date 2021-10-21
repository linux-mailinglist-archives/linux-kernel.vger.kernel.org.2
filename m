Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCAC435CED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhJUIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhJUIef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:34:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACE7960FC0;
        Thu, 21 Oct 2021 08:32:18 +0000 (UTC)
Date:   Thu, 21 Oct 2021 09:32:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] memblock: exclude MEMBLOCK_NOMAP regions from
 kmemleak
Message-ID: <YXElj+W48PUf2kIY@arm.com>
References: <20211021070929.23272-1-rppt@kernel.org>
 <20211021070929.23272-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021070929.23272-3-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:09:29AM +0300, Mike Rapoport wrote:
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index f9383736fa0f..71419eb16e09 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -21,6 +21,7 @@
>  #include <linux/earlycpio.h>
>  #include <linux/initrd.h>
>  #include <linux/security.h>
> +#include <linux/kmemleak.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -601,6 +602,8 @@ void __init acpi_table_upgrade(void)
>  	 */
>  	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
>  
> +	kmemleak_ignore_phys(acpi_tables_addr);
> +
>  	/*
>  	 * early_ioremap only can remap 256k one time. If we map all
>  	 * tables one time, we will hit the limit. Need to map chunks
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 59c1390cdf42..9da8835ba5a5 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -21,6 +21,7 @@
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
> +#include <linux/kmemleak.h>
>  
>  #include "of_private.h"
>  
> @@ -46,6 +47,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>  		err = memblock_mark_nomap(base, size);
>  		if (err)
>  			memblock_free(base, size);
> +		kmemleak_ignore_phys(base);
>  	}
>  
>  	return err;

More of a nitpick as there's no kmemleak scanning to race with during
early boot: I'd normally call kmemleak_ignore_phys() before marking it
nomap. Either way:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
