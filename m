Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60973B922E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhGANW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:22:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64656 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236587AbhGANWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:22:50 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GFytj08T5zB9np;
        Thu,  1 Jul 2021 14:58:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F3Q4u9vNdjG6; Thu,  1 Jul 2021 14:58:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GFytg6LvnzB9pC;
        Thu,  1 Jul 2021 14:58:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C88098B903;
        Thu,  1 Jul 2021 14:58:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uOkqtDmpu2rb; Thu,  1 Jul 2021 14:58:03 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62FDB8B961;
        Thu,  1 Jul 2021 14:58:03 +0200 (CEST)
Subject: Re: [PATCH] sched: Use WARN_ON
To:     Jason Wang <wangborong@cdjrlc.com>, jk@ozlabs.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210701125046.43018-1-wangborong@cdjrlc.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f72d43b9-88a1-19f0-c6ca-87fd7a01f379@csgroup.eu>
Date:   Thu, 1 Jul 2021 14:57:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701125046.43018-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/07/2021 à 14:50, Jason Wang a écrit :
> The BUG_ON macro simplifies the if condition followed by BUG, but it
> will lead to the kernel crashing. Therefore, we can try using WARN_ON
> instead of if condition followed by BUG.

But are you sure it is ok to continue if spu_acquire(ctx) returned false ?
Shouldn't there be at least for fallback handling ?

Something like:

	if (WARN_ON(spu_acquire(ctx)))
		return;


Christophe


> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   arch/powerpc/platforms/cell/spufs/sched.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
> index 369206489895..0f218d9e5733 100644
> --- a/arch/powerpc/platforms/cell/spufs/sched.c
> +++ b/arch/powerpc/platforms/cell/spufs/sched.c
> @@ -904,8 +904,8 @@ static noinline void spusched_tick(struct spu_context *ctx)
>   	struct spu_context *new = NULL;
>   	struct spu *spu = NULL;
>   
> -	if (spu_acquire(ctx))
> -		BUG();	/* a kernel thread never has signals pending */
> +	/* a kernel thread never has signals pending */
> +	WARN_ON(spu_acquire(ctx));
>   
>   	if (ctx->state != SPU_STATE_RUNNABLE)
>   		goto out;
> 
