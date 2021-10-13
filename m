Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9742CED8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJMWvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJMWvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:51:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0965C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IPNCwnThf2t1Ii4hs5jFUu0ZSK8PstKHiAQrTyemuXU=; b=mkHy3KBnPu8RFYERQV5eK5hDd8
        eiBovp6x/asrzJeBnzgyvDEHEUuSu2OshMM4+XOzuAWCMYzjqG82IEAJDLW5x+eNRBRxOYyukHN3k
        /zZNTrpQTxw6JGQ/I9qIOVUH5HTM1yRBDbajoBfpapPZyOv6PfwkgJbdYOPxs3/kaiT3IEJiLlhGy
        yg7DRZgslLfI8Zr1xma+Oey2pcIsc/dKUI/QSqNnhwAatxB8KV9lXPJfE2Xx2uJsdgmEsx9TgGNvc
        EvyUeK020H01WoDIlILEl28LPxH59cy/tn4vDfZcXlAFDrC6NevcXKht6LB04daTg5dArBcN6ev1h
        rC3JzgTw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1man3z-000w0v-QA; Wed, 13 Oct 2021 22:49:31 +0000
Subject: Re: [PATCH] init: Make unknown command line param message clearer
To:     Andrew Halaney <ahalaney@redhat.com>, akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, bp@suse.de, linux-kernel@vger.kernel.org
References: <20211013223502.96756-1-ahalaney@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e670eb5-2e73-5169-6ae1-6cd2b2ca8013@infradead.org>
Date:   Wed, 13 Oct 2021 15:49:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013223502.96756-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 3:35 PM, Andrew Halaney wrote:
> The prior message is confusing users, which is the exact opposite of the
> goal. If the message is being seen, one of the following situations is
> happening:
> 
>   1. the param is misspelled
>   2. the param is not valid due to the kernel configuration
>   3. the param is intended for init but isn't after the '--'
>      delineator on the command line
> 
> To make that more clear to the user, explicitly mention "kernel command
> line" and also note that the params are still passed to user space to
> avoid causing any alarm over params intended for init.
> 
> Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> Here's v2 of this. I had to change the code a bit from what Steven
> recommended to compile/look proper, but the intended format he had
> suggested is still the same.
> 
> v1 -> v2:
>   * Print a much more concise message
> 
> v1: https://lore.kernel.org/all/20211012213523.39801-1-ahalaney@redhat.com/
> 
> Thanks,
> Andrew
> 
>   init/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index ee4d3e1b3eb9..a286995449e2 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -925,7 +925,9 @@ static void __init print_unknown_bootoptions(void)
>   	for (p = &envp_init[2]; *p; p++)
>   		end += sprintf(end, " %s", *p);
>   
> -	pr_notice("Unknown command line parameters:%s\n", unknown_options);
> +	/* Start at unknown_options[1] to skip the initial space */
> +	pr_notice("Unknown kernel command line parameters \"%s\", will be passed to user space.\n",
> +		&unknown_options[1]);
>   	memblock_free(unknown_options, len);
>   }
>   
> 

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
