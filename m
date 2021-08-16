Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807DC3ED373
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHPL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:58:12 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49251 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhHPL6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:58:10 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GpCMj3cPpz9sTy;
        Mon, 16 Aug 2021 13:57:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EIHC1e0M3SAo; Mon, 16 Aug 2021 13:57:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GpCMj2cRlz9sTd;
        Mon, 16 Aug 2021 13:57:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36DE48B796;
        Mon, 16 Aug 2021 13:57:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zvj6u5B11xyV; Mon, 16 Aug 2021 13:57:37 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 09CF88B788;
        Mon, 16 Aug 2021 13:57:37 +0200 (CEST)
Subject: Re: [PATCH linux-next] module: remove duplicate include in
 interrupt.c
To:     cgel.zte@gmail.com, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20210816113453.126939-1-lv.ruyi@zte.com.cn>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7bf73aea-5758-63e1-ac69-156a2ffecf2c@csgroup.eu>
Date:   Mon, 16 Aug 2021 13:57:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816113453.126939-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/08/2021 à 13:34, cgel.zte@gmail.com a écrit :
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> 'asm/interrupt.h' included in 'interrupt.c' is duplicated.

This patch has been submitted at least half a dozen of times already.

You should maintain alphabetic order in the include list.

But please don't post it again, we have it in the pipe already, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1624329437-84730-1-git-send-email-jiapeng.chong@linux.alibaba.com/

Next time please check at https://patchwork.ozlabs.org/project/linuxppc-dev/list/ before submitting 
a new patch.

Thanks
Christophe

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>   arch/powerpc/kernel/interrupt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 21bbd615ca41..8a936515e4e4 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -10,7 +10,6 @@
>   #include <asm/cputime.h>
>   #include <asm/interrupt.h>
>   #include <asm/hw_irq.h>
> -#include <asm/interrupt.h>
>   #include <asm/kprobes.h>
>   #include <asm/paca.h>
>   #include <asm/ptrace.h>
> 
