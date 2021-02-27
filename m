Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B811326ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhB0T5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 14:57:11 -0500
Received: from shelob.surriel.com ([96.67.55.147]:40756 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB0T5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 14:57:02 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lG5hA-0003pP-16; Sat, 27 Feb 2021 14:56:08 -0500
Message-ID: <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
From:   Rik van Riel <riel@surriel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Date:   Sat, 27 Feb 2021 14:56:07 -0500
In-Reply-To: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-p2iMuyud8R1l++kK4rlj"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p2iMuyud8R1l++kK4rlj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-26 at 22:10 +0530, Srikar Dronamraju wrote:

> Current order of preference to pick a LLC while waking a wake-affine
> task:
> 1. Between the waker CPU and previous CPU, prefer the LLC of the CPU
>    that is idle.
>=20
> 2. Between the waker CPU and previous CPU, prefer the LLC of the CPU
>    that is less lightly loaded.
>=20
> In the current situation where waker and previous CPUs are busy, but
> only one of its LLC has an idle CPU, Scheduler may end up picking a
> LLC
> with no idle CPUs. To mitigate this, add a new step between 1 and 2
> where Scheduler compares idle CPUs in waker and previous LLCs and
> picks
> the appropriate one.

I like that idea a lot. That could also solve some of the
issues sometimes observed on multi-node x86 systems, and
probably on the newer AMD chips with several LLCs on chip.

> +	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> +		return this_cpu;

I wonder if we need to use a slightly lower threshold on
very large LLCs, both to account for the fact that the
select_idle_cpu code may not find the single idle CPU
among a dozen busy ones, or because on a system with
hyperthreading we may often be better off picking another
LLC for HT contention issues?

Maybe we could use "tnr_busy * 4 <
tllc_size * 3" or
something like that?

That way we will only try to find the last 5 idle
CPUs
in a 22 CPU LLC if the other LLC also has fewer than 6
idle cores.

That might increase our chances of finding an idle CPU
with SIS_PROP enabled, and might allow WA_WAKER to be
true by default.

> +	/* For better wakeup latency, prefer idler LLC to cache
> affinity */
> +	diff =3D tnr_busy * pllc_size - sync - pnr_busy * tllc_size;
> +	if (!diff)
> +		return nr_cpumask_bits;
> +	if (diff < 0)
> +		return this_cpu;
> +
> +	return prev_cpu;
> +}

--=20
All Rights Reversed.

--=-p2iMuyud8R1l++kK4rlj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmA6o9cACgkQznnekoTE
3oOwmQf5AcNEkODl1mcUA9dumuWDRBi4LvyhOEXhI2llLN9yZMzvNW9n/2rLLEX3
freYfyTjKB4reIXFydXQiHFOetlsudfgxszGYVroyXVse8IG0p+qxlVzc1Z/s8aO
PFKu+wG9kShkA7LX4OaWFPCsnse3/eO3IEfPIbWyaMn8/+karmKBdtgqCCdEpAt8
rG5HWI5ta5dfpOvuFBJReBe+0vYLhCXvClMJeL4Hg+8eSlHuL6OOtGQ+NX7gD6Ma
500P1NrpsfY0QMSALfjaqr0fdw2aIexVk8nt3Pf/oMzwwdk9AEkq59ln7xzALriq
Fez+fUFI5PlCkUyGow2YU9B1Cukeaw==
=PQF9
-----END PGP SIGNATURE-----

--=-p2iMuyud8R1l++kK4rlj--

