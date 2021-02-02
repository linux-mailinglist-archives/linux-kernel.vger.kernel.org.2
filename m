Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD72830BF11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhBBNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:10:14 -0500
Received: from foss.arm.com ([217.140.110.172]:49558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhBBNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:09:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 634421FB;
        Tue,  2 Feb 2021 05:09:06 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84AD53F718;
        Tue,  2 Feb 2021 05:09:04 -0800 (PST)
Subject: Re: [RESENT PATCH] arm64: cpuinfo: Add "model name" in /proc/cpuinfo
 for 64bit tasks also
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Sumit Gupta <sumitg@nvidia.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210201235809.401-1-cnsztl@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0c7bfb19-c6ca-1700-8203-fb54e8c1ffae@arm.com>
Date:   Tue, 2 Feb 2021 13:09:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201235809.401-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01 23:58, Tianling Shen wrote:
> From: Sumit Gupta <sumitg@nvidia.com>
> 
> Removed restriction of displaying model name for 32 bit tasks only.
> This can be used for 64 bit tasks as well, and it's useful for some
> tools that already parse this, such as coreutils `uname -p`, Ubuntu
> model name display etc.

How exactly is it useful? It clearly isn't necessary for compatibility, 
since AArch64 userspace has apparently been running quite happily for 8 
years without it. It also doesn't convey anything meaningful to the 
user, since they already know they're on an Armv8-compatible processor 
by the fact that they're running AArch64 userspace at all.

Robin.

> It should be like this:
> ```
> $ cat '/proc/cpuinfo' | grep 'model name' | head -n 1
> model name : ARMv8 Processor rev X (v8l)
> ```
> 
> Link: https://lore.kernel.org/lkml/1472461345-28219-1-git-send-email-sumitg@nvidia.com/
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>   arch/arm64/kernel/cpuinfo.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 77605aec25fe..d69b4e486098 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -148,8 +148,7 @@ static int c_show(struct seq_file *m, void *v)
>   		 * "processor".  Give glibc what it expects.
>   		 */
>   		seq_printf(m, "processor\t: %d\n", i);
> -		if (compat)
> -			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
> +		seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
>   				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
>   
>   		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> 
