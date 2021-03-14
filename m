Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194D033A8A2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhCNWph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:45:37 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57786 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCNWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:45:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A1E0A1C0B81; Sun, 14 Mar 2021 23:45:03 +0100 (CET)
Date:   Sun, 14 Mar 2021 23:45:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     robh@kernel.org, kernel list <linux-kernel@vger.kernel.org>
Subject: compile error in scripts/dtc/libfdt/fdt.c
Message-ID: <20210314224503.GA2000@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I get failure building ARM kernel. I can workaround it with. Are
system fdt headers used, or something like that?

I failed to copy the error message, but FDT_ERR_ALIGNMENT was
undefined symbol.

This is on 5.12-rc3.

BR,

      	      	       	   	     	 	       Pavel

diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index 3e893073da05..d15f437567d9 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -24,7 +24,7 @@ int32_t fdt_ro_probe_(const void *fdt)
=20
 	/* The device tree must be at an 8-byte aligned address */
 	if ((uintptr_t)fdt & 7)
-		return -FDT_ERR_ALIGNMENT;
+		return -FDT_ERR_INTERNAL;
=20
 	if (fdt_magic(fdt) =3D=3D FDT_MAGIC) {
 		/* Complete tree */

--=20
http://www.livejournal.com/~pavelmachek

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYE6R7wAKCRAw5/Bqldv6
8vMGAJ41rSflc7hlCzmB0uSJy8uxpPeamQCcCwKzJFcafGQGfRywbZT/qs2WJPQ=
=eBxa
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
