Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6942B785
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhJMGkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:40:19 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:40835 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbhJMGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:40:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HTjXK2t0qz4xbG;
        Wed, 13 Oct 2021 17:38:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1634107091;
        bh=vG5wu8rK/bYN0SCJfvAhVNcO15ZTCrwihNZzPlGYioU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjArxxtiWKW8QOQvHragrEHJbtBkAH6yvJiBrlCtpKo/Jvxv34mapJ9Bk9B7iT5Xu
         gHv9bYuIQ0YQpAYePJAC42B3GQEACJrC0vFeeJ9jUlGYXru4RHoODwhA6tNYJ1QsE4
         qIqSxq6Gbx0cjLzqskoflQpITzbv8NeKPLpb1UPueCrm6TM9mVdmJDeKwnMTWLcJ6t
         8cOA5cuh+NmKK3Jl2D7VAA5VEi0rwAIwx5rTMDnqb8ujb/NjkN2dFC8/TCgJkM6vHJ
         hDkGDeVBrlYYIEsfAPr1kjfKBJ5KwiGiKyDFlhCIJzNlY5ebt8QmgzkosjPGKGz30m
         M7qszNN/ZDtXw==
Date:   Wed, 13 Oct 2021 17:38:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc: dts: Remove MPC5xxx platforms
Message-ID: <20211013173808.7ab92035@canb.auug.org.au>
In-Reply-To: <20211012153456.2844193-1-robh@kernel.org>
References: <20211012153456.2844193-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hNT9L3ZDbI5k34wFOdCx2dr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hNT9L3ZDbI5k34wFOdCx2dr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, 12 Oct 2021 10:34:56 -0500 Rob Herring <robh@kernel.org> wrote:
>
> The mpc5xxx platforms have had dts warnings for some time which no one
> seems to care to fix, so let's just remove the dts files.
>=20
> According to Arnd:
> "Specifically, MPC5200B has a 15 year lifetime, which ends in
> 11 months from now. The original bplan/Genesi Efika 5K2 was
> quite popular at the time it came out, and there are probably
> still some of those hanging around, but they came with Open
> Firmware rather than relying on the dts files that ship with the
> kernel.
>=20
> Grant Likely was the original maintainer for MPC52xx until 2011,
> Anatolij Gustschin is still listed as maintainer since then but hasn't
> been active in it for a while either. Anatolij can probably best judge
> which of these boards are still in going to be used with future kernels,
> but I suspect once you start removing bits from 52xx, the newer
> but less common 512x platform can go away as well."
>=20
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Sending this out as a feeler to see if anyone cares. If anyone does,=20
> please fix the warnings.

Thanks.  However .. :-)

FATAL ERROR: Couldn't open "mpc5200b.dtsi": No such file or directory
make[2]: *** [/home/sfr/next/next/scripts/Makefile.lib:358: arch/powerpc/bo=
ot/dts/digsy_mtc.dtb] Error 1

$ grep -wrl mpc5200b.dtsi
arch/powerpc/boot/dts/digsy_mtc.dts

missed one :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/hNT9L3ZDbI5k34wFOdCx2dr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFmftAACgkQAVBC80lX
0GySTgf/SwHWqYw3xEIGHbUBCpLmTzIJWw0cXaAN8VFo6Lpsb/H7xKz/Cu3fUYyX
Z7veE1EKdxvZfcnE4rwSHEL8TvtLp3U3yAls5foblypO301bXEISgNaYxAHKSKeV
S7D0KIY0U8fcSaM0HrBhwxTECEBGJtSwf2K/I81GlIKO8h+dt6ajec974Ku8mMMc
LWukJfatx9F0Ex7prCIlJA1S/gnw8RO7x0GTaF8mM4ULay59UQbn2W+5W0MEs58g
zyQFj8yL5OqaV6ZlzPhGIKQc1DLTPlQLvI7iuF2CxDKomoHvTPSiGqRtd/p3qnrt
KR+wol1v6zuUZu7DClfczJuiGJ3vnw==
=oWcO
-----END PGP SIGNATURE-----

--Sig_/hNT9L3ZDbI5k34wFOdCx2dr--
