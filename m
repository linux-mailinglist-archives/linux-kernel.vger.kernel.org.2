Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8554C3E10C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbhHEJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHEJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:04:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC2C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:04:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628154267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qerA/3w98zKHBl/JR8gFLXMxNSmnHTzMiH8UfpFC6/Y=;
        b=AlRdJ/zspZYgz2vHfFPAur1J8SgJSAV9YsS2NDJLAqhOETa7b20HFTwrga0da6a/wR3oCo
        A8k1VI7OkI+xBYmhJHxaMel97/bQviv6lLT0mabdjZDrH/EKXkftKxiDyFCiCopqf7xdM1
        tEwSCrMtLpuJKLmM+hKt4zRf80jREz5QphnTdyhGNnaZ7No/Ib0HGtno5CaSy0kjiKN3HO
        +BUvqLJREpciZ/dzyGuMVnsHueBJ1Ifw2wH5h+mmawIvAFpoiSqH2kTPBU7x1BhPqipKxx
        CqH3ntp9VmCC/EFYKbpG87qrLi1EZdiZjkvbf6CJCRJstXo4KFpKGq4Nff7XCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628154267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qerA/3w98zKHBl/JR8gFLXMxNSmnHTzMiH8UfpFC6/Y=;
        b=yAjAnSnBRMsU8f4PUzplL65BNx3crGSeLOngfC8uZTVgRhayhTosWRqcZ7X3LPuFx0jStq
        1nwqY5OnbDL9UQAw==
To:     Waiman Long <llong@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 15/63] locking: Add base code for RT rw_semaphore and
 rwlock
In-Reply-To: <710fff58-1db3-d0c2-21db-b1837d37bfee@redhat.com>
References: <20210730135007.155909613@linutronix.de>
 <20210730135206.018846923@linutronix.de>
 <710fff58-1db3-d0c2-21db-b1837d37bfee@redhat.com>
Date:   Thu, 05 Aug 2021 11:04:27 +0200
Message-ID: <87o8ac1cv8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2021 at 15:37, Waiman Long wrote:
> On 7/30/21 9:50 AM, Thomas Gleixner wrote:
>> +static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>> +				     unsigned int state)
>> +{
>> +	struct rt_mutex_base *rtm = &rwb->rtmutex;
>> +	unsigned long flags;
>> +
>> +	/* Take the rtmutex as a first step */
>> +	if (rwbase_rtmutex_lock_state(rtm, state))
>
> This function is used here before it was defined in next patch (patch 16).

Correct and there are more I think. But that's a hen and egg
problem:

The base code cannot be compiled without the actual implementation for
either rw_semaphore or rw_lock substitutions. The implementations cannot
be compiled without the base code.

So I chose to split it up so the base logic is separate.

Thanks,

        tglx
