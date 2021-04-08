Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD09357BAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhDHFEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:04:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46311 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHFEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:04:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FG8MC4bsWzB09ZK;
        Thu,  8 Apr 2021 07:04:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H3RDLEs2Xddu; Thu,  8 Apr 2021 07:04:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FG8MC3Mr4zB09ZJ;
        Thu,  8 Apr 2021 07:04:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 14A968B7C3;
        Thu,  8 Apr 2021 07:04:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RTOnYx6zOUw8; Thu,  8 Apr 2021 07:04:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C8038B75F;
        Thu,  8 Apr 2021 07:04:39 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc: make 'boot_text_mapped' static
To:     Yu Kuai <yukuai3@huawei.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210408011801.557004-1-yukuai3@huawei.com>
 <20210408011801.557004-3-yukuai3@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5b91cd3f-d171-f510-7dae-8cbabb13b23c@csgroup.eu>
Date:   Thu, 8 Apr 2021 07:04:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408011801.557004-3-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/04/2021 à 03:18, Yu Kuai a écrit :
> The sparse tool complains as follow:
> 
> arch/powerpc/kernel/btext.c:48:5: warning:
>   symbol 'boot_text_mapped' was not declared. Should it be static?
> 
> This symbol is not used outside of btext.c, so this commit make
> it static.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   arch/powerpc/kernel/btext.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
> index 359d0f4ca532..8df9230be6fa 100644
> --- a/arch/powerpc/kernel/btext.c
> +++ b/arch/powerpc/kernel/btext.c
> @@ -45,7 +45,7 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
>   
>   static unsigned char vga_font[cmapsz];
>   
> -int boot_text_mapped __force_data = 0;
> +static int boot_text_mapped __force_data;

Are you sure the initialisation to 0 can be removed ? Usually initialisation to 0 is not needed 
because not initialised variables go in the BSS section which is zeroed at startup. But here the 
variable is flagged with __force_data so it is not going in the BSS section.


>   
>   extern void rmci_on(void);
>   extern void rmci_off(void);
> 
