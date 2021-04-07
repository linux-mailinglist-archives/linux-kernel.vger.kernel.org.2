Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9F356C19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352184AbhDGMbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235368AbhDGMbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA9EF60FEE;
        Wed,  7 Apr 2021 12:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617798668;
        bh=BOWtBqadjO4pUurB7R+rTs0QMWY2HKWF2R3IZ05VFjU=;
        h=Date:From:To:Cc:Subject:From;
        b=HB/Q4V5ArIrSoisHQ4oQcwVlwZChbxuVnkhfy3o10/aqNGS6grYLKFJdemtkiUkFB
         YK9U13GKrbSo/hBSsm6EzlIFR4WAdci56GRpNh0Gjs+sMwP5vVgz5DQMz6HYEzl8d5
         +rLfXCwnoA4TTotvUgFkUjU0wwt93zmXhXKe+QcBY0KdSqugyuGv8qstbykSzI588S
         49iKhvokCxB3hl+yRK6wIV8A1U+ghyxHy0jGd4SS9e+fvkOFD7iDl+mUi0CjxtniXp
         swAu0+vOBWajxFyjDY/Uue3FKuLd9KrILrGSY4d2JRJg2Wm21t1uOUCwI0OH9ba+3n
         CpW6wbc+10EDA==
Date:   Wed, 7 Apr 2021 18:01:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.13-rc1
Message-ID: <YG2mCCQUiSrouQoo@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gAUNDmWExdT5yU8h"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gAUNDmWExdT5yU8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Here is the soundwire pull request for this cycle. Bunch of core cleanup
and changes along with driver updates

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.13-rc1

for you to fetch changes up to 14968dd36a507866be0edfc2a05d48c997da5d99:

  soundwire: intel_init: test link->cdns (2021-04-06 10:26:44 +0530)

----------------------------------------------------------------
soundwire updates for 5.13-rc1

Updates for v5.13-rc1 are:

Core:
 - Ability to add quirks for masters
 - static checker cleanup for bus code

Drivers:
 - DMI quirks for Intel controllers
 - static checker cleanup for drivers
 - add auto enumeration support qcom controller

----------------------------------------------------------------
Bard Liao (4):
      soundwire: add master quirks for bus clash and parity
      soundwire: bus: handle master quirks for bus clash and parity
      soundwire: intel: add master quirks for bus clash and parity
      soundwire: intel_init: test link->cdns

Pierre-Louis Bossart (22):
      soundwire: Intel: introduce DMI quirks for HP Spectre x360 Convertible
      soundwire: Intel: add DMI quirk for Dell SKU 0A3E
      soundwire: intel: add missing \n in dev_err()
      soundwire: bandwidth_allocation: add missing \n in dev_err()
      soundwire: cadence: add missing \n in dev_err()
      soundwire: stream: add missing \n in dev_err()
      soundwire: qcom: add missing \n in dev_err()
      soundwire: bus: use correct driver name in error messages
      soundwire: bus: test read status
      soundwire: bus: use consistent tests for return values
      soundwire: bus: demote clock stop prepare log to dev_dbg()
      soundwire: bus: uniquify dev_err() for SCP_INT access
      soundwire: bus: remove useless initialization
      soundwire: generic_bandwidth_allocation: remove useless init
      soundwire: intel: remove useless readl
      soundwire: qcom: check of_property_read status
      soundwire: stream: remove useless initialization
      soundwire: stream: remove useless bus initializations
      soundwire: cadence_master: fix kernel-doc
      soundwire: add definition for DPn BlockPackingMode
      soundwire: generic_allocation: fix confusion between group and packing
      soundwire: cadence: only prepare attached devices on clock stop

Rander Wang (1):
      soundwire: stream: fix memory leak in stream config error path

