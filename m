Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C138835DFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbhDMNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhDMNAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54F81613BB;
        Tue, 13 Apr 2021 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618318834;
        bh=cJd5gEKEKaZSb9uFKqHIAHqh5CE9Y1iKpOsW8fH1KSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQR/H1LP/GdJDQUYi5kjAAP9crEBzsMZfaMzLuOPVawZNgAUFNI8uuTtB2FDJn9fQ
         xzW5xqrCr6rRDSwE56e2SqFhAeJ7ceL3y94QB6v2p8YGoijBxi2TgRJ6fueOkbKAv7
         dqmmCfB8iTejc7P8dQFboT7BHRCuiC0CNEaLn5uYZy+WdKq3/TkgfaEeWDMOIy1dfZ
         yy5U1bxm6dcEQEUPLVdWbHHQjCnlZCb2v6jwunaeElw8xj8YN1PWYgSexHvp0vgyot
         qDJtBcPYn9B9ea5snujOpivE0urYT/np4yYMq+NkLJ4uhGxxZpVCFEiWIVR/zlZV3N
         39BR02j3p8PQw==
Date:   Tue, 13 Apr 2021 22:00:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-Id: <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
In-Reply-To: <20210413180231.19b72601@xhacker.debian>
References: <20210413180231.19b72601@xhacker.debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Apr 2021 18:03:24 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Use the __vmalloc_node_range() to simplify x86's alloc_insn_page()
> implementation.

Have you checked this is equivarent to the original code on
all architecture? IIRC, some arch has a special module_alloc(),
thus I NACKed similar patch previously.

Thank you,

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index df776cdca327..75081f3dbe44 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -383,26 +383,10 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
>  /* Make page to RO mode when allocate it */
>  void *alloc_insn_page(void)
>  {
> -	void *page;
> -
> -	page = module_alloc(PAGE_SIZE);
> -	if (!page)
> -		return NULL;
> -
> -	set_vm_flush_reset_perms(page);
> -	/*
> -	 * First make the page read-only, and only then make it executable to
> -	 * prevent it from being W+X in between.
> -	 */
> -	set_memory_ro((unsigned long)page, 1);
> -
> -	/*
> -	 * TODO: Once additional kernel code protection mechanisms are set, ensure
> -	 * that the page was not maliciously altered and it is still zeroed.
> -	 */
> -	set_memory_x((unsigned long)page, 1);
> -
> -	return page;
> +	return __vmalloc_node_range(PAGE_SIZE, PAGE_SIZE, VMALLOC_START,
> +			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
> +			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> +			__builtin_return_address(0));
>  }
>  
>  /* Recover page to RW mode before releasing it */
> -- 
> 2.31.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
