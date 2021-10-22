Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D973437999
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhJVPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:08:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhJVPIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:08:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4CAA1FB;
        Fri, 22 Oct 2021 08:06:03 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C49FE3F694;
        Fri, 22 Oct 2021 08:05:58 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:05:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 04/15] irq: simplify handle_domain_{irq,nmi}()
Message-ID: <20211022150555.GB86184@C02TD0UTHF1T.local>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-5-mark.rutland@arm.com>
 <87lf2lbac3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf2lbac3.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:52:28AM +0100, Marc Zyngier wrote:
> On Thu, 21 Oct 2021 19:02:25 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > There's no need for handle_domain_{irq,nmi}() to open-code the NULL
> > check performed by handle_irq_desc(), nor the resolution of the desc
> > performed by generic_handle_domain_irq().
> > 
> > Use generic_handle_domain_irq() directly, as this is functioanlly
> > equivalent and clearer. At the same time, delete the stale comments,
> > which are no longer helpful.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/irq/irqdesc.c | 24 ++++--------------------
> >  1 file changed, 4 insertions(+), 20 deletions(-)

> Yup, that's really neat. I somehow missed that when I moved some of
> the legacy stuff to be ARM specific.
> 
> On a vaguely related note, I think you can drop the EXPORT_SYMBOL_GPL
> on handle_irq_desc() now.

Seems so:

[mark@lakrids:~/src/linux]% git grep -w handle_irq_desc   
arch/arm/kernel/irq.c:          handle_irq_desc(desc);
include/linux/irqdesc.h:int handle_irq_desc(struct irq_desc *desc);
kernel/irq/irqdesc.c:int handle_irq_desc(struct irq_desc *desc)
kernel/irq/irqdesc.c:   return handle_irq_desc(irq_to_desc(irq));
kernel/irq/irqdesc.c:   return handle_irq_desc(irq_resolve_mapping(domain, hwirq));

I'll add a patch to clean that up.

Thanks,
Mark
