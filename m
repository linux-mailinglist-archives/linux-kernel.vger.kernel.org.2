Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7013B35F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFXSn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:43:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37764 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFXSny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:43:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIfDQ6074471;
        Thu, 24 Jun 2021 13:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624560073;
        bh=PwhGT5b1kWmV4Ngw9Q8N5BJaBMf7WQHsRP6rwzdY8gc=;
        h=From:To:CC:Subject:Date;
        b=dK3xG2Dkj9pSbC9Gvs/+Dujrnyhy/LVhV+sqH8CVVySZt9MBpqOme6UmbQqLnVqjJ
         0wP1JD5vM/fqxa7U13i7yPDYvDMYYzeHP0SEuPkoZBv/M8z/gCtGngDWFsQibSZekz
         NDuO0LL7I/X2LDOLpzUFO90wYy11E2P4JhnUxmMU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIfDaf107198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:41:13 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:41:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:41:13 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIf9Hv041395;
        Thu, 24 Jun 2021 13:41:10 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 0/7] Rx mode support for Cadence DPHY
Date:   Fri, 25 Jun 2021 00:11:01 +0530
Message-ID: <20210624184108.21312-1-p.yadav@ti.com>
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
split off from [0] to facilitate easier merging. I have still kept it as
v3 to maintain continuity with the previous patches. This series also
includes conversion to YAML binding.

Tested on TI's J721E with OV5640 sensor.

[0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both

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

Paul Kocialkowski (1):
  phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes

Pratyush Yadav (6):
  phy: cdns-dphy: Prepare for Rx support
  phy: cdns-dphy: Allow setting mode
  phy: cdns-dphy: Add Rx support
  phy: dt-bindings: Convert Cadence DPHY binding to YAML
  phy: dt-bindings: cdns,dphy: make clocks optional
  phy: dt-bindings: cdns,dphy: add power-domains property

 .../devicetree/bindings/phy/cdns,dphy.txt     |  20 -
 .../devicetree/bindings/phy/cdns,dphy.yaml    |  54 +++
 drivers/phy/cadence/cdns-dphy.c               | 344 ++++++++++++++++--
 include/linux/phy/phy-mipi-dphy.h             |  13 +
 4 files changed, 375 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml

-- 
2.30.0

