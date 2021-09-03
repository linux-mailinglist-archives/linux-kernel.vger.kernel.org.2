Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C33FFCDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbhICJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:18:16 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39979 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhICJR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:17:59 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1By25Mpvz9sTF;
        Fri,  3 Sep 2021 11:16:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ij6FTKTMMlQS; Fri,  3 Sep 2021 11:16:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1By249hhz9sTB;
        Fri,  3 Sep 2021 11:16:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 767348B8DB;
        Fri,  3 Sep 2021 11:16:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jM0WhLpLl04Y; Fri,  3 Sep 2021 11:16:58 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F37BF8B764;
        Fri,  3 Sep 2021 11:16:57 +0200 (CEST)
Subject: Re: [PATCH -next] powerpc/mm: check base flags in ioremap_prot
To:     Nanyong Sun <sunnanyong@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210903090339.3671524-1-sunnanyong@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <90aa2b67-24c8-4a5f-d91a-b562054d5c5d@csgroup.eu>
Date:   Fri, 3 Sep 2021 11:16:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903090339.3671524-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2021 à 11:03, Nanyong Sun a écrit :
> Some drivers who call ioremap_prot without setting base flags like
> ioremap_prot(addr, len, 0) may work well before
> commit 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in
> ioremap()"), but now they will get a virtual address "successfully"
> from ioremap_prot and badly fault on memory access later because that
> patch also dropped the hack adding of base flags for ioremap_prot.
> 
> So return NULL and throw a warning if the caller of ioremap_prot did
> not set base flags properly. Why not just hack adding PAGE_KERNEL flags
> in the ioremap_prot, because most scenarios can be covered by high level
> functions like ioremap(), ioremap_coherent(), ioremap_cache()...
> so it is better to keep max flexibility for this low level api.

As far as I can see, there is no user of this fonction that sets flags to 0 in the kernel tree.

Did you find any ? If you did, I think it is better to fix the caller.

Christophe

> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   arch/powerpc/mm/ioremap.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 57342154d2b0..b7eda0f0d04d 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -46,6 +46,10 @@ void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long f
>   	pte_t pte = __pte(flags);
>   	void *caller = __builtin_return_address(0);
>   
> +	/* The caller should set base page flags properly */
> +	if (WARN_ON((flags & _PAGE_PRESENT) == 0))

This probably doesn't work for some plateforms like book3s/64. You should use helpers like 
pte_present().

See the comment at 
https://elixir.bootlin.com/linux/v5.14/source/arch/powerpc/include/asm/book3s/64/pgtable.h#L591

> +		return NULL;
> +
>   	/* writeable implies dirty for kernel addresses */
>   	if (pte_write(pte))
>   		pte = pte_mkdirty(pte);
> 
