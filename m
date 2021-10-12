Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517FB42B0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhJMAI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:08:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33140 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232243AbhJMAIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 336F4201F28;
        Wed, 13 Oct 2021 02:06:21 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EF88B2001AA;
        Wed, 13 Oct 2021 02:06:20 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 3984A40A77;
        Tue, 12 Oct 2021 17:06:20 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 00/17] Cleanup of LS1021a device trees
Date:   Tue, 12 Oct 2021 18:58:06 -0500
Message-Id: <20211012235824.31096-1-leoyang.li@nxp.com>
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

Changes in V3
- Remove the flash label and num-cs
- Drop the i2c-imx binding change, instead update the DTS to remove
  clock-names and re-order DMA channels

Li Yang (17):
  dt-bindings: arm: fsl: add ls1021a-tsn board
  ARM: dts: ls1021a: remove clock-names property for i2c nodes
  ARM: dts: ls1021a: change dma channels order to match schema
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
 arch/arm/boot/dts/ls1021a-qds.dts             |  85 ++-----
 arch/arm/boot/dts/ls1021a-tsn.dts             |   4 +-
 arch/arm/boot/dts/ls1021a-twr.dts             |  63 +----
 arch/arm/boot/dts/ls1021a.dtsi                | 219 +++++++-----------
 5 files changed, 123 insertions(+), 249 deletions(-)

-- 
2.25.1

