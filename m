Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD53E3704
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhHGUHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHGUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 16:07:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3969C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 13:07:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628366841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rouqJ6YQEHtzrLXwBbMfbCJhwqiFnVmjZ19r7KAZp7w=;
        b=j+mBlyyVhwj6RJB7skbqjcfFkfb6hNO32e1bDiaHu03r+MvXzqXv3Kdr6uOsWVGEOOMAam
        lNvc3+OowgaIgbAf7nMEfz8Fq7L08LNYcu4D0ex5ckG/Vb8EBqw/9RR4rfN1KL5OH6JQqM
        BnwMAxOB3ovolJM+2WevloM8nfnGo+7WQdZzKaU7S2ICI4Z31BNR9Ssx1zb83mq+/H17dr
        9OubrvdDHeAENaPFOpBlSzELJc9mK7Lz40qmaeScww7HlfzfpXpyh5QPsdTyu9d4DqtPMa
        MtowbWkLZORTmzfha+ZlphyBUszs3iahjy4Lw+CCrAoCfBCj9wP4tcKUQgiZ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628366841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rouqJ6YQEHtzrLXwBbMfbCJhwqiFnVmjZ19r7KAZp7w=;
        b=EL3sSLesPCX8PVGrY7aYKGnf1w2fIt5vcSCHOg9qg2qPCknYgfgor0hsJVW8+QRL+0ucuA
        RL6LDJeYMYTLwiDw==
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 50/64] locking/rtmutex: Extend the rtmutex core to
 support ww_mutex
In-Reply-To: <YQ09mREYoqt6YunQ@hirez.programming.kicks-ass.net>
References: <20210805151300.330412127@linutronix.de>
 <20210805153955.709189588@linutronix.de>
 <20210806110051.GF22037@worktop.programming.kicks-ass.net>
 <YQ09mREYoqt6YunQ@hirez.programming.kicks-ass.net>
Date:   Sat, 07 Aug 2021 22:07:19 +0200
Message-ID: <8735rl5894.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2021 at 15:48, Peter Zijlstra wrote:

> On Fri, Aug 06, 2021 at 01:00:51PM +0200, Peter Zijlstra wrote:
>> Also, I found a note that said I had to check what this code does for
>> !RT tasks, lemme go do that now.
>
> Do we want something like the below?

I think so.

> AFAICT the existing RB-tree actually does FIFO for equal prio right. Per
> rb_add_cached() we only go left for less, therefore equal goes right,
> giving a tail-add for equal prio.
>
> Furthermore, rt_mutex_adjust_prio_chain() is careful not to requeue when
> the priority doesn't change, preserving this FIFO order (as is mandated
> by SCHED_FIFO semantics IIRC).
>
> Therefore, all that seems to be missing is to squash all !RT tasks to
> the same prio to make sure they're all FIFO ordered.

The reason why the nice value is accounted for today is that it gave
more exposure to the PI code. But yes, we can squash all !RT tasks and
let them queue in FIFO order.

Let me add that to the series.

Thanks,

        tglx
