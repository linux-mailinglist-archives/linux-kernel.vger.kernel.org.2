Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A33691D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbhDWMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:17:16 -0400
Received: from foss.arm.com ([217.140.110.172]:34188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhDWMRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:17:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E312E11D4;
        Fri, 23 Apr 2021 05:16:36 -0700 (PDT)
Received: from [10.57.62.63] (unknown [10.57.62.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140C03F694;
        Fri, 23 Apr 2021 05:16:35 -0700 (PDT)
Subject: Re: [PATCH] arm/mach-hisi: Use BUG_ON instead of if condition
 followed by BUG
To:     zhouchuangao <zhouchuangao@vivo.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1619165686-69955-1-git-send-email-zhouchuangao@vivo.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8875077b-ed17-0896-97e7-1b2b13e9a9fa@arm.com>
Date:   Fri, 23 Apr 2021 13:16:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1619165686-69955-1-git-send-email-zhouchuangao@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-23 09:14, zhouchuangao wrote:
> BUG_ON uses unlikely in if(). Through disassembly, we can see that
> brk #0x800 is compiled to the end of the function.
> As you can see below:
>      ......
>      ffffff8008660bec:   d65f03c0    ret
>      ffffff8008660bf0:   d4210000    brk #0x800
> 
> Usually, the condition in if () is not satisfied. For the
> multi-stage pipeline, we do not need to perform fetch decode
> and excute operation on brk instruction.

32-bit Arm does not have "ret" and "brk" instructions, and either way 
the relevant BUG() instruction(s) aren't executed unless the condition 
is met, so this really makes very little sense.

> In my opinion, this can improve the efficiency of the
> multi-stage pipeline.

It has very little to do with the pipeline - modern cores are 
considerably more sophisticated than the 3-stage Acorn RISC Machine of 
1985, and are not usually limited by frontend throughput. The point of 
unlikely() is to avoid having a normally-taken forward branch to skip 
over in-line code, and instead make sure the only thing in the normal 
execution path is a normally-not-taken branch to handle the condition 
out-of-line. Yes, the impact of branches - and thus why it can be 
desirable to avoid them - is indeed *related* to pipelining, but that's 
rather tangential.

Even then, it's only worth considering things at this level in 
frequently-executed and/or performance-critical code. Saving a couple of 
CPU cycles in something that is effectively a one-time operation is 
utterly immaterial.

The realistic justification for these patches is that that BUG_ON() 
exists for implementing conditional BUG()s, so we may as well use it if 
it makes the source code more readable.

> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
> ---
>   arch/arm/mach-hisi/hotplug.c  | 3 +--
>   arch/arm/mach-hisi/platmcpm.c | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
> index c517941..b9ced60 100644
> --- a/arch/arm/mach-hisi/hotplug.c
> +++ b/arch/arm/mach-hisi/hotplug.c
> @@ -193,8 +193,7 @@ void hix5hd2_set_cpu(int cpu, bool enable)
>   	u32 val = 0;
>   
>   	if (!ctrl_base)
> -		if (!hix5hd2_hotplug_init())
> -			BUG();
> +		BUG_ON(!hix5hd2_hotplug_init());

Whatever tool you're using to detect these patterns, consider improving 
it, or at least giving a bit more thought to the results beyond blindly 
applying one single rule - "if(x) BUG_ON(y);" arguably makes even less 
sense since it's now neither one thing nor the other.

Robin.

>   	if (enable) {
>   		/* power on cpu1 */
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> index 96a4840..6c90039 100644
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -82,8 +82,8 @@ static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
>   {
>   	unsigned long data;
>   
> -	if (!fabric)
> -		BUG();
> +	BUG_ON(!fabric);
> +
>   	data = readl_relaxed(fabric + FAB_SF_MODE);
>   	if (on)
>   		data |= 1 << cluster;
> 
