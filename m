Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291E034343A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhCUS6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:58:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33544 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCUS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:58:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lO3HQ-0000v7-AY; Sun, 21 Mar 2021 14:58:28 -0400
Message-ID: <fdf9d6bc50200e5b955b7ff77a8046e1ea09c284.camel@surriel.com>
Subject: Re: [PATCH] sched/fair: bring back select_idle_smt, but differently
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Sun, 21 Mar 2021 14:58:27 -0400
In-Reply-To: <20210321144832.36f31f3e@imladris.surriel.com>
References: <20210321144832.36f31f3e@imladris.surriel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5buy7KC4vm2xwfWl320E"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5buy7KC4vm2xwfWl320E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2021-03-21 at 14:48 -0400, Rik van Riel wrote:
>=20
> +	if (cpus_share_cache(prev, target)) {
> +		/* No idle core. Check if prev has an idle sibling. */
> +		i =3D select_idle_smt(p, sd, prev);

Uh, one minute. This is the wrong version of the patch.

There's supposed to be a !smt && in there as well. I first
merged it right, then somehow git ate it, and I merged it
wrong the second time. Sigh.

--=20
All Rights Reversed.

--=-5buy7KC4vm2xwfWl320E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBXl1MACgkQznnekoTE
3oMQzwgAmmBAhKhZ6RvAFft6hiwHVeeIp+Ei/0yLIBhEhgztOcjSFgIQExnvjX15
vFlHhP1FKJfZt7L4R4wvlHyqxm1yL3XryvJxC/7+GNClOA9kRpn4GsEGImqP4z0s
/VeZEeoQ40IXca2T+sKay0HCOPj+wFjOse7NakG2NN+E3FUGp/uGVBHHQ138Ppm4
QBn5ZmNxFNhbJlNjboRumKJ70oOCafsiwVg1TlMWW3ri2UE0UI2eF3ZTuI9pRLa7
jiw/190jBq0WFEnzFCiOsqACH/xuSt3rQQjljudr+MoFeDq5EG60Q66sGSM9iC6l
i8HvAwSzfQvDtX2bjna4lZPS8JmyCg==
=KWt5
-----END PGP SIGNATURE-----

--=-5buy7KC4vm2xwfWl320E--

