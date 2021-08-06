Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341783E295B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbhHFLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhHFLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:19:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B76C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:19:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628248756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J39G6NCEsr7Pn7yKXUeWhGGMrV16idiFuOdv/wvfupg=;
        b=q0YQm7pglzmIU7rNx7SL8KWW7dDWQr1P7adpjDzxv2jvtkSD8xR3gEIonGVheU8tmyvj0n
        vNcRB6CZYw/Rv7ne520So1bLuRS6mwDX9ysMJk00/kvsvAS+4rTPShgS2yXnLdmVDwDZAJ
        wYgJZK8Srvwll0RJinOje0NHmpWzYPYPIybPV3ztr16NtP4qcsk6WNgjSYYmLw3XTtzl0h
        eKT5RjMY9OaHF0gtf0o4yHjogoapo6k7FUXioF09QxOCsdHyxJOZNM6CPauppI/IWxfo3T
        5xktsa6ZzruY4AqrVyChy0LC4Ecpen/Pdr4+Mu6xtII4QudEWxwmZ3Kd75sotQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628248756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J39G6NCEsr7Pn7yKXUeWhGGMrV16idiFuOdv/wvfupg=;
        b=vC94hY5sr10DDSMFkTWcWmvAMP38XpQs5CAkLOSSey4TYT5wAHJ5KqbrKnp1c2RsT21vrp
        SLCmulR7ME3HZ0Dw==
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
In-Reply-To: <20210806110051.GF22037@worktop.programming.kicks-ass.net>
References: <20210805151300.330412127@linutronix.de>
 <20210805153955.709189588@linutronix.de>
 <20210806110051.GF22037@worktop.programming.kicks-ass.net>
Date:   Fri, 06 Aug 2021 13:19:15 +0200
Message-ID: <87fsvm6css.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2021 at 13:00, Peter Zijlstra wrote:

> On Thu, Aug 05, 2021 at 05:13:50PM +0200, Thomas Gleixner wrote:
>>  static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
>>  {
>> -	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));
>
> Given ^
>
>> +	struct rt_mutex_waiter *aw = __node_2_waiter(a);
>> +	struct rt_mutex_waiter *bw = __node_2_waiter(b);
>> +
>> +	if (rt_mutex_waiter_less(aw, bw))
>> +		return 1;
>
> We can, with this new build_ww_mutex(), do:
>
> 	if (!build_ww_mutex())
> 		return 0;
>
> here, to preserve the old behaviour.
>
>> +	if (rt_mutex_waiter_less(bw, aw))
>> +		return 0;
>> +
>> +	/* NOTE: relies on waiter->ww_ctx being set before insertion */
>> +	if (build_ww_mutex() && aw->ww_ctx) {
>
> Then it can go away here.

Pretty obvious. Indeed.
