Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6C3413A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhCSDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:45:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37370 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCSDog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:44:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J3iRuK040094;
        Thu, 18 Mar 2021 22:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616125467;
        bh=kVS5oX3UgcPCp8IqYYmKdIbWqBDo9bvj+pujPsefqwA=;
        h=From:To:CC:Subject:Date;
        b=y/FwMgrMMxV65kGCb6xNwHt1/SaNqEYww9KZc/g2iscD/Q4uHW4WajAzoarDMAUuN
         8lrM4zTmYY9t9bOWhKDFNXYkdRDw+kuKS+p3XdaeRA93HNx/RrrNhQNIuTVsG7xvft
         9MKiekwh8ooxURh/wP87ihMXA2+CN5iWHUajzwvg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J3iRqq066706
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Mar 2021 22:44:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 18
 Mar 2021 22:44:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 18 Mar 2021 22:44:27 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J3iN0J039408;
        Thu, 18 Mar 2021 22:44:24 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/3] J7200: Add support for GPIO and higher speed modes in MMCSD subsystems
Date:   Fri, 19 Mar 2021 09:14:18 +0530
Message-ID: <20210319034422.17630-1-a-govindraju@ti.com>
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
https://pastebin.ubuntu.com/p/xqZt34mRWf/

- SD SDR104 speed mode
https://pastebin.ubuntu.com/p/qM2H85SQvX/

- GPIO logs
https://pastebin.ubuntu.com/p/7WXdRxxdWz/


Changes since v5:
- Corrected the link in patch 3 as it broken.
- Added the version number for the references used in patch 3.
- picked up reviewed-by from gyrgorii for patches 1 and 2.

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

 .../dts/ti/k3-j7200-common-proc-board.dts     | 58 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 86 ++++++++++++++++++-
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 34 ++++++++
 3 files changed, 176 insertions(+), 2 deletions(-)

-- 
2.17.1

