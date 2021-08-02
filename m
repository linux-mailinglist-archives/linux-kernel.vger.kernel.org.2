Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106A13DDB27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhHBOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:36:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhHBOgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:36:08 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627914958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSF4LCL8KG9Cshl8MiOPlOAr1DwKy4xSuc4wY3Vs2vM=;
        b=WxRi9ZJT+d2IqRdsKCCgOclEBNilMr+8BPrE5czQU6pFGYdIehZfe6KaqR2roOVx/XHL3P
        QZIK54lbHhD0Bvr+/DvZWN/7cc3mPG6ksmcYO9OXQWlEDLhQfqoMkyekavtZja+9wW9Eh1
        Bow0CvDbM5HVMVc1/DAf6bnJVNYKdeZ9yPRstoDnVcEnTOsKQclD3JHOWOv/d9G4AVaIhe
        iYoauTFTMpxM6hbQuZxvAU4bdT2YbWSyy91zkOmdJQUjaWhcOz6PR6RZ81FMZ2TPKVxq9R
        u1ohgY0g3BAwdN12v1pU+eihsu7fTuxynv0RjmA/Hz3nMuUoSvF9fXzFbviL8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627914958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSF4LCL8KG9Cshl8MiOPlOAr1DwKy4xSuc4wY3Vs2vM=;
        b=KxCfLgzrMPJxhCO/XmmwfYcmxyIzCO/OHYRMxd6AhECAwvdHQ8SkLpIN54YdVd/E54bcik
        besQoaq0ke8ReLDA==
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
In-Reply-To: <YQfurhYEojdg8VZY@hirez.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
 <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
 <YQfurhYEojdg8VZY@hirez.programming.kicks-ass.net>
Date:   Mon, 02 Aug 2021 16:35:58 +0200
Message-ID: <878s1j3odt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2021 at 15:10, Peter Zijlstra wrote:

> On Mon, Aug 02, 2021 at 02:56:09PM +0200, Peter Zijlstra wrote:
>>  static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
>>  {
>> +	int old, new;
>>  
>> +	old = atomic_read_acquire(&q->requeue_state);
>> +	do {
>>  		/* Is requeue done already? */
>> +		if (old >= Q_REQUEUE_PI_DONE)
>>  			break;
>
> I think that can be: return old; for slightly simpler code.

Yes.