Srinivas Kandagatla (16):
      soundwire: bus: Fix device found flag correctly
      dt-bindings: soundwire: qcom: clarify data port bus parameters
      soundwire: qcom: add support to missing transport params
      soundwire: qcom: set continue execution flag for ignored commands
      soundwire: qcom: start the clock during initialization
      soundwire: qcom: update register read/write routine
      soundwire: qcom: add support to new interrupts
      soundwire: export sdw_compare_devid, sdw_extract_slave_id and sdw_sla=
ve_add
      soundwire: qcom: add auto enumeration support
      soundwire: qcom: wait for enumeration to be complete in probe
      soundwire: add static port mapping support
      soundwire: qcom: update port map allocation bit mask
      soundwire: qcom: add static port map support
      soundwire: qcom: wait for fifo space to be available before read/write
      soundwire: qcom: cleanup internal port config indexing
      soundwire: qcom: handle return correctly in qcom_swrm_transport_params

Vinod Koul (2):
      soundwire: add override addr ops
      soundwire: qcom: use signed variable for error return

 .../devicetree/bindings/soundwire/qcom,sdw.txt     |  20 +
 drivers/soundwire/Makefile                         |   2 +-
 drivers/soundwire/bus.c                            | 100 +++-
 drivers/soundwire/bus.h                            |   2 +
 drivers/soundwire/bus_type.c                       |  15 +-
 drivers/soundwire/cadence_master.c                 |  16 +-
 drivers/soundwire/dmi-quirks.c                     |  96 +++
 drivers/soundwire/generic_bandwidth_allocation.c   |  15 +-
 drivers/soundwire/intel.c                          |  24 +-
 drivers/soundwire/intel_init.c                     |   9 +
 drivers/soundwire/qcom.c                           | 652 +++++++++++++++++=
----
 drivers/soundwire/slave.c                          |   9 +-
 drivers/soundwire/stream.c                         |  28 +-
 include/linux/soundwire/sdw.h                      |  36 +-
 14 files changed, 833 insertions(+), 191 deletions(-)
 create mode 100644 drivers/soundwire/dmi-quirks.c

Thanks
--=20
~Vinod

--gAUNDmWExdT5yU8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmBtpggACgkQfBQHDyUj
g0dQCw/+J3FzDh2oVtb7ky27Nle1vAr1Ro+efG60X2S4xtIqsBvrmqTqGf/EerBI
DWa0ijRI8zWRKMueP1eNoDHrnfuaxIFI+iFTUpNBK5eix5LMd5q2GvOxUUwzBDJg
ZQz+R0pnQsY736IIDVhSAvdcKbu8xrnkeIxlunkdA7dFNC5GN43R0W1wQ/Ongz2n
6QgCRJlfR/mNz8hSUpLLvtl9ncgR95jQoGXgvcCG+nV7JoMc0xborDQzoyI1NIfU
SwvdjTm3HUonpGESGvVYoC3iptWgMN10SjcoHh5AAsF4fsZsJwp1giLkYMOk6c0c
hw5BSXRrAmVFzZ4FqrXsev0b550qz2eQ2G1GVqQwt+CCtluJBKEUTN0fFcoVjLXg
bV2ZfbQTsbjkm6SWFRiHzd9ybgqkSkYppPPFC0meN6Jq3HgzBRL+Gl3QlU68BHSc
W8uR7EKEe9qySpzU9h2StawuumtV3YM5xvYJ5w+/cYIZdUCiTfKA4cjBoocGX8S7
YFsVQnzc1asIq7Wu5q2xpRhaPgbm+BBvin9TqkYsXjb7yY6QBjBNqo6v2LPkNQGc
PTNIkKB0owauwedIAWUXZu6LSVl7xMIl7pHJHzmktGJfOSaFW4U/deXODCQRvSMu
PDpKITXthCQq30vJH3Vl/9amS+oD6NAaMJ1bRDs/wJQy6hVvono=
=1VnQ
-----END PGP SIGNATURE-----

--gAUNDmWExdT5yU8h--
