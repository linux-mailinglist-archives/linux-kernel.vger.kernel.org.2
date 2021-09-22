Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31B94141EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhIVGdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:33:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhIVGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:33:40 -0400
Date:   Wed, 22 Sep 2021 08:32:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632292329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LHGvGMeI0MChbmKlKUQjDfvhqjuQaXlro5jHJuiZF4w=;
        b=AFVjxbaCU1HStARR3s5GptNPD2J5/N0DhTmeIwza4KWjgE+XUqWjrBrxHbQGi7hd7Zc7js
        BHFE42pswXTDMhQasgTwaXzYu1Z5U7vQqOUkhQxJkwL44gOvnvS936y1q6EXfoP6eSvqAj
        Zm5RWUWQjozxlGg1uiJx4q+3169rv57mrbiYxUk/p882wbSwK6BZFw6qvBGh3REOZ+X1XY
        /SBVb/7v658z3MqITZma+6RAWuLc8OqTz8T9jLfSEy2wlmX5hWZmrIpyBGhvNr5mDfW2wD
        JkAea82CIUY8rNHK5VEh5oHqy1BhWnhx1QTf4WpFKkSKUgGysTJnwsKbugSQ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632292329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LHGvGMeI0MChbmKlKUQjDfvhqjuQaXlro5jHJuiZF4w=;
        b=XOSDGiTQMoMm+wYlF4/FhKR/TW81atLKv4UkTrp7RxxMkfUED2spl7KHV32imSzOmG+EnO
        gY3q8TF3EL5ks0CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
Message-ID: <20210922063208.ltf7sdou4tr5yrnc@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <20210921234518.GB100318@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921234518.GB100318@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-22 01:45:18 [+0200], Frederic Weisbecker wrote:
> 
> Also while at it, I'm asking again: traditionally softirqs could assume that
> manipulating a local state was safe against !irq_count() code fiddling with
> the same state on the same CPU.
> 
> Now with preemptible softirqs, that assumption can be broken anytime. RCU was
> fortunate enough to have a warning for that. But who knows how many issues like
> this are lurking?

If "local state" is modified then it is safe as long as it is modified
within a local_bh_disable() section. And we are in this section while
invoking a forced-threaded interrupt. The special part about RCU is
that it is used in_irq() as part of core-code.

> Thanks.

Sebastian
