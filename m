Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D7382573
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhEQHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:39:27 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:53302 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEQHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:39:26 -0400
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 4BD67B9DCFB;
        Mon, 17 May 2021 09:38:09 +0200 (CEST)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id ltGXZ89Y7-mn; Mon, 17 May 2021 09:38:08 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:3d80:4187:1735:8dd9])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Mon, 17 May 2021 09:38:08 +0200 (CEST)
Subject: Re: [PATCH] [v2] printf: fix errname.c list
To:     Arnd Bergmann <arnd@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210514213456.745039-1-arnd@kernel.org>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <1986de34-bd7f-3a74-5cf9-d1efceb0ff54@kleine-koenig.org>
Date:   Mon, 17 May 2021 09:38:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514213456.745039-1-arnd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AZ5x7BOcwfp4S4aFbQZeC0xRw6VJKvlCl"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AZ5x7BOcwfp4S4aFbQZeC0xRw6VJKvlCl
Content-Type: multipart/mixed; boundary="oyrrUHCpA4h6R8smJICWrwbB9DYAjeXDs";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Arnd Bergmann <arnd@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Message-ID: <1986de34-bd7f-3a74-5cf9-d1efceb0ff54@kleine-koenig.org>
Subject: Re: [PATCH] [v2] printf: fix errname.c list
References: <20210514213456.745039-1-arnd@kernel.org>
In-Reply-To: <20210514213456.745039-1-arnd@kernel.org>

--oyrrUHCpA4h6R8smJICWrwbB9DYAjeXDs
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On 5/14/21 11:34 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> On most architectures, gcc -Wextra warns about the list of error
> numbers containing both EDEADLK and EDEADLOCK:
>=20
> lib/errname.c:15:67: warning: initialized field overwritten [-Woverride=
-init]
>     15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <=3D 0 || err > 30=
0)] =3D "-" #err
>        |                                                               =20
   ^~~
> lib/errname.c:172:2: note: in expansion of macro 'E'
>    172 |  E(EDEADLK), /* EDEADLOCK */
>        |  ^
>=20
> On parisc, a similar error happens with -ECANCELLED, which is an
> alias for ECANCELED.
>=20
> Make the EDEADLK printing conditional on the number being distinct
> from EDEADLOCK, and remove the -ECANCELLED bit completely as it
> can never be hit.
>=20
> To ensure these are correct, add static_assert lines that verify
> all the remaining aliases are in fact identical to the canonical
> name.
>=20
> Fixes: 57f5677e535b ("printf: add support for printing symbolic error n=
ames")
> Cc: Petr Mladek <pmladek@suse.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM
Acked-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Thanks
Uwe


--oyrrUHCpA4h6R8smJICWrwbB9DYAjeXDs--

--AZ5x7BOcwfp4S4aFbQZeC0xRw6VJKvlCl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCiHVwACgkQwfwUeK3K
7Alr4Qf/ZcaLwlAUdig5CT2zlGUiapijstlmSlpZGXWKtNdvUR6r5qr7Ht0aIVqx
jiuoBOF8hrX6esuzvMT1XazzTYqpbE97eso+WhtQxRJjT67Ff1jqc7Xg0N+HCza5
HayawabjniL+6/wzVOAplUv5tlAhJJnSgsA0OUW+OCkfivhGjqdF1+h6OjEmucb1
9b5xFv81aqFO1FU6Kr0pDNzlw293MDTlw2FpxpdxvLeURSgAUQyTiTq6lNCCPP3o
hNFyeVFGMGlnW0XVKWY9Fosl6FfDmrgeHFGXqgboFtmDiQ4vGaKtYt5zOFwvjXu7
U8HNUzB42rOq0PmmCI5VLKtQ0qcMbA==
=65tb
-----END PGP SIGNATURE-----

--AZ5x7BOcwfp4S4aFbQZeC0xRw6VJKvlCl--
