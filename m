Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E216A34576B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWFmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:42:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1156 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCWFl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:41:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F4Kxc6YH5z9v0Ck;
        Tue, 23 Mar 2021 06:41:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id t1PddXMWBVjS; Tue, 23 Mar 2021 06:41:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F4Kxc438nz9v0Cj;
        Tue, 23 Mar 2021 06:41:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F9858B7AE;
        Tue, 23 Mar 2021 06:41:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6PHfTCxDZ_5z; Tue, 23 Mar 2021 06:41:56 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6006B8B75F;
        Tue, 23 Mar 2021 06:41:56 +0100 (CET)
Subject: Re: [PATCH] arch: powerpc: Remove duplicate include of interrupt.h
To:     Wan Jiabing <wanjiabing@vivo.com>,
        zhouchuangao <zhouchuangao@vivo.com>
Cc:     kael_w@yeah.net, Qiang Zhao <qiang.zhao@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
References: <20210323024126.237840-1-wanjiabing@vivo.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e38279c5-3284-1693-ec34-4e537bd49c1e@csgroup.eu>
Date:   Tue, 23 Mar 2021 06:41:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323024126.237840-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/03/2021 à 03:41, Wan Jiabing a écrit :
> asm/interrupt.h has been included at line 12. According to
> alphabetic order,we remove the duplicate one at line 10.

Could you please cook a single patch for all files in arch/powerpc/

Thanks
Christophe

> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   arch/powerpc/kernel/interrupt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index c475a229a42a..11d456896772 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -7,7 +7,6 @@
>   #include <asm/asm-prototypes.h>
>   #include <asm/kup.h>
>   #include <asm/cputime.h>
> -#include <asm/interrupt.h>
>   #include <asm/hw_irq.h>
>   #include <asm/interrupt.h>
>   #include <asm/kprobes.h>
> 
