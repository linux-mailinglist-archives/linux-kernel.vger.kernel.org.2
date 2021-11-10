Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E856444CC87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhKJWZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:25:24 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36158 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhKJWZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:25:23 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FB151A08E2;
        Wed, 10 Nov 2021 23:22:34 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0455E1A1196;
        Wed, 10 Nov 2021 23:22:34 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 1E45C40BCF;
        Wed, 10 Nov 2021 15:22:33 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 00/11] lx216x DTS updates
Date:   Wed, 10 Nov 2021 16:21:49 -0600
Message-Id: <20211110222200.6780-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accumulated updates for lx2160/lx2162 SoC and boards with two
missing binding updates being used already.

Ioana Radulescu (1):
  arm64: dts: lx2160a-rdb: Add Inphi PHY node

Li Yang (3):
  dt-bindings: qoriq-clock: add missing compatible for lx2160a
  dt-bindings: fsl,layerscape-dcfg: add missing compatible for lx2160a
  arm64: dts: lx2160a: update PCIe nodes to match rev2 silicon

Pankaj Bansal (1):
  arm64: dts: lx2160aqds: Add mdio mux nodes

Pankaj Gupta (1):
  arm64: dts: lx2160a: add optee-tz node

Peng Ma (1):
  arm64: dts: lx2160a-qds: enable sata nodes

Ran Wang (1):
  arm64: dts: lx2160a: enable usb3-lpm-capable for usb3 nodes

Xiaowei Bao (1):
  arm64: dts: lx2160a: add pcie EP mode nodes

Yangbo Lu (1):
  arm64: dts: lx2162aqds: support SD UHS-I and eMMC HS400 modes

Zhang Ying-22455 (1):
  arm64: dts: lx2160a: fix scl-gpios property name

 .../arm/freescale/fsl,layerscape-dcfg.txt     |   2 +-
 .../devicetree/bindings/clock/qoriq-clock.txt |   1 +
 .../boot/dts/freescale/fsl-lx2160a-qds.dts    | 165 +++++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  21 +++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 170 ++++++++++++------
 .../boot/dts/freescale/fsl-lx2162a-qds.dts    |   7 +
 6 files changed, 315 insertions(+), 51 deletions(-)

-- 
2.25.1

