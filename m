Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D741D6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349621AbhI3Jze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:55:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbhI3Jzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:55:32 -0400
Date:   Thu, 30 Sep 2021 11:53:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632995629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsd2FzfAAtlltoh1UbK5BBWkvOz3euK0mJwimuouqZY=;
        b=dLSlSP1cvDuJdOYHcKvS0nLmo/43U/XD088sDRcOysXk8eElIwzDKfqo9AIrjrEDnSKTb8
        jpwTIYmqA04S5LQQuXLQq+rVj30WuU/x6cCd9BJfd4D8jaa7rlKjm0v1sPKYvU57lYA6dL
        RZtj85Roe9waQg5vmCb9WlcXLEDFFyJr+Mt+a/rY+j/rTr8zwbsXc1FWpB0MCK5sK+Jtvd
        i701v+yCiJ7rOeeoutk6NVJKi6lsQsQHoKwHcPPcfcOTNL3scpUnn10o7fVu5ouKf1G/Jj
        RRNbi/Wo9VI/MxPgp7Xbis8dNE06qgBPF9bGrGDOQ/ZWBBUqivEB2OWiMESeLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632995629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsd2FzfAAtlltoh1UbK5BBWkvOz3euK0mJwimuouqZY=;
        b=aFkhY1d/UceLRlqgGkXkPs/MNXH4z0KDYEdF+MUqrHDD+fXN89UsuK43dWQGUFxGWo2CsA
        rAjll964+8YyZTBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <20210930095348.tud6jdcenfkfzugz@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
 <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-30 11:07:18 [+0200], Peter Zijlstra wrote:
> 
> IIRC we have existing problems in -RT due to this irq_work softirq muck.

We have existing problems in -RT due irq_work being used without knowing
the consequences.

> I think the problem was something Jolsa found a while ago, where perf
> defers to an irq_work (from NMI context) and that irq_work wants to
> deliver signals, which it can't on -RT, so the whole thing gets punted
> to softirq. With the end-result that if you self-profile RT tasks,
> things come apart or something.

For signals (at least on x86) we this ARCH_RT_DELAYS_SIGNAL_SEND thingy
where the signal is delayed until exit_to_user_mode_loop().

perf_pending_event() is the only non-HARD on RT (on the perf side). I
think that is due to perf_event_wakeup() where we have wake_up_all() and
read_lock_irqsave().

> There might have been others as well, I don't know. But generally I
> think we want *less* softirq, not more.

I agree. The anonymous softirqs concept brings problems of its own.
But what should I do with things like that:
- kernel/trace/ring_buffer.c rb_wake_up_waiters()
  kernel/bpf/ringbuf.c bpf_ringbuf_notify()
   wake_up_all()

- drivers/acpi/apei/ghes.c ghes_proc_in_irq()
  spinlock_t
 
- drivers/dma-buf/dma-fence-array.c irq_dma_fence_array_work()
  spinlock_t, callbacks, potential kfree().

- drivers/gpu/drm/i915/gt/intel_breadcrumbs.c signal_irq_work()
  spinlock_t, rpm_put() -> wake_up_var(), callbacks, kref_put() like
  constructs which may free memory.

I didn't look at _all_ of them but just a few. And the only one I looked
at and didn't add to the list was
    drivers/edac/igen6_edac.c ecclog_irq_work_cb()

which simply reads PCI registers (which acquires raw_spinlock_t only
(however only on x86 are those raw_spinlock_t now that looked around))
and does schedule_work(). All harmless.

I *think* the irq_work in printk is going to leave once John is done
with it. But there are way more of these things in the kernel now
compared to when I first pushed them into softirq because they were
causing trouble.

Sebastian
