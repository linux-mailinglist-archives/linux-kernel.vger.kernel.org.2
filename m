Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA53448D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhCVPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:08:39 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53912 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhCVPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:08:01 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lOM9j-0006sY-IL; Mon, 22 Mar 2021 11:07:47 -0400
Message-ID: <982f027e3a91b74cfa93e6fa91e2883d6c2f5dfd.camel@surriel.com>
Subject: Re: [PATCH v2] sched/fair: bring back select_idle_smt, but
 differently
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Mon, 22 Mar 2021 11:07:47 -0400
In-Reply-To: <20210322110306.GE3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
         <20210322110306.GE3697@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-G1wO/w/F3f45MZ65+Ih/"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G1wO/w/F3f45MZ65+Ih/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-22 at 11:03 +0000, Mel Gorman wrote:
> On Sun, Mar 21, 2021 at 03:03:58PM -0400, Rik van Riel wrote:
> >     Mel Gorman did some nice work in 9fe1f127b913
> >     ("sched/fair: Merge select_idle_core/cpu()"), resulting in the
> > kernel
> >     being more efficient at finding an idle CPU, and in tasks
> > spending less
> >     time waiting to be run, both according to the schedstats
> > run_delay
> >     numbers, and according to measured application latencies. Yay.
> >    =20
>=20
> Other than unusual indentation of the changelog, yey for part 1.
>=20
> >     The flip side of this is that we see more task migrations
> > (about
> >     30% more), higher cache misses, higher memory bandwidth
> > utilization,
> >     and higher CPU use, for the same number of requests/second.
> >    =20
>=20
> I am having difficulty with this part and whether this patch affects
> task
> migrations in particular.

Sorry, I should be more clear in the changelog for the
next version. Task migrations continue to be high with
this patch applied, but memory bandwidth and L2 cache
misses go back down, due to better cache locality.

