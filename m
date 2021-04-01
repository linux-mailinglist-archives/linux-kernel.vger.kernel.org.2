Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA4352190
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhDAVV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233926AbhDAVVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:21:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4340610F8;
        Thu,  1 Apr 2021 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617312113;
        bh=fqFgia6xhcUSTm8pPYkWji0FiEe1A8KsE2ZdGQsnsjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WHW08u3rWaahx3qFLlnszE0gmloCWxA2IA+cvoFohd0HfSUReF3+Cy0fl8no1XKao
         Qas0X00DsfcfL2cLcd1wMIRV7GTC5OJXEofuaNQb3pSpT/pqiLfVVEuVy2X+upQZtT
         V5+A7T6BcIUNLgcUjYH6946PdRiAFgMtpdyOXDru10NfxAoRCcooi63DKHH6PtFXtQ
         LaYnGzoMryFry3vrD9T01YGyQpWIkoCY/iJGddX1kwO+TpQN/RD0Ev3Qkz7tqxjeoM
         wogIMZdP+MJt1vqvDXmUKAATXY/a1eIUtJiJDUt3QgzhEU58hxVR5SdlNSug6BCP+Z
         C6hPoR2m9GVNw==
Date:   Fri, 2 Apr 2021 06:21:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/kernel/probes: Use BUG_ON instead of if condition
 followed by BUG.
Message-Id: <20210402062149.98ad11a0ec940cef86122fc2@kernel.org>
In-Reply-To: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
References: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 04:57:50 -0700
zhouchuangao <zhouchuangao@vivo.com> wrote:

> It can be optimized at compile time.
> 

Anyway, this seems to make the code simpler.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 66aac28..ecf0f61 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -264,8 +264,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>  		 * normal page fault.
>  		 */
>  		instruction_pointer_set(regs, (unsigned long) cur->addr);
> -		if (!instruction_pointer(regs))
> -			BUG();
> +		BUG_ON(!instruction_pointer(regs));
>  
>  		if (kcb->kprobe_status == KPROBE_REENTER)
>  			restore_previous_kprobe(kcb);
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
