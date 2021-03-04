Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ECA32DBA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhCDVPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbhCDVPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:15:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 13:14:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614892466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bw4qJjxKXVLh4PBNDOjMp/7CQXX7cieAxRXd2KtY/JM=;
        b=c7Kb9ZAE+mGVXBIr81LLFHdoQilGRJAGuNHd+Ja7BalqgdlOA1LZnpFrlhwTaB8nGSoBfg
        D8S2pFsmOX86eRXKenCfSIaIGYXzELSSSu4GGsenMkAL/8nUfGC02odu9B2tQIOLXCsdNP
        ptKRFSDk/XKpG9V+swRM2xq5cRwjzatz29uZNJbYNgUQhPozhIFwi6uUDvi+o/o2C9eF9q
        kNAKxL7B7lm0ubRexOjXrZQIPFhRu/63GN84DwFYeJLwHjGNcAzPVik+WEuJuWxL+QtGpA
        Cdyhq5iNcpbalFSTtUXnBYu+OYhLmOMgbyFXw1p2yJVd+b+DFkTW6Gx6zA7yHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614892466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bw4qJjxKXVLh4PBNDOjMp/7CQXX7cieAxRXd2KtY/JM=;
        b=yfFBAKmme33doAZag+SXQd7QwFJ9u9ZaIG8nbQ1VCq9p8tAOrbaMJYG8H2NUjsxmmZVM9C
        Zjb7J1XRKnGj+kCw==
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
Date:   Thu, 04 Mar 2021 22:14:26 +0100
Message-ID: <87ft1a62q5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03 2021 at 16:37, Oleg Nesterov wrote:
> On 03/03, Sebastian Andrzej Siewior wrote:
>> +static void __sigqueue_cache_or_free(struct sigqueue *q)
>> +{
>> +	struct user_struct *up;
>> +
>> +	if (q->flags & SIGQUEUE_PREALLOC)
>> +		return;
>> +
>> +	up = q->user;
>> +	if (atomic_dec_and_test(&up->sigpending))
>> +		free_uid(up);
>> +	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
>> +		kmem_cache_free(sigqueue_cachep, q);
>> +}
>
> Well, this duplicates __sigqueue_free... Do we really need the new helper?
> What if we simply change __sigqueue_free() to do sigqueue_add_cache() if
> task_is_realtime() && !PF_EXITING ? This too can simplify the patch...

Need to stare at all callers of __sigqueue_free() whether they are
really happy about this. Even if not, this surely can be deduplicated.

Thanks,

        tglx
