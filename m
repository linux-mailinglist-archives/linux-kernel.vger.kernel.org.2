Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786B743092C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbhJQNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:00:20 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36178 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhJQNAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:00:19 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C3E7D1C0B76; Sun, 17 Oct 2021 14:58:08 +0200 (CEST)
Date:   Sun, 17 Oct 2021 14:58:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: 5.15-rc on x86-32: chromium dies with floating point exception
Message-ID: <20211017125808.GA2739@duo.ucw.cz>
References: <20211017093905.GA3069@amd>
 <YWv9wfVCllOnXex6@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <YWv9wfVCllOnXex6@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > does someone have any ideas?
>=20
> Fix just went to Linus:
>=20
> https://git.kernel.org/tip/b2381acd3fd9bacd2c63f53b2c610c89959b31cc

Thank you, that seems to solve it for me.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYWwd4AAKCRAw5/Bqldv6
8lh1AJ9DfoY6AWTm+tgL+B/qlSamy5nnWQCgqbEC7S1GeGQhnmcOcR+JGxSrINA=
=GSB7
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
