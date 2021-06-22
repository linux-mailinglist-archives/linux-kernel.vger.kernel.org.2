Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8F3AFC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFVFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhFVFZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FD8608FE;
        Tue, 22 Jun 2021 05:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624339397;
        bh=E4NMCA4W3dnltbMakIr6/XVxBoznsmXbNirNwbydmKM=;
        h=Date:From:To:Cc:Subject:From;
        b=IlwzFUkaCR9LqeQU9HWRqbdqD6xyCwQ+SocHoOpT669kKCUeLfFDYslmKd9Yiigo5
         MvXCoRCDmxpw+Nk5x/Lj3Ud6x08YtMFXS9kVfu3oA/ytiZPJQVXDt8MG+T8YxHM0Ur
         l9n3J7qUrlsUvPmXYQ+SaZbodSBHkEuNjyTq8Aa/blW8RhupdfVdQ+krv5V8liXztl
         MT4Yyc9oA9DrfS8Aj794L6Bj+9BQo3bGG6+EkHKhvFxt/l42XdFlWf2NG/ckuxsyrA
         hQGgPOEGc1iDYxvUWX8UVdZGpAEq2Kl3l/chbX52p1f2ItTMEswFOJddJoIpMpyDgI
         rvc0mLX+rt3EA==
Date:   Tue, 22 Jun 2021 10:53:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.14-rc1
Message-ID: <YNFzwibyyESNJx9w@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6L/MhWVvpJdSV+Y+"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6L/MhWVvpJdSV+Y+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive the soundwire subsystem updates for this cycle.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.14-rc1

for you to fetch changes up to 3d3e88e336338834086278236d42039f3cde50e1:

  soundwire: stream: Fix test for DP prepare complete (2021-06-20 16:46:18 =
+0530)

----------------------------------------------------------------
soundwire updates for 5.14-rc1

Updates for v5.14-rc1 are:

- Core has odd updates including improving clock stop codes, write api,
  handling ENODATA etc

 - Drivers has Big move of Intel driver to be aux dev and minor updates
   to Intel/cadence driver

----------------------------------------------------------------
Pierre-Louis Bossart (9):
      soundwire/ASoC: add leading zeroes in peripheral device name
      soundwire: bandwidth allocation: improve error messages
      soundwire: bus: only use CLOCK_STOP_MODE0 and fix confusions
      soundwire: add missing kernel-doc description
      soundwire: bus: handle -ENODATA errors in clock stop/start sequences
      soundwire: bus: add missing \n in dynamic debug
      soundwire: cadence_master: always set CMD_ACCEPT
      soundwire: dmi-quirks: remove duplicate initialization
      soundwire: intel: move to auxiliary bus

Richard Fitzgerald (2):
      soundwire: bus: Make sdw_nwrite() data pointer argument const
      soundwire: stream: Fix test for DP prepare complete

Shaokun Zhang (1):
      soundwire: cadence: remove the repeated declaration

 drivers/soundwire/Kconfig                        |   1 +
 drivers/soundwire/bus.c                          | 163 +++++++---------
 drivers/soundwire/cadence_master.c               |  21 +-
 drivers/soundwire/cadence_master.h               |   3 -
 drivers/soundwire/dmi-quirks.c                   |   2 +-
 drivers/soundwire/generic_bandwidth_allocation.c |  14 +-
 drivers/soundwire/intel.c                        |  56 +++---
 drivers/soundwire/intel.h                        |  14 +-
 drivers/soundwire/intel_init.c                   | 232 +++++++++++++++----=
----
 drivers/soundwire/slave.c                        |   4 +-
 drivers/soundwire/stream.c                       |  13 +-
 include/linux/soundwire/sdw.h                    |   5 +-
 include/linux/soundwire/sdw_intel.h              |   6 +-
 sound/soc/intel/boards/sof_sdw.c                 |   4 +-
 14 files changed, 299 insertions(+), 239 deletions(-)

Thanks
--=20
~Vinod

--6L/MhWVvpJdSV+Y+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmDRc8EACgkQfBQHDyUj
g0eqWA//Z8GedgYo2EN5nypzL7TXVhSk70i87VOAXEjyqrsxcxeb8Q1zb6cJ1deB
3uSMbkHFW20zPrW6i+5gcHngX+j5py9lsuCSDIENoCrXgRHeUrXjNkgYPldOwzfY
ysccgSs5X4+rTBGQ76pYMFb4qHdvDrJrT/b0ho+3N1S9H5hyH4Xd3ulfw7Y+PqH8
NwQwDUeQ/xmO+YgZTMafwrGBPXC0ZmY3dEW76iPlz4PbdJiV2KU4j2HIiu2Thdi5
RZ6TbV2CP5JprldWTIKKguCH9mLxGY4brLyU9aVJNGiElFsTPk/qwZpIhYFxXvp0
m9yOmardK1OZloHA7ql8BVX6zZ5vLZc32vjG1XautQen0gKq+qpZx+9gVtgh5Eae
73/UqOh1mciyW5gEYOLabpexNQdD2JWHlRFKQN0EaeVRMdocRo1Yidj8d05kvzIg
9WZZyznXJMENgJSS7dqvILtHcI5jc/Jtg6+4QKNWc2763mk8OJLIbk3j73SMRs7i
xHfYWAmTIUGUT4jZNp7L5FHllU0MJdRom4BAf4jlLwvxKCDlV8QB84JwhkRH6ojV
KTUX8DjTv3d30DPxv4a2LbuFvIyZMECv7viPkED45kS8AruLbJyYivERXJNrBFWc
QMjc5/B0hmh+ogEJF/vvWbmrZ7H50ODFI+ok9UjEXnXfuCWC1qg=
=wVg8
-----END PGP SIGNATURE-----

--6L/MhWVvpJdSV+Y+--
