Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4433CE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhCPG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:58:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53503 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233679AbhCPG5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:57:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F03yC1wWpz9v01q;
        Tue, 16 Mar 2021 07:57:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dAvZpDnyIIEM; Tue, 16 Mar 2021 07:57:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F03yC0bC2z9v01p;
        Tue, 16 Mar 2021 07:57:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C604A8B77F;
        Tue, 16 Mar 2021 07:57:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9y2Jva0TRQda; Tue, 16 Mar 2021 07:57:39 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 061878B766;
        Tue, 16 Mar 2021 07:57:38 +0100 (CET)
Subject: Re: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup
 warnings
To:     He Ying <heying24@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        dja@axtens.net, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, rppt@kernel.org, ardb@kernel.org,
        clg@kaod.org
Cc:     johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210316041148.29694-1-heying24@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ae9d758b-d62c-ed60-75e7-2917187d976b@csgroup.eu>
Date:   Tue, 16 Mar 2021 07:57:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316041148.29694-1-heying24@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/03/2021 à 05:11, He Ying a écrit :
> warning: symbol 'rfi_flush' was not declared.
> warning: symbol 'entry_flush' was not declared.
> warning: symbol 'uaccess_flush' was not declared.
> We found warnings above in arch/powerpc/kernel/setup_64.c by using
> sparse tool.
> 
> Define 'entry_flush' and 'uaccess_flush' as static because they are not
> referenced outside the file. Include asm/security_features.h in which
> 'rfi_flush' is declared.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/kernel/setup_64.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 560ed8b975e7..f92d72a7e7ce 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -68,6 +68,7 @@
>   #include <asm/early_ioremap.h>
>   #include <asm/pgalloc.h>
>   #include <asm/asm-prototypes.h>
> +#include <asm/security_features.h>
>   
>   #include "setup.h"
>   
> @@ -949,8 +950,8 @@ static bool no_rfi_flush;
>   static bool no_entry_flush;
>   static bool no_uaccess_flush;
>   bool rfi_flush;
> -bool entry_flush;
> -bool uaccess_flush;
> +static bool entry_flush;
> +static bool uaccess_flush;
>   DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
>   EXPORT_SYMBOL(uaccess_flush_key);
>   
> 
