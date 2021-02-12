Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED70319D21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBLLPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhBLLPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:15:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3140964DEA;
        Fri, 12 Feb 2021 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613128466;
        bh=IidUhkGGwdtC3r30xlEMa5gZ+5/0HvnkTQjR8pcg7RY=;
        h=Date:From:To:Cc:Subject:From;
        b=hXjdU/pXzLipGv3AsMZABVO2s7VOg5kdWBgyHXZ6fUEeV+IGGkuiId83U4M3a7qsw
         6nViF+q4AMrjvI7ZH0LHk6w8KQoqnjrAgM5kzonHMKhDAHeNqQ3Z/K7esHGSkkff01
         tI8K7td4BEXP/pQCy3NVzAw14NbkAWo7/10QPn00b56zLn8vOrnZyyaCMv4gVAcw/t
         PodBSnHZWOiSy90ieum17eXqn1JaS5G4pLRx1q138pA2LBhNbYrqE1LlqJzGPr8Z5C
         Mlg9KHjNu0KG7rSbc5B9uMIdf7jO1we5eW1seMl0mTf9glgFATFtHiFSVSEtjHf6sJ
         JM2bP3SQndUYg==
Date:   Fri, 12 Feb 2021 16:44:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] soundwire updates for v5.12-rc1
Message-ID: <20210212111422.GN2774@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello greg,

Few more patches came in late and would be great to have in upcoming
merge window. Please pull to receive a fix for Intel laptops and support
for _no_pm in sdw regmap (acked by Mark)

The following changes since commit 6d7a1ff71cbb326fadfbedb7f75c1fc8f5c84d84:

  soundwire: bus: clarify dev_err/dbg device references (2021-02-07 17:49:1=
7 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-2_5.12-rc1

for you to fetch changes up to 8d8d958428674518cef083cd97e535ac5ac9f9d8:

  regmap: sdw-mbq: use MODULE_LICENSE("GPL") (2021-02-11 10:54:00 +0530)

----------------------------------------------------------------
soundwire second update for 5.12-rc1

Some late changes for sdw:
 - fix for crash on intel driver
 - support for _no_pm IO calls in sdw regmap

----------------------------------------------------------------
Bard Liao (3):
      regmap: sdw: use _no_pm functions in regmap_read/write
      regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
      regmap: sdw-mbq: use MODULE_LICENSE("GPL")

Marcin =C5=9Alusarz (1):
      soundwire: intel: fix possible crash when no device is detected

 drivers/base/regmap/regmap-sdw-mbq.c | 10 +++++-----
 drivers/base/regmap/regmap-sdw.c     |  4 ++--
 drivers/soundwire/intel_init.c       |  3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

Thanks
--=20
~Vinod

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmAmYw0ACgkQfBQHDyUj
g0dnlQ/+KdsYFCgQrzivQXA0HMHcROqMam02X/vWUwzWm6gEaKxsRuoWvvocgnOb
YKlI26aIFyxA1/3kGAlIewGuBOlVTcRVlK9bR+GTYm4tcXmoWXpWy9jxotG0qCNT
z2G0nk8yd8bIyAKcKAs3FjXkRzlCZqszHCHc41KPYuARev31byYo4J1qYSJEx/+K
VTFpgby/bUzaFRWp6NSjO/gH4vUOutJn9ceSQZFxWBXODdbJc4io1O7IDpSQEsJr
s9Rht//f0k6vDrMO+LIGLmaDWaEQtKVgX7RO2524o4OtbsZnay3QhxIMI92kZ6C2
/WUsiPL3FKclSaYNweMQxM2emUTpwKdMagQ6vWWjcdxXqsbMKa7nT4/dxmC0zUAd
KK5UFAqtU1w/EvOqz7ghVg3I/lNODAqAVOnUudyGxFFbviYkITf2OLchIJhQgr9D
h+6qj5SME0iKv/0AlfKy0HPrt9HcTMU8UQMlFinJwlt1Elt6MOkgAozLBJs+V1wR
LPowS8/WVt1e83DpMhRYXJy14u9HRKxWQ8X9m+qd5COgSTVdAe+IRAeE01IoLMAJ
atNGSYPhwymzB/OCElDsPC0DtSK8qV+3AEzd5wZPI6nj/ehCMycHVJFJDJ76ok+K
0gT9N1Wnp/iM7Fgg7Gha+sb3a3smJLXiQeJmL9+zSjIPYDOzO5Q=
=ceGZ
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
