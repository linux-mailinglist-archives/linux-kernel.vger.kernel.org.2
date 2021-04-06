Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF03557B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345639AbhDFP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:26:53 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32874 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbhDFP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:26:52 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lTnbC-0003Pk-GU; Tue, 06 Apr 2021 11:26:38 -0400
Message-ID: <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
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
Date:   Tue, 06 Apr 2021 11:26:37 -0400
In-Reply-To: <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
References: <20210321150358.71ef52b1@imladris.surriel.com>
         <20210322110306.GE3697@techsingularity.net>
         <20210326151932.2c187840@imladris.surriel.com>
         <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-h2yb9mmylf3PhyRBn23s"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h2yb9mmylf3PhyRBn23s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-04-06 at 17:10 +0200, Vincent Guittot wrote:
> On Fri, 26 Mar 2021 at 20:19, Rik van Riel <riel@surriel.com> wrote:
>=20
> > -static int select_idle_cpu(struct task_struct *p, struct
> > sched_domain *sd, int target)
> > +static int select_idle_cpu(struct task_struct *p, struct
> > sched_domain *sd, int prev, int target)
> >  {
> >         struct cpumask *cpus =3D
> > this_cpu_cpumask_var_ptr(select_idle_mask);
> >         int i, cpu, idle_cpu =3D -1, nr =3D INT_MAX;
> > @@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct
> > task_struct *p, struct sched_domain *sd, int t
> >=20
> >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >=20
> > -       if (sched_feat(SIS_PROP) && !smt) {
> > -               u64 avg_cost, avg_idle, span_avg;
> > +       if (!smt) {
> > +               if (cpus_share_cache(prev, target)) {
>=20
> Have you checked the impact on no smt system ? would worth a static
> branch.
>=20
> Also, this doesn't need to be in select_idle_cpu() which aims to loop
> the sched_domain becaus you only compare  target and prev. So you can
> move this call to select_idle_smt() in select_idle_sibling()

After Mel's rewrite, there no longer are calls to
select_idle_core() or select_idle_smt() in select_idle_sibling().

Everything got folded into one single loop in select_idle_cpu()

I would be happy to pull the static branch out of select_idle_smt()
and place it into this if condition, though. You are right that
would save some overhead on non-smt systems.

Peter, would you prefer a follow-up patch for that or a version 4
of the patch?

--=20
All Rights Reversed.

--=-h2yb9mmylf3PhyRBn23s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBsfa4ACgkQznnekoTE
3oPVdwgAknAH01IMA1aQ5Y2oSZ6UL5PULzo4l3LekWhtXcBFnpezYdxo/Ya+a2lL
ykdmlvDGVyu1UL42Qi59KWb/0licduWdV35mItRg3OJrHaY7JONAJf70fqExBhYc
ZTnyn0O6wsrAFJWjphOEs3Ksw1D/FsiTvUtf28gAK2F94qvyng4wDdnA2FoK/rFQ
gswLeNK8hII4UPFeFMszvPwLBRvZoSE3njNRhA/Ly9INmFmfxRjIHrvciDDnGJKx
Gb5KqP9zr3Xs8C1Zw2AZfSd05hdoWcKQqH99oTE7lFqbN7w5OeK427ZHGzQ2Mkrs
JzqofUv0hmKMzKzYadeHavEQ8KLLOA==
=IISW
-----END PGP SIGNATURE-----

--=-h2yb9mmylf3PhyRBn23s--

