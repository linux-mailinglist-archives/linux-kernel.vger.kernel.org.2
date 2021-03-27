Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0834B87A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhC0RZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:25:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43766 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhC0RYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:24:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F75Lq5JlPz9ty5J;
        Sat, 27 Mar 2021 18:24:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L9WsE6gnoJQe; Sat, 27 Mar 2021 18:24:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F75Lq46k3z9ty5H;
        Sat, 27 Mar 2021 18:24:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A58E78B777;
        Sat, 27 Mar 2021 18:24:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BhA0t_BILO1F; Sat, 27 Mar 2021 18:24:51 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3595A8B771;
        Sat, 27 Mar 2021 18:24:51 +0100 (CET)
Subject: Re: [PATCH v3 37/41] powerpc/32s: Move KUEP locking/unlocking in C
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
 <4eadd873927e9a73c3d1dfe2f9497353465514cf.1615552867.git.christophe.leroy@csgroup.eu>
Message-ID: <4ff132a6-7552-a46f-5690-e73c37c805f9@csgroup.eu>
Date:   Sat, 27 Mar 2021 18:24:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <4eadd873927e9a73c3d1dfe2f9497353465514cf.1615552867.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/03/2021 à 13:50, Christophe Leroy a écrit :
> This can be done in C, do it.
> 
> Unrolling the loop gains approx. 15% performance.
> 
>  From now on, prepare_transfer_to_handler() is only for
> interrupts from kernel.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/include/asm/book3s/32/kup.h | 31 -------------------
>   arch/powerpc/include/asm/interrupt.h     |  6 +++-
>   arch/powerpc/include/asm/kup.h           |  8 +++++
>   arch/powerpc/kernel/entry_32.S           | 16 ----------
>   arch/powerpc/kernel/head_32.h            |  3 ++
>   arch/powerpc/kernel/head_booke.h         |  3 ++
>   arch/powerpc/kernel/interrupt.c          |  4 +++
>   arch/powerpc/mm/book3s32/Makefile        |  1 +
>   arch/powerpc/mm/book3s32/kuep.c          | 38 ++++++++++++++++++++++++
>   9 files changed, 62 insertions(+), 48 deletions(-)
>   create mode 100644 arch/powerpc/mm/book3s32/kuep.c
> 

> diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
> new file mode 100644
> index 000000000000..c70532568a28
> --- /dev/null
> +++ b/arch/powerpc/mm/book3s32/kuep.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <asm/reg.h>
> +#include <asm/task_size_32.h>
> +#include <asm/mmu.h>

Need to add <asm/kup.h> to make Robot happy (missing prototypes of kuep_lock() and kuep_unlock())

> +
> +#define KUEP_UPDATE_TWO_USER_SEGMENTS(n) do {		\
> +	if (TASK_SIZE > ((n) << 28))			\
> +		mtsr(val1, (n) << 28);			\
> +	if (TASK_SIZE > (((n) + 1) << 28))		\
> +		mtsr(val2, ((n) + 1) << 28);		\
> +	val1 = (val1 + 0x222) & 0xf0ffffff;		\
> +	val2 = (val2 + 0x222) & 0xf0ffffff;		\
> +} while (0)
> +
> +static __always_inline void kuep_update(u32 val)
> +{
> +	int val1 = val;
> +	int val2 = (val + 0x111) & 0xf0ffffff;
> +
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(0);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(2);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(4);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(6);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(8);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(10);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(12);
> +	KUEP_UPDATE_TWO_USER_SEGMENTS(14);
> +}
> +
> +void kuep_lock(void)
> +{
> +	kuep_update(mfsr(0) | SR_NX);
> +}
> +
> +void kuep_unlock(void)
> +{
> +	kuep_update(mfsr(0) & ~SR_NX);
> +}
> 
