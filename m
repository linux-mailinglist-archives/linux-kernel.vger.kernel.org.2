Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56B4391B99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhEZPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:24:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35140 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhEZPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:24:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2549E1F431D4
Received: by jupiter.universe (Postfix, from userid 1000)
        id CDDB54800DE; Wed, 26 May 2021 17:22:51 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCHv3 0/3] Support for GE B1x5v2 and B1x5Pv2
Date:   Wed, 26 May 2021 17:22:40 +0200
Message-Id: <20210526152243.51059-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for another General Electric patient
monitor series (similar to existing Bx50v3), which is based on
i.MX6DL using Congatec's QMX6 module.

This series has a runtime dependency on two commits, that have
already been merged to linux-next:

1. Any imx6dl-qmx6 based boards without f765e349c3e1 ("rtc: m41t80:
   add support for fixed clock") and CONFIG_RTC_DRV_M41T80 enabled
   will result in unstable system. Because the kernel will disable
   one of the CPU clocks.

2. Booting B155(P)v2 additionally requires 94dfec48fca7 ("drm/imx:
   Add 8 pixel alignment fix") to avoid boot hanging indefinitely.

Changes since PATCHv2:
 * https://lore.kernel.org/lkml/20210428222953.235280-1-sebastian.reichel@collabora.com/
 * Add Acked-by from Rob Herring to patch DT binding patches
 * Drop RTC and DRM patch (applied)
 * order DT Makefile entries alphabetically
 * order DT nodes alphabetically
 * Remove a couple of superfluous status = 'okay';
 * Move compatible property to start of nodes
 * Move status property to end of nodes (but before sub-nodes)
 * Drop useless fsl,spi-num-chipselects property
 * Update pinctrl config for audio pins fixing noise issue affecting some boards
 * rebased to v5.13-rc1

Changes since PATCHv1:
 * https://lore.kernel.org/lkml/20210222171247.97609-1-sebastian.reichel@collabora.com/
 * drop patch 5 (applied)
 * instead of using 'protected-clocks' in RTC node, add fixed-clock
   node as suggested by Saravana Kannan
 * rebased to current master (68a32ba14177)

Thanks,

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: vendor-prefixes: add congatec
  dt-bindings: arm: fsl: add GE B1x5pv2 boards
  ARM: dts: imx6: Add GE B1x5v2

 .../devicetree/bindings/arm/fsl.yaml          |  11 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   5 +
 arch/arm/boot/dts/imx6dl-b105pv2.dts          |  32 +
 arch/arm/boot/dts/imx6dl-b105v2.dts           |  32 +
 arch/arm/boot/dts/imx6dl-b125pv2.dts          |  30 +
 arch/arm/boot/dts/imx6dl-b125v2.dts           |  30 +
 arch/arm/boot/dts/imx6dl-b155v2.dts           |  32 +
 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi         | 413 ++++++++++++
 arch/arm/boot/dts/imx6dl-b1x5v2.dtsi          |  58 ++
 arch/arm/boot/dts/imx6dl-qmx6.dtsi            | 612 ++++++++++++++++++
 11 files changed, 1257 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-b105pv2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b105v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b125pv2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b125v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b155v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-b1x5v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-qmx6.dtsi

-- 
2.30.2

