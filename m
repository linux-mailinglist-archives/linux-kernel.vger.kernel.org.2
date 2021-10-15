Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC50542F1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhJONM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239332AbhJONMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:12:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11D53611C3;
        Fri, 15 Oct 2021 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634303417;
        bh=P2BeoMAkiudgWbX946jwmj5l1omZI6aI6TZn2ZUN/qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RbWTn8uDLhWZ3wR8CjLDbw8l54/rsXfq9bmxmiYRd2Ix6wKON8XFvc8ELxtzhkyTY
         4yNgIxNc2KikAH9IO5Y5dtBYdEgf32Jf1P85OxgXa4i6TP22eXEvjsY+1QgDzvOWeB
         /ahRphw5njZIRA6ghGbDO864TBDIQQgutdyw6an83eALSf3y1o8a/dumBlGobjUZz5
         XzgN7jp+Mtmy+2aU4hb3eqVbg+DdDPIVE0xx0UyivKxhPY7034/SztT+1ABJH8fX1z
         0mWlXe0uqyR6+p5dysE0HYOcgCusBVz0Twb2KiSUvJXdO2/xcCx1ZtifLpCsMNsuPE
         HT+we5v/MPD8Q==
Date:   Fri, 15 Oct 2021 22:10:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/10] x86/unwind: Compile kretprobe fixup code only if
 CONFIG_KRETPROBES=y
Message-Id: <20211015221014.5be86007034a5ed9356848b3@kernel.org>
In-Reply-To: <163430227030.459050.12754362425825951410.stgit@devnote2>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
        <163430227030.459050.12754362425825951410.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 21:51:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Compile kretprobe related stacktrace entry recovery code and
> unwind_state::kr_cur field only when CONFIG_KRETPROBES=y.

Oh, this is another new patch, and is a kind of cleanup.
No functionality change, but a bit reducing memory usage
when CONFIG_KRETPROBES=n.

Thank you,

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/include/asm/unwind.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
> index fca2e783e3ce..2a1f8734416d 100644
> --- a/arch/x86/include/asm/unwind.h
> +++ b/arch/x86/include/asm/unwind.h
> @@ -16,7 +16,9 @@ struct unwind_state {
>  	unsigned long stack_mask;
>  	struct task_struct *task;
>  	int graph_idx;
> +#ifdef CONFIG_KRETPROBES
>  	struct llist_node *kr_cur;
> +#endif
>  	bool error;
>  #if defined(CONFIG_UNWINDER_ORC)
>  	bool signal, full_regs;
> @@ -105,9 +107,13 @@ static inline
>  unsigned long unwind_recover_kretprobe(struct unwind_state *state,
>  				       unsigned long addr, unsigned long *addr_p)
>  {
> +#ifdef CONFIG_KRETPROBES
>  	return is_kretprobe_trampoline(addr) ?
>  		kretprobe_find_ret_addr(state->task, addr_p, &state->kr_cur) :
>  		addr;
> +#else
> +	return addr;
> +#endif
>  }
>  
>  /* Recover the return address modified by kretprobe and ftrace_graph. */
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
