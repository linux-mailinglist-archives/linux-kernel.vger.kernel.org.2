Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F223A2184
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhFJAjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFJAjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:39:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B14C0613FE;
        Thu, 10 Jun 2021 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623285477;
        bh=QZo8nWG9dQvYQdYPtjwbsUO0z9XBFqplGiXGzJWMzAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctfvsFdIacm10HEtoCxKOM8puMw9rffVZSlo5j6js2tgJF2V4gUHiRZZbUL16oliY
         P9BLJPN51FhAlgzl0ebGZ1OkUTuTj443OQpRwMioNcsZMZT4oHNUuzoNFbkrBBTXqT
         Ln8UqqqkvIQPMqgcyJ4h+1VPdgP4PAMHx9b0Q82JMafcNv78DGyzTr0b/PtaCXaYLx
         ZEFzhQuPPViR012EnY7wWr68yIyS8uRREWNuog1qgLpxWwKoBpVn5LIYEHrQozByTt
         KoRAbxzZSEC8tv72dJmsuubudWyEYDBk/dqK/D/aC0M2SOspYDFBHZFrcuPYoDx7kS
         yXc6UkDhprdMg==
Date:   Thu, 10 Jun 2021 09:37:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] kprobes: Make arch_check_ftrace_location static
Message-Id: <20210610093739.e9a67b16dfc50732cc048ee9@kernel.org>
In-Reply-To: <20210609105019.3626677-6-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-6-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 19:50:19 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> arch_check_ftrace_location() was introduced as a weak function in
> f7f242ff0044 ("kprobes: introduce weak arch_check_ftrace_location()
> helper function") to allow architectures to handle kprobes call site
> on their own.
> 
> Recently, the only architecture (csky) to implement
> arch_check_ftrace_location() was migrated to using the common
> version.
> 
> As a result, further cleanup the code to drop the weak attribute and
> rename the function to remove the architecture specific
> implementation.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  include/linux/kprobes.h | 2 --
>  kernel/kprobes.c        | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 771013bab18a..beea9ecee187 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -369,8 +369,6 @@ static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
>  }
>  #endif
>  
> -int arch_check_ftrace_location(struct kprobe *p);
> -
>  /* Get the kprobe at this addr (if any) - called with preemption disabled */
>  struct kprobe *get_kprobe(void *addr);
>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 54d37d4ab897..b12ae6cc8dc3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1531,7 +1531,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
>  	return ret;
>  }
>  
> -int __weak arch_check_ftrace_location(struct kprobe *p)
> +static int check_ftrace_location(struct kprobe *p)
>  {
>  	unsigned long ftrace_addr;
>  
> @@ -1554,7 +1554,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  {
>  	int ret;
>  
> -	ret = arch_check_ftrace_location(p);
> +	ret = check_ftrace_location(p);
>  	if (ret)
>  		return ret;
>  	jump_label_lock();
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
