Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210D333C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhCJMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:09:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44444 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhCJMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:08:53 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8kNC031705;
        Wed, 10 Mar 2021 06:08:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615378126;
        bh=qY7ThBBsSPEZdjnXNXPHXBLNpfP2APeZIQPl0uTiT+0=;
        h=From:To:CC:Subject:Date;
        b=NF/dADPkNFcAhISAI7kwje610H+vvHrAM9Hd80+Ku80BIkL0c6FKzqF2t0G1AEMz9
         5nsfEfopjwVmI5Md+H8eB2s1vb0uDKqu6AKAYjlkqLvg676EsEZIRcCBbkaG9M4aTI
         cNipE2JAm/FSeq+OzezPv84sHeB62nnL8SNWb37c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AC8kvO110849
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 06:08:46 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 06:08:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 06:08:46 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8ghb017368;
        Wed, 10 Mar 2021 06:08:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 0/6] AM64: Add SERDES driver support
Date:   Wed, 10 Mar 2021 17:38:34 +0530
Message-ID: <20210310120840.16447-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 uses the same SERDES as in J7200, however AM642 EVM doesn't
have a clock generator (unlike J7200 base board). Here the clock from
the SERDES has to be routed to the PCIE connector. This series adds
support to drive reference clock output from SERDES and also adds
SERDES (torrent) and SERDES wrapper (WIZ) bindings.

v1 of the patch series can be found @ [1]
v2 of the patch series can be found @ [3]

Changes from v2:
*) Sent the DT bindings as a separate series [4]
*) Remove enabling PHY output clock in isolation mode

Changes from v1:
*) Model the internal clocks without device tree input (Add #clock-cells
   to SERDES DT nodes for getting a reference to the clock using index
   to phandle). This is in accordance with comment given by Rob [2].
   However the existing method to model clocks from device tree is not
   removed to support upstreamed device tree.
*) Included a patch to fix modifying static data by instance specific
   initializations.
*) Added a fix to delete "clk_div_sel" clk provider during cleanup

[1] -> https://lore.kernel.org/r/20201224114250.1083-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20210108025943.GA1790601@robh.at.kernel.org
[3] -> http://lore.kernel.org/r/20210222112314.10772-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20210310112745.3445-1-kishon@ti.com

Kishon Vijay Abraham I (6):
  phy: ti: j721e-wiz: Remove "regmap_field" from wiz_clk_{mux|div}_sel
  phy: ti: j721e-wiz: Delete "clk_div_sel" clk provider during cleanup
  phy: ti: j721e-wiz: Configure full rate divider for AM64
  phy: ti: j721e-wiz: Model the internal clocks without device tree
    input
  phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
  phy: cadence-torrent: Add support to drive refclk out

 drivers/phy/cadence/Kconfig               |   1 +
 drivers/phy/cadence/phy-cadence-torrent.c | 188 +++++++++++-
 drivers/phy/ti/phy-j721e-wiz.c            | 349 +++++++++++++++++++---
 3 files changed, 488 insertions(+), 50 deletions(-)

-- 
2.17.1

