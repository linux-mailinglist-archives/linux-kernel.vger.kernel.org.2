Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3410398364
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhFBHqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:46:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35376 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhFBHqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:46:01 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fw1J12j0hzBCJg;
        Wed,  2 Jun 2021 09:44:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8FGfsZLeU5Ok; Wed,  2 Jun 2021 09:44:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fw1J04z0FzBCP1;
        Wed,  2 Jun 2021 09:44:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9275C8B7D4;
        Wed,  2 Jun 2021 09:44:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RFZfY_rbGftx; Wed,  2 Jun 2021 09:44:16 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25BA58B771;
        Wed,  2 Jun 2021 09:44:16 +0200 (CEST)
Subject: Re: [PATCH] powerpc/8xx: select CPM1 for MPC8XXFADS
To:     trix@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210601175304.2634549-1-trix@redhat.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <50ed000a-c1af-8552-9d35-771b3bc131e5@csgroup.eu>
Date:   Wed, 2 Jun 2021 09:44:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601175304.2634549-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/06/2021 à 19:53, trix@redhat.com a écrit :
> From: Tom Rix <trix@redhat.com>
> 
> With MPC8XXFADS, there is this linker error
> ppc64-linux-ld: m8xx_setup.o: in function `cpm_cascade':
> m8xx_setup.c: undefined reference to `cpm_get_irq'

It looks like this config item is stale, it doesn't build any board support, there is no 
define_machine() for this config item, no file is linked to that config item.

I think you should just remove that item from the possible choices.

Christophe


> 
> cpm_get_irq() is conditionally complied by CPM1
> So add a select, like the other plaforms
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   arch/powerpc/platforms/8xx/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
> index 60cc5b537a98..919082cdb2f1 100644
> --- a/arch/powerpc/platforms/8xx/Kconfig
> +++ b/arch/powerpc/platforms/8xx/Kconfig
> @@ -10,6 +10,7 @@ choice
>   
>   config MPC8XXFADS
>   	bool "FADS"
> +	select CPM1
>   
>   config MPC86XADS
>   	bool "MPC86XADS"
> 
