Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2D42B354
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhJMDYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236946AbhJMDYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:24:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4025F60C4A;
        Wed, 13 Oct 2021 03:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634095336;
        bh=mpb89R+bOx0GW7CkSqtcwCMTRLUovfoYbKKce8i9jFI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=qpVQcUn4kAXdBSekhYSWq4Jqw34PwQEghsTzWsWscmgxoc/nq53AoCAAgdOl5vnM/
         V20SwYhBY75eLkR8vuoq1W/VokA7HsXwAKRiXQ5Uqx4nD7N1YatPDpM/wdOsBt0jbN
         8HAMBHG/2MuURpoc2x94o713cmMjm1gXwRAmGGAgV4HJi2Lj1J4pKcb8h7oxKpcfbB
         rwFbTzD829L67ju0IlXZDYdcrWhKRASWW3lfTDbl7KcFKvzCcJGWEJARfH1UgviafH
         Vlvn+KFxVonWj5q5w4e85obn6btXfz3kHr4U32ewjaHTcvIs65PpcXKHB00lriZPYj
         ovvjrPlXUkxdA==
Subject: Re: [RFC PATCH] NIOS2: irqflags: rename a redefined register name
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20211004075606.6229-1-rdunlap@infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <261a69a1-0037-f1f8-9ddd-de50e45085fc@kernel.org>
Date:   Tue, 12 Oct 2021 22:22:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004075606.6229-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/21 2:56 AM, Randy Dunlap wrote:
> Both arch/nios2/ and drivers/mmc/host/tmio_mmc.c define a macro
> with the name "CTL_STATUS". Change the one in arch/nios2/ to be
> "CTL_FSTATUS" (flags status) to eliminate the build warning.
> 
> In file included from ../drivers/mmc/host/tmio_mmc.c:22:
> drivers/mmc/host/tmio_mmc.h:31: warning: "CTL_STATUS" redefined
>     31 | #define CTL_STATUS 0x1c
> arch/nios2/include/asm/registers.h:14: note: this is the location of the previous definition
>     14 | #define CTL_STATUS      0
> 
> Fixes: b31ebd8055ea ("nios2: Nios2 registers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> ---
>   arch/nios2/include/asm/irqflags.h  |    4 ++--
>   arch/nios2/include/asm/registers.h |    2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20211001.orig/arch/nios2/include/asm/irqflags.h
> +++ linux-next-20211001/arch/nios2/include/asm/irqflags.h
> @@ -9,7 +9,7 @@
>   
>   static inline unsigned long arch_local_save_flags(void)
>   {
> -	return RDCTL(CTL_STATUS);
> +	return RDCTL(CTL_FSTATUS);
>   }
>   
>   /*
> @@ -18,7 +18,7 @@ static inline unsigned long arch_local_s
>    */
>   static inline void arch_local_irq_restore(unsigned long flags)
>   {
> -	WRCTL(CTL_STATUS, flags);
> +	WRCTL(CTL_FSTATUS, flags);
>   }
>   
>   static inline void arch_local_irq_disable(void)
> --- linux-next-20211001.orig/arch/nios2/include/asm/registers.h
> +++ linux-next-20211001/arch/nios2/include/asm/registers.h
> @@ -11,7 +11,7 @@
>   #endif
>   
>   /* control register numbers */
> -#define CTL_STATUS	0
> +#define CTL_FSTATUS	0
>   #define CTL_ESTATUS	1
>   #define CTL_BSTATUS	2
>   #define CTL_IENABLE	3
> 

Applied!

Thanks,
Dinh
