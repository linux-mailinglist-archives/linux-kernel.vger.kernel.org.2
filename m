Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDF368525
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhDVQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:47:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35582 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhDVQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:47:43 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lZcTl-00088P-I4; Thu, 22 Apr 2021 12:47:01 -0400
Message-ID: <416c515026af10cc913a83bc72c18aeb296c6583.camel@surriel.com>
Subject: Re: [PATCH v3] sched,fair: skip newidle_balance if a wakeup is
 pending
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Thu, 22 Apr 2021 12:47:01 -0400
In-Reply-To: <CAKfTPtBogNs1uVoTmiNj0Xw57ZsJ0DS-pas-gA67E79CXvHR5w@mail.gmail.com>
References: <20210420120705.5c705d4b@imladris.surriel.com>
         <CAKfTPtCcS_bNUi-KwspHssabORupj9K8Y=+Hc7nOzr9JBK-8AA@mail.gmail.com>
         <CAKfTPtBogNs1uVoTmiNj0Xw57ZsJ0DS-pas-gA67E79CXvHR5w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yCBy0EHXV/dXifHXfKvy"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yCBy0EHXV/dXifHXfKvy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-04-22 at 10:37 +0200, Vincent Guittot wrote:
> On Wed, 21 Apr 2021 at 19:27, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >=20
> > > -       if (pulled_task)
> > > +       /*
> > > +        * If we are no longer idle, do not let the time spent
> > > here pull
> > > +        * down this_rq->avg_idle. That could lead to
> > > newidle_balance not
> > > +        * doing enough work, and the CPU actually going idle.
> > > +        */
> > > +       if (pulled_task || this_rq->ttwu_pending)
> >=20
> I confirmed that the line above generate hackbench regression on my
> large arm64 system (2 * 112 CPUs)
> I'm testing hackbench with various number of group : 1, 2, 4, 16, 32,
> 64, 128, 256 but I have only put the 2 results which significantly
> regress. The other ones are in the +/-1% variation range
>=20
> hackbench -g $group
>=20
> group    v5.12-rc8+tip    w/ this patch          w/ this patch
> without
> the line above
> 64       2.862(+/- 9%)    2.952(+/-11%) -3%      2.807(+/- 7%) +2%
> 128      3.334(+/-10%)    3.561-+/-13%) -7%      3.181(+/- 6%) +4%

OK, I guess this part of the patch needs additional work.

I'll send a v4 with just the first two changes.

Thank you for running those tests.

--=20
All Rights Reversed.

--=-yCBy0EHXV/dXifHXfKvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmCBqIUACgkQznnekoTE
3oOUmgf/Z/szhtFna60CfwqqA2THsv3i0ehF+f4r1z7Y9HSkk3YSKcdfutPXIUOU
kBrkd7+mns5HS8iVsmeIHB6LjyPtfARpqgVWIS9yF+6LWL7mU18yTABwjFFu0wk0
Dgr2SbNkRvTtqin93k4bPvA3FQhH3yx+Zn5+4qt72zy7aJcb9FJTruxQ8PZFctge
ApHrxhTvZlFjx9sbakHiVpD6KoCWlJJoa8CNosPsDhZyi8spUNsfUybOb5XR9C5X
AS00AcYwzRdKJYAcVptLUv7Nn6ikqVZb/WvG4k7vDok7yXueKKEejcEpoI3MXL76
Ad8UIoASVdzpXD0NlzKP9Yc4f7bihA==
=dEQ8
-----END PGP SIGNATURE-----

--=-yCBy0EHXV/dXifHXfKvy--

