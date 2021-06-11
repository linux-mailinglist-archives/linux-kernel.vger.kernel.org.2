Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6291B3A3B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFKGFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:05:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54610 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFKGFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:05:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G1Vdp5s2fzBDn9;
        Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O073bCl2e0pq; Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G1Vdp4wD0z9xF5;
        Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 98D458B82C;
        Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ax2RHWfUqtTH; Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 395E58B765;
        Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Subject: Re: [PATCH] powerpc/tau: Remove redundant parameter in
 alloc_workqueue() call
To:     Finn Thain <fthain@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <4af6a7138fbd400e458352f6b384115f4adc4301.1623380367.git.fthain@linux-m68k.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c3824489-2f36-7b4c-e306-0c91b52e9c26@csgroup.eu>
Date:   Fri, 11 Jun 2021 08:03:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4af6a7138fbd400e458352f6b384115f4adc4301.1623380367.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redundant with what ?

Do you mean superfluous ?

Le 11/06/2021 à 04:59, Finn Thain a écrit :
> This avoids an (optional) compiler warning:
> 
> arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
> arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for format [-Werror=format-extra-args]
>    tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: b1c6a0a10bfa ("powerpc/tau: Convert from timer to workqueue")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   arch/powerpc/kernel/tau_6xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
> index 6c31af7f4fa8..b9a047d92ec0 100644
> --- a/arch/powerpc/kernel/tau_6xx.c
> +++ b/arch/powerpc/kernel/tau_6xx.c
> @@ -201,7 +201,7 @@ static int __init TAU_init(void)
>   	tau_int_enable = IS_ENABLED(CONFIG_TAU_INT) &&
>   			 !strcmp(cur_cpu_spec->platform, "ppc750");
>   
> -	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
> +	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1);
>   	if (!tau_workq)
>   		return -ENOMEM;
>   
> 
