Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073073342EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhCJQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:20:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53874 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhCJQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:19:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AGJUGt000996;
        Wed, 10 Mar 2021 10:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615393170;
        bh=P3eM0t6MhUE/H4fUlyfPBBus5lwTyjhJ8ycW5BbeCpY=;
        h=From:To:CC:Subject:Date;
        b=VKC7PTnTr9+9tlUiDY6nMk8NI4YnIoINjlx189jvwSBX8oWku18dDIXge+brKTaba
         7IoTH4vzs9dO7an8Ts3TVK8SnrFrbpS/8dmwcbHy3vFc+Amp36Xid3uyh0/OPY0snc
         3Y1hIzYyAaxGZk+XOgjYKeBprr3xT+m1zytdlrbg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AGJUbv081823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 10:19:30 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 10:19:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 10:19:30 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AGJPxr058353;
        Wed, 10 Mar 2021 10:19:26 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <a-govindraju@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] J7200: Add support for GPIO and higher speed modes in MMCSD subsystems
Date:   Wed, 10 Mar 2021 21:49:20 +0530
Message-ID: <20210310161924.22256-1-a-govindraju@ti.com>
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

