Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999F0366ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhDUMaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:30:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9479 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238576AbhDUMaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:30:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FQKcc4dPYz9tvqS;
        Wed, 21 Apr 2021 14:29:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CeELRF3p2Hho; Wed, 21 Apr 2021 14:29:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FQKcc3hDwz9tvq9;
        Wed, 21 Apr 2021 14:29:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6FBC8B825;
        Wed, 21 Apr 2021 14:29:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T1yXWHZXlfsX; Wed, 21 Apr 2021 14:29:37 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62B1F8B770;
        Wed, 21 Apr 2021 14:29:37 +0200 (CEST)
Subject: Re: [PATCH v11 6/6] powerpc: Book3S 64-bit outline-only KASAN support
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-7-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <fc849719-e2c0-bbcb-c58e-f4ff3e9c5f18@csgroup.eu>
Date:   Wed, 21 Apr 2021 14:29:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210319144058.772525-7-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/03/2021 à 15:40, Daniel Axtens a écrit :
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index aca354fb670b..63672aa656e8 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -20,6 +20,7 @@
>   #include <linux/seq_file.h>
>   #include <asm/fixmap.h>
>   #include <linux/const.h>
> +#include <linux/kasan.h>
>   #include <asm/page.h>
>   #include <asm/hugetlb.h>
>   
> @@ -317,6 +318,23 @@ static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
>   	unsigned long addr;
>   	unsigned int i;
>   
> +#if defined(CONFIG_KASAN) && defined(CONFIG_PPC_BOOK3S_64)
> +	/*
> +	 * On radix + KASAN, we want to check for the KASAN "early" shadow
> +	 * which covers huge quantities of memory with the same set of
> +	 * read-only PTEs. If it is, we want to note the first page (to see
> +	 * the status change), and then note the last page. This gives us good
> +	 * results without spending ages noting the exact same PTEs over 100s of
> +	 * terabytes of memory.
> +	 */
> +	if (p4d_page(*p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud))) {
> +		walk_pmd(st, pud, start);
> +		addr = start + (PTRS_PER_PUD - 1) * PUD_SIZE;
> +		walk_pmd(st, pud, addr);
> +		return;
> +	}
> +#endif
> +
>   	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
>   		addr = start + i * PUD_SIZE;
>   		if (!pud_none(*pud) && !pud_is_leaf(*pud))


The above changes should not be necessary once PPC_PTDUMP is converted to GENERIC_PTDUMP.

See https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=239795


Christophe
