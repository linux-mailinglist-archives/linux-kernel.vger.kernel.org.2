Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C577B36F0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhD2TuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:50:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50970 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhD2TuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:50:21 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DDD8A1C0B9F; Thu, 29 Apr 2021 21:49:33 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:49:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 001/190] Revert "net/rds: Avoid potential use after free
 in rds_send_remove_from_sock"
Message-ID: <20210429194933.GC31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-2-gregkh@linuxfoundation.org>
 <YIhaAEsa+92ipKuU@kroah.com>
 <YIhaUH9PDZx1SC/J@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <YIhaUH9PDZx1SC/J@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The original, while again messy, looks ok, so I'll drop this revert.
> >=20
> > greg k-h
>=20
> Argh, no, this one has already been reverted in Linus's tree.  I've been
> reviewing to many of these today, I think it's time to get some rest...

This one is important, it is the one that triggered it AFAICT. And
this one is _bad_, so should be reverted.

But I see no proof of malice.
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLDc0ACgkQMOfwapXb+vJCvQCfaQfYmyjW8V+FIhvSrJlh667c
xpwAoJngtydl20KQxjJDgPu4/2Omj2DH
=MiS2
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
