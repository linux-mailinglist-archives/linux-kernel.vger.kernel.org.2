Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FBB41E53C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351007AbhJAAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:06:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51440 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230221AbhJAAGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:06:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49C4F200BCB;
        Fri,  1 Oct 2021 02:04:22 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11540200B63;
        Fri,  1 Oct 2021 02:04:22 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 48A7940A77;
        Thu, 30 Sep 2021 17:04:21 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 00/16] Cleanup of LS1021a device trees
Date:   Thu, 30 Sep 2021 19:04:01 -0500
Message-Id: <20211001000417.15334-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches trying to cleanup the LS1021a based device
trees including:
- Add missing nodes
- Update to use SPDX tags
- Fix existing schema check issues in dts
- Update related bindings to deal with some check issues

Changes in V2
- Spin-off the IFC binding related patches into a separate series due to
  its dependency on driver changes
- Added two more fixes about thermal-zones node and flash compatible
- Remove copyright updates
- Updated description in i2c binding patch to clarify the intension
- Added Acked-by tag


Li Yang (16):
  dt-bindings: arm: fsl: add ls1021a-tsn board
  dt-bindings: i2c: imx: update schema to align with original txt
    binding
  ARM: dts: ls1021a: change to use SPDX identifiers
  ARM: dts: ls1021a-qds: Add node for QSPI flash
  ARM: dts: ls1021a: update pcie nodes for dt-schema check
  ARM: dts: ls1021a: fix board compatible to follow binding schema
  ARM: dts: ls1021a: breakup long values in thermal node
  ARM: dts: ls1021a: disable ifc node by default
  ARM: dts: ls1021a: remove regulators simple-bus
  ARM: dts: ls1021a: fix memory node for schema check
  ARM: dts: ls1021a: add #dma-cells to qdma node
  ARM: dts: ls1021a: add #power-domain-cells for power-controller node
  ARM: dts: ls1021a-qds: change fpga to simple-mfd device
  ARM: dts: ls1021a-tsn: remove undocumented property "position" from
    mma8452 node
  ARM: dts: ls1021a: move thermal-zones node out of soc/
  ARM: dts: ls1021a-tsn: use generic "jedec,spi-nor" compatible for
    flash

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/i2c/i2c-imx.yaml      |  12 +-
 arch/arm/boot/dts/ls1021a-qds.dts             |  86 +++-----
 arch/arm/boot/dts/ls1021a-tsn.dts             |   4 +-
 arch/arm/boot/dts/ls1021a-twr.dts             |  63 +-----
 arch/arm/boot/dts/ls1021a.dtsi                | 204 +++++++-----------
 6 files changed, 124 insertions(+), 246 deletions(-)

-- 
2.25.1

