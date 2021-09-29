Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08E41BD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhI2DMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhI2DMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632885025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXdkycR73/zNfkluTLeMsLWh81UPqs6kxv2+DoxeOwQ=;
        b=Ra8F7Zcqpni7COrDfAAdB68lQY7JBrknQ95cfxR5Pmct5p2aB91VyHIae4n/l1GPQUypvh
        ZqPMl2HERFjMRAswoHoXGlegfGRUX3tDf8VOqz31wGCNyuYJqPcowBaQD5Quh8KEzMyJbq
        AX7s0cnfafC+QYNYL9OfXBHmNNqAKoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-LSPGNI3YNwuJdkZ2_Hnndg-1; Tue, 28 Sep 2021 23:10:23 -0400
X-MC-Unique: LSPGNI3YNwuJdkZ2_Hnndg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B8D6824FA9;
        Wed, 29 Sep 2021 03:10:21 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A0AF19C79;
        Wed, 29 Sep 2021 03:10:16 +0000 (UTC)
Date:   Wed, 29 Sep 2021 11:10:11 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/5] irqchip/GICv3: let gic_handle_irq() utilize
 irqentry on arm64
Message-ID: <YVPZEwfi8OFkzcd1@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-5-kernelfans@gmail.com>
 <20210928091053.GD1924@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928091053.GD1924@C02TD0UTHF1T.local>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:10:53AM +0100, Mark Rutland wrote:
> On Fri, Sep 24, 2021 at 09:28:36PM +0800, Pingfan Liu wrote:
> > The call to rcu_irq_enter() originated from gic_handle_irq() is
> > redundant now, since arm64 has enter_from_kernel_mode() akin to
> > irqenter_entry(), which has already called rcu_irq_enter().
> 
> Here I think you're referring to the call in handle_domain_irq(), but
> that isn't clear from the commit message.
> 
Yes, and I will make it clear in V2.

> > Based on code analysis, the redundant can raise some mistake, e.g.
> > rcu_data->dynticks_nmi_nesting inc 2, which causes
> > rcu_is_cpu_rrupt_from_idle() unexpected.
> > 
> > So eliminate the call to irq_enter() in handle_domain_irq(). And
> > accordingly supplementing irq_enter_rcu().
> 
> We support many more irqchips on arm64, and GICv3 can be used on regular
> 32-bit arm, so this isn't right. Moving the irq_enter_rcu() call
> into the GICv3 driver specifically breaks other drivers on arm64 by
> removing the call, and breaks the GICv3 driver on arm by adding a
> duplicate call.
> 
Oops. I forgot to protect the code in GICv3 with CONFIG_HAVE_ARCH_IRQENTRY

> It looks like this should live in do_interrupt_handler() in
> arch/arm64/kernel/entry-common.c, e.g.
> 
> | static void do_interrupt_handler(struct pt_regs *regs,
> | 				 void (*handler)(struct pt_regs *)) 
> | {
> | 	irq_enter_rcu();
> | 	if (on_thread_stack())
> | 		call_on_irq_stack(regs, handler);
> | 	else
> | 		handler(regs);
> | 	irq_exit_rcu();
> | }
> 
> ... unless there's some problem with that?
> 
Yeah, do_interrupt_handler() is a more suitable place. But to resolve
the performance regression of rescheduling IPI [1], it is badly demanded to
distinguish irqnr before calling irq_enter_rcu() (please see 5/5 and [2]
for the context). So it is a compromise to host the code in GICv3.

Any good idea?


[1]: https://lore.kernel.org/linux-arm-kernel/20201101131430.257038-1-maz@kernel.org/
[2]: https://lore.kernel.org/linux-arm-kernel/87lfewnmdz.fsf@nanos.tec.linutronix.de/



Thanks,

	Pingfan

