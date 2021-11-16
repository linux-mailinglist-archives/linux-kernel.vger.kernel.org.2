Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7184536E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhKPQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238861AbhKPQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:09:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1516613DB;
        Tue, 16 Nov 2021 16:06:20 +0000 (UTC)
Date:   Tue, 16 Nov 2021 11:06:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
Message-ID: <20211116110618.490b4a57@gandalf.local.home>
In-Reply-To: <20211116024942.60644-3-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211116024942.60644-1-yinan@linux.alibaba.com>
        <20211116024942.60644-3-yinan@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 10:49:42 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> In some business scenarios, GCC versions are so old that
> optimizations in ftrace cannot be completed, such as
> -mrecord-mcount and -mnop-mcount. The recordmCount in the
> kernel is actually used. In this case, ftrace_init will
> consume a period of time, usually around 9~12ms. Do nop
> substitution in recordmcount.c to speed up ftrace_init.
> 
> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c  |  7 +++++++
>  scripts/recordmcount.h | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c776a2956237..ccc690e81556 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6478,6 +6478,13 @@ static int ftrace_process_locs(struct module *mod,
>  	 * until we are finished with it, and there's no
>  	 * reason to cause large interrupt latencies while we do it.
>  	 */
> +#ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
> +#ifdef CONFIG_HAVE_C_RECORDMCOUNT

So the above alone does not guarantee that the callers are converted into
nops. So this is wrong.

There's already logic to convert to nops. But that's done in the
architecture code, not in the generic code.

> +	ret = 0;
> +	goto out;
> +#endif
> +#endif
> +
>  	if (!mod)
>  		local_irq_save(flags);
>  	ftrace_update_code(mod, start_pg);
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index 1e9baa5c4fc6..152311639a0b 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -406,6 +406,8 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
>  			       uint_t const recval,
>  			       unsigned const reltype)
>  {
> +	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff) + (void *)ehdr);
> +	Elf_Shdr const *const shdr = &shdr0[w(relhdr->sh_info)];
>  	uint_t *const mloc0 = mlocp;
>  	Elf_Rel *mrelp = *mrelpp;
>  	Elf_Sym const *sym0;
> @@ -419,6 +421,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
>  	get_sym_str_and_relp(relhdr, ehdr, &sym0, &str0, &relp);
>  
>  	for (t = nrel; t; --t) {
> +		int ret = -1;
>  		if (!mcountsym)
>  			mcountsym = get_mcountsym(sym0, relp, str0);
>  
> @@ -436,6 +439,17 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
>  				*mlocp++ = addend;
>  
>  			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
> +			/* convert mcount into nop */
> +			if (make_nop)

Here you even have an if statement that only converts to nops if it is
already done.

-- Steve


> +				ret = make_nop((void *)ehdr,
> +						_w(shdr->sh_offset) + _w(relp->r_offset));
> +			if (!ret) {
> +				Elf_Rel rel;
> +				rel = *(Elf_Rel *)relp;
> +				Elf_r_info(&rel, Elf_r_sym(relp), rel_type_nop);
> +				ulseek(fd_map, (void *)relp - (void *)ehdr, SEEK_SET);
> +				uwrite(fd_map, &rel, sizeof(rel));
> +			}
>  		}
>  		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
>  	}

