Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB95406C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhIJM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:57:12 -0400
Received: from foss.arm.com ([217.140.110.172]:56808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhIJM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:57:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3058D6D;
        Fri, 10 Sep 2021 05:56:00 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57DC83F5A1;
        Fri, 10 Sep 2021 05:55:59 -0700 (PDT)
Subject: Re: [PATCH] dma-debug: prevent an error message from causing runtime
 problems
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
References: <20210910120541.39938-1-someguy@effective-light.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <215cd3ba-3f4c-ab74-c59e-f099fa64aaac@arm.com>
Date:   Fri, 10 Sep 2021 13:55:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910120541.39938-1-someguy@effective-light.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-10 13:05, Hamza Mahfooz wrote:
> For some drivers, that call add_dma_entry() from somewhere down the call
> stack.

Nit: strictly, drivers don't call add_dma_entry(). Drivers only call the 
DMA API functions, and it is the DMA API internals which take a detour 
through dma-debug when desired.

> If this error condition is triggered once, it causes the error
> message to spam the kernel's printk buffer

Is that true? It doesn't look like anything in dma-debug itself can 
obviously lead to that; I was assuming that in Jeremy's case it's the 
driver which has managed to do something such that every new mapping 
call it makes ends up hitting the warning. A busy network interface is 
probably more than capable of saturating the kernel log with a print for 
every packet (particularly a great big 100GBE-capable multi-queue thing 
like that one).

> and bring the CPU usage up to
> 100%. Also, since there is at least one driver that is in the mainline
> and suffers from the error condition, it is more useful to WARN_ON() here
> instead of just printing the error message (in hopes that it will make it
> easier for other drivers that suffer from this issue to be spotted).
> 
> Link: https://lkml.kernel.org/r/fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>   kernel/dma/debug.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 6c90c69e5311..d9806689666e 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -567,7 +567,9 @@ static void add_dma_entry(struct dma_debug_entry *entry)
>   		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
>   		global_disable = true;
>   	} else if (rc == -EEXIST) {
> -		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
> +		WARN_ONCE(1,
> +			  pr_fmt("cacheline tracking EEXIST, overlapping mappings aren't supported\n"
> +			 ));

Unless there's some subtlety I'm missing, it would be better to use 
err_printk() here - not only for consistency of output, but also to tie 
in with dma-debug's existing output-limiting controls.

Robin.

>   	}
>   }
>   
> 