> >     This is most pronounced on a memcache type workload, which saw
> >     a consistent 1-3% increase in total CPU use on the system, due
> >     to those increased task migrations leading to higher L2 cache
> >     miss numbers, and higher memory utilization. The exclusive L3
> >     cache on Skylake does us no favors there.
> >    =20
>=20
> Out of curiousity, what is the load generator for memcache or is this
> based on analysis of a production workload? I ask because mutilate
> (https://github.com/leverich/mutilate) is allegedly a load generator
> that can simulate FaceBook patterns but it is old. I would be
> interested
> in hearing if mutilate is used and if so, what parameters the load
> generator is given.

I had never heard of mutilate, I'll take a look at that.

I am running systems that get real production queries, but
at a higher average load than regular production systems.
Also, the same queries get replicated out to 3 systems on
the A and B side each, which seems to be enough to factor
out random noise for this workload.

> This is understandable because finding an idle CPU and incurring the
> migration cost can be better than stacking a task on a busy CPU for
> workloads that are sensitive to wakeup latency.

It absolutely is, most of the time. Our web servers have
"only" about 70k context switches/second on a 36 CPU system,
while the memcache style workload has about 170k context
switches/second on the same hardware.

> But this is the part I'm having a problem with. If the sibling of
> prev is
> idle then a task migration cost is still incurred. The main
> difference is
> that it's more likely to share a L1 or L2 cache and with no idle
> cores,
> some sharing of resources between HT siblings is inevitable.
>=20
> Can you confirm that task migrations are still higher with this
> patch?

They are higher. In fact, with my patch the number of task
migrations increases ever so slightly over what it is with
just your patches.  However, memory bandwidth used, and the
number of L2 cache misses go down.

> >     This fixes both the occasional 9% regression on the web serving
> >     workload, and the continuous 2% CPU use regression on the
> > memcache
> >     type workload.
> >    =20
> >     With Mel's patches and this patch together, the p95 and p99
> > response
> >     times for the memcache type application improve by about 20%
> > over what
> >     they were before Mel's patches got merged.
>=20
> Again, I would be very interested in hearing how this conclusion was
> reached because I can update mmtests accordingly and wire it into the
> "standard battery of scheduler workloads".

I monitor a number of different metrics during this test:
- number of task migrations
- number of context switches
- p95 & p99 application response latency
- memory bandwidth used
- L2 cache misses per 1000 instructions
- CPU utilization (total, user, system)
- the cpu_delay schedstat number

There are other metrics too, but these seem the most useful
ones.

With just your patches applied, I see an increase in:
- number of task migrations
- amount of CPU time used
- memory bandwidth & L2 cache misses
and a reduction in:
- cpu_delay
- p95 & p99 application response latency

With my patch on top, I continue to see the benefits in
the cpu_delay and application response latency metrics,
while the CPU time, memory bandwidth, and L2 cache miss
metrics all go back down.

I suspect this is an artifact of the L3 CPU cache on
Skylake being an eviction cache, rather than an
inclusive cache. When a task is moved from one CPU
core to another, it cannot load stuff from the L3
cache that hasn't yet been evicted from another CPU
core's L2 cache.

> >     Signed-off-by: Rik van Riel <riel@surriel.com>
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 794c2cb945f8..0c986972f4cd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6098,6 +6098,28 @@ static int select_idle_core(struct
> > task_struct *p, int core, struct cpumask *cpu
> >  	return -1;
> >  }
> > =20
> > +/*
> > + * Scan the local SMT mask for idle CPUs.
> > + */
> > +static int select_idle_smt(struct task_struct *p, struct
> > sched_domain *sd, int
> > +target)
> > +{
> > +	int cpu;
> > +
> > +	if (!static_branch_likely(&sched_smt_present))
> > +		return -1;
> > +
> > +	for_each_cpu(cpu, cpu_smt_mask(target)) {
> > +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> > +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> > +			continue;
> > +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > +			return cpu;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> >  #else /* CONFIG_SCHED_SMT */
> > =20
>=20
> Take a look at Barry's patch
> "!static_branch_likely(&sched_smt_present)". If that is applied first
> then
> you can remove the static_branch_likely check here as it'll be
> covered
> by an earlier test_idle_cores() call.
>=20
> As the ordering is not known, just note that it's a potential follow-
> up
> if Barry's patch was merged after yours.

I'll keep an eye out for those.

> > +	if (!smt && cpus_share_cache(prev, target)) {
> > +		/* No idle core. Check if prev has an idle sibling. */
> > +		i =3D select_idle_smt(p, sd, prev);
> > +		if ((unsigned int)i < nr_cpumask_bits)
> > +			return i;
> > +	}
> > +
> >  	for_each_cpu_wrap(cpu, cpus, target) {
> >  		if (smt) {
> >  			i =3D select_idle_core(p, cpu, cpus, &idle_cpu);
>=20
> Please consider moving this block within the SIS_PROP && !smt check
> above. It could become something like

I'll try that right now. That is a nice cleanup, and
potential optimization.

> Second, select_idle_smt() does not use the cpus mask so consider
> moving
> the cpus initialisation after select_idle_smt() has been called.
> Specifically this initialisation
>=20
> 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>=20
> Alternatively, clear the bits in the SMT sibling scan to avoid
> checking
> the siblings twice. It's a tradeoff because initialising and clearing
> bits is not free and the cost is wasted if a sibling is free.

If we're doing that, should we also clear "target" and "prev"
from the mask?  After all, we might scan those twice with
the current code...

> A third concern, although it is mild, is that the SMT scan ignores
> the
> SIS_PROP limits on the depth search. This patch may increase the scan
> depth as a result. It's only a mild concern as limiting the depth of
> a
> search is a magic number anyway.=20

Agreed, placing the search inside the SIS_PROP block is
going to clip the search differently than placing it
outside, too.

Probably no big deal, but I'll push a kernel with
that change into the tests, anyway :)

> Otherwise, the biggest difference from historical behaviour is that
> we are
> explicitly favouring SMT siblings when !idle_cores and !idle_cores
> can
> be inaccurate. That is going to be a "win some, lose some" scenario
> and
> might show up in overloaded workloads that rapidly idle (e.g.
> hackbench).
> I don't have a strong opinion on this one because *some* HT sibling
> is going to be used and it's workload and hardware dependant what the
> impact is.
>=20
> I think I'll run this through a short run of some scheduler loads but
> I'll wait to see if you decide to create another version based on
> this
> review.

I'll make the changes you suggested right now, and will
kick off a test. If things go as expected, I'll send out
a v3 in a few hours :)

--=20
All Rights Reversed.

--=-G1wO/w/F3f45MZ65+Ih/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBYssMACgkQznnekoTE
3oOZWQf/eFzs6KFl+kyj0MQVcvnWpOp9rwSU2AD3No+6VClZxPTPUkK4YGtqaucp
7lJKa9YGRADCu+RB09n/qanSbvATQj3TMIGKO11xbinxp2x1M88+ls/t+3IcYkER
XLWSGdn+1OgoywKSm/rzQl4hTFQ89cNIOIERnUGZOOiGOI87KraeSYR683037BSo
qR7lYjanSZoK3QwuCdrXA+2wca+WuRHHNoFdAm+dCJKZ0glUPM5GvqtanHV5+V2R
ojLzlU7nWM9Kq11gaRy3l1ox92CLZ9h8sGrfTAmoWHgdr0Hxx6y6eA85KFNUyv9y
Y0KO2M0g0UN2afyNed5tjmm+DU8Fag==
=9Hx+
-----END PGP SIGNATURE-----

--=-G1wO/w/F3f45MZ65+Ih/--

