Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCED7357BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhDHFCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:02:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33238 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDHFCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:02:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FG8J94JYGzB09ZJ;
        Thu,  8 Apr 2021 07:02:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wo15aJ24badP; Thu,  8 Apr 2021 07:02:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FG8J90khkzB09ZH;
        Thu,  8 Apr 2021 07:02:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1F158B7C3;
        Thu,  8 Apr 2021 07:02:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YoTzwfEJdziZ; Thu,  8 Apr 2021 07:02:01 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 231688B75F;
        Thu,  8 Apr 2021 07:02:01 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc: remove set but not used variable
 'force_printk_to_btext'
To:     Yu Kuai <yukuai3@huawei.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210408011801.557004-1-yukuai3@huawei.com>
 <20210408011801.557004-2-yukuai3@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b7636590-42ef-e588-59e1-b0591243d619@csgroup.eu>
Date:   Thu, 8 Apr 2021 07:01:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408011801.557004-2-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/04/2021 à 03:18, Yu Kuai a écrit :
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> arch/powerpc/kernel/btext.c:49:12: error: 'force_printk_to_btext'
> defined but not used.

You don't get this error as it is now.
You will get this error only if you make it 'static', which is what you did in your first patch 
based on the 'sparse' report.

When removing a non static variable, you should explain that you can remove it after you have 
verifier that it is nowhere used, neither in that file nor in any other one.

> 
> It is never used, and so can be removed.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   arch/powerpc/kernel/btext.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
> index 803c2a45b22a..359d0f4ca532 100644
> --- a/arch/powerpc/kernel/btext.c
> +++ b/arch/powerpc/kernel/btext.c
> @@ -46,7 +46,6 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
>   static unsigned char vga_font[cmapsz];
>   
>   int boot_text_mapped __force_data = 0;
> -int force_printk_to_btext = 0;
>   
>   extern void rmci_on(void);
>   extern void rmci_off(void);
> 
