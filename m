Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B641BD27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbhI2DRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhI2DRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632885325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYUwZTajBKG73N6boXA2eLFqYW6+o4P9ejOOh0bWbFg=;
        b=ET73G2qCnst0nmmX3AH9O7U/jWwbZuxNKq1vh9seY1o4vJMAkghZQEcuiLNRNTHVx4Y5iG
        TlxvqhmT+IuE/XZtst2vdNq5CsvOkEYjEH7x+ZGIJVrFI4Ty/mtYVv7CX9xEvt+ksquoMt
        ArH/ruR5Diz7CcLK70/B2eIKg3Q8nB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-4BAQyUcGPhy24kJMwOxdew-1; Tue, 28 Sep 2021 23:15:22 -0400
X-MC-Unique: 4BAQyUcGPhy24kJMwOxdew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EEBE1084687;
        Wed, 29 Sep 2021 03:15:20 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45EE060583;
        Wed, 29 Sep 2021 03:15:13 +0000 (UTC)
Date:   Wed, 29 Sep 2021 11:15:09 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/5] kernel/irq: make irq_{enter,exit}() in
 handle_domain_irq() arch optional
Message-ID: <YVPaPf/rREkvZkok@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-4-kernelfans@gmail.com>
 <20210928085500.GC1924@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928085500.GC1924@C02TD0UTHF1T.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:55:00AM +0100, Mark Rutland wrote:
> On Fri, Sep 24, 2021 at 09:28:35PM +0800, Pingfan Liu wrote:
> > handle_domain_irq() contains two major parts:
> >   -1. irq_enter()/irq_exit(), which serves as hooks for rcu and trace etc.
> >   -2. irq mapping and dispatching
> > 
> > After the introduction of irqentry_enter()/irqentry_exit() and arch
> > specific counterpart (e.g. arm64), roughly speaking, rcu_irq_enter() has
> > already been called.  Hence here comes requirement to move
> > irq_enter/irq_exit out of handle_domain_irq(). And arches should handle
> > about irq_enter_rcu()/irq_exit_rcu() by themself.
> > 
> > Since there is still arches, which does not adopt irqentry_enter(), let
> > irq_enter()/irq_exit() arch optional in handle_domain_irq().
> 
> The patch below looks good to me, but the commit message is a little
> hard to follow. How about:
> 
>   When an IRQ is taken, some accounting needs to be performed to enter
>   and exit IRQ context around the IRQ handler. Historically arch code
>   would leave this to the irqchip or core IRQ code, but these days we
>   want this to happen in exception entry code, and architectures such as
>   arm64 do this.
> 
>   Currently handle_domain_irq() performs this entry/exit accounting, and
>   if used on an architecture where the entry code also does this, the
>   entry/exit accounting will be performed twice per IRQ. This is
>   problematic as core RCU code such as rcu_is_cpu_rrupt_from_idle()
>   depends on this happening once per IRQ, and will not detect quescent
>   periods correctly, leading to stall warnings.
> 
>   As irqchip drivers which use handle_domain_irq() need to work on
>   architectures with or without their own entry/exit accounting, this
>   patch makes handle_domain_irq() conditionally perform the entry
>   accounting depending on a new HAVE_ARCH_IRQENTRY Kconfig symbol that
>   architectures can select if they perform this entry accounting
>   themselves.
> 
>   For architectures which do not select the symbol. there should be no
>   functional change as a result of this patch.
> 
Thanks for your precious time to improve the log. It looks great, and I
will use it in V2. I will keep learning to improve my level of log.

> With that commit message:
> 
>   Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
Thanks,

	Pingfan

