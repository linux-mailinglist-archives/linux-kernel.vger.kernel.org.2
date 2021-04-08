Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34433588E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhDHPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:52:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60936 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhDHPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:52:43 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lUWxD-00079r-2v; Thu, 08 Apr 2021 11:52:23 -0400
Message-ID: <f11b6fe58424edc8a72464b5ffa7842a5aa214f4.camel@surriel.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Thu, 08 Apr 2021 11:52:22 -0400
In-Reply-To: <YG2HPUfrb0YyB1SG@hirez.programming.kicks-ass.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
         <20210322110306.GE3697@techsingularity.net>
         <20210326151932.2c187840@imladris.surriel.com>
         <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
         <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
         <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
         <20210407094217.GA2926@vingu-book>
         <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net>
         <YG2HPUfrb0YyB1SG@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9wDzU0QRkGGAPp3JncBt"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9wDzU0QRkGGAPp3JncBt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-07 at 12:19 +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 11:54:37AM +0200, Peter Zijlstra wrote:
>=20
> > Let me have another poke at it.
>=20
> Pretty much what you did, except I also did s/smt/has_idle_core/ and
> fixed that @sd thing.
>=20
> Like so then?

Looks good to me. Thank you.

--=20
All Rights Reversed.

--=-9wDzU0QRkGGAPp3JncBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBvJrYACgkQznnekoTE
3oP9xAf+JvfHGl8oTlAgGnS+XPW0xHA+DOC9OLgtarfgf8leZH3SOgIPxL3jotDN
baw+ICV8L1Z1fTr2gSyt7aybpiOTE48o9+MPBFs0ZcQjFG0SXhn7YVhWWn/otPC4
aXvesK/QsyTHVCMiTyheBhfQ/OkwUC0nINseaNag3nxzlfC+JM+Z3jLsCVoHyW7E
EpJNBBikhDNRoF/8xAQUuPK0+FrfJnVyp2TLV+4NM2Do4E6Wb5/Ne5WTvYXjwzMH
p5JOx4OIfIWsJR6XM5Samn6aTu8fFRJ7CpY9LpYsYf9BPgzQbjtl3puQBWTJ99Q3
t8S+upU8L+80SPnwHkfmE9H/R4vTpw==
=98tH
-----END PGP SIGNATURE-----

--=-9wDzU0QRkGGAPp3JncBt--

