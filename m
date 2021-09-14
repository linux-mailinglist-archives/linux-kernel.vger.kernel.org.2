Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FB40B40A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhINQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:02:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhINQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:02:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD22101E;
        Tue, 14 Sep 2021 09:01:03 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0A293F5A1;
        Tue, 14 Sep 2021 09:01:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 17:00:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64/traps: Avoid unnecessary kernel/user pointer
 conversion
Message-ID: <20210914160056.GA35239@C02TD0UTHF1T.local>
References: <20210914152742.27047-1-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914152742.27047-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:57:42PM +0530, Amit Daniel Kachhap wrote:
> Annotating a pointer from kernel to __user and then back again might
> confuse sparse. In call_undef_hook() it can be avoided by not using the
> intermediate user pointer variable.

When you say "might confuse sparse", does it complain today? If so, can
you include an example of what goes wrong?

> Note: This patch adds no functional changes to code.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
>  arch/arm64/kernel/traps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b03e383d944a..357d10a8bbf5 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -404,7 +404,8 @@ static int call_undef_hook(struct pt_regs *regs)
>  
>  	if (!user_mode(regs)) {
>  		__le32 instr_le;
> -		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
> +		if (get_kernel_nofault(instr_le,
> +				       (__le32 *)instruction_pointer(regs)))

Can we make `pc` an unsigned long, instead?

It'd be nice to handle all three cases consistently, even if that means
adding __force to the two user cases.

Thanks,
Mark.

>  			goto exit;
>  		instr = le32_to_cpu(instr_le);
>  	} else if (compat_thumb_mode(regs)) {
> -- 
> 2.17.1
> 
