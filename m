Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7C3D443D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 03:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhGXA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:58:21 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55284 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhGXA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:58:19 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1m76ck-0001il-7W; Fri, 23 Jul 2021 21:38:42 -0400
Message-ID: <239ada57a88c69072fc2933a39affe3923c90800.camel@surriel.com>
Subject: Re: [PATCH] x86,mm: print likely CPU at segfault time
From:   Rik van Riel <riel@surriel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Date:   Fri, 23 Jul 2021 21:38:38 -0400
In-Reply-To: <87sg07pfpk.ffs@nanos.tec.linutronix.de>
References: <20210719150041.3c719c94@imladris.surriel.com>
         <87sg07pfpk.ffs@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jOBphdMuPxA5mHcISIkd"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jOBphdMuPxA5mHcISIkd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-07-21 at 22:36 +0200, Thomas Gleixner wrote:
> Rik,
>=20
> On Mon, Jul 19 2021 at 15:00, Rik van Riel wrote:
> >=20
> > Adding a printk to show_signal_msg() achieves that purpose. It
> > isn't
> > perfect since the task might get rescheduled on another CPU between
> > when the fault hit and when the message is printed, but it should
> > be
> > good enough to show correlation between userspace and kernel errors
> > when dealing with a bad CPU.
>=20
> we could collect the cpu number in do_*_addr_fault() before
> interrupts
> are enabled and just hand it through. There are only a few callchains
> which end up in __bad_area_nosemaphore().

We could, but do we really want to add that to the hot path
for page faults, when segfaults are so rare?

I suspect the simple patch I sent will be good enough to
identify a bad CPU, even if only 3 out of 4 userspace crashes
get attributed to the right CPU...

I would be happy to write a patch that does what you want
though, so you can compare them side by side :)

--=20
All Rights Reversed.

--=-jOBphdMuPxA5mHcISIkd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmD7byEACgkQznnekoTE
3oNpfQf+OlV2Fopv0o9cq9pk6BF7w5tFjNPg9lGokSbQ9f8bD30SRzhskZoj/VvL
h/Zf5cI/XjbBFZ2H/GU888M4Cl2L2H8iPt7lvf2wjM6rTjcQOht+o56HUQaIg/ye
+IQn+MEfLxwAzBEsMuhliQGoUxeM/Yc2KpJyEDqQL92XkZRfvxUqkyCHiMyCIKKY
l6bovzm9QlEFjLfM9+BMVuyhxmvsSWo3TZrBuqqIzjm4jnliwzxcFq8sof8nLO+y
6hL2RoViXfXV/E8Mn5mZKeufGab2XKblTYI+AEhaXX8wffJs3I8dHvEyrcCs320I
HNvcvBN4K7s6H59qK8njEJp2rPKV2g==
=EFd/
-----END PGP SIGNATURE-----

--=-jOBphdMuPxA5mHcISIkd--

