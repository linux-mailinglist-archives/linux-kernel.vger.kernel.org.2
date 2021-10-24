Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6141943896B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJXOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 10:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhJXOGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 10:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AD6860EDF;
        Sun, 24 Oct 2021 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635084260;
        bh=Ups2H/GReLMCIGgYYqgKpnTOPkkyAW9q1NZM6vOxoRs=;
        h=Date:From:To:Cc:Subject:From;
        b=j9nH2SyMUAjysiqOw9/We63XjP8njzQbIEgy1BtMq/qBaxEP125hFgWWX9a78yacL
         C2p8KsjekazaArpflNqLU6SNA/muMUQBViUUVzQmY3dJfF3Gll5wc6+ip4X+vhWpZN
         y4ucwxjpo8GzpB5cAUWLNbxuCPjPnn5sY95xUXFSFnPJ3Ujv5PQSB1mFpL63zNjWAb
         DD5gLnwlEZnggJhWEGfkkSD9JhL4IJHp9QtUq2TNmDGQqeJvbnOYU6w44JjodmfNhC
         aJ4n4F0Bq4mnY7LPsCf4j12QW+F56RHHA4K/zEuyt477c35iMTl7VETqnpujC/fiXY
         2/x+dD2ksCHPw==
Date:   Sun, 24 Oct 2021 19:34:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.16-rc1
Message-ID: <YXVn3w1vRvPp0xY4@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LGaEO8Ein83qS2eD"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LGaEO8Ein83qS2eD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive updates for SoundWire subsystem. Things seems
settling down now, odd updates for core and qcom driver.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.16-rc1

for you to fetch changes up to abd9a6049bb59a9bab8cc8b42ccbe4a46c307f92:

  soundwire: qcom: add debugfs entry for soundwire register dump (2021-10-2=
0 20:54:59 +0530)

----------------------------------------------------------------
soundwire updates for 5.16-rc1

 - Update on sysfs wildcard documentation
 - debugfs update for core and qcom driver
 - invalid slave pointer fix for bus

----------------------------------------------------------------
Mauro Carvalho Chehab (2):
      ABI: sysfs-bus-soundwire-master: use wildcards on What definitions
      ABI: sysfs-bus-soundwire-slave: use wildcards on What definitions

Srinivas Kandagatla (3):
      soundwire: debugfs: use controller id and link_id for debugfs
      soundwire: bus: stop dereferencing invalid slave pointer
      soundwire: qcom: add debugfs entry for soundwire register dump

 .../ABI/testing/sysfs-bus-soundwire-master         | 20 +++----
 .../ABI/testing/sysfs-bus-soundwire-slave          | 62 +++++++++++-------=
----
 drivers/soundwire/bus.c                            |  2 +-
 drivers/soundwire/debugfs.c                        |  2 +-
 drivers/soundwire/qcom.c                           | 27 ++++++++++
 5 files changed, 70 insertions(+), 43 deletions(-)

Thanks
--=20
~Vinod

--LGaEO8Ein83qS2eD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmF1Z98ACgkQfBQHDyUj
g0e4Vg/9Ga2XO4fcFwbv6A2HgoKziSx/F3tV7Ap+9/Jf6649o+QyyBvfFKqp07oz
P6TBcoqihRqxLTpPngdNw6sTA0uraSPyiODSWBTyTmbBc9QUCsvQY+hdI3QpMyb6
Qi4zfO6aU799DpaYCfnYsPPUmx8MGlkzfIrcdQdyQ+Lp29AgR8WiiKNk7YXkiKtm
QuEcqVPWuToJiDQd4RxqhqyYVSVLzN997qdSh9Jjy6D/Wmm+s5T4TMHZUxJgUUEO
TMmuE+AMVrILVcsnO3NR3JxaPkyGwxa3gMvv7jx2sSHljwkDlTr29WJ7u4aBYgGr
zo270WILXqk2F259CFDLjfwZCtM5kpigLZ5yah4mO7aKjYMHaCm/taxJQYAS3IbV
ka5gZOm0aABNOldoBZnAf+Z9/NMaWW7ZakSkGDlBEgMArdiP5rkKTfPvxUTV503t
aUehiujLtLlQsoPFeBk7BTy4EIIqOs2w9ROpcTkJw9e7QYxaCGXoCCh+zk37X022
TTmBlu5E0H5DvSKd+Ko3rnw6rMqcKt5nRBkhikntO1HtmMllblKZY6qTlM5UggYm
EWtvubdm8H0lI/8DIEt1PZTTkeKCvcUihu5zumbQQ491Cacpv9qheCOKaEVfm1UI
eQsxAnga5cj9xqCAoLyw3Djr7Vhn1qRCdYmHk4o8TcWJW7Asso0=
=E6Nc
-----END PGP SIGNATURE-----

--LGaEO8Ein83qS2eD--
