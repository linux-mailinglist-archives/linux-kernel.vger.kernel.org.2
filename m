Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29D368F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbhDWJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhDWJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:44:32 -0400
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Apr 2021 02:43:56 PDT
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:43:55 -0700 (PDT)
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8734582B82;
        Fri, 23 Apr 2021 11:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1619170472;
        bh=ssSuyNsmvt4IB+BkTpVXtSrkaWAHUR5XccZmzwwEo9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LQ4+peO1sLZ/crVqtZ6GNGJb4mVdtfyxbkqUnGCBGB0QBKFrdJTzna0GYb3ACDtyh
         mOE8rox7/vHtzON+RjBpepx4sDv/EkI8DkAmGaYvpYSCiU7IOKxudcLGk7ZEm8IpVq
         uGcQZBPABIXHA1hKZAol5ccbj8d9jP4PKxao6i7tsuDH35I1L33WdbVnoCeMtsEeAm
         S2ZXEs1ymdJbCCFtdiVmNsyWXQDnjJiaMJSqv0RSrQBDlawg7WsFhsXcLOwqsgDd55
         2Zb2Lu75jfpqfpXC3sjqxLblxCMT4af1dJsZC6S4RXbMPdzgJLIUlZj8rlESu6i7BV
         +lwy0KX3Bdkiw==
Date:   Fri, 23 Apr 2021 11:34:24 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [patch 5/6] futex: Prepare futex_lock_pi() for runtime clock
 selection
Message-ID: <20210423113424.19e26b77@jawa>
In-Reply-To: <20210422194705.338657741@linutronix.de>
References: <20210422194417.866740847@linutronix.de>
        <20210422194705.338657741@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/3yTGmbENL6O1ZgcusCzSQEf"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3yTGmbENL6O1ZgcusCzSQEf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

> futex_lock_pi() is the only futex operation which cannot select the
> clock for timeouts (CLOCK_MONOTONIC/CLOCK_REALTIME). That's
> inconsistent and there is no particular reason why this cannot be
> supported.
>=20
> This was overlooked when CLOCK_REALTIME_FLAG was introduced and
> unfortunately not reported when the inconsistency was discovered in
> glibc.
>=20
> Prepare the function and enforce the CLOCK_REALTIME_FLAG on
> FUTEX_LOCK_PI so that a new FUTEX_LOCK_PI2 can implement it correctly.
>=20
> Reported-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/futex.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2786,7 +2786,7 @@ static int futex_lock_pi(u32 __user *uad
>  	if (refill_pi_state_cache())
>  		return -ENOMEM;
> =20
> -	to =3D futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);
> +	to =3D futex_setup_timer(time, &timeout, flags, 0);
> =20
>  retry:
>  	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key,
> FUTEX_WRITE); @@ -3711,7 +3711,7 @@ long do_futex(u32 __user *uaddr,
> int op,=20
>  	if (op & FUTEX_CLOCK_REALTIME) {
>  		flags |=3D FLAGS_CLOCKRT;
> -		if (cmd !=3D FUTEX_WAIT_BITSET &&	cmd !=3D
> FUTEX_WAIT_REQUEUE_PI)
> +		if (cmd !=3D FUTEX_WAIT_BITSET && cmd !=3D
> FUTEX_WAIT_REQUEUE_PI) return -ENOSYS;

What is the exact change for those two lines above? Looks like some
different tab/spaces...

>  	}
> =20
> @@ -3743,6 +3743,7 @@ long do_futex(u32 __user *uaddr, int op,
>  	case FUTEX_WAKE_OP:
>  		return futex_wake_op(uaddr, flags, uaddr2, val,
> val2, val3); case FUTEX_LOCK_PI:
> +		flags |=3D FLAGS_CLOCKRT;
>  		return futex_lock_pi(uaddr, flags, timeout, 0);
>  	case FUTEX_UNLOCK_PI:
>  		return futex_unlock_pi(uaddr, flags);
>=20



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/3yTGmbENL6O1ZgcusCzSQEf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmCClKAACgkQAR8vZIA0
zr0jiwgAuT8QWLtlVgm2TY+62ki+xaPtLiKTchq+DKy51BhaCDOhjIsrtui3W1Zw
tDXs5IsAJ0Hkns8KCPiPmJD6rxnn1knD0BMaWqUSF4yv9UpiWC2Ab/TA5QMA+e4Z
tOlXMy6Hy7tnXxkJaAeRXy8W2NWLyMul52kGmEESFlY+/xpjdx8QC/D80Rg8jtbx
ErIcJn/Rg2sZpiO/hREXnRE9g15lDGboJ0MSC7ibeU8ZHhlB9/H+5CwI0keT7ZKd
Jeg1bmNcFg+xBq3iINmIHwRNDgQGLIJPyQUpkkAZvLhKaAAe8Www8ZE1t+IY+Ehz
hAsuTyewoQugpD5E5YU78sILzuFVHA==
=OTkZ
-----END PGP SIGNATURE-----

--Sig_/3yTGmbENL6O1ZgcusCzSQEf--
