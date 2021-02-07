Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9D312668
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 18:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGRgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:36:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C8B664E05;
        Sun,  7 Feb 2021 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612719366;
        bh=lfZVA4TJ0u7Z73tC1n2QinNUzUjjNHPy0eX0J09YL68=;
        h=Date:From:To:Cc:Subject:From;
        b=Puag2A0Lb/YbJtA8FsyW8DhhwZHemJUXMo2xi0Z1/IyvV6XGT7YS6oTa0lN8rXCGd
         j6iauA7U6a4Ag8HK5eo+CZqoknhsEPW8rLFDDMS5Tc/n2+z6Q0s+jWP4TkprzAjED4
         QI3VLNG/ROeSk6qBg66Kj24OQheMAeahNLcXJrd9RrOecHKQ8JVaXrILEzJmmOjLZy
         81w+3eOd7q3dTlIrLyNlm9x8CoU4vg0M9oPQ9bLavk6wUp/4SKaAM/xMhgazJRob4I
         RhLMcStREIYTUfo7ZdN5Lh5R9T0ansX7CLzhQ7/p5xAaXqliUZ46RBtlBOa1j1qdRn
         6JKzVJQ5RAvxw==
Date:   Sun, 7 Feb 2021 23:06:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: soundwire: updates for v5.12-rc1
Message-ID: <20210207173601.GA879029@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive update for v5.12-rc1. This update includes new
no_pm IO routines and bunch of updates for intel & cadence drivers.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.12-rc1

for you to fetch changes up to 6d7a1ff71cbb326fadfbedb7f75c1fc8f5c84d84:

  soundwire: bus: clarify dev_err/dbg device references (2021-02-07 17:49:1=
7 +0530)

----------------------------------------------------------------
soundwire updates for 5.12-rc1

Updates forv5.12-rc1 are:
 - New no_pm IO routines and the usage in Intel drivers
 - Intel driver & Cadence lib updates

----------------------------------------------------------------
Bard Liao (3):
      soundwire: intel: don't return error when clock stop failed
      soundwire: bus: add more details to track failed transfers
      soundwire: export sdw_write/read_no_pm functions

Chao Song (1):
      soundwire: return earlier if no slave is attached

Pierre-Louis Bossart (11):
      soundwire: cadence: reduce timeout on transactions
      soundwire: use consistent format for Slave devID logs
      soundwire: cadence: add status in dev_dbg 'State change' log
      soundwire: cadence: fix ACK/NAK handling
      soundwire: cadence: adjust verbosity in response handling
      soundwire: bus: add better dev_dbg to track complete() calls
      soundwire: bus: use sdw_update_no_pm when initializing a device
      soundwire: bus: use sdw_write_no_pm when setting the bus scale regist=
ers
      soundwire: bus: use no_pm IO routines for all interrupt handling
      soundwire: bus: fix confusion on device used by pm_runtime
      soundwire: bus: clarify dev_err/dbg device references

Rikard Falkeborn (1):
      soundwire: sysfs: Constify static struct attribute_group

Srinivas Kandagatla (1):
      soundwire: debugfs: use controller id instead of link_id

Vinod Koul (2):
      MAINTAINERS: soundwire: Add soundwire tree
      soundwire: Revert "soundwire: debugfs: use controller id instead of l=
ink_id"

Zheng Yongjun (1):
      soundwire: intel: Use kzalloc for allocating only one thing

 MAINTAINERS                        |   1 +
 drivers/soundwire/bus.c            | 179 ++++++++++++++++++++-------------=
----
 drivers/soundwire/cadence_master.c |  31 +++----
 drivers/soundwire/intel.c          |   8 +-
 drivers/soundwire/slave.c          |  10 +--
 drivers/soundwire/sysfs_slave.c    |   2 +-
 include/linux/soundwire/sdw.h      |   2 +
 7 files changed, 128 insertions(+), 105 deletions(-)

Thanks
--=20
~Vinod

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmAgJQEACgkQfBQHDyUj
g0dF4w/9G3CcwiK07vq20rk3JAceuaNVjO0sylgzPrcCpHXiJjKNqF6RzQp3aVZt
T0E8sfE0aWIvU4O4RCA7O+2GelcMp8FubDr/3uwB8GimnhAMSRQ/7ymo7twUHCib
v2fEqfp11uv/c0+x6hAcz2lOeETpKAI8m0uPJ4uoj3P1m16VuVZ/rMI9W3ea60NK
0Xc8BbquXqE8HoprWYVNeBTOA1ZQf4jMMEss5OTuI8K9X6v7Cfk5Febt3zSIe174
kBwwsMCi2seZrUKK/wpqy8YXcqK4zv1d98DnLDu2T3T23mSyPOjkeXV9zU+Pbq4+
W2vkmuS98JBFoPTpxHUbq/03GAA8G//rYM2McSILOyKHqpcGNjGAeXfUh/e1obye
HYSwOeG9jFpNW+6fmBFrqfx2+xcpQfrponEFPbC+oa8IjJgw9+tdchZMoDyjf97n
lJ3GbFWZ6ey8j7B6DXYB7/J5RAA4Q6bxaEefhrOVDBtbrziDuvNwnBw7454G7NYo
PWkOE9CojV9c/Wvc5PGGYZ4rXEnjfxaOVEiusXd1z1jdq003R2JP8FpwpYhv5+LL
3NFoodFxmxn6Vt6acaQzf5tYwzbljlCJbttMF0ZfGm7nA3SZEYIakIJZZ8h9gWW6
nhJY3ZyVRuAom5ieEuvY3tZ16pw5YWQShllMf/3Z9ztoAQ7eRXE=
=Bbjt
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
