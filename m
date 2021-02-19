Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6404931FC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBSQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:02:01 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55588 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhBSQBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:01:47 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 527112000AA;
        Fri, 19 Feb 2021 17:00:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 413E72000E5;
        Fri, 19 Feb 2021 17:00:57 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DCC22042F;
        Fri, 19 Feb 2021 17:00:56 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 00/19] Rework support for i.MX8MQ interconnect with devfreq
Date:   Fri, 19 Feb 2021 17:59:57 +0200
Message-Id: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been on my queue for quite some time now. It is more of a
proof-of-concept.

This rework is done with the compatibility of future i.MX platforms in
mind. For example, the i.MX8MP platform has multiple NoCs. This
patchsets prepares the imx interconnect and imx devfreq for that too.

As of now, none of the drivers involved are being used and there is no
icc consumer on any off the i.MX platforms.

Basically, the steps taken here are the following:

1. Make the dram_apb clock "reparantable" from kernel.
This is needed in order to keep track of the actual parent of the 
dram_apb clock in the kernel clock hierarchy. Note that the actual
switch is done EL3 (TF-A).

2. Rework the imx-bus so the actual link between the icc and the 
NoCs or the pl301s is not tightly coupled. This allows us to have
as many NoCs as necessary but also allows as to use the same driver
for the pl301s. The pl301s have their own clocks too, so we need to
reduce their rates too.

3. Rework the imx8m-ddrc driver. Remove the support for dts defined
OPPs. The EL3 provides those. So instead of havingi to keep the OPP table in
both EL3 and kernel in sync, we rely on what the EL3 gives us.
Also, when the platform suspends, the bus needs to be running at highest
rate, otherwise there is a chance it might not resume anymore.
By adding the late system sleep PM ops we can handle that easily.

4. Rework the imx interconnect driver to use the fsl,icc-id instead
of the robust imx_icc_node_adj_desc for linking with the target node.
By adding the fsl,icc-id property to all the NoC and pl301 dts nodes,
we can link each icc node to their corresponding NoC, pl301 or dram.
Basically, when the imx interconnect platform specific driver probes,
it will take each node defined for that platform and look-up the
corresponding dts node based on the id and add that as the qos device.

5. Added the fec and usdhc as icc consumers. This is just as an example.
All the other consumers can be added later. Basically, each consumer
will add a path to their device node and in the driver will have to
handle that icc path accordingly.

Abel Vesa (19):
  clk: imx8mq: Replace critical with ignore_unused flag for dram_apb
    clock
  dt-bindings: interconnect: imx8mq: Add missing pl301 and SAI ids
  devfreq: imx-bus: Switch governor to powersave
  devfreq: imx-bus: Decouple imx-bus from icc made
  devfreq: imx8m-ddrc: Change governor to powersave
  devfreq: imx8m-ddrc: Use the opps acquired from EL3
  devfreq: imx8m-ddrc: Add late system sleep PM ops
  interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id
    node assignment
  interconnect: imx8: Remove the imx_icc_node_adj_desc
  interconnect: imx8mq: Add the pl301_per_m and pl301_wakeup nodes and
    subnodes
  interconnect: imx8mq: Add of_match_table
  interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
  arm64: dts: imx8mq: Add fsl,icc-id property to ddrc node
  arm64: dts: imx8mq: Add fsl,icc-id to noc node
  arm64: dts: imx8mq: Add all pl301 nodes
  arm64: dts: imx8mq: Add the interconnect node
  arm64: dts: imx8mq: Add interconnect properties to icc consumer nodes
  net: ethernet: fec_main: Add interconnect support
  mmc: sdhci-esdhc-imx: Add interconnect support

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 200 +++++++++++++++++++++-
 drivers/clk/imx/clk-imx8mq.c              |   2 +-
 drivers/devfreq/imx-bus.c                 |  42 +----
 drivers/devfreq/imx8m-ddrc.c              |  75 +++-----
 drivers/interconnect/imx/imx.c            |  92 +++++-----
 drivers/interconnect/imx/imx.h            |  19 +-
 drivers/interconnect/imx/imx8mm.c         |  32 ++--
 drivers/interconnect/imx/imx8mn.c         |  28 +--
 drivers/interconnect/imx/imx8mq.c         |  59 ++++---
 drivers/mmc/host/sdhci-esdhc-imx.c        |  26 +++
 drivers/net/ethernet/freescale/fec.h      |   3 +
 drivers/net/ethernet/freescale/fec_main.c |  19 ++
 include/dt-bindings/interconnect/imx8mq.h |   9 +
 scripts/dtc/fdtoverlay                    | Bin 0 -> 61280 bytes
 14 files changed, 393 insertions(+), 213 deletions(-)
 create mode 100755 scripts/dtc/fdtoverlay

-- 
2.29.2

