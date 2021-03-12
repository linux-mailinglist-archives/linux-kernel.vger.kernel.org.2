Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1887D3398E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhCLVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbhCLVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:13:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:13:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615583605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8cbNOoxUdxvtKMbJI/6thmSir0x9hZ24uQjfzmb3lo=;
        b=cmks//HZFB/wTqjuFqDoO4Ywm6CmvRO6w5WNxx2yenNiKS6IFWB0jxsP7mUZ1gZ6bg6bHV
        19HEFjm3sRSiJo6Io0XTD93cxJQo9H8n7SSUphuNGlGd8j0+uZGH0sfACWNPi/k8fgiGVS
        g7kil9H4BldPORoQMG48/IN/psClfcRoJplwmTu3yVqcv+xGlie6gjPN9Dm/ROc61bvMNK
        0qBpa/b7dEJvmUGAmFmgUvsZDFcfFp7+93O8uJsErgAan1PHO9nulxTGIiw2LWLARWmug8
        LOCLWQue1FT8N3hzzIlEQ1yL6CneCtTNi42YgAx5DKqHwrLGN13YdV2GcniDWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615583605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8cbNOoxUdxvtKMbJI/6thmSir0x9hZ24uQjfzmb3lo=;
        b=vJoICCtDBtMxCBdTHHO6uKddLnifTPVPkCka97dQwOIOMRD+NdZYDEcLbgbN4PumyULN9s
        KloWEL0C5fkKMWCQ==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch V2 3/3] signal: Allow tasks to cache one sigqueue struct
In-Reply-To: <87blbo2my0.fsf@nanos.tec.linutronix.de>
References: <20210311132036.228542540@linutronix.de> <20210311141704.424120350@linutronix.de> <20210312161148.GA25946@redhat.com> <87blbo2my0.fsf@nanos.tec.linutronix.de>
Date:   Fri, 12 Mar 2021 22:13:25 +0100
Message-ID: <871rck2hze.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2021 at 20:26, Thomas Gleixner wrote:
> On Fri, Mar 12 2021 at 17:11, Oleg Nesterov wrote:
>> On 03/11, Thomas Gleixner wrote:
>>>
>>> @@ -456,7 +460,12 @@ static void __sigqueue_free(struct sigqu
>>>  		return;
>>>  	if (atomic_dec_and_test(&q->user->sigpending))
>>>  		free_uid(q->user);
>>> -	kmem_cache_free(sigqueue_cachep, q);
>>> +
>>> +	/* Cache one sigqueue per task */
>>> +	if (!current->sigqueue_cache)
>>> +		current->sigqueue_cache = q;
>>> +	else
>>> +		kmem_cache_free(sigqueue_cachep, q);
>>>  }
>>
>> This doesn't look right, note that __exit_signal() does
>> flush_sigqueue(&sig->shared_pending) at the end, after exit_task_sighand()
>> was already called.
>>
>> I'd suggest to not add the new exit_task_sighand() helper and simply free
>> current->sigqueue_cache at the end of __exit_signal().
>
> Ooops. Thanks for spotting this!

Hrm.

The task which is released is obviously not current, so even if there
are still sigqueues in shared_pending then they wont end up in the
released tasks sigqueue_cache. They can only ever end up in
current->sigqueue_cache.

But that brings my memory back why I had cmpxchg() in the original
version. This code runs without current->sighand->siglock held.

So we need READ/WRITE_ONCE() for that on both sides which is sufficient.

Thanks,

        tglx


