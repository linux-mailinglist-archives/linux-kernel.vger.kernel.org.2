Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4B36CC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhD0UAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:00:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0UA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:00:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619553583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWb+u5lHbSE2K4wZrJfb4KDMLjOmVqGo2GjajvJMOFI=;
        b=vlxMA+PWBbA1ChYXEUqvHEsTzGqVNdA9qLzzXZ71HumV2VTWmn5kSlPbyffgTwXYhbQYBr
        juY2JCOZoCWI1UCpIYR4ktd52zlUW186FaoXvZqbYXrEZfiKSL+8pNB7rIETNCQNf1yxNK
        AX7wk+jnLZX0nO1qOWsa5vP5ZYTX52AFlaPdPBjQndT3RXtxyUkSzMgmBWOIzAwOG/UnDR
        3Wimxrj9LrigQ8DdutnRUqGSfAo8386igvT7K8VXODQ9wDWiKKwtPP5yteRx4MIp/wWNT3
        l5v1YyypoZG9ER/v9vQ2IMC7h8WHDDrzv1cHyBy2tAuvfZNIuJ4aI2NFSC81fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619553583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWb+u5lHbSE2K4wZrJfb4KDMLjOmVqGo2GjajvJMOFI=;
        b=TEHEYt+XG/QKqlwfJOzEnMg+4+iyczXBlI2bspQMRi5u2LzBGFxZ+zb+Pv8auts+Mn7Sf9
        MvLK0AyQ8v2y58BA==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 8/8] hrtimer: Avoid more SMP function calls in clock_was_set()
In-Reply-To: <20210427151125.GA171315@fuller.cnet>
References: <20210427082537.611978720@linutronix.de> <20210427083724.840364566@linutronix.de> <20210427151125.GA171315@fuller.cnet>
Date:   Tue, 27 Apr 2021 21:59:43 +0200
Message-ID: <877dkno5w0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27 2021 at 12:11, Marcelo Tosatti wrote:
> On Tue, Apr 27, 2021 at 10:25:45AM +0200, Thomas Gleixner wrote:
> Consider
>
>
> hrtimer_interrupt
> in_hrtirq = 1
> __run_hrtimer
> raw_spin_unlock_irqrestore(&cpu_base->lock, flags)
> 								settimeofday
> 								clock_was_set
> 								lock cpu_base->lock
> 								update_needs_ipi returns false
> continue to process hrtimers with stale base->offset

Bah. I somehow convinced myself that hrtimer_interrupt() rechecks the
offset before clearing in_hrtirq, but that's not true. It does so when
reprogramming fails, but not for the regular case.

Lemme stare at it some more.

Thanks,

        tglx
