Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3353E336F90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhCKKEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:04:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:33232 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhCKKET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:04:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dx4Km1kcQz9v13M;
        Thu, 11 Mar 2021 11:04:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Yt5SNfQdPg-7; Thu, 11 Mar 2021 11:04:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dx4Kl02sDz9v13K;
        Thu, 11 Mar 2021 11:04:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 204788B806;
        Thu, 11 Mar 2021 11:04:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HUDGfYWbibI3; Thu, 11 Mar 2021 11:04:12 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 748098B802;
        Thu, 11 Mar 2021 11:04:11 +0100 (CET)
Subject: Re: [PATCH] powerpc/prom: remove unneeded semicolon
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mpe@ellerman.id.au
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1615455601-117447-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <eb17f128-7a00-886e-c7f3-ca215398fbfc@csgroup.eu>
Date:   Thu, 11 Mar 2021 11:04:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615455601-117447-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 11/03/2021 à 10:40, Jiapeng Chong a écrit :
> Fix the following coccicheck warnings:
> 
> ./arch/powerpc/kernel/prom_init.c:2986:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

You already sent this patch in February and it is under Review, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=&submitter=81048&state=&q=&archive=&delegate=

Any reason for resending it ?


> ---
>   arch/powerpc/kernel/prom_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index ccf77b9..41ed7e3 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2983,7 +2983,7 @@ static void __init fixup_device_tree_efika_add_phy(void)
>   				" 0x3 encode-int encode+"
>   				" s\" interrupts\" property"
>   			" finish-device");
> -	};
> +	}
>   
>   	/* Check for a PHY device node - if missing then create one and
>   	 * give it's phandle to the ethernet node */
> 
