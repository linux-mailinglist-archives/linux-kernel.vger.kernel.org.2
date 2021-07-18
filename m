Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1EE3CC91B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhGRMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 08:32:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35530 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 08:32:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BE3181C0B76; Sun, 18 Jul 2021 14:29:06 +0200 (CEST)
Date:   Sun, 18 Jul 2021 14:29:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, jpoimboe@redhat.com,
        peterz@infradead.org, mingo@kernel.org
Subject: Re: 5.14-rc0: regression when compiling tools/objtool
Message-ID: <20210718122906.GA15278@amd>
References: <20210711091729.GA22833@duo.ucw.cz>
 <20210718121822.GA14683@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20210718121822.GA14683@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2021-07-18 14:18:22, Pavel Machek wrote:
> Hi!
>=20
> > I'm getting build errors trying to build 5.14-rc0. Earlier -rc0
> > releases built okay. This is 64-bit x86 build, 32-bit x86 and arm
> > build okay for me, too. Attaching config, as it may be related?
>=20
> This is quite annoying, as I'd like to try 5.14. Problem is not fixed
> in -next, either...

Installing libelf-dev fixed / worked around the problem.


Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmD0HpIACgkQMOfwapXb+vIv6ACgjsal2AY1F6wOwHowT8QakDXq
KNEAni8bUuxYa9vJuI9jTtzqaOV7I2SO
=Wnmq
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
