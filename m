Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC830D8B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhBCLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:32:55 -0500
Received: from foss.arm.com ([217.140.110.172]:38270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhBCLc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:32:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36EFAD6E;
        Wed,  3 Feb 2021 03:31:43 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B60F3F719;
        Wed,  3 Feb 2021 03:31:41 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:31:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/kernel: minor coding style tweaks
Message-ID: <20210203113138.GC55896@C02TD0UTHF1T.local>
References: <1612329552-17977-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612329552-17977-1-git-send-email-daizhiyuan@phytium.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:19:12PM +0800, Zhiyuan Dai wrote:
> Fixed two coding style issues in kernel/trap.c
> 1. spaces required around that '='

This change makes sense to me as a cleanup.

> 2. Missing a blank line after declarations

We're inconsistent w.r.t. this across the tree, and applying this
everywhere would be very churny, but I think it makes sense to be
consistent locally (e.g. within a function).

Currently call_undef_hook() is inconsistent in this respect, but I think
this patch leaves it inconsistent in a different way. Please see below.

> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>  arch/arm64/kernel/traps.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 6895ce7..4001a39 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -45,7 +45,7 @@
>  #include <asm/system_misc.h>
>  #include <asm/sysreg.h>
>  
> -static const char *handler[]= {
> +static const char *handler[] = {
>  	"Synchronous Abort",
>  	"IRQ",
>  	"FIQ",
> @@ -318,6 +318,7 @@ static int call_undef_hook(struct pt_regs *regs)
>  	} else if (compat_thumb_mode(regs)) {
>  		/* 16-bit Thumb instruction */
>  		__le16 instr_le;
> +
>  		if (get_user(instr_le, (__le16 __user *)pc))
>  			goto exit;
>  		instr = le16_to_cpu(instr_le);

Immediately above this we have:

|	if (!user_mode(regs)) {
|		__le32 instr_le;
|		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
|			goto exit;
|		instr = le32_to_cpu(instr_le);

... which we should either change at the same time, or not bother with
this at all.

Thanks,
Mark.

> @@ -332,6 +333,7 @@ static int call_undef_hook(struct pt_regs *regs)
>  	} else {
>  		/* 32-bit ARM instruction */
>  		__le32 instr_le;
> +
>  		if (get_user(instr_le, (__le32 __user *)pc))
>  			goto exit;
>  		instr = le32_to_cpu(instr_le);
> -- 
> 1.8.3.1
> 
