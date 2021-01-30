Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB0309543
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhA3NQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 08:16:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50536 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhA3NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 08:16:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10UDENVi011926;
        Sat, 30 Jan 2021 07:14:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612012463;
        bh=L/J5I2KkIPJZNSrlFwIakXVyKMxvDh3HJ0FmCiOuwPw=;
        h=Date:From:To:CC:Subject;
        b=ouyubAwo4PnPE01Q08BEqhi724AsfGMiJlWnlepFMHZFvV1ABKHVyZPo7UcpOlj0x
         AqPeoY+7W3LYXeQcdJhBbpXQWLnw6Y2KG0klguw8Y5OWX8JRWDAFwMDEj0UCevphFM
         wbgu0lRG9fdc7UwLKDEehrcWsfwplb8Kft+fvnik=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10UDENSF105895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jan 2021 07:14:23 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 30
 Jan 2021 07:14:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 30 Jan 2021 07:14:23 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10UDEMWC070354;
        Sat, 30 Jan 2021 07:14:23 -0600
Date:   Sat, 30 Jan 2021 07:14:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL 2/2] arm64: TI K3 DT updates for v5.12
Message-ID: <20210130131422.yvq2edxfongys7x5@pendant>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gkd7b7sfbn2ezeg6"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gkd7b7sfbn2ezeg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following device tree changes for v5.12 cycle.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-dt-for-v5.12

for you to fetch changes up to ae10ce938da59c19f303a91197ea7d664d1bc080:

  arm64: dts: ti: k3*: Fixup PMU compatibility to be CPU specific (2021-01-=
28 08:51:18 -0600)

----------------------------------------------------------------
Devicetree changes for TI K3 platforms for v5.12 merge window:

- Common fixups: PMU compatible, MMC dtbs_check warnings squelch

- J7200: R5F, PCIe, SERDES support

- J721E: PCIE fixups

----------------------------------------------------------------
Grygorii Strashko (1):
      arm64: dts: ti: k3: mmc: fix dtbs_check warnings

Kishon Vijay Abraham I (6):
      arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
      arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for pcieX_=
ctrl
      arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
      arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
      arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
      arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe

Nishanth Menon (1):
      arm64: dts: ti: k3*: Fixup PMU compatibility to be CPU specific

Suman Anna (3):
      arm64: dts: ti: k3-j7200: Add R5F cluster nodes
      arm64: dts: ti: k3-j7200-som-p0: Add mailboxes to R5Fs
      arm64: dts: ti: k3-j7200-som-p0: Add DDR carveout memory nodes for R5=
Fs

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   4 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |   2 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  38 +++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          | 161 +++++++++++++++++=
+++-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |  42 +++++-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  80 +++++++++-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi               |   2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  70 +++------
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |   2 +-
 9 files changed, 336 insertions(+), 65 deletions(-)
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--gkd7b7sfbn2ezeg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmAVW6cACgkQ3bWEnRc2
JJ20bQ//c3SydLlkqx1GMrOPBO5n/hpPlJ+C+LddeGifiW1i4Iof+fu8Fj4GgLZF
O8Q47fGzcAXdjGv3I8jn62K2CHocWAyoKQ70WoJPtLOzLd57hQ4QooQhHHi2edV7
uJtSh5tWOG7M/mCibs8lik0XROfPRUbYG8Ax/+yNt0zopO8W5nsd15ZzeeIOnuN1
MWclPoRBlt5Eaa/Br2ettDqBmOJa2mDaYOHQDRfkNrSDBo52h7aVX27HyLOkAj35
4SwpAT3vUjGq1JH4R61+USJXii06FrCtxMB6cczuewdQkM6HEL/f1VsUzKxfHj8L
DZhfsnwW5upCyWoogvP7zIwP4qbWW5P7F/NrdyrTd0arBdgXFvyXt7c/ZRIF1i25
TSo7YkymscR0ZH4Xetr78xtU0GJVfwKmpH5Iv2sbCGuYXo2T+Y1DpdotyQ0Vp+cw
wdkowdh1jEwZ+nNuEi/sNHBRrIOs0Hn1FyihXD1KcjsuDR5n1OZweHsRKbBnoag8
RCJYnAMNadlqOg/o98SB9ur2RixSrvJi2UK4UtlPv42NqLDrHb7w5L+OFrQOcWxV
R31/agA5K3JKyjF8eEQETKHcN1jCltiEfWNzrSoYw80FYQ2K3hweVxHEoMEVg1iP
mRVvb4XjUjlUGEH+fUDgK+LJvrOkw8cBxr0JRFyhBwgpzLeQNXM=
=MaoA
-----END PGP SIGNATURE-----

--gkd7b7sfbn2ezeg6--
