Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74340B263
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhINPCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:02:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34000 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhINPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:02:14 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631631656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGBRmHV9K/M0F5ppDOKp+GVLwJxmlYjlIieCg77sEIs=;
        b=i6zXfj1hGfaZEqgANktxkGbh4IjfyCDsOasfy5HpHdcvVUD6HwT6us2p5/KePzrmSxgQD7
        tmqFPh2pxdAlI2sIJJ98TNtIWVoyMiDmYMzN5fZvBqQyxsFrqnloJrGJNVd829p1RdaLea
        I++VIbp835LEiRGuafEqa14cXwbpjIyobOeltIGGYOkoIEAvLmgnzg7IZqgzVv3J4B30Tv
        atFCr4hL462Ez57p1AiyEsXQcvlZ/SswQ1IZoMIzZ5jVSi4fJumsB95/8IzD/lVUeUjgHQ
        qWoKLb1vNZb1FCoGRQqj77CWNnZdnTIXhl97/p7PpCCz/0MrDsOYKergrXHcIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631631656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGBRmHV9K/M0F5ppDOKp+GVLwJxmlYjlIieCg77sEIs=;
        b=usbVLW4qSnYCxGogEAqh6bTxiRLYACwBtWZofJd+nQ5pfmeEcHqzy89uH4Cz7RjUx1cT5T
        Ca2nkqmpfqWfymAw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] locking/rwbase: Fix rwbase_write_lock() vs
 __rwbase_read_lock()
In-Reply-To: <YUCq3L+u44NDieEJ@hirez.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.893845303@infradead.org> <87k0jjeh2v.ffs@tglx>
 <YUCq3L+u44NDieEJ@hirez.programming.kicks-ass.net>
Date:   Tue, 14 Sep 2021 17:00:56 +0200
Message-ID: <87sfy7b3rr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2021 at 15:59, Peter Zijlstra wrote:
> On Tue, Sep 14, 2021 at 09:45:12AM +0200, Thomas Gleixner wrote:
>> The read/set is always in the same lock instance.
>
> I really did make a mess of things didn't I :-/ It was some intermediate
> state that was broken.

Thinking about memory ordering can reorder your memory :)

> How's this then?
>
> ---
> Subject: locking/rwbase: Extract __rwbase_write_trylock()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 09 Sep 2021 12:59:18 +0200
>
> The code in rwbase_write_lock() is a little non-obvious vs the
> read+set 'trylock', extract the sequence into a helper function to
> clarify the code.
>
> This also provides a single site to fix fast-path ordering.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

