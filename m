Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D441D599
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348741AbhI3Iof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348518AbhI3Ioe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 040AA61439;
        Thu, 30 Sep 2021 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632991372;
        bh=YAnA2FtNx+qKH+DUhXFTr035RylLWdDdVr26z3gny3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNN48DDrtgswcaru3LHGl7NIqrLp1HEB8JubJ12b7gm+02FO64euY3Zcf/N2xrsKi
         h8SSwH3omgH/zN8rTqniJGQR4YlBnqLvUGoB0Fhe3aKUyd7SsTQSyQM/xkshI1M7F1
         gLQC0+1k304iTXeIZh/JbxZSTuQ6ip+8lpgsd5AuGuELW/LHcI/1ScXmQXsADUVKEx
         YfWiwKzTvHVRBNQbYyoKI1IpHwZZhcGtdZ3b2CdTndusVE1vvJnj/YiPERRTx3nB/k
         gN47SY1pjtHs0weXfAe6o0y/9DRGIcDT/FZmNk9Hnynp0FNdoNDQkz9EgyWyH0sJ9N
         i2XobeaZh7JdA==
Date:   Thu, 30 Sep 2021 09:42:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Chen Lin <chen45464546@163.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
Subject: Re: [PATCH] arm64: traps: add dump instr before BUG in kernel
Message-ID: <20210930084247.GC23389@willie-the-truck>
References: <1632922186-3116-1-git-send-email-chen45464546@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632922186-3116-1-git-send-email-chen45464546@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:29:46PM +0800, Chen Lin wrote:
> From: Chen Lin <chen.lin5@zte.com.cn>
> 
> we should dump the real instructions before BUG in kernel mode, and
> compare this to the instructions from objdump.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> ---
>  arch/arm64/kernel/traps.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b03e383..621a9dd 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -495,7 +495,12 @@ void do_undefinstr(struct pt_regs *regs)
>  	if (call_undef_hook(regs) == 0)
>  		return;
>  
> -	BUG_ON(!user_mode(regs));
> +	if (!user_mode(regs)) {
> +		pr_emerg("Undef instruction in kernel, dump instr:");
> +		dump_kernel_instr(KERN_EMERG, regs);
> +		BUG();
> +	}

Hmm, I'm not completely convinced about this as the instruction in the
i-cache could be completely different. I think the PC value (for addr2line)
is a lot more useful, and we should be printing that already.

Maybe you can elaborate on a situation where this information was helpful?

Thanks,

Will
