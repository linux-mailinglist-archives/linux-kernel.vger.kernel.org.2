Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6BF3DDB23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhHBOeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49480 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhHBOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:34:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627914876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xxZo+uAauJEpvhaSgtPdJVYpeQCcr5aJGzYokRsY+7c=;
        b=L3MZjgdG7Yl508ib7srRPWl++oD8+w9LIM740+LW4UT5Kf580RoxDsM8qm5kdJijk6KQV8
        3Ymxv+0B3aZDzVD8RPayrmySq9oIDREv831ac3OU3Tb/gxxcq0o1KRPRUg0tLOvgv7oQEW
        qFKvy/vchJUynffr+4aw2ZBi4uH7zGpsN4Wa+deEk5SeNPgaar7MH/Q7XOWHWd0xlynLK9
        pVilJc4eLQcZ1OZ8ZYPnhiKxivBiOX7T8iKVOehxCof947g6PykFeOxBBGeYAM7TuDHLx/
        3l0XJxcngmlss5cCJjK6f4x+KXBS8gw1mSa0Y6BmlZxKvo13cCmNs7CbCAs8Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627914876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xxZo+uAauJEpvhaSgtPdJVYpeQCcr5aJGzYokRsY+7c=;
        b=7CsuH9m0DkJsnSjObXgmtbbBfNuDKuTbHE3dVhfxlshrw5P5BKoHaMbWjkbzjIW0jFf88R
        eAtDUrJgTawPfeDw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on RT
In-Reply-To: <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
 <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
Date:   Mon, 02 Aug 2021 16:34:36 +0200
Message-ID: <87bl6f3og3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2021 at 14:56, Peter Zijlstra wrote:
> On Fri, Jul 30, 2021 at 03:51:05PM +0200, Thomas Gleixner wrote:
> I did:
>
>  - atomic_cmpxchg() -> atomic_try_cmpxchg()

Ack.

>  - atomic_read() -> atomic_read_acquire(); which I think is required for
>    at least the futex_requeue_pi_wakeup_sync() >= Q_REQUEUE_PI_DONE case
>    to ensure we observe the state as per whoever set DONE/LOCKED.

Indeed

>  - use atomic_cond_read_relaxed()

Cute

>  - removed one ternary operator for (IMO) clearer code.

It's definitely more readable this way.

Thanks,

        tglx
