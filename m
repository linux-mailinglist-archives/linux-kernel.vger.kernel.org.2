Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA83FA044
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhH0UEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:04:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhH0UD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:03:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630094589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qT1e7UDzPD/tmV/mrQZy1+bKcswB6P5HtcZoatfuCQQ=;
        b=sUaX5HujlOMjAMMd1QGv5EM7yODf1sRY2QUPqTWE+k6MjcYR2SrFTKUSc5/xSo1sgQwRGD
        g4LelV7SsvftIDAQ3J0KEj9ZSZ+V0HoHR6CPyxAgfRCTqQutHv7GFUssrPvSsursdBpYdc
        NbssWKjPgvN+BJrTyTsHZLIWOSiGB0AtMq1e8TDsPxpzY9dsbYNc2DQCh1hK5mHNBsy41H
        RcslIU/nrCY4i0RHjmCLfgnR1dmLgkpz5WDgxvUS2vjQQaG9+53ZEYjYUsjjFYH3ZCOprC
        2cogSanZMX/APsMtrj3TjNTEpeQko4xvoHI1uouAT/7DWhXGf4DanppCX6dQ8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630094589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qT1e7UDzPD/tmV/mrQZy1+bKcswB6P5HtcZoatfuCQQ=;
        b=VT3Pfwr10LVsg+X1APpKHCtA1BzKrXEmZ1TVyZk3irsM/Zw1Jm39Qb+aUkRd+T1DNpo07n
        bk5/sS6XQomInaBg==
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V5 32/72] locking/rtmutex: Provide the spin/rwlock core
 lock function
In-Reply-To: <YSkfKoXIYhsLT2Ef@boqun-archlinux>
References: <20210815203225.710392609@linutronix.de>
 <20210815211303.770228446@linutronix.de>
 <YSkfKoXIYhsLT2Ef@boqun-archlinux>
Date:   Fri, 27 Aug 2021 22:03:08 +0200
Message-ID: <87mtp21wqr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28 2021 at 01:21, Boqun Feng wrote:
> On Sun, Aug 15, 2021 at 11:28:25PM +0200, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> +static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
>> +{
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>> +	rtlock_slowlock_locked(lock);
>> +	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>
> Just out of curiosity, could we use raw_spin_{un,}lock_irq() here
> instead of *_irq{save,restore}()? Because rtlock_slowlock() might sleep,
> and we cannot call it with irq-off.

Unfortunately we can during early boot when lock debugging is enabled
because then the fast path is disabled. We might make it conditional on
!DEBUG though, but I'm not sure whether it's worth it.

Thanks,

        tglx
