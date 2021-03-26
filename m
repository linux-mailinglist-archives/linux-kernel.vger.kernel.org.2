Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311D34A211
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCZGmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:42:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhCZGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12Q6fRZR077190;
        Fri, 26 Mar 2021 01:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616740887;
        bh=O19EPkZCn6lrkNRAjKVLw4QtOhRf27/e3x5spcRBOKs=;
        h=From:To:CC:Subject:Date;
        b=NQPOPEP65BkRF/8ro8LMFzW38+XtCEEYwXulzC2mpjNsLKGSUqayhueRTosVz7MPG
         jYsG+4A8GJRzi5qRBqKAYUDRe7XiRkq/oJ+Lk9Q5TATjkaFoNL1akFt/dlXZFon1z9
         fmEDYJamq9ING4OS9UfnOLu08NtOloobr8FvNC7w=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12Q6fRZL118222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 01:41:27 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 01:41:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 01:41:26 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12Q6fNO3089943;
        Fri, 26 Mar 2021 01:41:23 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/3] J7200: Add support for GPIO and higher speed modes in MMCSD subsystems
Date:   Fri, 26 Mar 2021 12:11:17 +0530
Message-ID: <20210326064120.31919-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches
- Add support for GPIO subsystem in main and wakeup domains.
- Add voltage regulator device tree nodes and their corresponding pinmux
  to support power cycle and voltage switch required for UHS-I modes
- sets respective tags in sdhci0 node to support higher speeds
- remove no-1-8-v tag from sdhci1 node to support UHS-I modes
- Update delay values for various speed modes supported.


test logs
- eMMC HS400 speed mode
  https://pastebin.ubuntu.com/p/pRzV2ZvSJZ/

- SD SDR104 speed mode
  https://pastebin.ubuntu.com/p/n64PNdDy2v/

- GPIO logs
  https://pastebin.ubuntu.com/p/HDBBMwMcdj/

Changes since v8:
- Fixed minor changes sugested by kishon in patch 3
- Picked up kishon's reviewed-by for patch 3

Changes since v7:
- Added the voltage regulator nodes to indicate the complete
  power flow for MMCSD1 subsystem
- Corrected minor errors in DT nodes
- Reran the tests.
- Rebased the series

Changes since v6:
- Corrected the node name from vdd_sd_dv_pins_default to
  vdd-sd-dv-pins-default

Changes since v5:
- Corrected the link in patch 3 as it broken.
- Added the version number for the references used in patch 3.
- picked up reviewed-by from grygorii for patches 1 and 2.

Changes since v4:
- Added main_i2c0 pinmux required for doing power cycles to MMCSD1
  subsystem
- Updated delay values for various speed modes supported
- Corrected the ti,ngpio property to indicate highest gpio lines that
  can be accessed.
- Reran the performace tests

Changes since v3:
- Removed patch (1 in v3).
- Rebased and included patches that add support for GPIO from series [1].
- Re-ran the performace tests for SD and eMMC.

Changes since v2:
- Added main_gpio0 DT node
- Added voltage regulator device tree nodes required to support UHS-I modes

Changes since v1:
- squashed the two patches into one
- added performance logs for the above mentioned speed modes

Aswath Govindraju (1):
  arm64: dts: ti: k3-j7200: Add support for higher speed modes and
    update delay select values for MMCSD subsystems

Faiz Abbas (2):
  arm64: dts: ti: k3-j7200: Add gpio nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
    modules

 .../dts/ti/k3-j7200-common-proc-board.dts     | 94 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 86 ++++++++++++++++-
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 34 +++++++
 3 files changed, 212 insertions(+), 2 deletions(-)

-- 
2.17.1

