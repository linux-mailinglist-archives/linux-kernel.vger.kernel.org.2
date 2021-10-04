Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC0420A1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhJDLay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhJDLax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:30:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC4ED61354;
        Mon,  4 Oct 2021 11:29:03 +0000 (UTC)
Subject: Re: [PATCH] m68knommu: Remove MCPU32 config symbol
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20211004070231.2943362-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <41cd6008-75c8-1fa7-dfc3-3bf843707db3@linux-m68k.org>
Date:   Mon, 4 Oct 2021 21:29:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004070231.2943362-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 5:02 pm, Geert Uytterhoeven wrote:
> As of commit a3595962d82495f5 ("m68knommu: remove obsolete 68360
> support"), nothing selects MCPU32 anymore.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks Geert. I'll push it into the m68knommu git tree.

Regards
Greg


>   arch/m68k/Kconfig.cpu          | 11 -----------
>   arch/m68k/include/asm/bitops.h |  2 +-
>   2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index 277d61a094637ce3..0d00ef5117dceed9 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -53,17 +53,6 @@ config M68000
>   	  System-On-Chip devices (eg 68328, 68302, etc). It does not contain
>   	  a paging MMU.
>   
> -config MCPU32
> -	bool
> -	select CPU_HAS_NO_BITFIELDS
> -	select CPU_HAS_NO_CAS
> -	select CPU_HAS_NO_UNALIGNED
> -	select CPU_NO_EFFICIENT_FFS
> -	help
> -	  The Freescale (was then Motorola) CPU32 is a CPU core that is
> -	  based on the 68020 processor. For the most part it is used in
> -	  System-On-Chip parts, and does not contain a paging MMU.
> -
>   config M68020
>   	bool "68020 support"
>   	depends on MMU
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index 7b414099e5fc20fa..7b93e1fd8ffa902f 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -451,7 +451,7 @@ static inline unsigned long ffz(unsigned long word)
>    *	generic functions for those.
>    */
>   #if (defined(__mcfisaaplus__) || defined(__mcfisac__)) && \
> -	!defined(CONFIG_M68000) && !defined(CONFIG_MCPU32)
> +	!defined(CONFIG_M68000)
>   static inline unsigned long __ffs(unsigned long x)
>   {
>   	__asm__ __volatile__ ("bitrev %0; ff1 %0"
> 

