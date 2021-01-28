Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09A53079BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhA1P25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:28:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40802 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhA1P2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:28:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SFRpVi069369;
        Thu, 28 Jan 2021 09:27:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611847671;
        bh=Fj6KFWyyZtFnRM7XJT7i/dSWP4gKw6wFt0BqbhXtMlU=;
        h=From:To:CC:Subject:Date;
        b=sl66z9S9w8xy8hIuLvInu6lxhsMlw9l8tnGVGsNV7SdVqCyVvQePGHLimIm9ZkhHm
         iMD8dmGUuKY0ujCgSvRenVGbGy/zUDKQP471YrYcOyPlicfnU0Cux0Zd2wAIzyt9tp
         BnR8X/no2YKHOZwDt2VYCCuluiXNimvR8K69D0+Y=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SFRp3M113127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 09:27:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 09:27:50 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 09:27:50 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SFRk5A094536;
        Thu, 28 Jan 2021 09:27:47 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] J7200: Add support for GPIO and higher speed modes in MMCSD subsystems
Date:   Thu, 28 Jan 2021 20:57:41 +0530
Message-ID: <20210128152744.12439-1-a-govindraju@ti.com>
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

performance test logs using EXT4 filesystem
- For eMMC HS400 speed mode,
  https://pastebin.ubuntu.com/p/gDxBCwtkt8/  
- For SD SDR104 speed mode,
  https://pastebin.ubuntu.com/p/tHYTn2wxwg/  

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
  arm64: dts: ti: k3-j7200: Add support for higher speed modes in MMCSD
    subsystems

[1] - https://lkml.org/lkml/2020/11/17/1489

Faiz Abbas (2):
  arm64: dts: ti: k3-j7200: Add gpio nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
    modules

 .../dts/ti/k3-j7200-common-proc-board.dts     | 47 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 75 ++++++++++++++++++-
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 34 +++++++++
 3 files changed, 155 insertions(+), 1 deletion(-)

-- 
2.17.1

