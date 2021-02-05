Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8C311986
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhBFDJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:09:18 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45686 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhBFCil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:38:41 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D66E1A0228;
        Sat,  6 Feb 2021 00:50:45 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BA601A179A;
        Sat,  6 Feb 2021 00:50:44 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 80FFA40011;
        Fri,  5 Feb 2021 16:50:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 00/15] Cleanup of LS1021a device trees
Date:   Fri,  5 Feb 2021 17:47:19 -0600
Message-Id: <20210205234734.3397-1-leoyang.li@nxp.com>
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
- Update/convert related bindings to deal with some check issues

Li Yang (15):
  dt-bindings: arm: fsl: add ls1021a-tsn board
  dt-bindings: i2c: imx: update schema to align with original binding
  dt-bindings: memory: fsl: convert ifc binding to yaml schema
  ARM: dts: ls1021a: change to use SPDX identifiers
  ARM: dts: ls1021a-qds: Add node for QSPI flash
  ARM: dts: ls1021a: update pcie nodes for dt-schema check
  ARM: dts: ls1021a: fix board compatible to follow binding schema
  ARM: dts: ls1021a: breakup long values in thermal node
  ARM: dts: ls1021a: fix ifc node to follow binding schema
  ARM: dts: ls1021a: remove regulators simple-bus
  ARM: dts: ls1021a: fix memory node for schema check
  ARM: dts: ls1021a: add #dma-cells to qdma node
  ARM: dts: ls1021a: add #power-domain-cells for power-controller node
  ARM: dts: ls1021a-qds: change fpga to simple-mfd device
  ARM: dts: ls1021a-tsn: remove undocumented property "position" from
    mma8452 node

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/i2c/i2c-imx.yaml      |  11 +-
 .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
 .../bindings/memory-controllers/fsl/ifc.yaml  | 140 +++++++++++++++++
 arch/arm/boot/dts/ls1021a-qds.dts             |  88 ++++-------
 arch/arm/boot/dts/ls1021a-tsn.dts             |   2 +-
 arch/arm/boot/dts/ls1021a-twr.dts             |  65 +-------
 arch/arm/boot/dts/ls1021a.dtsi                | 141 +++++++-----------
 8 files changed, 233 insertions(+), 297 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml

-- 
2.17.1

