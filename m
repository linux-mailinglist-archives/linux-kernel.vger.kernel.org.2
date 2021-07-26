Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681563D6815
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhGZTj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhGZTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:39:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CEA60F8F;
        Mon, 26 Jul 2021 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627330826;
        bh=vPJluLR+UyESGAnN0/1xKurOHbvHvNV/vQaSvtv7XZk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lwm2qD0tnML6jfHA9ffIA5lSwU0q7SBuKU63vfFdSljE+v1foGG95mLcSmYVSm3qG
         xmageAoK9V3Jp7BaCXqxzndIait+SuEsgoMqidOitPvSMLeFm01bjwd/UAH9D+GjPj
         N6P08Ki5rAX4mFgMHzM/bF+vfQLYe9oIF+KegRKMHiplB61RfgtxRQnGQBWoy4jPrJ
         mItjZFgVaf7Z5SqjKQcL2K+VPgDr41pEIwGRaIAsz9Csetxu0lnq6CnCHf2+GyRtV8
         51hTr6slgEyyU+PZFsSgKQMCN/jyE17kFySj/crIfg3p5ZGEG0M7nk5DsA36LcSHtv
         iHyO+c0KLLQMA==
Subject: Re: [PATCH] x86/mm: use WARN_ONCE
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210726130829.93874-1-wangborong@cdjrlc.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <0038691f-b247-f3b2-ee25-ac7b0e7b9aeb@kernel.org>
Date:   Mon, 26 Jul 2021 13:20:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726130829.93874-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 6:08 AM, Jason Wang wrote:
> printk + WARN_ON_ONCE can be just WARN_ONCE.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/x86/mm/ioremap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 60ade7dd71bd..3e57035ef9e3 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -195,9 +195,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>  		return NULL;
>  
>  	if (!phys_addr_valid(phys_addr)) {
> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
> -		       (unsigned long long)phys_addr);
> -		WARN_ON_ONCE(1);
> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
> +			  (unsigned long long)phys_addr);
>  		return NULL;
>  	}
>  
> 

This isn't a no-op change.  Before, it would KERN_WARNING once per event
and dump a trace once.  Now it will only print anything at all once.
