Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C4341D28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCSMnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:43:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45972 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCSMno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:43:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfYFP107917;
        Fri, 19 Mar 2021 07:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157694;
        bh=uSKf2oDFa6c9KV6u9vbyFkn/JVaeAc8Tka00BC8gqUI=;
        h=From:To:CC:Subject:Date;
        b=IO9lDVr8Gs1O7/PRrBS/Ys2gZPnJzbxAlj51kYqvaodJU8D9JS+5miFwp1uPtv8K5
         Pv1egDeN8s9t4kkXviB2VeIeofHoqd00INSm6KKaBxlHmTgT/cMC4zs0JW5dL8SMoz
         pe9ytJiQ+5kmRablU3axhnSSjBmPwLu9q3KZDpns=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCfYmQ090700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:41:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:41:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:41:33 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTf1011913;
        Fri, 19 Mar 2021 07:41:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 00/13] PHY: Add support in Sierra to use external clock
Date:   Fri, 19 Mar 2021 18:11:15 +0530
Message-ID: <20210319124128.13308-1-kishon@ti.com>
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
v4 of the patch series can be found @ [5]
v5 of the patch series can be found @ [6]
v6 of the patch series can be found @ [7]

Changes from v6:
1) Fixed $subject of patches to just have Sierra
2) Added Reviewed-by Tags
3) Fixed dt-binding example which included phy-cadence-torrent.h

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
[7] -> http://lore.kernel.org/r/20210310154558.32078-1-kishon@ti.com

Kishon Vijay Abraham I (13):
  phy: cadence: Sierra: Fix PHY power_on sequence
  phy: ti: j721e-wiz: Invoke wiz_init() before
    of_platform_device_create()
  phy: cadence: Sierra: Create PHY only for "phy" or "link" sub-nodes
  phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link"
    subnode
  phy: cadence: Sierra: Move all clk_get_*() to a separate function
  phy: cadence: Sierra: Move all reset_control_get*() to a separate
    function
  phy: cadence: Sierra: Explicitly request exclusive reset control
  phy: cadence-torrent: Use a common header file for Cadence SERDES
  phy: cadence: Sierra: Add array of input clocks in "struct
    cdns_sierra_phy"
  phy: cadence: Sierra: Add missing clk_disable_unprepare() in .remove
    callback
  dt-bindings: phy: phy-cadence-sierra: Add binding to model Sierra as
    clock provider
  phy: cadence: Sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux
    clocks)
  phy: cadence: Sierra: Enable pll_cmnlc and pll_cmnlc1 clocks

 .../bindings/phy/phy-cadence-sierra.yaml      |  17 +-
 .../bindings/phy/phy-cadence-torrent.yaml     |   2 +-
 drivers/phy/cadence/Kconfig                   |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c      | 419 ++++++++++++++++--
 drivers/phy/cadence/phy-cadence-torrent.c     |   2 +-
 drivers/phy/ti/phy-j721e-wiz.c                |  21 +-
 include/dt-bindings/phy/phy-cadence-torrent.h |  15 -
 include/dt-bindings/phy/phy-cadence.h         |  20 +
 8 files changed, 429 insertions(+), 68 deletions(-)
 delete mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h
 create mode 100644 include/dt-bindings/phy/phy-cadence.h

-- 
2.17.1

