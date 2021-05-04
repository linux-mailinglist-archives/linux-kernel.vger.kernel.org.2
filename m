Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2D372989
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEDL31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:29:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhEDL3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:29:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0593AD6E;
        Tue,  4 May 2021 04:28:30 -0700 (PDT)
Received: from [10.163.77.186] (unknown [10.163.77.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570D13F73B;
        Tue,  4 May 2021 04:28:28 -0700 (PDT)
Subject: Re: [PATCH] mm/ioremap: Fix iomap_max_page_shift
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <0d615a242c4470462da547dc332e4ec5f00479dd.1619855673.git.christophe.leroy@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <21a38d63-a229-17e4-7a70-bde7101cd6fd@arm.com>
Date:   Tue, 4 May 2021 16:59:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d615a242c4470462da547dc332e4ec5f00479dd.1619855673.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/21 1:28 PM, Christophe Leroy wrote:
> iomap_max_page_shift is expected to contain a page shift,
> so it can't be a 'bool', has to be an 'unsigned int'
> 
> And fix the default values: P4D_SHIFT is when huge iomap is allowed.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Fixes: bbc180a5adb0 ("mm: HUGE_VMAP arch support cleanup")

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/ioremap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index d1dcc7e744ac..2f7193c6a99e 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -16,16 +16,16 @@
>  #include "pgalloc-track.h"
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static bool __ro_after_init iomap_max_page_shift = PAGE_SHIFT;
> +static unsigned int __ro_after_init iomap_max_page_shift = P4D_SHIFT;
>  
>  static int __init set_nohugeiomap(char *str)
>  {
> -	iomap_max_page_shift = P4D_SHIFT;
> +	iomap_max_page_shift = PAGE_SHIFT;
>  	return 0;
>  }
>  early_param("nohugeiomap", set_nohugeiomap);
>  #else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static const bool iomap_max_page_shift = PAGE_SHIFT;
> +static const unsigned int iomap_max_page_shift = PAGE_SHIFT;
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
>  int ioremap_page_range(unsigned long addr,
> 
