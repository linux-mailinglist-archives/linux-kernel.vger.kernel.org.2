Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A685F3F343C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhHTTEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:04:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42446 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhHTTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:04:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KJ3p9I081608;
        Fri, 20 Aug 2021 14:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629486231;
        bh=quRiQhXdk6WCGDxPbnZkmnARtCTeN8OCt02MgE+FDH4=;
        h=From:To:CC:Subject:Date;
        b=nTMIU5pEKssi9MXATtK5n9c5nJ5VktdOdQA6xRpuZN7i818X8kIRb7BCr/Lg/j2W0
         I/mH2TSZgmuUZgEvAmH81xODVUcQKFimBlgzaVGdHTLOpLzeaWgjqKhkOdnvO1hfwj
         j9lrPvWDC0hV2HNM5MVVUAgByIfC7KW0vIKvaVP4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KJ3pDM022046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 14:03:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 14:03:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 14:03:51 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KJ3lwW018479;
        Fri, 20 Aug 2021 14:03:47 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v4 0/6] Rx mode support for Cadence DPHY
Date:   Sat, 21 Aug 2021 00:33:40 +0530
Message-ID: <20210820190346.18550-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
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

Changes in v4:
- Instead of having both Rx and Tx modes in the same driver data, keep
  them separate since the op selection is based on compatible now. For
  that reason, the cdns_dphy_driver_data struct is no longer needed.
- Rename ref_dphy_ops to tx_ref_dphy_ops to clarify their purpose.
- Drop submode checks in validate() hook.
- Drop the submode parts. Use a different compatible for the Rx ops.
- Make bands and num_bands static.

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
  phy: dt-bindings: cdns,dphy: make clocks optional
  phy: dt-bindings: cdns,dphy: add power-domains property
  phy: dt-bindings: cdns,dphy: add Rx DPHY compatible

 .../devicetree/bindings/phy/cdns,dphy.txt     |  20 --
 .../devicetree/bindings/phy/cdns,dphy.yaml    |  55 ++++
 drivers/phy/cadence/cdns-dphy.c               | 294 +++++++++++++++---
 3 files changed, 313 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml

--
2.30.0

