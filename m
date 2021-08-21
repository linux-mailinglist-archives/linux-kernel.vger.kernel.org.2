Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE83F38C3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhHUE40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 00:56:26 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:54037 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhHUE4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 00:56:24 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d11 with ME
        id k4vj250063riaq2034vkFW; Sat, 21 Aug 2021 06:55:44 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 06:55:44 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH linux-next] ia64/kernel/iosapic: replace a printk +
 WARN_ON() to a WARN()
To:     CGEL <cgel.zte@gmail.com>, inux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210821034416.27992-1-jing.yangyang@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <ff3592ac-2dd0-f92d-fc75-cdb4f9761753@wanadoo.fr>
Date:   Sat, 21 Aug 2021 06:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821034416.27992-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

beside the fact that your patch seems to change the log level from ERR 
to WARN, have you compile tested your change?

You are still using WARN_ON, which takes only 1 parameter.

CJ

Le 21/08/2021 à 05:44, CGEL a écrit :
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Replace a printk+WARN_ON() by a WARN(); this increases the chance of
                                   ^^^^
> the string making it into the bugreport
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>   arch/ia64/kernel/iosapic.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
> index 35adcf8..cb8ba1c 100644
> --- a/arch/ia64/kernel/iosapic.c
> +++ b/arch/ia64/kernel/iosapic.c
> @@ -794,17 +794,13 @@ static inline unsigned char choose_dmode(void)
>   	 */
>   	irq = gsi_to_irq(gsi);
>   	if (irq < 0) {
> -		printk(KERN_ERR "iosapic_unregister_intr(%u) unbalanced\n",
> -		       gsi);
> -		WARN_ON(1);
> +		WARN_ON(1, "iosapic_unregister_intr(%u) unbalanced\n", gsi);
                 ^^^^^^^
>   		return;
>   	}
>   
>   	spin_lock_irqsave(&iosapic_lock, flags);
>   	if ((rte = find_rte(irq, gsi)) == NULL) {
> -		printk(KERN_ERR "iosapic_unregister_intr(%u) unbalanced\n",
> -		       gsi);
> -		WARN_ON(1);
> +		WARN_ON(1, "iosapic_unregister_intr(%u) unbalanced\n", gsi);
                 ^^^^^^^
>   		goto out;
>   	}
>   
> 

