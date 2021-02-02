Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16430B862
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhBBHHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:07:52 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56979 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhBBHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:07:36 -0500
X-Originating-IP: 82.65.183.113
Received: from [172.16.5.113] (82-65-183-113.subs.proxad.net [82.65.183.113])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 773666000A;
        Tue,  2 Feb 2021 07:06:44 +0000 (UTC)
Subject: Re: [PATCH] riscv: kasan: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, aryabinin@virtuozzo.com
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, glider@google.com,
        linux-riscv@lists.infradead.org, dvyukov@google.com
References: <1612245119-116845-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <4b3294d7-ff30-8f02-81ff-d2d73a79e465@ghiti.fr>
Date:   Tue, 2 Feb 2021 02:06:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612245119-116845-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Le 2/2/21 à 12:51 AM, Yang Li a écrit :
> Eliminate the following coccicheck warning:
> ./arch/riscv/mm/kasan_init.c:103:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   arch/riscv/mm/kasan_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index a8a2ffd..fac437a 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -100,7 +100,7 @@ void __init kasan_init(void)
>   			break;
>   
>   		populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
> -	};
> +	}
>   
>   	for (i = 0; i < PTRS_PER_PTE; i++)
>   		set_pte(&kasan_early_shadow_pte[i],
> 

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex
