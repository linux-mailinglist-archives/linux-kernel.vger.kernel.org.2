Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264E33A212D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJAJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhFJAJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:09:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9732613F0;
        Thu, 10 Jun 2021 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623283682;
        bh=32g+BqOqkw9hiIJzBLCIC3Ni7y/3goorKlmjTRTpk9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XA3F7/s63rv1gJ9FmZ5a22Iz+HRzB2YnOKglK+ZJOnMmM2eL5z75rp2l2oUNTtR+f
         VO24MYvi4Bvw9BiAuWy80hgLdFpOahKvrO7fq9UeiomGziauOIiyNRB+YukukNBbE9
         0PifGwJjSYiii6Tlvw3sdTpfHvoJvR6zvblFNLhHdWyw+aGbsHq7T06Hc3Wst9hyZV
         8F3hzyK4e7Ar4wiVWMBeedRAyu6Y9PxkdyGFZhY9XuCaeTZujktZqAGZEUZ7DgDvZU
         2iMjSruxIzDDsqvr1vDUfkWhRf+YqO/Lcd0IlrEfTQGTL/oKerC/NTyjYn3tavtFMb
         3PlV6uNBA54KA==
Date:   Thu, 10 Jun 2021 09:07:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 4/5] csky: ftrace: Drop duplicate implementation of
 arch_check_ftrace_location()
Message-Id: <20210610090758.dfb02db4d804ffaf319d77a5@kernel.org>
In-Reply-To: <20210609105019.3626677-5-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-5-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 19:50:18 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> The csky specific arch_check_ftrace_location() shadows a weak
> implementation of the function in core code that offers the same
> functionality but with additional error checking.
> 
> Drop the architecture specific function as a step towards further
> cleanup in core code.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/csky/kernel/probes/ftrace.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index ef2bb9bd9605..b388228abbf2 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -2,13 +2,6 @@
>  
>  #include <linux/kprobes.h>
>  
> -int arch_check_ftrace_location(struct kprobe *p)
> -{
> -	if (ftrace_location((unsigned long)p->addr))
> -		p->flags |= KPROBE_FLAG_FTRACE;
> -	return 0;
> -}
> -
>  /* Ftrace callback handler for kprobes -- called under preepmt disabled */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
