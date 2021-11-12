Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9844ED52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhKLTiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 14:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhKLTiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:38:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A6C61039;
        Fri, 12 Nov 2021 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636745715;
        bh=Up9Hf6abDKDP4HIGkjlMZdQh3dCREUOqZMXjMC7RbDY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KrDA3XQYFSVl7Naj16oHQBfe5STM0XTOJH8NALoXXdwdqJtxm0duBeZY1CAmGEz27
         MUDzSA55NmVCapvxVTot2xSSF5JmhOGOoTdfeNn2Sra9/tD0U7TXHCyH9GLPmYbo8A
         HeuDrclOBBNiWxFg4cFuMQviN1ehdXzQC+cansbX7bdKxZwUy3OPphsRHbsRAI+SnX
         NAIRSCogQ54pLBr9L1BgkNJrOxr2blFi4s2vpAnTJ8ZJ+vTwSNjG+QZ8LmN+kVfEH/
         7Kc1i0UqYjE2rBNhHSWKp44DaY3GjMHG51+AuAnyFsnTQeNHkiCjwCHezZuk8++RiL
         el6sE2Fp+JHYw==
Subject: Re: [PATCH] driver: firmware: stratix10-svc: schedule thread out when
 there is no data reveived
To:     Meng Li <Meng.Li@windriver.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20211109074613.13994-1-Meng.Li@windriver.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <9ead8789-381d-2358-0c11-95b3350ca63e@kernel.org>
Date:   Fri, 12 Nov 2021 13:35:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109074613.13994-1-Meng.Li@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/21 1:46 AM, Meng Li wrote:
> From: Meng Li <meng.li@windriver.com>
> 
> In thread svc_normal_to_secure_thread(), function kfifo_out_spinlocked()
> always return, so this thread can't release cpu even if there is no data
> received, and cause cpu is under heave load status. System performance

do you mean "heavy"?

> is poor.
> 
> This issue is introduced by commit 7ca5ce896524("firmware: add Intel
> Stratix10 service layer driver")
> 
> Therefore, schedule this thread out when there is no data reveived, and

s/reveived/received

> wake it up after sending data to it.
> 
> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>   drivers/firmware/stratix10-svc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 2a7687911c09..ddb86d441726 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -365,8 +365,10 @@ static int svc_normal_to_secure_thread(void *data)
>   						pdata, sizeof(*pdata),
>   						&ctrl->svc_fifo_lock);
>   
> -		if (!ret_fifo)
> +		if (!ret_fifo) {
> +			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
>   			continue;
> +		}
>   
>   		pr_debug("get from FIFO pa=0x%016x, command=%u, size=%u\n",
>   			 (unsigned int)pdata->paddr, pdata->command,
> @@ -861,6 +863,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
>   	ret = kfifo_in_spinlocked(&chan->ctrl->svc_fifo, p_data,
>   				  sizeof(*p_data),
>   				  &chan->ctrl->svc_fifo_lock);
> +	wake_up_process(chan->ctrl->task);
>   
>   	kfree(p_data);
>   
> 

I've made above spelling fixes and have applied it.

Thanks,
Dinh
