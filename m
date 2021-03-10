Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013F93341E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhCJPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:46:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47654 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhCJPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:46:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFk6CN067600;
        Wed, 10 Mar 2021 09:46:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391166;
        bh=AUn7XpCLIngAp4n26qKR/3PFFYMJbQoYcvX98ciR6gI=;
        h=From:To:CC:Subject:Date;
        b=rqtHkgX5OhrDx6BZ2cqWuHo6NV5PQoMaemvR3lck9KwOi7esikm2d3C7QiYlI/qYT
         X/zSETkHjSi67TeNUJFOkj201yx37st8uEAfuGV9x1AujESuuxRwzDuYFNHM7wfMG7
         xfoR5oVCkGMoR/PcmycL/Gl5/Kly0roWaYvHnvlE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFk6WN087462
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:46:06 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:46:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:46:05 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFk2KO066370;
        Wed, 10 Mar 2021 09:46:02 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 00/13] PHY: Add support in Sierra to use external clock
Date:   Wed, 10 Mar 2021 21:15:45 +0530
Message-ID: <20210310154558.32078-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds support in Sierra driver to use external clock.

v1 of the patch series can be found @ [1]
v2 of the patch series can be found @ [2]
v3 of the patch series can be found @ [3]
v5 of the patch series can be found @ [5]
v6 of the patch series can be found @ [6]

Changes from v5:
1) Added Rob's Reviewed-by for the DT binding
2) Fixed another error handling case pointed out by Swapnil
3) Fixed few checkpatch errors.

Changes from v4:
1) Fixed couple of error handling cases
2) Added reviewed by from Philipp Zabel
3) Fixed couple of patch commit subjects to be uniform with other
patches.

Changes from v3:
1) Instead of adding separate subnodes for each clock, just add
#clock-cells in Sierra SERDES nodes and model the clocks. This is
in alignment with Rob's comment for a different series [4]
2) Removed device tree changes from the series.

Changes from v2:
1) Add depends on COMMON_CLK in Sierra
2) Add modelling PLL_CMNLC and PLL_CMNLC1 as clocks into a separate
patch
3) Disable clocks in Sierra driver remove

Changes from v1:
1) Remove the part that prevents configuration if the SERDES is already
   configured and focus only on using external clock and the associated
   cleanups
2) Change patch ordering
3) Use exclusive reset control APIs
4) Fix error handling code
5) Include DT patches in this series (I can send this separately to DT
MAINTAINER once the driver patches are merged)

[1] -> http://lore.kernel.org/r/20201103035556.21260-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201222070520.28132-1-kishon@ti.com
[3] -> http://lore.kernel.org/r/20201224111627.32590-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20210108025943.GA1790601@robh.at.kernel.org
[5] -> https://lore.kernel.org/r/20210304044122.15166-1-kishon@ti.com
[6] -> https://lore.kernel.org/r/20210308050732.7140-1-kishon@ti.com

Kishon Vijay Abraham I (13):
  phy: cadence: Sierra: Fix PHY power_on sequence
  phy: ti: j721e-wiz: Invoke wiz_init() before
    of_platform_device_create()
  phy: cadence: cadence-sierra: Create PHY only for "phy" or "link"
    sub-nodes
  phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link"
    subnode
  phy: cadence: cadence-sierra: Move all clk_get_*() to a separate
    function
  phy: cadence: cadence-sierra: Move all reset_control_get*() to a
    separate function
  phy: cadence: cadence-sierra: Explicitly request exclusive reset
    control
  phy: cadence-torrent: Use a common header file for Cadence SERDES
  phy: cadence: cadence-sierra: Add array of input clocks in "struct
    cdns_sierra_phy"
  phy: cadence: cadence-sierra: Add missing clk_disable_unprepare() in
    .remove callback
  dt-bindings: phy: phy-cadence-sierra: Add binding to model Sierra as
    clock provider
  phy: cadence: phy-cadence-sierra: Model PLL_CMNLC and PLL_CMNLC1 as
    clocks (mux clocks)
  phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks

 .../bindings/phy/phy-cadence-sierra.yaml      |  17 +-
 drivers/phy/cadence/Kconfig                   |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c      | 419 ++++++++++++++++--
 drivers/phy/cadence/phy-cadence-torrent.c     |   2 +-
 drivers/phy/ti/phy-j721e-wiz.c                |  21 +-
 include/dt-bindings/phy/phy-cadence-torrent.h |  15 -
 include/dt-bindings/phy/phy-cadence.h         |  20 +
 7 files changed, 428 insertions(+), 67 deletions(-)
 delete mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h
 create mode 100644 include/dt-bindings/phy/phy-cadence.h

-- 
2.17.1

