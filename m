Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7545E7C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbhKZGU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhKZGS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:18:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD05461108;
        Fri, 26 Nov 2021 06:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637907344;
        bh=7i6gFe2C6oGCBK0Fvigb5z0S/fOiViYh88W5TJHbEdM=;
        h=Date:From:To:Cc:Subject:From;
        b=PMvUPJArqSFpqe5bgiJj/i4GO8Rm7LNL0v4paqVTouvuFSgmiObf02taeYQSjdKMQ
         FYHHKn1gT1/26Bw9WOha+cZH1mApVsmhD8p6mycHbY7LrxTEQ3V8MTe4O6jDB3+MFm
         f0d+0VCQiOGEXIo3/MxO7K7alUZNhB3ejHMVNm00NNDzvFbIHJWps9yd2gT/20nT8u
         E4xrV66mNv3BIwLmE/pa2ywqbPvf56FmbhFY4wweCczeDWLHvsmXGUk/4dyktyOwz4
         OjuMgWs/gecdF68x1YBUJZew0pifoMvwdgc5vtQpp5mnkxovHrF0YduoMF+GYTw3lF
         SyRdmEzmpwy4Q==
Date:   Fri, 26 Nov 2021 11:45:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: Generic phy fixes for v5.16
Message-ID: <YaB7jK+ADoUQHWjh@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wb8CkePjKWIP3qbP"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wb8CkePjKWIP3qbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to recieve bunch of fixes for generic phy subsystem. These
contain mostly kernel-doc warning fixes along with couple of driver
fixes.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-5.16

for you to fetch changes up to f0ae8685b2858fc1dabf5ea743642abb5f242375:

  phy: HiSilicon: Fix copy and paste bug in error handling (2021-11-23 10:4=
2:13 +0530)

----------------------------------------------------------------
phy: fixes for 5.16

Fixes for:
 - kernel-doc warnings for various drivers
 - error handling fix for HiSilicon driver
 - name fix for zynqmp phy
 - property name fix in stm32 phy

----------------------------------------------------------------
Amelie Delaunay (1):
      phy: stm32: fix st,slow-hs-slew-rate with st,decrease-hs-slew-rate

Dan Carpenter (1):
      phy: HiSilicon: Fix copy and paste bug in error handling

Liam Beguin (1):
      dt-bindings: phy: zynqmp-psgtr: fix USB phy name

Randy Dunlap (1):
      phy: ti: report 2 non-kernel-doc comments

Vinod Koul (6):
      phy: mvebu-cp110-utmi: Fix kernel-doc warns
      phy: qualcomm: qmp: Add missing struct documentation
      phy: qualcomm: usb-hsic: Fix the kernel-doc warn
      phy: ti: tusb1210: Fix the kernel-doc warn
      phy: qualcomm: ipq806x-usb: Fix kernel-doc style
      phy: ti: omap-usb2: Fix the kernel-doc style

 .../devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml |  2 +-
 drivers/phy/hisilicon/phy-hi3670-pcie.c            |  4 ++--
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         |  4 ++--
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        | 26 ++++++++++++------=
----
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  3 +++
 drivers/phy/qualcomm/phy-qcom-usb-hsic.c           |  2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |  2 +-
 drivers/phy/ti/phy-am654-serdes.c                  |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |  2 +-
 drivers/phy/ti/phy-omap-usb2.c                     |  6 ++---
 drivers/phy/ti/phy-tusb1210.c                      |  2 +-
 11 files changed, 30 insertions(+), 25 deletions(-)

Thanks
--=20
~Vinod

--Wb8CkePjKWIP3qbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmGge4wACgkQfBQHDyUj
g0dsdw//T5ZvdCm1jzrV62/7wFTeHNNOXXnfmPCF0oe4E+CfIUs6ZPLbrauC8etG
ySobv58PBNuwUUw/LTVgIzcws+NRZIh/b79hFW1ieH50zYyUlcOi2uS1wyRIjOVt
rZYtnFWUezsm4u46+43u5uK9aEU9Vrkmet5zMABm86FnuAtvuvvcSCO9VbeaHet9
NFcoqTLK6Smt13pLOdDTf2iBq3VuiNa1HEQ2EsCKp3JL2fZ8UjsHfajz5f5kILhl
LrS0FKztMuXivOcTDM7Wb8tfiRkmTsDAeVizpuZej/zJTnyASYT4B8MgIZeemoPv
Wrv6Knv0UVWwjr/4Wxu4DpEJ9QhiOG9gdGPkBlrfVgWInN6MjX+3/YZBBDWsULMf
1egKmHcNGYi3b2sNS1gXmeviCdD+GmBFEj4pKe9ldCCZqupzohKv9RQ3arvCOpyT
cc7wLma61+LzXONgv0sGf/lh0uVZ6Fb0Vk62pjXyI327JTZhIYJGI37kwjSqhY5W
oCY9lKOI6JhDeKCp09PMndllutMGgy83IBHKiBadEFM70Fmg4ZQnGdZ56PhD8PhC
9QelLNDSks1925FUpFZwk28hRnXjC/m7PNBI3qszVbImKurcPUTG2SmSPwwchsUm
OXgOOQKTBxevObj42HbWSttbbUn6kEuuSNxLTbw78ozvFCWcwPY=
=5fSZ
-----END PGP SIGNATURE-----

--Wb8CkePjKWIP3qbP--
