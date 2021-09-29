Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE641C392
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245710AbhI2Lm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245647AbhI2Lm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632915677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmzmDk9yn4uyiLffmbomlcu4SQVXSZNR4VUc4kZeVC0=;
        b=e4juIcHLgOPxo/ZbfqZCgS0hcQqJfZaICMbQ7hXO5/tLyCZZ5IlmX109G6+OJVWhdNV48/
        b7fbErTd4oFlpNgOcpQB838v5ovla5mqZxSlLwjgtzcFQ1vcIONu1FZ5IKxcc4wa23o2Ct
        xaTs/r/ol6fFoI5C9X8eQTVqBB9gq48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-EudIvpAdMaaVbSzhU0xZOw-1; Wed, 29 Sep 2021 07:41:13 -0400
X-MC-Unique: EudIvpAdMaaVbSzhU0xZOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F8AE19200CB;
        Wed, 29 Sep 2021 11:41:12 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FC15E255;
        Wed, 29 Sep 2021 11:41:05 +0000 (UTC)
Date:   Wed, 29 Sep 2021 19:40:58 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/5] irqchip/GICv3: let gic_handle_irq() utilize
 irqentry on arm64
Message-ID: <YVRQyvUa+JCVxxr0@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-5-kernelfans@gmail.com>
 <20210928091053.GD1924@C02TD0UTHF1T.local>
 <YVPZEwfi8OFkzcd1@piliu.users.ipa.redhat.com>
 <87mtnvu9to.wl-maz@kernel.org>
 <YVQjX7GfuFKdW9hm@piliu.users.ipa.redhat.com>
 <20210929092358.GB33284@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929092358.GB33284@C02TD0UTHF1T.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:23:58AM +0100, Mark Rutland wrote:
> On Wed, Sep 29, 2021 at 04:27:11PM +0800, Pingfan Liu wrote:
> > On Wed, Sep 29, 2021 at 08:20:35AM +0100, Marc Zyngier wrote:
> > > On Wed, 29 Sep 2021 04:10:11 +0100,
> > > Pingfan Liu <piliu@redhat.com> wrote:
> > > > 
> > > > On Tue, Sep 28, 2021 at 10:10:53AM +0100, Mark Rutland wrote:
> > > > > On Fri, Sep 24, 2021 at 09:28:36PM +0800, Pingfan Liu wrote:
> > > > > > The call to rcu_irq_enter() originated from gic_handle_irq() is
> > > > > > redundant now, since arm64 has enter_from_kernel_mode() akin to
> > > > > > irqenter_entry(), which has already called rcu_irq_enter().
> > > > > 
> > > > > Here I think you're referring to the call in handle_domain_irq(), but
> > > > > that isn't clear from the commit message.
> > > > > 
> > > > Yes, and I will make it clear in V2.
> > > > 
> > > > > > Based on code analysis, the redundant can raise some mistake, e.g.
> > > > > > rcu_data->dynticks_nmi_nesting inc 2, which causes
> > > > > > rcu_is_cpu_rrupt_from_idle() unexpected.
> > > > > > 
> > > > > > So eliminate the call to irq_enter() in handle_domain_irq(). And
> > > > > > accordingly supplementing irq_enter_rcu().
> > > > > 
> > > > > We support many more irqchips on arm64, and GICv3 can be used on regular
> > > > > 32-bit arm, so this isn't right. Moving the irq_enter_rcu() call
> > > > > into the GICv3 driver specifically breaks other drivers on arm64 by
> > > > > removing the call, and breaks the GICv3 driver on arm by adding a
> > > > > duplicate call.
> > > > > 
> > > > Oops. I forgot to protect the code in GICv3 with CONFIG_HAVE_ARCH_IRQENTRY
> > > > 
> > > > > It looks like this should live in do_interrupt_handler() in
> > > > > arch/arm64/kernel/entry-common.c, e.g.
> > > > > 
> > > > > | static void do_interrupt_handler(struct pt_regs *regs,
> > > > > | 				 void (*handler)(struct pt_regs *)) 
> > > > > | {
> > > > > | 	irq_enter_rcu();
> > > > > | 	if (on_thread_stack())
> > > > > | 		call_on_irq_stack(regs, handler);
> > > > > | 	else
> > > > > | 		handler(regs);
> > > > > | 	irq_exit_rcu();
> > > > > | }
> > > > > 
> > > > > ... unless there's some problem with that?
> > > > > 
> > > > Yeah, do_interrupt_handler() is a more suitable place. But to resolve
> > > > the performance regression of rescheduling IPI [1], it is badly demanded to
> > > > distinguish irqnr before calling irq_enter_rcu() (please see 5/5 and [2]
> > > > for the context). So it is a compromise to host the code in GICv3.
> > > > 
> > > > Any good idea?
> > > 
> > > There is no way we are going to single out a particular interrupt
> > > controller. As for the "regression", we'll have to look at the numbers
> > > once we have fixed the whole infrastructure.
> > > 
> > But I just realize that at present, gic_handle_nmi() sits behind
> > gic_handle_irq().  So it will make an mistaken for accounting of normal
> > interrupt if calling irq_enter_rcu() in do_interrupt_handler().
> 
> We can restructure entry-common.c to avoid that if necessary.
> 
> TBH, the more I see problems in this area the more I want to rip out the
> pNMI bits...
> 
Could you give further comments and some guide to my reply to [1/5],
which can help to decide pNMI at this earlier stage? If things can go
that way, then everything can be fixed easier.

I think they abstract the ability of irqchip by exporting two
interfaces:
  void (*handle_arch_nmi)(struct pt_regs *regs);
  bool (*interrupt_is_nmi)(void);
And each irqchip can select whether to implement or not.

> > And going through drivers/irqchip/irq-chip-gic*, I think there are only
> > two files should be handled: irq-gic.c and irq-gic-v3.c.
> 
> That are irqchips other than GICv2 and GICv3 that are used as the root
> irqchip on arm64. For example, Raspberry Pi 3 uses
> drivers/irqchip/irq-bcm2836.c as its root irqchip.
> 

Thanks for the explanation. The situation is worse than I had thought. And
no way out in that direction.


Thanks,

	Pingfan

