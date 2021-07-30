Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C677C3DB880
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhG3MWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhG3MWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73F3360F0F;
        Fri, 30 Jul 2021 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627647761;
        bh=6rPDKOhXYLbds6nrD5HJGHt+dOnovarXwROp9/CyKZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlMh3a4XCuGOTkoRFslKFOC5+jQetKCuY/TGSoGMd8duetvdFMbYrlk/juRI5DszS
         o/21RNLixzIm0twxsanZdlfA9ud7qzIXIoCTJy+w35c9BZN88mAzALUXUYZ+0BC6SE
         bgQQk3N64Kl+qQs+4ne9MHMNxzLRLU77mcDeA+Nk8307mNHaa4l6Rje9ium3weZmQB
         aRt65/xJkTlgY899amR/yd+aDgBxS8/hVeVb5eQiCGPasZEEsgfLWvyOYFYQpUY7rb
         ZaEVIQOLmgwZOHs93DOhsRVASXlP9jOud2GALq738PRXWobe6a4Gzy9Zu0iaobh8oo
         F89/OkH6DsLBg==
Date:   Fri, 30 Jul 2021 13:22:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Yuchen Wei <weiyuchen3@huawei.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, vincenzo.frascino@arm.com,
        keescook@chromium.org, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: audit: fix return value high 32bit truncation
 problem
Message-ID: <20210730122236.GE23589@willie-the-truck>
References: <20210722060707.531-1-weiyuchen3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722060707.531-1-weiyuchen3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 02:07:07PM +0800, Yuchen Wei wrote:
> From: weiyuchen <weiyuchen3@huawei.com>
> 
> Add error code judgment in invoke_syscall() to prevent kernel
> components such as audit and tracepoint from obtaining incorrect
> return values. For example:
> 
> type=SYSCALL msg=audit(342.780:69): arch=40000028 syscall=235
> success=yes exit=4294967235
> 
> The syscall return value is -61, but due to the following process in
> invoke_syscall():
> 
> 	if (is_compat_task())
> 		ret = lower_32_bits(ret);
> 	regs->regs[0] = ret;
> 
> The return value audit or tracepoint get from regs[0] is 4294967235,
> which is an incorrect return value.
> 
> Signed-off-by: weiyuchen <weiyuchen3@huawei.com>
> ---
>  arch/arm64/kernel/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 263d6c1a525f..f9f042d9a088 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -54,7 +54,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  		ret = do_ni_syscall(regs, scno);
>  	}
>  
> -	if (is_compat_task())
> +	if (is_compat_task() && !IS_ERR_VALUE(ret))
>  		ret = lower_32_bits(ret);

Hmm, I'm worried this might break other users who don't expect to see
non-zero bits for the upper 32-bits of a compat task.

Mark -- I remember you looking into this relatively recently. Where did you
get to with it?

Will
