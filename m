Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7532D5D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhCDPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:03:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhCDPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:02:47 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVvkw9RDbs10tqMMQB/pBeMdzmi4nKP3nDo8iaP1ruc=;
        b=TDWHEyc2FMTVPZyLAtGluLIN1dnW8cKI30XwOPhohMs3da21+jVj+9ampeZOnQ1yVmNZJm
        UgRFy2dri7n3LmyosLkDISFUdWIBHATZIUIVg5svdZH6DXU4nAWSUkHRyUN6zhWQn+Cmku
        njRbGN9vuGQyPTEGztEAey+HXM9yyslPJX7k8gujto+fTitKJhFoeI4QCEXmht8OmyQRlS
        O2SodqHxiEZ6p2zB4MMwVS7JZJD00R5WNpZSYQHNxuOs91Gswe1ljd9hB1yLVpIYm/6JU0
        NPsdU8roYtjrv71Y5N/3ywE536y55z4b0VFF/6XmIbrBdHsN8+AqvVFcffJi1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVvkw9RDbs10tqMMQB/pBeMdzmi4nKP3nDo8iaP1ruc=;
        b=ayKzHysVkCDtUq3cBgGjGK8+Acwb3i+zsEqN6iMHrOwJ7eb9XV3q97z8fm3dlSNJ0KNWxr
        r81THeLtZsAJTwCg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
In-Reply-To: <20210304081142.digtkddajkadwwq5@linutronix.de>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <m1zgzj7uv2.fsf@fess.ebiederm.org> <20210304081142.digtkddajkadwwq5@linutronix.de>
Date:   Thu, 04 Mar 2021 16:02:05 +0100
Message-ID: <87tupr55ea.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04 2021 at 09:11, Sebastian Andrzej Siewior wrote:
> On 2021-03-03 16:09:05 [-0600], Eric W. Biederman wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>=20
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > Allow realtime tasks to cache one sigqueue in task struct. This avoids=
 an
>> > allocation which can increase the latency or fail.
>> > Ideally the sigqueue is cached after first successful delivery and wil=
l be
>> > available for next signal delivery. This works under the assumption th=
at the RT
>> > task has never an unprocessed signal while a one is about to be queued.
>> >
>> > The caching is not used for SIGQUEUE_PREALLOC because this kind of sig=
queue is
>> > handled differently (and not used for regular signal delivery).
>>=20
>> What part of this is about real time tasks?  This allows any task
>> to cache a sigqueue entry.
>
> It is limited to realtime tasks (SCHED_FIFO/RR/DL):
>
> +static void __sigqueue_cache_or_free(struct sigqueue *q)
> +{
> =E2=80=A6
> +	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
> +		kmem_cache_free(sigqueue_cachep, q);
> +}

We could of course do the caching unconditionally for all tasks.

Thanks,

        tglx
