Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EED311651
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhBEXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhBEOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:37:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0987AC061224
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:15:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612537200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQS1atlJp0GWrdvv3C9vL1QMEy6xhIDqNluWSLp1A5k=;
        b=xIhQ5uGcJ6BcdU14r0txPMabY89WnUIchSMBd2+luqw24tdLVUZBvg0TXpwxtN4FXWZmh3
        l28YWhCh7zEvqfBfAdEuFAwmhqIRMXmG80UTPjlpBnGdo7IekY7YDjrf/pn2bT38w8pSFi
        BtifArjvn2Gkrlee9V0DDidrJe0kP9FiN2kz/AmKpJMSJaQeCyx7Z06i16ct/bYiGnD2dX
        h4jKOoGQZXo/t0n6gLGxctayj/V6majH9ZcFd2+AIrAwLkRrmhHtq7gCTm7S6o+lfKcT4D
        srF6CWj206lYyxKpepVQnWeN26dPP6OP7XebLtyOIJ8z2VME9y3eGGgFswU/bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612537200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQS1atlJp0GWrdvv3C9vL1QMEy6xhIDqNluWSLp1A5k=;
        b=GOpZ7OK/dOdrZyLEhWC0rcf1UH9oV1tv/USFrse+asjnGwLy8aRAXC8Mwu5iSd4e04ElWL
        Z1E1LWjHxevXLeCA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 03/12] x86/irq/64: Adjust the per CPU irq stack pointer by 8
In-Reply-To: <YB1NzV4Zxfmu7PEH@hirez.programming.kicks-ass.net>
References: <20210204204903.350275743@linutronix.de> <20210204211154.410462790@linutronix.de> <YB1NzV4Zxfmu7PEH@hirez.programming.kicks-ass.net>
Date:   Fri, 05 Feb 2021 16:00:00 +0100
Message-ID: <87tuqq8sr3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05 2021 at 14:53, Peter Zijlstra wrote:
> On Thu, Feb 04, 2021 at 09:49:06PM +0100, Thomas Gleixner wrote:
>>  Move the definition
>> next to the inuse flag so they end up in the same cache line.
>
>> -DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
>> +DEFINE_PER_CPU(void *, hardirq_stack_ptr);
>>  DEFINE_PER_CPU(bool, hardirq_stack_inuse);
>
> Not strictly guaranteed they end up in the same line. If you stick them
> in a struct and force alignment on the instance you'll have better
> guarantees.

You're right. There are a bunch of per cpu variables which are randomly
defined all over the place which should stay in the same cache line.
