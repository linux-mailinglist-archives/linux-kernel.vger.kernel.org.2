Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61853D9182
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhG1PIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:08:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44577 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhG1PIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:08:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627484882; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=sj2A2zR3rcI8P9VUMF3/9Yk8xk+GhmmV1rwmsS/dDMU=; b=mC3qGMR2gROfN8/EHK4FGKlgas4yi5oZ0mb3nu897gdZS2fpQVWWwQ5pqocuHek3zeHPQV9S
 USLI0cyq9WrFVJ5I7tcaN9HzuN7pTAPvSDfkg7g10qSkmlw78xJHCiGtRIhv//DOM/ugydSe
 IuxBXlLr1z/lyE2Y03IEy0/1vJw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 610172c5b653fbdadd4e6ad5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Jul 2021 15:07:48
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33600C433F1; Wed, 28 Jul 2021 15:07:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 497DBC433F1;
        Wed, 28 Jul 2021 15:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 497DBC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nathan Chancellor'" <nathan@kernel.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        "'Manning, Sid'" <sidneym@quicinc.com>
References: <20210728001729.1960182-1-nathan@kernel.org>
In-Reply-To: <20210728001729.1960182-1-nathan@kernel.org>
Subject: RE: [PATCH] hexagon: Clean up timer-regs.h
Date:   Wed, 28 Jul 2021 10:07:45 -0500
Message-ID: <03bc01d783c2$52e6f200$f8b4d600$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHsvcFl/v/yGvN+KqOPEWg6PsqxiKsuCMEw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
...
> When building allmodconfig, there is a warning about TIMER_ENABLE being
> redefined:
> 
>  drivers/clocksource/timer-oxnas-rps.c:39:9: warning: 'TIMER_ENABLE'
>  macro redefined [-Wmacro-redefined]
>  #define TIMER_ENABLE            BIT(7)
>          ^
>  arch/hexagon/include/asm/timer-regs.h:13:9: note: previous definition
>  is here
>  #define TIMER_ENABLE            0
>          ^
>  1 warning generated.
> 
> The values in this header are only used in one file each, if they are
> used at all. Remove the header and sink all of the constants into their
> respective files.
> 
> TCX0_CLK_RATE is only used in arch/hexagon/include/asm/timex.h
> 
> TIMER_ENABLE, RTOS_TIMER_INT, RTOS_TIMER_REGS_ADDR are only used in
> arch/hexagon/kernel/time.c.
> 
> SLEEP_CLK_RATE and TIMER_CLR_ON_MATCH have both been unused since
> the
> file's introduction in commit 71e4a47f32f4 ("Hexagon: Add time and timer
> functions").
> 
> TIMER_ENABLE is redefined as BIT(0) so the shift is moved into the
> definition, rather than its use.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/include/asm/timer-regs.h | 26 --------------------------
>  arch/hexagon/include/asm/timex.h      |  3 +--
>  arch/hexagon/kernel/time.c            | 12 ++++++++++--
>  3 files changed, 11 insertions(+), 30 deletions(-)
>  delete mode 100644 arch/hexagon/include/asm/timer-regs.h
> 
> diff --git a/arch/hexagon/include/asm/timer-regs.h
> b/arch/hexagon/include/asm/timer-regs.h
> deleted file mode 100644
> index ee6c61423a05..000000000000
> --- a/arch/hexagon/include/asm/timer-regs.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Timer support for Hexagon
> - *
> - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> - */
> -
> -#ifndef _ASM_TIMER_REGS_H
> -#define _ASM_TIMER_REGS_H
> -
> -/*  This stuff should go into a platform specific file  */
> -#define TCX0_CLK_RATE		19200
> -#define TIMER_ENABLE		0
> -#define TIMER_CLR_ON_MATCH	1
> -
> -/*
> - * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
> - * release 1.1, and then it's "adjustable" and probably not defaulted.
> - */
> -#define RTOS_TIMER_INT		3
> -#ifdef CONFIG_HEXAGON_COMET
> -#define RTOS_TIMER_REGS_ADDR	0xAB000000UL
> -#endif
> -#define SLEEP_CLK_RATE		32000
> -
> -#endif
> diff --git a/arch/hexagon/include/asm/timex.h
> b/arch/hexagon/include/asm/timex.h
> index 8d4ec76fceb4..dfe69e118b2b 100644
> --- a/arch/hexagon/include/asm/timex.h
> +++ b/arch/hexagon/include/asm/timex.h
> @@ -7,11 +7,10 @@
>  #define _ASM_TIMEX_H
> 
>  #include <asm-generic/timex.h>
> -#include <asm/timer-regs.h>
>  #include <asm/hexagon_vm.h>
> 
>  /* Using TCX0 as our clock.  CLOCK_TICK_RATE scheduled to be removed. */
> -#define CLOCK_TICK_RATE              TCX0_CLK_RATE
> +#define CLOCK_TICK_RATE              19200
> 
>  #define ARCH_HAS_READ_CURRENT_TIMER
> 
> diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
> index feffe527ac92..febc95714d75 100644
> --- a/arch/hexagon/kernel/time.c
> +++ b/arch/hexagon/kernel/time.c
> @@ -17,9 +17,10 @@
>  #include <linux/of_irq.h>
>  #include <linux/module.h>
> 
> -#include <asm/timer-regs.h>
>  #include <asm/hexagon_vm.h>
> 
> +#define TIMER_ENABLE		BIT(0)
> +
>  /*
>   * For the clocksource we need:
>   *	pcycle frequency (600MHz)
> @@ -33,6 +34,13 @@ cycles_t	pcycle_freq_mhz;
>  cycles_t	thread_freq_mhz;
>  cycles_t	sleep_clk_freq;
> 
> +/*
> + * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
> + * release 1.1, and then it's "adjustable" and probably not defaulted.
> + */
> +#define RTOS_TIMER_INT		3
> +#define RTOS_TIMER_REGS_ADDR	0xAB000000UL
> +
>  static struct resource rtos_timer_resources[] = {
>  	{
>  		.start	= RTOS_TIMER_REGS_ADDR,
> @@ -80,7 +88,7 @@ static int set_next_event(unsigned long delta, struct
> clock_event_device *evt)
>  	iowrite32(0, &rtos_timer->clear);
> 
>  	iowrite32(delta, &rtos_timer->match);
> -	iowrite32(1 << TIMER_ENABLE, &rtos_timer->enable);
> +	iowrite32(TIMER_ENABLE, &rtos_timer->enable);
>  	return 0;
>  }
> 
> 
> base-commit: 7d549995d4e0d99b68e8a7793a0d23da6fc40fe8

Acked-by: Brian Cain <bcain@codeaurora.org>

