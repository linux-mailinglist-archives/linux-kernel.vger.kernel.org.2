Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94B42A3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhJLMKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:10:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:10:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19CC8Hso051427;
        Tue, 12 Oct 2021 07:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634040497;
        bh=4oOkOKVmpHRmmefNMWhNF9KUMmYSnPAMUu8b9ZRQ18E=;
        h=Date:From:To:CC:Subject;
        b=UGUe7sdYZgAmBT6Ha8B6h+Lg4Ekf7dpH/zL35Bavwn+JbVTsel+gWQyqxM8nHeVfr
         JDGyRWt2dpojhi7wBzjdeSS2jj8A5LVr3cZtIq5k0J9m1CgTzarfp7wh+PwZyqT4L6
         bxu6pbfiyvoJco5Z6RAoJ9LJknQwS+3mkEn94SLw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19CC8HfM051869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Oct 2021 07:08:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Oct 2021 07:08:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Oct 2021 07:08:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19CC8Ho3002677;
        Tue, 12 Oct 2021 07:08:17 -0500
Date:   Tue, 12 Oct 2021 07:08:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL] arm64: dts: TI K3 updates for v5.16
Message-ID: <20211012120817.beqhp4tygnf3xyi5@wireless>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcl6uq6jur7wwyyd"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kcl6uq6jur7wwyyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

We are still working on cleaning up various other existing device tree
binding warnings, which we hope to address in follow on kernel revs.
Primarily: audio, adc, ufs, display bridge.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-dt-for-v5.16

for you to fetch changes up to f46d16cf5b43b66de030f0e3b2f20d24ba95f369:

  arm64: dts: ti: k3-j721e-sk: Add DDR carveout memory nodes (2021-10-05 17=
:46:40 -0500)

----------------------------------------------------------------
Devicetree changes for TI K3 platforms for v5.16 merge window:

* New Platforms:
  - AM654: Siemens IOT2050 PG2 boards
  - J721E: Low cost SK board
* New features:
  - mmc aliases introduced
  - AM64 ICSSG nodes, mcu pinctrl added
* Fixes:
  - Schema fixups for pcie, thermal zones
  - Fixup to include board specific property for J721e-evm and j7200-evm
  - Misc fixups including cleaning up order in Makefile

----------------------------------------------------------------
Christian Gmeiner (1):
      arm64: dts: ti: k3-am64-mcu: Add pinctrl

Jan Kiszka (6):
      arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
      arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
      arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F=
 cores
      dt-bindings: arm: ti: Add bindings for Siemens IOT2050 PG2 boards
      arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
      arm64: dts: ti: iot2050: Add support for product generation 2 boards

Kishon Vijay Abraham I (6):
      arm64: dts: ti: k3-j721e-main: Fix "max-virtual-functions" in PCIe EP=
 nodes
      arm64: dts: ti: k3-j721e-main: Fix "bus-range" upto 256 bus number fo=
r PCIe
      arm64: dts: ti: j7200-main: Fix "vendor-id"/"device-id" properties of=
 pcie node
      arm64: dts: ti: j7200-main: Fix "bus-range" upto 256 bus number for P=
CIe
      arm64: dts: ti: j7200-main: Add *max-virtual-functions* for pcie-ep D=
T node
      arm64: dts: ti: k3-am65-main: Cleanup "ranges" property in "pcie" DT =
node

Nishanth Menon (6):
      arm64: dts: ti: ti-k3*: Introduce aliases for mmc nodes
      arm64: dts: ti: k3-am65: Relocate thermal-zones to SoC specific locat=
ion
      arm64: dts: ti: Makefile: Collate AM64 platforms together
      dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
      arm64: dts: ti: k3-j721e-common-proc-board: Add j721e-evm compatible
      arm64: dts: ti: k3-j7200-common-proc-board: Add j7200-evm compatible

Sinthu Raja (4):
      dt-bindings: arm: ti: Add compatible for J721E SK
      arm64: dts: ti: Add support for J721E SK
      arm64: dts: ti: k3-j721e-sk: Add IPC sub-mailbox nodes
      arm64: dts: ti: k3-j721e-sk: Add DDR carveout memory nodes

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   15 +-
 arch/arm64/boot/dts/ti/Makefile                    |    4 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  280 ++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi            |    8 +
 arch/arm64/boot/dts/ti/k3-am64.dtsi                |    2 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |    8 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |    8 +
 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    |   46 +
 .../boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   51 +
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |   39 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |    8 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |    4 -
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |    2 +
 .../dts/ti/k3-am6528-iot2050-basic-common.dtsi     |   60 ++
 .../boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts    |   24 +
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts |   56 +-
 arch/arm64/boot/dts/ti/k3-am654.dtsi               |    4 +
 .../dts/ti/k3-am6548-iot2050-advanced-common.dtsi  |   56 ++
 .../boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts |   29 +
 .../boot/dts/ti/k3-am6548-iot2050-advanced.dts     |   50 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |    3 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |    7 +-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi               |    2 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |    3 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   16 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 1002 ++++++++++++++++=
++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |    3 +
 27 files changed, 1665 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.d=
tsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-commo=
n.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.d=
ts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk.dts

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 8=
49D 1736 249D

--kcl6uq6jur7wwyyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmFleqoACgkQ3bWEnRc2
JJ1/Ow//eG/2mK+z7FsxSD9V6Xpvzwz3FwQbzRRWn5KnT/hn3autI/k8P55xnqGw
COfdlo4oVs2r+38erm+PjanPlvf8Tye29RLxV31zcMjrA+Gde++gpulIMk2CNluT
/RW75lPqUrIHvPZ8GdlK6q5WJ64ZgRLrDF9aWPRTQ9GSsPdcyQWw2R9dDuk1/8yL
oumA7dwb7eYIdlZPjeSVq2PWqUp9/od8vYtpTHxzVGDodNillsfrw1sNqgoNc5AC
8STqWepbhxM4nYqpvhV8PvijvtuUKXjV8O8AdjSYDVQSM8wcmo/589+GMdEoz7a2
VhV1vUTQlWmROH3iHnYs3lkUN5IMP+8SkrDePrWlro0Tw0JndOLkY8fVh8Z7jf1y
ZKLUkQtInoe3Uw84emkGzv/MitdX3qHNa7g/F2Jjcpm67mQ4YWbna2XQuGtcWIuT
eAtG80cTJr5qXqplLM3usppnVt26UWKzYFa7PpoYRcMOYzkSFzgq36lwq0RXewo7
Tu9JmEcqJ4Kae2kvRrlHn9h0JGPIvS0JPREjzQcXvWNkn07fmCsVJCvazuoWImQB
NldTry7S7zwiG61YjcDPRWejZt8bU5gvnA2uJdgafzvo8PUNkD9wSBcIAKyTsrMI
3cmopDkN8iYEw7LhRBcSJRKea5+6S736TnuEm0Z0///6IBvwHHw=
=e6hK
-----END PGP SIGNATURE-----

--kcl6uq6jur7wwyyd--
