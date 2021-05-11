Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3963E37A907
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhEKOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:23:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhEKOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:23:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620742945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TcexFrF5RvItiV32i5dbLwb8XIl5kKRJt7Imzjq/iA4=;
        b=Mv0fcxOMmkqOLc+JSkChRmhPdCxbpBcP6SrNZ+qdkJrB4gGt293J3cLJukPYe/QfI88t1k
        BKWTqSeLbAJJUQyUon7qay4JA/Rr4vg9MgVrTJJZPueO0efw8jKG2kj6YIG44By7b2zlcA
        53FSAkIOJst/bf2v/+q1X7SXmVh7J0vBKPvP+2DuRG+HvuaxgaUeTcMS6VPh9ykHOpQpcE
        tEZ8v4mF9uVDvns8qfFoyP09lL1Xv2vUSNvBxmlrkaRIo8WsnA5Z0WRLYgVV6pbhCmysvr
        +ZQmA05ngToMkIhRmXjRHEYAURHIfVagu3YxEVn4yg2N0//85xvlrtrA/F0CHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620742945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TcexFrF5RvItiV32i5dbLwb8XIl5kKRJt7Imzjq/iA4=;
        b=WrkAMqEdRyP3brMubbgslHGCO+wGguG3P6QEz8cGWutI49JWDKNwZ5wNvzcul3dcq6o7kH
        uiH/2AX6KBAOqICQ==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin \(Intel\)" <hpa@zytor.com>
Subject: Re: [PATCH 4/6] x86/irq: merge common code in DEFINE_IDTENTRY_SYSVEC[_SIMPLE]
In-Reply-To: <20210511005531.1065536-5-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com> <20210511005531.1065536-5-hpa@zytor.com>
Date:   Tue, 11 May 2021 16:22:24 +0200
Message-ID: <87lf8lfizj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 17:55, H. Peter Anvin wrote:
> +/**
> + * IDTENTRY_INVOKE_SYSVEC - Common code for system vector IDT entry points
> + * @what:	What should be called
> + *
> + * Common code for DEFINE_IDTENTRY_SYSVEC and _SYSVEC_SIMPLE
> + */
> +#define IDTENTRY_INVOKE_SYSVEC(what)					\
> +do {									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	what;								\
> +	instrumentation_end();						\
> +	irqentry_exit(regs, state);					\
> +} while (0)								\
> +
>  /**
>   * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>   * @func:	Function name of the entry point
> @@ -233,13 +250,7 @@ static void __##func(struct pt_regs *regs);				\
>  									\
>  __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> -									\
> -	instrumentation_begin();					\
> -	kvm_set_cpu_l1tf_flush_l1d();					\
> -	run_sysvec_on_irqstack_cond(__##func, regs);			\
> -	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	IDTENTRY_INVOKE_SYSVEC(run_sysvec_on_irqstack_cond(__##func, regs)); \
>  }									\
>  									\
>  static noinline void __##func(struct pt_regs *regs)
> @@ -260,15 +271,7 @@ static __always_inline void __##func(struct pt_regs *regs);		\
>  									\
>  __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> -									\
> -	instrumentation_begin();					\
> -	__irq_enter_raw();						\
> -	kvm_set_cpu_l1tf_flush_l1d();					\
> -	__##func (regs);						\
> -	__irq_exit_raw();						\
> -	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	IDTENTRY_INVOKE_SYSVEC(__irq_enter_raw(); __##func(regs); __irq_exit_raw()); \

That's not really making the code more readable. Something like the
below perhaps?

#define IDTENTRY_INVOKE_SYSVEC(func, regs, raw)				\
do {									\
	irqentry_state_t state = irqentry_enter(regs);			\
									\
	instrumentation_begin();					\
	kvm_set_cpu_l1tf_flush_l1d();					\
        if (raw) {							\
		__irq_enter_raw();					\
		func(regs);						\
		__irq_exit_raw();			                \
	} else {	                                                \
		run_sysvec_on_irqstack_cond(func, regs);	        \
        }                                                               \
	instrumentation_end();						\
        irqentry_exit(regs, state);					\
} while (0)								\

Thanks,

        tglx
