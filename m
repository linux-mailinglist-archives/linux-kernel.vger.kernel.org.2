Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0509D456560
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhKRWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhKRWL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:11:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6E7610FC;
        Thu, 18 Nov 2021 22:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637273309;
        bh=nM7eJgtYblZpyGin8DxssN6bOnWk6deJi37e+HcLp7I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a2a9m1Ycwc/r8EaPgt9WTFnFBxmn2G1YStW9s96zuJVUSkS819PGpsiY08/R1ElQB
         j28n4E/xJCH6ezk/kaRH+mDEhdTNYI/sK71y2shhFM8Ymbsfg/gsjQZc9OdGfub8+k
         zrC7RLGkhIN95+YD//MMy3r6vMDH1JN4a3WsES3hpf7ZhD1DdH4JlVyo7Pb8gBVRuc
         XQhGeUEpkQgGAk86v+B1Cbepo1vOTTBiqLmF2ezE9A5Wet7ZHovnYwRSDDk9HsbjIF
         cghgyF4p1idHulmPrl+aNxv2+5MbR8Im9lJVTtE21TwPDoF2iJX0jnFdplaZZd8dqN
         Syf0WjKVU35LQ==
Subject: Re: [PATCH v2] ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211118142508.19200-1-tiwai@suse.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <91f8a48f-512d-ea18-3af9-fa444d826b23@kernel.org>
Date:   Thu, 18 Nov 2021 16:08:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118142508.19200-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwai,

Should this have the following tag:

Fixes: 9c4566a117a6 ("ARM: socfpga: Enable SMP for socfpga")

As well?

On 11/18/21 8:25 AM, Takashi Iwai wrote:
> When CONFIG_FORTIFY_SOURCE is set, memcpy() checks the potential
> buffer overflow and panics.  The code in sofcpga bootstrapping
> contains the memcpy() calls are mistakenly translated as the shorter
> size, hence it triggers a panic as if it were overflowing.
> 
> This patch changes the secondary_trampoline and *_end definitions
> to arrays for avoiding the false-positive crash above.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Buglink: https://bugzilla.suse.com/show_bug.cgi?id=1192473
> Link: https://lore.kernel.org/r/20211117193244.31162-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> v1->v2: Use arrays for trampoline area instead of hackish workaround
> 	with __NO_FORTIFY
> 
>   arch/arm/mach-socfpga/core.h    | 2 +-
>   arch/arm/mach-socfpga/platsmp.c | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> index fc2608b18a0d..18f01190dcfd 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -33,7 +33,7 @@ extern void __iomem *sdr_ctl_base_addr;
>   u32 socfpga_sdram_self_refresh(u32 sdr_base);
>   extern unsigned int socfpga_sdram_self_refresh_sz;
>   
> -extern char secondary_trampoline, secondary_trampoline_end;
> +extern char secondary_trampoline[], secondary_trampoline_end[];
>   
>   extern unsigned long socfpga_cpu1start_addr;
>   
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index fbb80b883e5d..201191cf68f3 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -20,14 +20,14 @@
>   
>   static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   {
> -	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> +	int trampoline_size = secondary_trampoline_end - secondary_trampoline;
>   
>   	if (socfpga_cpu1start_addr) {
>   		/* This will put CPU #1 into reset. */
>   		writel(RSTMGR_MPUMODRST_CPU1,
>   		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
>   
> -		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> +		memcpy(phys_to_virt(0), secondary_trampoline, trampoline_size);
>   
>   		writel(__pa_symbol(secondary_startup),
>   		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
> @@ -45,12 +45,12 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   
>   static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   {
> -	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> +	int trampoline_size = secondary_trampoline_end - secondary_trampoline;
>   
>   	if (socfpga_cpu1start_addr) {
>   		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
>   		       SOCFPGA_A10_RSTMGR_MODMPURST);
> -		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> +		memcpy(phys_to_virt(0), secondary_trampoline, trampoline_size);
>   
>   		writel(__pa_symbol(secondary_startup),
>   		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
> 
