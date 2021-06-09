Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50D3A179C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhFIOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237065AbhFIOoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E181E60C41;
        Wed,  9 Jun 2021 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623249763;
        bh=Lp60OTlEpA4K5hhgaDeUeuOpwZLJTceSMA4AcexQtDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1N60SBwy3hhUI46/fN+kdehhpeImnmtscq8b13N5KLlfhHalhL19DyhtSNBX8S9Z
         9CDaDA17auI1RHJuJhRandVrmoAUs9Ph/YqROiIXoT93L0j0Cj+uQX8RwvA2axRHbk
         sRDx1WA1oBUErIq/+qinZXUbEAu+M3PyM8+47TIzPp7/yz1lpM9YdW7FRSfc05H+pJ
         u6fRahWU12idNUlBHvjO4ayKFNkaVp8eZfmu8N3H3PIw5HRNWvyQh3ajAtV/ztZ3Fq
         fBM1KRCuEtzYnd3P+8L8iu1D5NBLfIOLZuczMlCdSriyWae17OK0ve/Ld0uMweQbPQ
         yDYLChHfcaeUg==
Date:   Wed, 9 Jun 2021 23:42:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] kprobe: Simplify prepare_kprobe() by dropping
 redundant version
Message-Id: <20210609234239.8b61d29b7f12fb1307048e6c@kernel.org>
In-Reply-To: <20210609105019.3626677-4-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-4-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 19:50:17 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> The function prepare_kprobe() is called during kprobe registration and
> is responsible for ensuring any architecture related preparation for
> the kprobe is done before returning.
> 
> One of two versions of prepare_kprobe() is chosen depending on the
> availability of KPROBE_ON_FTRACE in the kernel configuration.
> 
> Simplify the code by dropping the version when KPROBE_ON_FTRACE is not
> selected - instead relying on kprobe_ftrace() to return false when
> KPROBE_ON_FTRACE is not set.
> 

OK, since kprobe_ftrace() just checks a flag is set or not,
it is always usable in kprobes.c.
Looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> No functional change.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  include/linux/kprobes.h |  5 +++++
>  kernel/kprobes.c        | 23 +++++++++--------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 1883a4a9f16a..771013bab18a 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -362,6 +362,11 @@ static inline void wait_for_kprobe_optimizer(void) { }
>  extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
>  extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
> +#else
> +static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  int arch_check_ftrace_location(struct kprobe *p);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1a11d3c411bf..54d37d4ab897 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1022,15 +1022,6 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
>  static int kprobe_ipmodify_enabled;
>  static int kprobe_ftrace_enabled;
>  
> -/* Must ensure p->addr is really on ftrace */
> -static int prepare_kprobe(struct kprobe *p)
> -{
> -	if (!kprobe_ftrace(p))
> -		return arch_prepare_kprobe(p);
> -
> -	return arch_prepare_kprobe_ftrace(p);
> -}
> -
>  /* Caller must lock kprobe_mutex */
>  static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  			       int *cnt)
> @@ -1102,11 +1093,6 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
>  		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
>  }
>  #else	/* !CONFIG_KPROBES_ON_FTRACE */
> -static inline int prepare_kprobe(struct kprobe *p)
> -{
> -	return arch_prepare_kprobe(p);
> -}
> -
>  static inline int arm_kprobe_ftrace(struct kprobe *p)
>  {
>  	return -ENODEV;
> @@ -1118,6 +1104,15 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
>  }
>  #endif
>  
> +static int prepare_kprobe(struct kprobe *p)
> +{
> +	/* Must ensure p->addr is really on ftrace */
> +	if (kprobe_ftrace(p))
> +		return arch_prepare_kprobe_ftrace(p);
> +
> +	return arch_prepare_kprobe(p);
> +}
> +
>  /* Arm a kprobe with text_mutex */
>  static int arm_kprobe(struct kprobe *kp)
>  {
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
