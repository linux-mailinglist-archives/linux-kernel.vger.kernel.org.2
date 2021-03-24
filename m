Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF233471B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCXGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:38:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34664 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCXGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:38:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12O6c5Ia069595;
        Wed, 24 Mar 2021 01:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616567885;
        bh=OafF6wJwhVSd3dBUNqHOK7IKMis1VR4ZQ+wmHHRnODc=;
        h=From:To:CC:Subject:Date;
        b=NYX+CciwxFaS2RPUaZrY4eEJ2aTsGwvZTDwMDkQaQqMqBz7LSfYw2/QxpQCFDapoW
         GqiVQBpMg9nPHtYRST+fnTHjgT/uZvbJcbArZizVI8Tq0DKbhvBlDQAxWIOzbp6+P9
         LByGoGEODkc0/fQBR9uD+1pP2/+K+fu1muAZaelA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12O6c5Al128850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Mar 2021 01:38:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 24
 Mar 2021 01:38:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 24 Mar 2021 01:38:05 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12O6c2c6014513;
        Wed, 24 Mar 2021 01:38:02 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/3] J7200: Add support for GPIO and higher speed modes in MMCSD subsystems
Date:   Wed, 24 Mar 2021 12:07:56 +0530
Message-ID: <20210324063759.5837-1-a-govindraju@ti.com>
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

