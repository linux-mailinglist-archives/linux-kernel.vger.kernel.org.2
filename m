Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5136F09A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhD2TbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:31:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49326 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2Ta7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:30:59 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EE0E21C0BA2; Thu, 29 Apr 2021 21:30:11 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:30:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/7] Revert "rocker: fix incorrect error handling in
 dma_rings_init"
Message-ID: <20210429193011.GB31692@amd>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20210429130811.3353369-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-04-29 15:08:05, Greg Kroah-Hartman wrote:
> This reverts commit 58d0c864e1a759a15c9df78f50ea5a5c32b3989e.
>=20
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review

This is a lie.

Known bad _patches_ were sent from @gmail.com addresses, and this is not
one of them.

									Pavel

--=20
http://www.livejournal.com/~pavelmachek

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLCUMACgkQMOfwapXb+vJ62gCgpX1EMdbDa55/ATgGMHq8Ju5q
JroAoJobXDlCuHinr30LL/uAl8D6BNld
=uavN
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
