Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934803E2A12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbhHFLuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbhHFLuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:50:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC2C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:50:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628250637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzkzg82CcnzDEB0oMUakpBB4hZUoV99SYb8903gM7pE=;
        b=EM04dC8dAdbAD/ZPq5eW5kBea7gLF5rQbuud8bI1b4Ab7Et0nl0aCjuI+SQyY4nThYxWGd
        oV0h4x3ulPO8JgsuJlDQpV27wG2c5Q2zvCi0GX82V0jWVM0w6UKHxFDq/wdhoeZERAsPmA
        SUb7EMKF2XFawmQ0tyObGjP5x6EF5w28cmUnFu97xsZRppSfAlVCxmWzCISDY77QpOgMMf
        mAGACKpxniRldvdRkjYAptrcazdPFkvznF2gjnLMmcXYM5OlqoIFfYv4kgX7Q05IDGcVO4
        TEwWfn0vxZSWEH9XWNx/MATzaHI2eht15oUbaobedFw9Kirh9Bz0Ss9+NedHmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628250637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzkzg82CcnzDEB0oMUakpBB4hZUoV99SYb8903gM7pE=;
        b=WfOaaDJAL7hIhtPhZu0RUNwCOCA2MXJskoqAo6g/lGddVUQZTF8h3KjP5aMCzTTCI2TpEx
        qG6Q+B7mluSWL2Cg==
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
Subject: Re: [patch V3 48/64] locking/ww_mutex: Add RT priority to W/W order
In-Reply-To: <20210806104835.GE22037@worktop.programming.kicks-ass.net>
References: <20210805151300.330412127@linutronix.de>
 <20210805153955.595804799@linutronix.de>
 <20210806104835.GE22037@worktop.programming.kicks-ass.net>
Date:   Fri, 06 Aug 2021 13:50:37 +0200
Message-ID: <87czqq6bci.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2021 at 12:48, Peter Zijlstra wrote:

> On Thu, Aug 05, 2021 at 05:13:48PM +0200, Thomas Gleixner wrote:
>>  static inline bool
>> +__ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
>>  {
>> +/*
>> + * Can only do the RT prio for WW_RT because task->prio isn't stable due to PI,
>> + * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter and
>> + * isn't affected by this.
>> + */
>> +#ifdef WW_RT
>> +	/* kernel prio; less is more */
>> +	int a_prio = a->task->prio;
>> +	int b_prio = b->task->prio;
>> +
>> +	if (dl_prio(a_prio) || dl_prio(b_prio)) {
>
> Whoever wrote this was an idiot :-) Both should be rt_prio().

Along with the idiot who picked that up and stared at it for quite some
time.
