Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF512322B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhBWNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhBWNC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:02:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E72FE64E60;
        Tue, 23 Feb 2021 13:02:17 +0000 (UTC)
Subject: Re: [PATCH] m68k: Fix virt_addr_valid() W=1 compiler warnings
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
References: <20210223104957.2209219-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <bbb367f6-4f6d-027c-f0b7-345a24fdea0c@linux-m68k.org>
Date:   Tue, 23 Feb 2021 23:02:14 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223104957.2209219-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/2/21 8:49 pm, Geert Uytterhoeven wrote:
> If CONFIG_DEBUG_SG=y, and CONFIG_MMU=y:
> 
>      include/linux/scatterlist.h: In function ‘sg_set_buf’:
>      arch/m68k/include/asm/page_mm.h:174:49: warning: ordered comparison of pointer with null pointer [-Wextra]
>        174 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
> 	  |                                                 ^~
> 
> or CONFIG_MMU=n:
> 
>      include/linux/scatterlist.h: In function ‘sg_set_buf’:
>      arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
>         33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
> 	  |                                                  ^~
> 
> Fix this by doing the comparison in the "unsigned long" instead of the
> "void *" domain.
> 
> Note that for now this is only seen when compiling btrfs, due to commit
> e9aa7c285d20a69c ("btrfs: enable W=1 checks for btrfs"), but as people
> are doing more W=1 compile testing, it will start to show up elsewhere,
> too.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


> ---
> Probably we want this as a fix for v5.12, to avoid the build bots
> nagging about it all the time?
> 
>   arch/m68k/include/asm/page_mm.h | 2 +-
>   arch/m68k/include/asm/page_no.h | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
> index 7f5912af2a52ea0a..9b1672f9b2e22cdf 100644
> --- a/arch/m68k/include/asm/page_mm.h
> +++ b/arch/m68k/include/asm/page_mm.h
> @@ -171,7 +171,7 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
>   #include <asm-generic/memory_model.h>
>   #endif
>   
> -#define virt_addr_valid(kaddr)	((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
> +#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && ((unsigned long)kaddr) < (unsigned long)high_memory)
>   #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
> index 6bbe52025de3c5c6..8d0f862ee9d79532 100644
> --- a/arch/m68k/include/asm/page_no.h
> +++ b/arch/m68k/include/asm/page_no.h
> @@ -30,8 +30,8 @@ extern unsigned long memory_end;
>   #define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
>   #define pfn_valid(pfn)	        ((pfn) < max_mapnr)
>   
> -#define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
> -				((void *)(kaddr) < (void *)memory_end))
> +#define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
> +				((unsigned long)(kaddr) < memory_end))
>   
>   #endif /* __ASSEMBLY__ */
>   
> 
