Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F906430781
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbhJQJlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:41:17 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45186 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhJQJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:41:16 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 12C7B1C0B76; Sun, 17 Oct 2021 11:39:06 +0200 (CEST)
Date:   Sun, 17 Oct 2021 11:39:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: 5.15-rc on x86-32: chromium dies with floating point exception
Message-ID: <20211017093905.GA3069@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have an "interesting" x86-32 system on thinkpad x60. Depending on
kernel version, chromium either works or fails with floating point
exception.

Working:

Linux amd 5.12.0+ #104 SMP PREEMPT Tue Apr 27 10:31:57 CEST 2021 i686
GNU/Linux

Broken:

Linux amd 5.15.0-rc5-next-20211015+ #204 SMP Sun Oct 17 10:29:18 CEST
2021 i686 GNU/Linux

pavel@amd:~$ chromium  --temp-profile
Floating point exception (core dumped)

Is there any chance to get anything useful from the coredump? Besides
bisection, does someone have any ideas?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFr7zkACgkQMOfwapXb+vJwngCeMZGDOEl3EB8aszlQJEDyOFy2
zIIAn14IcRViAjNw32IZMre6yOeeEtbd
=iIZu
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
