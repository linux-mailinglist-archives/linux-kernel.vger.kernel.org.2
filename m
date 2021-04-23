Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31636929C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbhDWNCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:02:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45986 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhDWNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:02:01 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619182884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSY2/gYOdotd/jaEwm21lbEsmSCocKn3J8Yq4V9NaR4=;
        b=TDVd56DKo9LkEK17x2DJXIHlkpMrWAMJPeYQg6m+A1veFo1eumh2r65IGTY9eWhrZzQrsN
        KmoR/NxwOHnbX5axhXJz3gMuEBKB5JW/GQiCKmWvkaDb5IkZp96XMPqGuDhz7LTl1E2o41
        b1vyNvc4E6gbXuWFWkE6au45otcybFrBF1Xs/LvxLYkSBcCSx8qh2os6atRRlITyROfEJa
        caKsDcs60iUaZtjYhOuMF8u8V6qKpoqBCu6UQuuG4NeuEA1sYM+KlCdQpOWYbI8S9BONZ+
        b8qdruQJDqY4Udq2DNniy524m/baN/6uEAqskO1FGtqZ7F69oVxANcDdPFwTkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619182884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSY2/gYOdotd/jaEwm21lbEsmSCocKn3J8Yq4V9NaR4=;
        b=6iBeaJFCuzUCoILDwx2L15VO7BjqHB0IETk+h7mD6jbwXElOzojGzl2w39FrG/thQawR1K
        22KAgtTx4IHOqtCw==
To:     John Garry <john.garry@huawei.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: Question on threaded handlers for managed interrupts
In-Reply-To: <874kfxw9zv.ffs@nanos.tec.linutronix.de>
References: <b8c4be8c-1d67-c16c-570e-d3c883c77ea2@huawei.com> <874kfxw9zv.ffs@nanos.tec.linutronix.de>
Date:   Fri, 23 Apr 2021 15:01:23 +0200
Message-ID: <871rb1w3x8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On Fri, Apr 23 2021 at 12:50, Thomas Gleixner wrote:
> On Thu, Apr 22 2021 at 17:10, John Garry wrote:
> OTOH, the way how you splitted the handling into hard/thread context
> provides already the base for this.
>
> The missing piece is infrastructure at the irq/scheduler core level to
> handle this transparently.
>
> I have some horrible ideas how to solve that, but I'm sure the scheduler
> wizards can come up with a reasonable and generic solution.

So one thing I forgot to ask is:

Is the thread simply stuck in the while() loop forever or is
this just an endless hardirq/thread/hardirq/thread stream?

Thanks,

        tglx
