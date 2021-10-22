Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBCD437A01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhJVPi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:38:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhJVPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:38:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42DB91FB;
        Fri, 22 Oct 2021 08:36:09 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8973F694;
        Fri, 22 Oct 2021 08:36:05 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:36:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 09/15] irq: arm: perform irqentry in entry code
Message-ID: <20211022153602.GE86184@C02TD0UTHF1T.local>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-10-mark.rutland@arm.com>
 <0efc4465-12b5-a568-0228-c744ec0509a3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efc4465-12b5-a568-0228-c744ec0509a3@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 04:18:18PM +0100, Vladimir Murzin wrote:
> Hi Mark,
> 
> On 10/21/21 7:02 PM, Mark Rutland wrote:
> > +/*
> > + * TODO: restructure the ARMv7M entry logic so that this entry logic can live
> > + * in arch code.
> > + */
> > +asmlinkage void __exception_irq_entry
> > +static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> 
> I'm seeing build time failure...
> 
> drivers/irqchip/irq-nvic.c:50:8: error: two or more data types in declaration specifiers
>  static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>         ^~~~
> drivers/irqchip/irq-nvic.c:50:13: warning: 'nvic_handle_irq' defined but not used [-Wunused-function]
>  static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> 
> I've fixed that locally and planing to give it a go...

Ah, whoops. I've removed the extraneous `static void` from
nvic_handle_irq() and build tested that as part of stm32_defconfig.

The updated version is in my irq/handle-domain-irq branch at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

Thanks,
Mark.
