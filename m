Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABC3337FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhCJI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:57:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58628 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhCJI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:57:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615366650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Prcn4FBWkHEBWzQEVl+zK5TjWq1HiyVjVL+CC+4j9Y=;
        b=jy0h0pKixcREetU90jQ8vU2+IzUoXRINA6fqjcZJSIFT/uNy4y9VP5fA170ln1VhLtfcjX
        jq2uDZGbRbTuZ3vXW4RP44CW5/cvDuy49hB7nJGxjSsovfqgDDKEO68inqUqHL5+hu+U57
        F0S5M0+smxWd5lnieFc7ChDtCscJxtwNsoXid4q4oIf9mIZkUkluKR+V4+wdw9NNoqymOZ
        DsKgZdunabnxB7by6omPDBVFhA1GkEOY9BzpZDBbGYfAb/iO9CtJnuNjQ6cwW+yGZ+iyQ3
        FkKfp/groD4gm1EJG7nM5HYNwFsyD6G3Y69dfZFgGrZroAkPcTvEDYtqQcYjVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615366650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Prcn4FBWkHEBWzQEVl+zK5TjWq1HiyVjVL+CC+4j9Y=;
        b=SUIj8OjAPQmktIrPdGPWGmuXNbBC3kR8vvKcymTyQtvgW4NnhY2wHdp/Jn2NwpDZHube9F
        J0C80ZFxyLW0q9BQ==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
In-Reply-To: <draft-874khk5yed.fsf@nanos.tec.linutronix.de>
References: <draft-874khk5yed.fsf@nanos.tec.linutronix.de>
Date:   Wed, 10 Mar 2021 09:57:30 +0100
Message-ID: <87v99z4c91.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09 2021 at 13:01, Thomas Gleixner wrote:
> On Fri, Mar 05 2021 at 11:57, Oleg Nesterov wrote:
>> On 03/04, Thomas Gleixner wrote:
>>> On Wed, Mar 03 2021 at 16:37, Oleg Nesterov wrote:
>>> >> +static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
>>> >> +{
>>> >> +	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
>>> >> +		return true;
>>> >> +	return false;
>>> >> +}
>>> >
>>> > Do we really need cmpxchg? It seems they are always called with
>>> > spinlock held.
>>>
>>> With which spinlock held?
>>>
>>> __send_signal()         <- sighand::siglock held
>>>   __sigqueue_alloc()
>>>
>>> alloc_posix_timer()
>>>   sigqueue_alloc()      <- No lock held
>>>     __sigqueue_alloc()
>>
>> In the last case "fromslab" is true, sigqueue_from_cache() won't be called.
>>
>>> and on the free side we have a bunch of callers which do not hold
>>> sighand::siglock either.
>>
>> Where?

Bah. I confused myself. Let me start over with that.

Thanks,

        tglx
