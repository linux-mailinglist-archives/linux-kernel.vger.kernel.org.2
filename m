Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0858537F02A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhELX6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234351AbhELXon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:44:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5283D61408;
        Wed, 12 May 2021 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620863014;
        bh=QY+pbOK5m88B0wwDucAl3MHLjY2YDe0sMglYS33VW4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MBV9DlCYPIwfoAopNUE5fFRU5/aj85+myoONJ9W05PNrEipcHor2Mdsb1wzVSIhgr
         sqe8pxoXYZdgzY0Mwif4fgMncxgVfIE7h/YzHYtqsIPEzLH/7FW0yCfNEUNn7l6OHQ
         m/Vi/GAyHCKUc8s8R3fY2inGj1KDeklr4mpItsXw4SHXBaJ3OCfX75WeEXldqqbBDw
         IJ2wxg2s6VG/GHthLbhFMQ4g4e0XcnUePyJ68gnrgEwHVmWHcSOCBgRepLAXC3aaGr
         /cRdODnVM3vRot9xzSqSHkTqYB4CFzklP9BgCu4yGIdmco0vJGhQHvHFmJP2PRTlfQ
         wo6rIge0YvdQw==
Date:   Thu, 13 May 2021 08:43:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] kprobes: Allow architectures to override optinsn
 page allocation
Message-Id: <20210513084331.58371b520af4aae914518552@kernel.org>
In-Reply-To: <472c597cc8cc8f74f037acf971f7799fb381a647.1620829724.git.christophe.leroy@csgroup.eu>
References: <472c597cc8cc8f74f037acf971f7799fb381a647.1620829724.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 14:29:26 +0000 (UTC)
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Some architectures like powerpc require a non standard
> allocation of optinsn page, because module pages are
> too far from the kernel for direct branches.
> 
> Define weak alloc_optinsn_page() and free_optinsn_page(), that
> fall back on alloc_insn_page() and free_insn_page() when not
> overriden by the architecture.
> 

Looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/kprobes.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd7a6..8c0a6fdef771 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -321,11 +321,21 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
>  }
>  
>  #ifdef CONFIG_OPTPROBES
> +void __weak *alloc_optinsn_page(void)
> +{
> +	return alloc_insn_page();
> +}
> +
> +void __weak free_optinsn_page(void *page)
> +{
> +	free_insn_page(page);
> +}
> +
>  /* For optimized_kprobe buffer */
>  struct kprobe_insn_cache kprobe_optinsn_slots = {
>  	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
> -	.alloc = alloc_insn_page,
> -	.free = free_insn_page,
> +	.alloc = alloc_optinsn_page,
> +	.free = free_optinsn_page,
>  	.sym = KPROBE_OPTINSN_PAGE_SYM,
>  	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
>  	/* .insn_size is initialized later */
> -- 
> 2.25.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
