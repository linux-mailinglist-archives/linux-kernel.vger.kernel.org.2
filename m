Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F014443D5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhJ0Va4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhJ0Vaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:30:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD8C0431B7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:22:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3102536pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Xc/Ast+KV0V+8bSAPuAHdixgIXnPuRbN0YHRGdpcxXo=;
        b=f5hvHSRetT45O3UxIL1kMb2dMj9wGCIFtKwmoP0RZpjxQHK4++R5e1HzGlhXAFJrKg
         w/91j323bKPK4M2C33YVXi5g1H8lqU9JE0fVjg1sRRzNJ626EJbgUwq2yf0aODJiBENU
         3vsKCaoEbHxPYPrlH3sPqECE6CMapfED39lwC8WA36zIj/peheyUUv6xvqrXUF9vN1q1
         UzpmZgwX+ZLc+jNuQDUJ43Y8KshGsngIlLOLpR/4dKW8Wu83M2jBEsdtkFLU+DqBkKp5
         P1hW2Yo23r3yatT/a3fCBiJCQX8KJfqY05HcKadmpOkcuVphpwXih4PEYuhjVKT/xJep
         FfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Xc/Ast+KV0V+8bSAPuAHdixgIXnPuRbN0YHRGdpcxXo=;
        b=uLDNs3yomUShuQ37w3ZM/2Qq10ESpE9x96dM3NfqPAnhkGmQvUbML0/6F87SR3aKDD
         Z2E9EmHY+RqMfsN0rJytZI1Mwq6DKXtIsiyTsDpRfUH4o9/jjHzZs5zLxgal8THWVpQY
         CBwBA6ODKCSvjxL+MCH/NFVjxZd/ydciGWDWeMPOHglHA8M/6RADVsCLzE6GP4rWMi3L
         qY/60KDE6Ccrek6PFJT/9wxiM+FIsKTja+NJD1rUbkTeqo0hwiOCEB3NqgNYmn5+E1Kq
         Ez9sNHUdYUArzyMIWud4Zs3aUmdhsFqcClnWfqwG4UFrOxnOla2Y0jM7RZNVMzMgJfAi
         44YA==
X-Gm-Message-State: AOAM5301CAZURpM0169UUeOJL3KqhHLn3hWmSMpnZAY8+4hjTwSNs1DA
        TgwiKGGy0QmBCoOzL64AAfvdAl3NubGrcunv
X-Google-Smtp-Source: ABdhPJxU7ztJ7EYetBA4CpM7AQeHzHBfd6L84gm3zgJk/LxLo27YprSadcc+JwCmAojqGzj1ssbmyQ==
X-Received: by 2002:a17:90a:1d0b:: with SMTP id c11mr128695pjd.207.1635369745925;
        Wed, 27 Oct 2021 14:22:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:d96b:421d:2a73:9190])
        by smtp.gmail.com with ESMTPSA id p13sm671181pgr.27.2021.10.27.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:22:25 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:22:25 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 14:22:10 PDT (-0700)
Subject:     Re: [PATCH 13/15] irq: riscv: perform irqentry in entry code
In-Reply-To: <20211021180236.37428-14-mark.rutland@arm.com>
CC:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, Marc Zyngier <maz@kernel.org>,
        nickhu@andestech.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mark.rutland@arm.com
Message-ID: <mhng-8062da5e-6052-4722-ba26-c0a407747ca6@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 11:02:34 PDT (-0700), mark.rutland@arm.com wrote:
> In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/riscv
> perform all the irqentry accounting in its entry code. As arch/riscv
> uses GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to
> do so.
>
> Since generic_handle_arch_irq() handles the irq entry and setting the
> irq regs, and happens before the irqchip code calls handle_IPI(), we can
> remove the redundant irq entry and irq regs manipulation from
> handle_IPI().
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/riscv/Kconfig        | 1 -
>  arch/riscv/kernel/entry.S | 3 +--
>  arch/riscv/kernel/smp.c   | 9 +--------
>  3 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 740653063a56..301a54233c7e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -63,7 +63,6 @@ config RISCV
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>  	select HANDLE_DOMAIN_IRQ
> -	select HANDLE_DOMAIN_IRQ_IRQENTRY
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 98f502654edd..64236f7efde5 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -130,8 +130,7 @@ skip_context_tracking:
>
>  	/* Handle interrupts */
>  	move a0, sp /* pt_regs */
> -	la a1, handle_arch_irq
> -	REG_L a1, (a1)
> +	la a1, generic_handle_arch_irq
>  	jr a1
>  1:
>  	/*
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 921d9d7df400..2f6da845c9ae 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -140,12 +140,9 @@ void arch_irq_work_raise(void)
>
>  void handle_IPI(struct pt_regs *regs)
>  {
> -	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
>  	unsigned long *stats = ipi_data[smp_processor_id()].stats;
>
> -	irq_enter();
> -
>  	riscv_clear_ipi();
>
>  	while (true) {
> @@ -156,7 +153,7 @@ void handle_IPI(struct pt_regs *regs)
>
>  		ops = xchg(pending_ipis, 0);
>  		if (ops == 0)
> -			goto done;
> +			return;
>
>  		if (ops & (1 << IPI_RESCHEDULE)) {
>  			stats[IPI_RESCHEDULE]++;
> @@ -189,10 +186,6 @@ void handle_IPI(struct pt_regs *regs)
>  		/* Order data access and bit testing. */
>  		mb();
>  	}
> -
> -done:
> -	irq_exit();
> -	set_irq_regs(old_regs);
>  }
>
>  static const char * const ipi_names[] = {

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming you want to keep these togther.
