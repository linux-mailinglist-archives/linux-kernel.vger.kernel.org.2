Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9907439E10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhJYSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhJYSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:03:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE4E361002;
        Mon, 25 Oct 2021 18:00:43 +0000 (UTC)
Date:   Mon, 25 Oct 2021 19:00:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 10/15] irq: arm64: perform irqentry in entry code
Message-ID: <YXbwyKeAOfIayN1A@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-11-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-11-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:31PM +0100, Mark Rutland wrote:
> In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/arm64
> perform all the irqentry accounting in its entry code.
> 
> As arch/arm64 already performs portions of the irqentry logic in
> enter_from_kernel_mode() and exit_to_kernel_mode(), including
> rcu_irq_{enter,exit}(), the only additional calls that need to be made
> are to irq_{enter,exit}_rcu(). Removing the calls to
> rcu_irq_{enter,exit}() from handle_domain_irq() ensures that we inform
> RCU once per IRQ entry and will correctly identify quiescent periods.
> 
> Since we should not call irq_{enter,exit}_rcu() when entering a
> pseudo-NMI, el1_interrupt() is reworked to have separate __el1_irq() and
> __el1_pnmi() paths for regular IRQ and psuedo-NMI entry, with
> irq_{enter,exit}_irq() only called for the former.
> 
> In preparation for removing HANDLE_DOMAIN_IRQ, the irq regs are managed
> in do_interrupt_handler() for both regular IRQ and pseudo-NMI. This is
> currently redundant, but not harmful.
> 
> For clarity the preemption logic is moved into __el1_irq(). We should
> never preempt within a pseudo-NMI, and arm64_enter_nmi() already
> enforces this by incrementing the preempt_count, but it's clearer if we
> never invoke the preemption logic when entering a pseudo-NMI.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
