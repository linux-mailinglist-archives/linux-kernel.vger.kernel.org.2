Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116A03CBCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhGPTmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:42:31 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.31]:37106 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232949AbhGPTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:42:30 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 42DCC400E90BF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:39:31 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 4TgJmCAWIK61i4TgJmT7dG; Fri, 16 Jul 2021 14:39:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wG2fHRIYhToISlq/S0FluX42lfgP0GsA8YTjdaC6kf8=; b=FJX96jA0Fdz2e8153jhYYYymUl
        3xQW8aS/aM5g7lahRxIicefg9mrRo9F3xyU5Q7rVETSD2XSBuAaNu5PT30tWyoK/ualYbjKkTsf22
        J3XN6HIz+UADKpWE2WFtyzfUAqNuQEClplsY76QIbcz1+Jm2ioINwIDpYdeF7cqw+gsSQE74xA6+7
        VCN9upjgnbb6TlUSqcuHeiSfyNq4XzJq+vxpiA10b0GoOWTKrqFjYZbK6r+E2yvbMmJEFOVE52AO9
        aXxPWsEihxwphWCK6x4xyTfP88H0hH21z/gKGhNGtRI9iyjDLidMZWhG1PnGLN6hX8qLpLN47+Bhm
        3HkqPWBg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:42938 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1m4TgG-003TNa-Sf; Fri, 16 Jul 2021 14:39:28 -0500
Subject: Re: [PATCH] ARC: unwind: Use struct_size helper instead of open-coded
 arithmetic
To:     Len Baker <len.baker@gmx.com>, Vineet Gupta <vgupta@synopsys.com>
Cc:     "dean.yang_cp" <yangdianqing@yulong.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210716170344.9150-1-len.baker@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e39778bc-4059-49d6-79a1-9a207eb319cf@embeddedor.com>
Date:   Fri, 16 Jul 2021 14:41:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716170344.9150-1-len.baker@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1m4TgG-003TNa-Sf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:42938
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/21 12:03, Len Baker wrote:
> Dynamic size calculations (especially multiplication) should not be
> performed in memory allocator function arguments due to the risk of them
> overflowing. This could lead to values wrapping around and a smaller
> allocation being made than the caller was expecting. Using those
> allocations could lead to linear overflows of heap memory and other
> misbehaviors.
> 
> To avoid this scenario, use the struct_size helper.
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  arch/arc/kernel/unwind.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 47bab67f8649..af18052b86a7 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/module.h>
>  #include <linux/memblock.h>
> +#include <linux/overflow.h>
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  #include <linux/stop_machine.h>
> @@ -312,9 +313,7 @@ static void init_unwind_hdr(struct unwind_table *table,
>  	if (tableSize || !n)
>  		goto ret_err;
> 
> -	hdrSize = 4 + sizeof(unsigned long) + sizeof(unsigned int)
> -	    + 2 * n * sizeof(unsigned long);
> -
> +	hdrSize = struct_size(header, table, n);
>  	header = alloc(hdrSize);
>  	if (!header)
>  		goto ret_err;
> --
> 2.25.1
> 
