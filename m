Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97C743FD60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhJ2Nd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:33:56 -0400
Received: from foss.arm.com ([217.140.110.172]:38348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhJ2Ndz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:33:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0102D1063;
        Fri, 29 Oct 2021 06:31:27 -0700 (PDT)
Received: from [10.57.25.71] (unknown [10.57.25.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A5CC3F73D;
        Fri, 29 Oct 2021 06:31:25 -0700 (PDT)
Subject: Re: [PATCH] [RFC] arm64: export this_cpu_has_cap
To:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211029113023.760421-1-arnd@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
Date:   Fri, 29 Oct 2021 14:31:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211029113023.760421-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

Thanks for the fix.

On 29/10/2021 12:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It's now used in a coresight driver that can be a loadable module:
> 
> ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> 
> Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Will, Catalin, Mathieu,

Do you have a preference on how this fix can be pulled in ? This may
be safe to go via coresight tree if it is not too late. Otherwise,
it could go via the arm64 tree.

Suzuki

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure if we actually want this to be exported, this is my local
> workaround for the randconfig build bot.
> ---
>   arch/arm64/kernel/cpufeature.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ecbdff795f5e..beccbcfa7391 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2864,6 +2864,7 @@ bool this_cpu_has_cap(unsigned int n)
>   
>   	return false;
>   }
> +EXPORT_SYMBOL(this_cpu_has_cap);
>   
>   /*
>    * This helper function is used in a narrow window when,
> 

