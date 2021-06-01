Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379A43978AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhFARHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhFARHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:07:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0712E60FF1;
        Tue,  1 Jun 2021 17:05:38 +0000 (UTC)
Date:   Tue, 1 Jun 2021 13:05:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before
 switching to the thread stack
Message-ID: <20210601130537.7b389804@oasis.local.home>
In-Reply-To: <20210601065217.23540-2-jiangshanlai@gmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
        <20210601065217.23540-2-jiangshanlai@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Jun 2021 14:52:14 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Current kernel has no code to enforce data breakpoint not on the thread
> stack.  If there is any data breakpoint on the top area of the thread
> stack, there might be problem.
> 
> For example, when NMI hits on userspace in this setting, the code copies
> the exception frame from the NMI stack to the thread stack and it will
> cause #DB and after #DB is handled, the not yet copied portion on the
> NMI stack is in danger of corruption because the NMI is unmasked.
> 
> Stashing the exception frame on the entry stack before touching the
> entry stack can fix the problem.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S     | 22 ++++++++++++++++++++++
>  arch/x86/kernel/asm-offsets.c |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index a5f02d03c585..4190e668f346 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1121,8 +1121,30 @@ SYM_CODE_START(asm_exc_nmi)
>  	 *
>  	 * We also must not push anything to the stack before switching
>  	 * stacks lest we corrupt the "NMI executing" variable.
> +	 *
> +	 * Before switching to the thread stack, it switches to the entry
> +	 * stack first lest there is any data breakpoint in the thread
> +	 * stack and the iret of #DB will cause NMI unmasked before
> +	 * finishing switching.
>  	 */
>  
> +	/* Switch stack to entry stack */
> +	movq	%rsp, %rdx
> +	addq	$(+6*8			/* to NMI stack top */		\
> +		  -EXCEPTION_STKSZ	/* to NMI stack bottom */	\
> +		  -CPU_ENTRY_AREA_nmi_stack /* to entry area */		\

Just so that I understand this correctly. This "entry area" is not part
of the NMI stack, but just at the bottom of it? That is, this part of
the stack will never be touched by an NMI coming in from kernel space,
correct?

-- Steve


> +		  +CPU_ENTRY_AREA_entry_stack /* to entry stack bottom */\
> +		  +SIZEOF_entry_stack	/* to entry stack top */	\
> +		), %rsp
> +
> +	/* Stash exception frame and %rdx to entry stack */
> +	pushq	5*8(%rdx)	/* pt_regs->ss */
> +	pushq	4*8(%rdx)	/* pt_regs->rsp */
> +	pushq	3*8(%rdx)	/* pt_regs->flags */
> +	pushq	2*8(%rdx)	/* pt_regs->cs */
> +	pushq	1*8(%rdx)	/* pt_regs->rip */
> +	pushq	0*8(%rdx)	/* %rdx */
> +
>  	swapgs
>  	cld
>  	FENCE_SWAPGS_USER_ENTRY
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index ecd3fd6993d1..dfafa0c7e887 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -88,6 +88,7 @@ static void __used common(void)
>  	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
>  	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
>  	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
> +	OFFSET(CPU_ENTRY_AREA_nmi_stack, cpu_entry_area, estacks.NMI_stack);
>  
>  	/* Offset for fields in tss_struct */
>  	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);

