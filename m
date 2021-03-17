Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E323D33EA57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCQHBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:01:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38509 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCQHBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:01:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F0gzb65jfz9vBn3;
        Wed, 17 Mar 2021 08:00:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id arCS8u5r8lUa; Wed, 17 Mar 2021 08:00:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F0gzb4LkTz9vBn2;
        Wed, 17 Mar 2021 08:00:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 764C98B819;
        Wed, 17 Mar 2021 08:01:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TI4ffKCC1lw8; Wed, 17 Mar 2021 08:01:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 173228B81B;
        Wed, 17 Mar 2021 08:01:00 +0100 (CET)
Subject: Re: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jk@ozlabs.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
References: <1615963510-89830-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <188541f6-e047-0dfd-8f57-edfce5fae49b@csgroup.eu>
Date:   Wed, 17 Mar 2021 08:00:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615963510-89830-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/03/2021 à 07:45, Jiapeng Chong a écrit :
> Fix the following coccicheck warnings:
> 
> ./arch/powerpc/platforms/cell/spufs/sched.c:908:2-5: WARNING: Use BUG_ON
> instead of if condition followed by BUG.

Consider using WARN_ON() instead of BUG_ON() if relevant. If not, explain in the commit message why 
we need to keep a BUG_ON().

See https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on


> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   arch/powerpc/platforms/cell/spufs/sched.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
> index 3692064..139a6ec 100644
> --- a/arch/powerpc/platforms/cell/spufs/sched.c
> +++ b/arch/powerpc/platforms/cell/spufs/sched.c
> @@ -904,8 +904,7 @@ static noinline void spusched_tick(struct spu_context *ctx)
>   	struct spu_context *new = NULL;
>   	struct spu *spu = NULL;
>   
> -	if (spu_acquire(ctx))
> -		BUG();	/* a kernel thread never has signals pending */
> +	BUG_ON(spu_acquire(ctx));	/* a kernel thread never has signals pending */
>   
>   	if (ctx->state != SPU_STATE_RUNNABLE)
>   		goto out;
> 
