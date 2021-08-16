Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509923EDF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhHPWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233499AbhHPWBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0709601FA;
        Mon, 16 Aug 2021 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629151243;
        bh=D6G11k2cgnrfXeO4tqRi+f+FFeddZGnV7Vxpe2Ldj60=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RFoeBLTLggFqBH9D60i1VYk/n1v6LifKuwoWxiuOmb7uFxRdjLRrtPmvpuPUbLGDe
         C5ZvdvC5T7+c9xZK2u5xHMGcm1mrh+Z1bP7FY5Sk+Uc+KFW5p9UZ+VgIPVqNQpSUx/
         g/auW0EoA7B7/Ujc0ZeKUlxWid0r1vg7tSjPfIhubgBeTFNzRiO6mUOJrQikVnyay0
         v36k73rJHK3gWA/UndADYQcvlMlS9PNrB9TF2eS/3gUHgoahG8MmuglW1Kq5eMt1Q2
         A6vcvgXK9WdNcEJ/aOLRC+Cr+lsCfPiuuneZAZoV8l6lOKpDbLrmPw3VZ4FC3pitJU
         1U3CNWlncgdEQ==
Subject: Re: [PATCH] ARC: export clear_user_page() for modules
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
References: <20210816210533.16929-1-rdunlap@infradead.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <16255d77-e9a5-4bac-6c6e-596af6f5b0c1@kernel.org>
Date:   Mon, 16 Aug 2021 15:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816210533.16929-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 2:05 PM, Randy Dunlap wrote:
> 0day bot reports a build error:
>    ERROR: modpost: "clear_user_page" [drivers/media/v4l2-core/videobuf-dma-sg.ko] undefined!
> so export it in arch/arc/ to fix the build error.
>
> In most ARCHes, clear_user_page() is a macro. OTOH, in a few
> ARCHes it is a function and needs to be exported.
> PowerPC exported it in 2004. It looks like nds32 and nios2
> still need to have it exported.
>
> Fixes: 4102b53392d63 ("ARC: [mm] Aliasing VIPT dcache support 2/4")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org

Thx for the fix. Added for 5.16 !

-Vineet

> ---
>   arch/arc/mm/cache.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20210816.orig/arch/arc/mm/cache.c
> +++ linux-next-20210816/arch/arc/mm/cache.c
> @@ -1041,7 +1041,7 @@ void clear_user_page(void *to, unsigned
>   	clear_page(to);
>   	clear_bit(PG_dc_clean, &page->flags);
>   }
> -
> +EXPORT_SYMBOL(clear_user_page);
>   
>   /**********************************************************************
>    * Explicit Cache flush request from user space via syscall
>
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

