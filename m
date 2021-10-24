Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530554389EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhJXPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:40:08 -0400
Received: from elvis.franken.de ([193.175.24.41]:37658 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhJXPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:39:52 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mefYp-0006bc-05; Sun, 24 Oct 2021 17:37:23 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3BCA5C265F; Sun, 24 Oct 2021 17:30:41 +0200 (CEST)
Date:   Sun, 24 Oct 2021 17:30:41 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 02/15] irq: mips: stop (ab)using handle_domain_irq()
Message-ID: <20211024153041.GF4721@alpha.franken.de>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-3-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:23PM +0100, Mark Rutland wrote:
> On MIPS, the only user of handle_domain_irq() is octeon_irq_ciu3_ip2(),
> which is called from the platform-specific plat_irq_dispatch() function
> invoked from the early assembly code.
> 
> No other irqchip relevant to arch/mips uses handle_domain_irq():
> 
> * No other plat_irq_dispatch() function transitively calls
>   handle_domain_irq().
> 
> * No other vectored IRQ dispatch function registered with
>   set_vi_handler() calls handle_domain_irq().
> 
> * No chained irqchip handlers call handle_domain_irq(), which makes
>   sense as this is meant to only be used by root irqchip handlers.
> 
> Currently octeon_irq_ciu3_ip2() passes NULL as the `regs` argument to
> handle_domain_irq(), and as handle_domain_irq() will pass this to
> set_irq_regs(), any invoked IRQ handlers will erroneously see a NULL
> pt_regs if they call get_pt_regs().
> 
> Fix this by calling generic_handle_domain_irq() directly, and performing
> the necessary irq_{enter,exit}() logic directly in
> octeon_irq_ciu3_ip2(). At the same time, deselect HANDLE_DOMAIN_IRQ,
> which subsequent patches will remove.
> 
> Other than the corrected behaviour of get_pt_regs(), there should be no
> functional change as a result of this patch.
> 
> Fixes: ce210d35bb93c2c5 ("MIPS: OCTEON: Add support for OCTEON III interrupt controller.")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/Kconfig                    | 1 -
>  arch/mips/cavium-octeon/octeon-irq.c | 5 ++++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
