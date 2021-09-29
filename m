Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54341C0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbhI2Iek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244477AbhI2Iei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632904377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDg1MCFrit04NIscojLSyjzMh0R5/sGnkUnIDhDMvVg=;
        b=Ft1dEIC2THE9Q2NziCEHrQkl0rOI9REz/k4CfV04vF2hm9pFXrSBYN3lIWDR2Y20mU7Fri
        1BNw2wHrd6CYcpxeGbcPAh209VOjihsVMZjNnI0poIr8N4pd+hhSxPRPeA2xqGNlMvO43o
        4WcQLhUOFY2J/O4BKydT57LZ5VrdRFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-8LaGz_2oP8ivkwVAFkzcow-1; Wed, 29 Sep 2021 04:32:53 -0400
X-MC-Unique: 8LaGz_2oP8ivkwVAFkzcow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 114B1108468B;
        Wed, 29 Sep 2021 08:32:52 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB42660854;
        Wed, 29 Sep 2021 08:32:46 +0000 (UTC)
Date:   Wed, 29 Sep 2021 16:32:42 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 5/5] irqchip/GICv3: make reschedule-ipi light weight
Message-ID: <YVQkqnlOdZJ7QhJv@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-6-kernelfans@gmail.com>
 <87lf3fu9n1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf3fu9n1.wl-maz@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 08:24:34AM +0100, Marc Zyngier wrote:
> On Fri, 24 Sep 2021 14:28:37 +0100,
> Pingfan Liu <kernelfans@gmail.com> wrote:
> > 
> > To achieve the light weight as
> > DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi) on x86, it had
> > better treat irqnr differently at the frontend. And let IPI_RESCHEDULE
> > call __irq_enter_raw() instead of irq_enter_rcu().
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 906538fa8771..593d4539a209 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -709,6 +709,9 @@ static void gic_handle_nmi(struct pt_regs *regs)
> >  		gic_deactivate_unhandled(irqnr);
> >  }
> >  
> > +/* RESCHEDULE IPI hwirq nr is 0, and the only raw one */
> > +static unsigned long raw_interrupt_mask = 1;
> 
> I'm afraid you have the wrong end of the stick. This isn't a GIC
> property. This is an architecture decision, and only the architecture
> can expose what they want.
> 
Could it done be export an interface int (*get_irq_nr)(pte_regs) to
do_interrupt_handler()? So it can be seen as an architecture
decision.


Thanks,

	Pingfan
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

