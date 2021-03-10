Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97364333B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhCJL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:28:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40406 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhCJL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:27:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12ABRqqs098979;
        Wed, 10 Mar 2021 05:27:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615375672;
        bh=mrB7A5eFUsStRMGOQDpoao+QjlYjX/e54j3BJhMvifQ=;
        h=From:To:CC:Subject:Date;
        b=cyY0KMwMVRxXDR4R94QGpv1EucZsSDsFOs5drFLtgnlaIldpIQ8deWcV9pMylFOUP
         2OoiBzhfB+uLjT0kpegsU6aakp6EmjExAFMQ2qtbd9gPMHmhRBJV1KlDd+kSwd7Vwy
         Vr2Aup3J2wTgQxB3U0SBVjVx7AJPHvkRcH/1qgYk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12ABRqYS049319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 05:27:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 05:27:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 05:27:51 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12ABRkvW075949;
        Wed, 10 Mar 2021 05:27:48 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/3] AM64: Add SERDES DT bindings
Date:   Wed, 10 Mar 2021 16:57:42 +0530
Message-ID: <20210310112745.3445-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds device tree bindings to support SERDES in AM64
platform.

This is split from [1] since this binding is also required for AM64
USB DT patches to be merged.

Vinod,

Once the 1st patch of the series is reviewed by Rob, can you merge and
prepare a immutable tag to be used by Nishant Menon so that he can merge
USB3 DT patches.

Changes from [1]:
*) Reverted back to adding compatible under enum.

[1] -> http://lore.kernel.org/r/20210222112314.10772-1-kishon@ti.com

Kishon Vijay Abraham I (3):
  dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES
    Wrapper
  dt-bindings: phy: cadence-torrent: Add binding for refclk driver
  dt-bindings: ti-serdes-mux: Add defines for AM64 SoC

 .../bindings/phy/phy-cadence-torrent.yaml     | 20 +++++++++++++++---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  4 ++++
 include/dt-bindings/mux/ti-serdes.h           |  5 +++++
 include/dt-bindings/phy/phy-cadence-torrent.h |  2 ++
 include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
 5 files changed, 49 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-ti.h

-- 
2.17.1

