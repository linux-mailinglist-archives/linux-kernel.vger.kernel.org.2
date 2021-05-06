Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAD374EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 07:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhEFFf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 01:35:59 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:37462 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFFf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 01:35:57 -0400
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4E272201259;
        Thu,  6 May 2021 05:34:59 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 63222207CB; Thu,  6 May 2021 06:30:41 +0200 (CEST)
Date:   Thu, 6 May 2021 06:30:41 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia updates for v5.13
Message-ID: <YJNw8bTiB+kZWA7u@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uoCNDv3HRrEX0wQ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uoCNDv3HRrEX0wQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

A few PCMCIA changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-ne=
xt

for you to fetch changes up to e9d503fef7da2cc0610ce9cd056d0347ec9cafc4

  pcmcia: rsrc_nonstatic: Fix call-back function as reference formatting (2=
021-03-15 08:22:23 +0100)


A number of patches fixing W=3D1 kernel build warnings, and one patch
removing an always-false NULL check.


Thanks,
	Dominik

----------------------------------------------------------------
Lee Jones (6):
      pcmcia: rsrc_nonstatic: Demote kernel-doc abuses
      pcmcia: cistpl: Demote non-conformant kernel-doc headers to standard =
comments
      pcmcia: pcmcia_cis: Demote non-conforming kernel-doc headers to stand=
ard kernel-doc
      pcmcia: ds: Fix function name disparity in header
      pcmcia: pcmcia_resource: Fix some kernel-doc formatting/disparities a=
nd demote others
      pcmcia: rsrc_nonstatic: Fix call-back function as reference formatting

Uwe Kleine-K=F6nig (1):
      pcmcia: ds: Remove if with always false condition

 drivers/pcmcia/cistpl.c          | 12 ++++++------
 drivers/pcmcia/ds.c              |  7 ++-----
 drivers/pcmcia/pcmcia_cis.c      | 10 +++++-----
 drivers/pcmcia/pcmcia_resource.c | 11 ++++++-----
 drivers/pcmcia/rsrc_nonstatic.c  | 22 +++++++++++-----------
 5 files changed, 30 insertions(+), 32 deletions(-)

--3uoCNDv3HRrEX0wQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAmCTcPEACgkQmpdgiUyN
ow2RdQ//QyGBUWCwPlKSNPwtNV7XsPiDRhD0DDEo7RK9juXyRwPNFavv8NLoRTzR
WrsoeOlU2f2xpoOOOBCAZLJJlg4RfuEwouWNxkOKdN8aUPuvXED3I6HGbYlgjVI+
xBs1s9jld/1rrG+5c0JqJGImSwvePyvs5HTaWaeMVJ6TxryFf99oJaVknQIkwMqT
3+ve+JrDiuzP9zNtF+B6TvJM8qBYAnz3GUdFPiK+pnbtF8jiNSDxjH7VnIrDOD4h
MltPYQFaJ4TL4kai49XQGLNuzSYwgQ+VTiY5LcKUGrOQkxUFgUDQba1jmFWgikze
orRj+f3J4f/87DjARiW8Vk9SvyKZrJt48zw3c8UHqxH9yUHyV2uadVuay06c1pJ3
zkI555jr6JZYM+v/CUu92wY5JEaMv5TAc6/XvHFXlCpoGWoybFwJ7lRZRkjtm6Po
+JenrpNnJtJqc9tL6BjwR6VsMng9MQULekApjpfUKrBlZwMRWahNQMQXQ/Q79R3V
n51Eee4ilxztRS3wI+BFIRO5EZ7JlLJzA7Yr7y9CRQxxZQm4wTVCLJwNJDToDpsY
i/1OdvSQW+0dWbhbo3s7E730dbclz4QztpOk9y1DUvkNxAisVa2qhDff1ISi2Yv3
7zkfnkZDQhUDASBvEOrJKHvQ5PN7i3FDVF3uYDPBx4bbKYrIycQ=
=1Y/K
-----END PGP SIGNATURE-----

--3uoCNDv3HRrEX0wQ--
