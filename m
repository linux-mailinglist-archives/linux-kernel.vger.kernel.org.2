Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651B345550
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCWCIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:08:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45556 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCWCIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:08:20 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lOWSl-0000Ym-R8; Mon, 22 Mar 2021 22:08:07 -0400
Message-ID: <b81a0e641e6724c8aaf5b6a4b32fa4b550ecbbcd.camel@surriel.com>
Subject: Re: [PATCH v2] sched/fair: bring back select_idle_smt, but
 differently
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Mon, 22 Mar 2021 22:08:07 -0400
In-Reply-To: <20210322153320.GG3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
         <20210322110306.GE3697@techsingularity.net>
         <982f027e3a91b74cfa93e6fa91e2883d6c2f5dfd.camel@surriel.com>
         <20210322153320.GG3697@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xyUnV8fuVxsgGLSghDhF"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xyUnV8fuVxsgGLSghDhF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-22 at 15:33 +0000, Mel Gorman wrote:

> If trying that, I would put that in a separate patch. At one point
> I did play with clearing prev, target and recent but hit problems.
> Initialising the mask and clearing them in select_idle_sibling() hurt
> the fast path and doing it later was not much better. IIRC, the
> problem
> I hit was that the cost of clearing multiple CPUs before the search
> was
> not offset by gains from a more efficient search.

I'm definitely avoiding the more expensive operations,
and am only using __cpumask_clear_cpu now :)

> If I had to guess, simply initialising cpumask after calling
> select_idle_smt() will be faster for your particular case because you
> have a reasonable expectation that prev's SMT sibling is idle when
> there
> are no idle cores. Checking if prev's sibling is free when there are
> no
> idle cores is fairly cheap in comparison to a cpumask initialisation
> and
> partial clearing.
>=20
> If you have the testing capacity and time, test both.

Kicking off more tests soon. I'll get back with a v3 patch
on Wednesday.

--=20
All Rights Reversed.

--=-xyUnV8fuVxsgGLSghDhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBZTYcACgkQznnekoTE
3oPAYgf/ba0Cr42MT2tVn5FYSjaj8HD4oiYVei3lxUFEG03l5UtmLbuAyvCusD/6
74gkW7wHHWTKQvled5FAi/rNHz9RR1vxciPaXfxchUeCrm6dK6Pf2iRTAkCFQQP1
noNjA9JCkj6JX7V+dEBa2Suyh5su1IN4NkQh6ZeqIJdxR7zol336pf2P8QBFQ4Sb
J7GAWVHEhndG8oXlGAqpCcy+32a1Jvd/5r2KbESO/ka9a3Py0CGMY5NPXTaTdZsx
EVZSvp/qLBoIUgVwIzOJZNBqirDpJzv0oOLQBGjs0ZGgP3EqEITjA9kPefNjCvXD
nt9uFXEvWXW3pgk8Yid3zYzkmrC1Ug==
=FUHx
-----END PGP SIGNATURE-----

--=-xyUnV8fuVxsgGLSghDhF--

