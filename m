Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C804339763
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhCLT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhCLT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:26:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:26:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615577175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cR99nONFQQCVUW3yjxG5cuk/xCH6xSD9a2mt3RjZaV8=;
        b=EOenn1mfg1GUomxoWYLQkVMl3G4y0yf61CZQUqHQ1QWNWQ/EhdclpePLo68SB1xXnOBz7N
        6yanKEKVykFQ/Qm4TQ5trhOIUbgZ0NWFw0EfdsY/P8crPhvGN1HdV929Vv6f8xQuvBZH6Y
        BP0czc6uwH2Tl3cvTLnwBwHAMe2PMlRy+SKB5dZhBfE3CngUqooR2HEfFC36E23/xpWBN0
        w7yU/UAfhD1RvBbLRDwVj6e1n3oaWY72spij6aiwoG3VHDDPAYVWsMdfbXfMVKCffEYiXR
        GwJATn+3PhC6aSgd6wWfo2iYiFFipoPLsgzi/QmKzaiSCuZRUWAk5KblL+E00A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615577175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cR99nONFQQCVUW3yjxG5cuk/xCH6xSD9a2mt3RjZaV8=;
        b=YmN+gbyuUAxnvBHMT3wpzikQ3vBy+ZkNYCSS+QWGDEi4L5nxWLnca4dj10pUP+ayIYhw1D
        vWw4laWPKdspB3AA==
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
In-Reply-To: <20210312161148.GA25946@redhat.com>
References: <20210311132036.228542540@linutronix.de> <20210311141704.424120350@linutronix.de> <20210312161148.GA25946@redhat.com>
Date:   Fri, 12 Mar 2021 20:26:15 +0100
Message-ID: <87blbo2my0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2021 at 17:11, Oleg Nesterov wrote:
> On 03/11, Thomas Gleixner wrote:
>>
>> @@ -456,7 +460,12 @@ static void __sigqueue_free(struct sigqu
>>  		return;
>>  	if (atomic_dec_and_test(&q->user->sigpending))
>>  		free_uid(q->user);
>> -	kmem_cache_free(sigqueue_cachep, q);
>> +
>> +	/* Cache one sigqueue per task */
>> +	if (!current->sigqueue_cache)
>> +		current->sigqueue_cache = q;
>> +	else
>> +		kmem_cache_free(sigqueue_cachep, q);
>>  }
>
> This doesn't look right, note that __exit_signal() does
> flush_sigqueue(&sig->shared_pending) at the end, after exit_task_sighand()
> was already called.
>
> I'd suggest to not add the new exit_task_sighand() helper and simply free
> current->sigqueue_cache at the end of __exit_signal().

Ooops. Thanks for spotting this!
