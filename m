Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6C3CEDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386404AbhGSTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:33:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48326 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383807AbhGSSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:54:12 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1m5Z2E-0003Gd-IN; Mon, 19 Jul 2021 15:34:38 -0400
Message-ID: <a9f568139f0bd82cc8460c2c4f831f03a74f2a89.camel@surriel.com>
Subject: Re: [PATCH] x86,mm: print likely CPU at segfault time
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Date:   Mon, 19 Jul 2021 15:34:38 -0400
In-Reply-To: <c8e023cb-6f50-36f5-65d4-c5e25b264029@intel.com>
References: <20210719150041.3c719c94@imladris.surriel.com>
         <c8e023cb-6f50-36f5-65d4-c5e25b264029@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-l5bQu8+DJCBx325/Mnpg"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l5bQu8+DJCBx325/Mnpg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-07-19 at 12:20 -0700, Dave Hansen wrote:

> If it's as trivial as:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printk(KERN_CONT " on cpu=
/core %d/%d",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0raw_smp_processor_id(),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0topology_core_id(raw_smp_processor_id()));
>=20
> it would be handy.=C2=A0 But, it's also not hard to look at 10 segfaults,
> see
> that they happened only on 2 CPUs and realize that hyperthreading is
> enabled.

One problem with topology_core_id() is that that, on a
multi-socket system, the core number may not be unique.

That is why I ended up going with just the CPU number.
It's pretty easy to put one and one together afterwards.

Thanks for your quick patch review.

--=20
All Rights Reversed.

--=-l5bQu8+DJCBx325/Mnpg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmD1084ACgkQznnekoTE
3oMZwQf/dqGU0jn2GOBPnw0rMkRskRrmxg0yleYt5P2UKFatS3hTKRNCQVBg10pL
5BA6gsz2yk/oSHc/188BCjcW8KcWdq21obf9oxflp0w1uGkP8A9CGIg1zt0VndA2
zO2W18o6tECPgxYEevpaVlqqHI+yLV7XNN4Wk//UF5T1M2+QBr4BBvoPq9SVKp6w
3kbE1smSvgTz2FmPS6LrbJkvZSkc/e30veMn8py1q6NHDZe/b5wVbgcQJwEAdU1S
8eIiJnZ3VSQnRd/ay5kYrsYcm95T5rxjoTsBvIBy6FTBIiJXCy01kMff3/sicr5e
xgBsiYv058s3wwzNquscFsBdQH7r0Q==
=Ppt7
-----END PGP SIGNATURE-----

--=-l5bQu8+DJCBx325/Mnpg--

