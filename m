Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE77406F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhIJQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232987AbhIJQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631290064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D72imR/+0z9E6SGEgfDNfuIvKAmw/sK8lm5J8ko3H7M=;
        b=Dlbzyzl+mHOg1QvxFDXCGlWb15EFGYaeJ5ZDiYoT3UK3I46MJB5lBkiaL1HQ70WMBZlDAP
        aqV7lHdW8vdB/tkiU1Z5tCWX4hRxKXzGtKH4Y7HtHFnFgpGi7OOO0TM1eC/gP4WJl97JTV
        jnKhMniw1XxfqKMx/uKFMAs1VRN7X/Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-x20iGIV4P8mNtffXAgUwdQ-1; Fri, 10 Sep 2021 12:07:43 -0400
X-MC-Unique: x20iGIV4P8mNtffXAgUwdQ-1
Received: by mail-qt1-f199.google.com with SMTP id r5-20020ac85e85000000b0029bd6ee5179so19631818qtx.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D72imR/+0z9E6SGEgfDNfuIvKAmw/sK8lm5J8ko3H7M=;
        b=Vat2ldMoWADJnEuU6V4wyF0T83bCWAaDHFoZX8F53c9E9p4UtGbJg6rIjMj+aP4GKv
         UrSi1zQMuojPw6eu4JZeMSNyoBaXw8FqSOwcrjflwJfFiF6v6REqSWJ55bzkAtedEb84
         Cl4rO9TebuYs9w6Nn+klPnypIYgUguYGOmq0CXQU4hwYAD/mLKErgMpRCNLj3zqna9bS
         5UZ12ZaBsflb5WGm5m5oghG/HUzPLJ5gwnhxHQMYN+0mMSstAfWHHHu/Ifoq+T9qUBHv
         WKbziaFYBAc40Rk/unu3NrIW9zm0EOp3XskM1Z8IDrUkk5cpLYclaTWa9g6G/voW7uCj
         EErA==
X-Gm-Message-State: AOAM530QuS8ZYnyqYIRLpAd6oTKe01AieYWnguVI2sf0QHKPNJDixllO
        mHyypMJWGlg5g/viQettVfoUAHc8d8irLIY03UYPccYW/Ju13/kRQQzxqR1aTy6IXEjJBxyGrD4
        WSPuKUGrQH6dInr0WMb/rETnZ
X-Received: by 2002:ac8:43d6:: with SMTP id w22mr8574845qtn.92.1631290062813;
        Fri, 10 Sep 2021 09:07:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFAemKoeqHJx6Yh4ZcADD5BPp2KLAseY8MpSFYbYhdbm2nnMnvb536y0vYIn9TY+a8rjQHQA==
X-Received: by 2002:ac8:43d6:: with SMTP id w22mr8574821qtn.92.1631290062581;
        Fri, 10 Sep 2021 09:07:42 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j9sm3285210qta.65.2021.09.10.09.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:07:41 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
 <20210910125658.GA1454@willie-the-truck>
 <YTta0Kkz4OeFzUvJ@hirez.programming.kicks-ass.net>
 <YTtlOQfAl/cT5Na9@hirez.programming.kicks-ass.net>
Message-ID: <3242b07a-79be-f355-cf4a-3799913b5d2d@redhat.com>
Date:   Fri, 10 Sep 2021 12:07:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTtlOQfAl/cT5Na9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 10:01 AM, Peter Zijlstra wrote:
> On Fri, Sep 10, 2021 at 03:17:04PM +0200, Peter Zijlstra wrote:
>> On Fri, Sep 10, 2021 at 01:57:26PM +0100, Will Deacon wrote:
>>> On Thu, Sep 09, 2021 at 04:27:46PM +0200, Peter Zijlstra wrote:
>>>> Moo yes, so the earlier changelog I wrote was something like:
>>>>
>>>> 	current_save_and_set_rtlock_wait_state();
>>>> 	for (;;) {
>>>> 		if (try_lock())
>>>> 			break;
>>>>
>>>> 		raw_spin_unlock_irq(&lock->wait_lock);
>>>> 		if (!cond)
>>>> 			schedule();
>>>> 		raw_spin_lock_irq(&lock->wait_lock);
>>>>
>>>> 		set_current_state(TASK_RTLOCK_WAIT);
>>>> 	}
>>>> 	current_restore_rtlock_saved_state();
>>>>
>>>> which is more what the code looks like before these patches, and in that
>>>> case the @cond load can be lifted before __state.
>>> Ah, so that makes more sense, thanks. I can't see how the try_lock() could
>>> be reordered though, as it's going to have to do an atomic rmw.
>> OK, lemme go update the Changelog and make it __flags for bigeasy :-)
> The patch now reads:
>
> ---
> Subject: sched/wakeup: Strengthen current_save_and_set_rtlock_wait_state()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 09 Sep 2021 12:59:16 +0200
>
> While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> it really ought to use smp_store_mb(), because using it for a more
> traditional wait loop like:
>
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (cond)
> 			schedule();
>
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
>
> is actually broken, since the cond load could be re-ordered against
> the state store, which could lead to a missed wakeup -> BAD (tm).
>
> While there, make them consistent with the IRQ usage in
> set_special_state().
>
> Fixes: 5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210909110203.767330253@infradead.org
> ---
>   include/linux/sched.h |   21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -218,7 +218,7 @@ struct task_group;
>    */
>   #define set_special_state(state_value)					\
>   	do {								\
> -		unsigned long flags; /* may shadow */			\
> +		unsigned long __flags; /* may shadow */			\

Do you still need the "may shadow" comment?

Cheers,
Longman

