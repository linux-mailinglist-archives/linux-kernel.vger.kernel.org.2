Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42FA43DA71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhJ1Ej4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:39:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:55285 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJ1Ejy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:39:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hft866wPhz4xbG;
        Thu, 28 Oct 2021 15:37:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1635395847;
        bh=EHmA4HIULq//DjUm6aFg5pJV0fofAtPID68h62x4v2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XNvR7m+uJr22KapxqcPIQegTIjiS2ByWlSPGgdQ/ehrTXUovcpNfvew3UmVaRPLrI
         Ar0EAhx86QRADRiQ+mLMMlEm8wBV1kKjGCgPNA2NbMaHb0rWOR7o/xL0wBou9gGzrg
         XVoiGA+01LBr19HSrGQshe1mOU9cVFbWhx83ofOtIzb/Ge1dwaWNYepnTXFwubA1Hf
         8j+GzMqUBtpEFv2X39mMSGKYzNV0bXyH9oKFXC49h9fOMVjarOo7KQj0RpuSroAp39
         T4CxRzbxTddKglSqy7U3PWr2ZdsG+cSELVHS6cndswV4/DIJzlnH/6+Y5Shw8IiaPl
         JA2pgj2JLNaZQ==
Date:   Thu, 28 Oct 2021 15:37:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/unittest: Disable new dtc node_name_vs_property_name
 and interrupt_map warnings
Message-ID: <20211028153726.26d616ac@canb.auug.org.au>
In-Reply-To: <361311a6-5818-6fc8-56d9-1a0ab8eaa74b@gmail.com>
References: <20211026225527.3460520-1-robh@kernel.org>
        <361311a6-5818-6fc8-56d9-1a0ab8eaa74b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/knxp9t2jY00S9UFtCAEQ=tJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/knxp9t2jY00S9UFtCAEQ=tJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Wed, 27 Oct 2021 19:05:22 -0500 Frank Rowand <frowand.list@gmail.com> wr=
ote:
>
> Before applying this commit, I am not seeing the warning that -Wno-interr=
upt_map
> suppresses.  I've tried with (1) CONFIG_OF_DYNAMIC and (2) with both
> CONFIG_OF_DYNAMIC and CONFIG_OF_OVERLAY, and I don't see the warning.
>=20
> Where are you seeing the interrupt_map warning?

Original report here:

https://lore.kernel.org/all/20211026134417.1be98b56@canb.auug.org.au/
--=20
Cheers,
Stephen Rothwell

--Sig_/knxp9t2jY00S9UFtCAEQ=tJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmF6KQYACgkQAVBC80lX
0GxvVgf/X1CDobi1xWE+Zl6OJnq+nAgxmzezUhe/+/Z1iA58Suth3YNX0mHWbHpj
pm3Xn2S6PpYVpE/vthLS9Xj/S+h+BcKruNEp8jC1WnIsM0/PikdnNMjQCY5nWAMP
zXWq2SmybC/LfOUbzGqYylu9o+U46xnzvJ0BWKqlvgGbNYq7nymJ0bX+Xhb1Blis
Jk1oWf5Hu/ND5cR5i18Bu4g8fvAWrmxlLcMAA5v0pg/+YdRHVUGHWuMrq15JKAFg
+pJp0CjkELZteNskWNQ/rk42lWId2+nxlzYiM+YGqFdujpHJeuK936NfIL+Osm2W
8e7CYpzgHqxUOj0DEe9qwqZvJXR3Sw==
=e6kz
-----END PGP SIGNATURE-----

--Sig_/knxp9t2jY00S9UFtCAEQ=tJ--
