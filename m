Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5148355891
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbhDFPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:55:21 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32994 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbhDFPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:55:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lTo2i-0004dy-In; Tue, 06 Apr 2021 11:55:04 -0400
Message-ID: <300f7c0dac300e2c3a8dc7f57fd0a834383152ff.camel@surriel.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Tue, 06 Apr 2021 11:55:04 -0400
In-Reply-To: <CAKfTPtC2Cnr=SoD9t+dLh01ux_bc8PAcHTXxxiBqbqykLphBNw@mail.gmail.com>
References: <20210321150358.71ef52b1@imladris.surriel.com>
         <20210322110306.GE3697@techsingularity.net>
         <20210326151932.2c187840@imladris.surriel.com>
         <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
         <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
         <CAKfTPtC2Cnr=SoD9t+dLh01ux_bc8PAcHTXxxiBqbqykLphBNw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NYV5dbC0D0m5tD/Dk91k"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NYV5dbC0D0m5tD/Dk91k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-04-06 at 17:31 +0200, Vincent Guittot wrote:
> On Tue, 6 Apr 2021 at 17:26, Rik van Riel <riel@surriel.com> wrote:
> > On Tue, 2021-04-06 at 17:10 +0200, Vincent Guittot wrote:
> > > On Fri, 26 Mar 2021 at 20:19, Rik van Riel <riel@surriel.com>
> > > wrote:
> > >=20
> > > > -static int select_idle_cpu(struct task_struct *p, struct
> > > > sched_domain *sd, int target)
> > > > +static int select_idle_cpu(struct task_struct *p, struct
> > > > sched_domain *sd, int prev, int target)
> > > >  {
> > > >         struct cpumask *cpus =3D
> > > > this_cpu_cpumask_var_ptr(select_idle_mask);
> > > >         int i, cpu, idle_cpu =3D -1, nr =3D INT_MAX;
> > > > @@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct
> > > > task_struct *p, struct sched_domain *sd, int t
> > > >=20
> > > >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > >=20
> > > > -       if (sched_feat(SIS_PROP) && !smt) {
> > > > -               u64 avg_cost, avg_idle, span_avg;
> > > > +       if (!smt) {
> > > > +               if (cpus_share_cache(prev, target)) {
> > >=20
> > > Have you checked the impact on no smt system ? would worth a
> > > static
> > > branch.
> > >=20
> > > Also, this doesn't need to be in select_idle_cpu() which aims to
> > > loop
> > > the sched_domain becaus you only compare  target and prev. So you
> > > can
> > > move this call to select_idle_smt() in select_idle_sibling()
> >=20
> > After Mel's rewrite, there no longer are calls to
> > select_idle_core() or select_idle_smt() in select_idle_sibling().
>=20
> select_idle_smt() had even disappeared that why it was not in
> select_idle_sibling
>=20
> > Everything got folded into one single loop in select_idle_cpu()
>=20
> but this is done completely out of the loop so we don't need to
> complify the function with unrelated stuff

Not entirely. The call to select_idle_smt() is still
conditional on test_idle_cores() returning false.

We only look for the
other sibling if there is no idle
core in the LLC. If there is an idle core, we prefer
that.

Pulling the select_idle_smt() call out of select_idle_cpu()
would mean having to test_idle_cores() twice.

--=20
All Rights Reversed.

--=-NYV5dbC0D0m5tD/Dk91k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBshFgACgkQznnekoTE
3oNrewf/T4EWCI5gom5mJ6zioL9OD9wLkbJK5aZ1UNWk8v7YK5AZNKzouBFbRoET
HalJzBdqOpyeq68f/KPCN+8A2RiEwYXAZGH29IixJ7YKw0kvAvtOc7gYPANpleVp
zcO9AeOy/W1zzrTp/jch0jUTrmd4p+pEfvfoo7hBSYko5WWM9K09/ZQ08jcweGC/
rq2kfzjb3LESum/WvCTsWUOF2ogcWoOHF1PxxgoqC71DMYhfmxTJWT5vs/BHKKxu
WiS8lHpVb1CQgtXn16k4OJ5x5M589oHdld42Pxf0FcLuKbg222/YylQtIjTkXIUC
pyDg1YbRAtiKU1qLdp72mG2vlObinw==
=OSDL
-----END PGP SIGNATURE-----

--=-NYV5dbC0D0m5tD/Dk91k--

