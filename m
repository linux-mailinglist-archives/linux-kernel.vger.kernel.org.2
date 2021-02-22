Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1538C321508
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBVLZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:25:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59002 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhBVLYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:24:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNYSZ035075;
        Mon, 22 Feb 2021 05:23:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613993014;
        bh=eg79OgHeosFuQo7HrdUnztwwOwIbN8h6QbcvgDDBaog=;
        h=From:To:CC:Subject:Date;
        b=TlTrBh27TnlfrSKw1KlO+niUHt+WdvU/HT5UKK86VoD2qqhFarC2uHxuQtRdTu2iw
         MGPMPti7LUYM1HyBmqNNBv31/xzRWKPvgA+Y5/4q/6pMjleaLDFZex84znOlqfjhxC
         Tu2Y1dMvYZn5W9ztl4cCZ2IH6C9zmBbOUrXDgcsE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBNYms038366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:23:34 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:23:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:23:33 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNFDZ088010;
        Mon, 22 Feb 2021 05:23:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v2 0/9] AM64: Add SERDES bindings and driver support
Date:   Mon, 22 Feb 2021 16:53:05 +0530
Message-ID: <20210222112314.10772-1-kishon@ti.com>
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

Kishon Vijay Abraham I (9):
  dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES
    Wrapper
  dt-bindings: phy: cadence-torrent: Add binding for refclk driver
  dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
  phy: ti: j721e-wiz: Remove "regmap_field" from wiz_clk_{mux|div}_sel
  phy: ti: j721e-wiz: Delete "clk_div_sel" clk provider during cleanup
  phy: ti: j721e-wiz: Configure full rate divider for AM64
  phy: ti: j721e-wiz: Model the internal clocks without device tree
    input
  phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
  phy: cadence-torrent: Add support to drive refclk out

 .../bindings/phy/phy-cadence-torrent.yaml     |  20 +-
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  10 +-
 drivers/phy/cadence/phy-cadence-torrent.c     | 202 +++++++++-
 drivers/phy/ti/phy-j721e-wiz.c                | 349 +++++++++++++++---
 include/dt-bindings/mux/ti-serdes.h           |   5 +
 include/dt-bindings/phy/phy-cadence-torrent.h |   2 +
 include/dt-bindings/phy/phy-ti.h              |  21 ++
 7 files changed, 553 insertions(+), 56 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-ti.h

-- 
2.17.1

