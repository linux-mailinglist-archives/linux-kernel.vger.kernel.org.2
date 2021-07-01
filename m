Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560CE3B98E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 01:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhGAXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 19:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGAXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:22:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7AC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 16:20:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so7761030pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=WrlHNvkWBfLqct419PX+TWu2ul7w1zH8nd0KZgngHm4=;
        b=Kw+isHpbjpzrGdTJxpiPJQvZBcAO2G15/dCzDQ6FPjdtpu2Y2ywKJt27CBt3uRaGHn
         3ONd8+YtgPTPIHpInenrFRTZf11e0KwP6FX60PrJx8sIVRb/3g/OABYmYs/D6c3mW5of
         2QvLCpJ3ddQOzKi9rbbr/RVKn11XTLnYCPOcPYTZ452rkXuVNeexbPBEgDv2RVl7+Sra
         VdUQ/mS5Xi7qpZN4y+Lg4WfQhazKJfzNr4wAzef5S3ODJFUlVCcZX445GysiP0KKGa71
         Rt5cnuZdDhQ7SaK5JmYwBHKG9UEqwgzimju8vWRX5voUObsy187ixjXZJaidGHWS0BQ0
         e4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=WrlHNvkWBfLqct419PX+TWu2ul7w1zH8nd0KZgngHm4=;
        b=rWOklwV519LMeN9mCQsVzFHkgy5bkTfuIsWSQxb4z6E5BE0pBzen/uT/kxDfLQnaPG
         KFZ+Qfl5yb9ZgUY5rIPv0kZGayRwNlDiDFJr6ogwsxyp4DzfM5cBXUa2jGcFkib8RHPW
         4GsgG32YGd81Kg0sqdK83IbZgwdab/hx52faDWgW46A4QMH+19MN/YoX6vHwZVSSZCpX
         XZcZli4uFqgIOBfsByTvpznmxzPMzCdLJnYAnMdfKGa5pKsomkTucvHoFL8ixrTUYp8c
         zEXHe2ahcjWRW87kAoq5NqccDSGv0d5XCTGUYkefO8HShZ3aR8bEhZ8cLMQETBnoyuq0
         OiXw==
X-Gm-Message-State: AOAM532M02fnaZNHvAAl8/HIWelkhrhZexRqK27hInUEEXUWM8ZQNf1X
        FJPiZruFpk3RztAmlWSyy0U=
X-Google-Smtp-Source: ABdhPJxUwwkOTbetuYdlNHIfm/urdyY7BYf4UWi2Mb7Tl9Wk5aI1LxtBiE3VO4TKZFwH69oulzBxcA==
X-Received: by 2002:aa7:9e43:0:b029:301:c40f:de25 with SMTP id z3-20020aa79e430000b0290301c40fde25mr2048242pfq.59.1625181615441;
        Thu, 01 Jul 2021 16:20:15 -0700 (PDT)
Received: from localhost ([118.209.250.144])
        by smtp.gmail.com with ESMTPSA id a23sm1138816pfk.146.2021.07.01.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:20:15 -0700 (PDT)
Date:   Fri, 02 Jul 2021 09:20:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] nohz: nohz idle balancing per node
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210701055323.2199175-1-npiggin@gmail.com>
        <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
In-Reply-To: <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1625180528.uxc53b2kbi.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 1, 2021 8:18 pm:
> On Thu, Jul 01, 2021 at 03:53:23PM +1000, Nicholas Piggin wrote:
>> Currently a single nohz idle CPU is designated to perform balancing on
>> behalf of all other nohz idle CPUs in the system. Implement a per node
>> nohz balancer to minimize cross-node memory accesses and runqueue lock
>> acquisitions.
>>=20
>> On a 4 node system, this improves performance by 9.3% on a 'pgbench -N'
>> with 32 clients/jobs (which is about where throughput maxes out due to
>> IO and contention in postgres).
>=20
> Hmm, Suresh tried something like this around 2010 and then we ran into
> trouble that when once node went completely idle and another node was
> fully busy, the completely idle node would not run ILB and the node
> would forever stay idle.

I've only changed which CPU runs ilb on behalf of others, not how the=20
balancing is done.

If one node is idle, then one of the CPUs in that node will be the nohz
balancer for the others in that node. In any other respect, the=20
balancing will be done the same as if the nohz balancer was on a=20
different node. So I don't see how it could get into that situation=20
unless I have a bug. Maybe Suresh's patch was doing something different.

> I've not gone through the code to see if that could still happen -- lots
> has changed since, but it is something to consider.
>=20
> Some further nits below..
>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fb469b26b00a..832f8673bba1 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5722,13 +5722,27 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>> =20
>>  #ifdef CONFIG_NO_HZ_COMMON
>> =20
>> -static struct {
>> +struct nohz {
>>  	cpumask_var_t idle_cpus_mask;
>>  	atomic_t nr_cpus;
>>  	int has_blocked;		/* Idle CPUS has blocked load */
>>  	unsigned long next_balance;     /* in jiffy units */
>>  	unsigned long next_blocked;	/* Next update of blocked load in jiffies =
*/
>> -} nohz ____cacheline_aligned;
>> +} ____cacheline_aligned;
>> +
>> +static struct nohz **nohz_nodes __ro_after_init;
>> +
>> +static struct nohz *get_nohz(void)
>> +{
>> +#ifdef CONFIG_CPU_ISOLATION
>> +	/*
>> +	 * May not have a house keeping CPU per node, do global idle balancing=
.
>> +	 */
>> +	if (static_branch_unlikely(&housekeeping_overridden))
>> +		return nohz_nodes[0];
>> +#endif
>> +	return nohz_nodes[numa_node_id()];
>> +}
>=20
> *urgh* I'm not a fan of that isolation/hk behaviour. Even when the HK
> mask allows for a CPU per node, this code won't DTRT. Do we want a
> KERN_INFO message that performance will suffer here?

IIRC it turned out to be non-trivial to work out the housekeeping vs=20
online CPUs but it might be doable later.

I'm not sure about a printk, that would just fire every time. Maybe a=20
generic printk or something in the docs to say housekeeping can affect
performance of non-isolated CPUs so make sure you measure.

>=20
>>  #endif /* CONFIG_NO_HZ_COMMON */
>> =20
>> @@ -10291,14 +10305,14 @@ static void nohz_balancer_kick(struct rq *rq)
>>  	 * None are in tickless mode and hence no need for NOHZ idle load
>>  	 * balancing.
>>  	 */
>> -	if (likely(!atomic_read(&nohz.nr_cpus)))
>> +	if (likely(!atomic_read(&get_nohz()->nr_cpus)))
>>  		return;
>> =20
>> -	if (READ_ONCE(nohz.has_blocked) &&
>> -	    time_after(now, READ_ONCE(nohz.next_blocked)))
>> +	if (READ_ONCE(get_nohz()->has_blocked) &&
>> +	    time_after(now, READ_ONCE(get_nohz()->next_blocked)))
>>  		flags =3D NOHZ_STATS_KICK;
>> =20
>> -	if (time_before(now, nohz.next_balance))
>> +	if (time_before(now, get_nohz()->next_balance))
>>  		goto out;
>> =20
>>  	if (rq->nr_running >=3D 2) {
>=20
> Also, stuff like the above, will result in horrific code-gen, because
> it cannot CSE get_nohz().
>=20

It was somewhat mechanical conversion. I could use a local variable for=20
a couple of these cases.

Thanks,
Nick
