Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D842658E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJHIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233532AbhJHIDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:03:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB10661037;
        Fri,  8 Oct 2021 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633680080;
        bh=jBP5YiJelY1gFHbkIeJVER6Kc4RrNqrmg0M9IIt5CTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLEf2Qd3vCQd0wunvozQAOcFzTgr5ptD+soEtOINt59Vqj2rMFe6LV6JiHTWbCtve
         8juOuaYIzuEwFyla0xtdk0D6BAXpxZG4r7ekbBeZ5N/R3rmkRsVzvfGx0UbsvSb6F4
         B2RFw27JfS6boYJEofuBqUAzsmsbP40ciYauPfZtgpQ65UDCyh2hrMYjFb7ZKCWgCS
         wd4+hkSxIaKiOIK7OIeFh8cfo/UMyiwmkLp5rnZIABeKLUxQXLTTnAq/l4M1guFFYa
         iYR48lRMOz3NeUiW1sbYo6+9nTt6Q70t+rFlMWuOV+9rzU8oRaQ2cJzqIGO+YfD9RH
         36JZyDm3sVHTw==
Date:   Fri, 8 Oct 2021 09:01:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [RFC PATCH] arch: ARM64: add isb before enable pan
Message-ID: <20211008080113.GA441@willie-the-truck>
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> test, which can be work around by a msleep on the sw context. We assume
> suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> 
> PS:
> The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> alike racing between on chip PAN and SW_PAN.

Sorry, but I'm struggling to understand the problem here. Please could you
explain it in more detail?

  - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
  - Can you explain the race that you think might be occurring?
  - Why does an ISB prevent the race?

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index efed283..3c0de0d 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1663,6 +1663,7 @@ static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>  	WARN_ON_ONCE(in_interrupt());
>  
>  	sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
> +	isb();
>  	set_pstate_pan(1);

SCTLR_EL1.SPAN only affects the PAN behaviour on taking an exception, which
is itself a context-synchronizing event, so I can't see why the ISB makes
any difference here (at least, for the purposes of PAN).

Thanks,

Will
