Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C8832DB97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhCDVKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:10:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhCDVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:10:45 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614892204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2+VnMvEvSXZzNuMQTq1YMznMBaWnu0FKr4Suh2och8=;
        b=npDHvh0dps504ou84ECUWWR+K3afvndhhOK6XeXZQ8lVBynxTy2LTNUdhGpWZTh4GucY8P
        w17Nt84W9NILn3dphMgedxlwpSIN8HQKdQuJbUqk6dZJiseHUdhqizcuxRG+v0RO2u3wnP
        6zggCi+Dp7qXH1wjMI2Uh50Xuh4vrXCX6k5VAA+fvksZ72hMQKBOno0bA3Hv0NNxwpCzc9
        xTk670P6e94WVgkGRUgts2gFErqTH77tuSLC7Fk6zo+X8HvHXx4HQ6hNfRSI82y6KVyrcp
        /d4QLN7yp3VxdYuX72+Usptt/FxQ2ezJEJELhVdRnNv/Xu7Px1lsxG4mEbpQtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614892204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2+VnMvEvSXZzNuMQTq1YMznMBaWnu0FKr4Suh2och8=;
        b=YD6hZ297R1S7yLhrtJdkZrJ+RFIkqMfasXpRk8AeeaHjCd0g3Fsuw6tmZh5UCA+EWsW10V
        dO9RNJqohGu6sABg==
To:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
In-Reply-To: <20210303153732.GC28955@redhat.com>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <20210303153732.GC28955@redhat.com>
Date:   Thu, 04 Mar 2021 22:10:03 +0100
Message-ID: <87im6662xg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03 2021 at 16:37, Oleg Nesterov wrote:
> On 03/03, Sebastian Andrzej Siewior wrote:
>>
>> +static struct sigqueue *sigqueue_from_cache(struct task_struct *t)
>> +{
>> +	struct sigqueue *q = t->sigqueue_cache;
>> +
>> +	if (q && cmpxchg(&t->sigqueue_cache, q, NULL) == q)
>> +		return q;
>> +	return NULL;
>> +}
>> +
>> +static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
>> +{
>> +	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
>> +		return true;
>> +	return false;
>> +}
>
> Do we really need cmpxchg? It seems they are always called with
> spinlock held.

With which spinlock held?

__send_signal()         <- sighand::siglock held
  __sigqueue_alloc()

alloc_posix_timer()
  sigqueue_alloc()      <- No lock held
    __sigqueue_alloc()

and on the free side we have a bunch of callers which do not hold
sighand::siglock either. So the cmpxchg() is required.

Thanks,

        tglx

