Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4616C3F5792
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhHXFWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 01:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhHXFWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:22:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05994610C9;
        Tue, 24 Aug 2021 05:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629782490;
        bh=MRNMa3+d3rOQEWvczovCEbRMgE3bsiXSUyDC/fqPcv0=;
        h=Date:From:To:Cc:Subject:From;
        b=K7BabUvJOEcaW9umOohJ3hfI7u87UZe4wLL0E4Yaobup5t3UPO0/AeaS9HWi9vJd+
         r7yOykP6gsS69bWWFMVeeAwJt2ZYvGrjcNm/jTulTutKwPei817xJpUxIxlMCLQgNT
         GsljRlK0mmPU6Bsv5DFu/qQMDC87B8IcxqT1bA99KuPIyW9V9n2JVQaEsm0NnN6PCh
         XLm7eCu0qVhjv6Q7MHXehPovOGaj656AmimCBn+ivgV3PIFkmkDaVAqvCRcUc7O8Lv
         mnfMLRfGhMUKve+tUkXEs3LHWKnHXVYkzTDS4DAJkyOie1TCgG53mqgEPozmzGAgSu
         MjAdccJLXoVSQ==
Date:   Tue, 24 Aug 2021 10:51:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire updates for v5.15-rc1
Message-ID: <YSSB1bmorkoV71KE@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LIerrMBQEjAEjAUG"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LIerrMBQEjAEjAUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Here is the PR for soundwire subsystem for v5.15-rc1.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.15-rc1

for you to fetch changes up to 2564a2d4418bac166a9db2d6ca2f8b99953b1df5:

  soundwire: cadence: do not extend reset delay (2021-08-23 17:40:34 +0530)

----------------------------------------------------------------
soundwire updates for 5.15-rc1

- Core has updates to support SoundWire mockup device (includes tag from
  asoc), improved error handling and slave status.

- Drivers has update on Intel driver for new quriks and better handling of
  errors and suspend routines

----------------------------------------------------------------
Bard Liao (3):
      soundwire: bus: update Slave status in sdw_clear_slave_status
      soundwire: stream: don't abort bank switch on Command_Ignored/-ENODATA
      soundwire: stream: don't program mockup device ports

Peter Ujfalusi (1):
      soundwire: cadence: Remove ret variable from sdw_cdns_irq()

Pierre-Louis Bossart (16):
      ASoC: codecs: add SoundWire mockup device support
      ASoC: soc-acpi: cnl: add table for SoundWire mockup devices
      ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
      ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests
      soundwire: dmi-quirks: add ull suffix for SoundWire _ADR values
      soundwire: bus: filter out more -EDATA errors on clock stop
      soundwire: dmi-quirks: add quirk for Intel 'Bishop County' NUC M15
      soundwire: cadence: add paranoid check on self-clearing bits
      soundwire: add flag to ignore all command/control for mockup devices
      soundwire: bus: squelch error returned by mockup devices
      soundwire: cadence: add debugfs interface for PDI loopbacks
      soundwire: cadence: override PDI configurations to create loopback
      soundwire: intel: fix potential race condition during power down
      soundwire: intel: skip suspend/resume/wake when link was not started
      soundwire: intel: conditionally exit clock stop mode on system suspend
      soundwire: cadence: do not extend reset delay

Vinod Koul (1):
      Merge tag 'asoc-sdw-mockup-codec' into next

 drivers/soundwire/bus.c                            |  14 +-
 drivers/soundwire/cadence_master.c                 | 229 ++++++++++++---
 drivers/soundwire/cadence_master.h                 |   7 +
 drivers/soundwire/dmi-quirks.c                     |  36 ++-
 drivers/soundwire/intel.c                          | 166 ++++++++---
 drivers/soundwire/intel.h                          |   1 +
 drivers/soundwire/stream.c                         |   5 +-
 include/linux/soundwire/sdw.h                      |   3 +
 sound/soc/codecs/Kconfig                           |  18 ++
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/sdw-mockup.c                      | 312 +++++++++++++++++=
++++
 sound/soc/intel/boards/Kconfig                     |   1 +
 sound/soc/intel/boards/sof_sdw.c                   |  41 +++
 sound/soc/intel/common/Makefile                    |   3 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |  15 +
 .../intel/common/soc-acpi-intel-sdw-mockup-match.c | 166 +++++++++++
 .../intel/common/soc-acpi-intel-sdw-mockup-match.h |  17 ++
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |  23 ++
 18 files changed, 966 insertions(+), 93 deletions(-)
 create mode 100644 sound/soc/codecs/sdw-mockup.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.h

Thanks
--=20
~Vinod

--LIerrMBQEjAEjAUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmEkgdUACgkQfBQHDyUj
g0d+PRAAvoQHjKRRRxMc6WKl+Bpjnbn7lEtMGJZV9GY8msfWKFcEw48C0yQ4sBjc
JUrWByEs2i4GN1dQZrXPXDiYCRt32CkRGXx6aXkdAnqZyAyGSHGQFIP7E3hJomto
npaSZxAnsc1XxgQ5afBxysWNfMlBzpuY2sqfnfHvKmaEotPA+cY8mnBtvRhLpkTI
IOQk5hsjA3Ah+L3uryTtvnK1EMwQUyVahq6r7QsMX3i+M0t4JBwYj6ruKVRNbkGD
/3pqFtAFDruObF4iufKUkRk9andI17mNbkkYSDLzb6TzUK2pPdIZWigegcoWAFy7
MENa51a3ZqqhCiymWxL9jHtSGGsWJryXgXwY0BKQo6i9mrLUIdNJIYAl9eHIzn6s
ZxYA8IV0jMXpDMaansWFI78gLPZuUb9IaNj2UIHHg2aemmX/IG8Nu0sAdubKul9F
GywLTZxqZ0MXkCMjlIipFNz2Dd+LiVBArTKyflFFwsYVxZG4gkfi4HoU4cOh9DDG
PadiDTgIqJrH+tYym3LjhfWEO9IvuzF7jU32x2FZHaUtL6Wwa4PkHWeI8YQJAoVj
dg1CDAg6q+/OCIxDYP+beno9lP/OYA7QrNdxbncsnNwjmWVFyZIClkdpJG+nF4cs
usTg2MnS2b+aVFCzJxWOg3V5wKu3wa/nDihoXiMySGSwrjQKXno=
=c7Tb
-----END PGP SIGNATURE-----

--LIerrMBQEjAEjAUG--
