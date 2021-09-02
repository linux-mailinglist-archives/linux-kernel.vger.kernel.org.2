Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFA3FF39F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347227AbhIBS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:57:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47606 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbhIBS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:57:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 182ItmCI116551;
        Thu, 2 Sep 2021 13:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630608948;
        bh=y8LCb+YTT5nCF8UWI/R0EGK5b0c+FB4dHQffz0z42Qk=;
        h=From:To:CC:Subject:Date;
        b=vZwP79W3uiivn5yItQcYak/+rMIeV1GFwV5tQTBd4drIJR8fg6kmSrgV5AFwgbNHy
         aWxqt+SZC0uxXlATz9O/7fbLHm7JXhoKNrg95lXEbW6Ox162pNk18RfWpWjFR2wWcM
         F6T7lOimGrdrxOAXrx/G4XBGAvKX5NdQ4UmxPdmI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 182Itm0L003409
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Sep 2021 13:55:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Sep 2021 13:55:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Sep 2021 13:55:48 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 182Itiao017156;
        Thu, 2 Sep 2021 13:55:44 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v5 0/6] Rx mode support for Cadence DPHY
Date:   Fri, 3 Sep 2021 00:25:37 +0530
Message-ID: <20210902185543.18875-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Rx mode on Cadence DPHY driver. It has been
split off from [0] to facilitate easier merging. I have still kept the
version number to maintain continuity with the previous patches. This
series also includes conversion to YAML binding.

Tested on TI's J721E with OV5640 sensor.

[0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both

Changes in v5:
- Based on Laurent's suggestion, add cdns_dphy_info which contains the
  phy_ops and cdns_dphy_tx_ops (renamed from cdns_dphy_ops). This lets us
  get rid of the phy ops wrappers.
- Move probe() and remove() into cdns_dphy_common_ops() since they can
  be used by both modes. Drop the check in power_on().
- Get the clocks in the tx ops probe to make sure they are mandatory for
  Tx mode but not for Rx mode.
- Use the new cdns_dphy_info to specify PHY ops.
- Re-order include in alphabetical order.
- Make bands const.
- Drop num_bands.
- Make i, lanes unsigned.
- Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
  complete and return -EOPNOTSUPP when we reach the end.
- Drop the "rate < bands[i].min_rate" check since the bands are in
  ascending order.
- Move data_lane_ctrl to start of function and make it static const.
- Make clocks a required property based on the compatible.
- Use enum instead.

Changes in v4:
- Instead of having both Rx and Tx modes in the same driver data, keep
  them separate since the op selection is based on compatible now. For
  that reason, the cdns_dphy_driver_data struct is no longer needed.
- Rename ref_dphy_ops to tx_ref_dphy_ops to clarify their purpose.
- Drop submode checks in validate() hook.
- Drop the submode parts. Use a different compatible for the Rx ops.
- Make bands and num_bands static.
- Drop the submode patches. Use a different compatible for Rx mode DPHY
instead.

Changes in v3:
- Use a table to select the band.
- Use a table to poll the data lane ready bits.
- Multiply the DPHY HS clock rate by 2 to get the bit rate since the
  clock is DDR.
- Add Rob's R-by.

Changes in v2:
- Drop reg description.
- Add a description for each DPHY clock.
- Rename dphy@... to phy@... in example.
- Add Laurent's R-by.
- Re-order subject prefixes.
- Re-order subject prefixes.
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.

Pratyush Yadav (6):
  phy: cdns-dphy: Prepare for Rx support
  phy: cdns-dphy: Add Rx support
  phy: dt-bindings: Convert Cadence DPHY binding to YAML
  phy: dt-bindings: cdns,dphy: make clocks optional for Rx mode
  phy: dt-bindings: cdns,dphy: add power-domains property
  phy: dt-bindings: cdns,dphy: add Rx DPHY compatible

 .../devicetree/bindings/phy/cdns,dphy.txt     |  20 -
 .../devicetree/bindings/phy/cdns,dphy.yaml    |  66 ++++
 drivers/phy/cadence/cdns-dphy.c               | 351 +++++++++++++++---
 3 files changed, 356 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml

-- 
2.33.0

