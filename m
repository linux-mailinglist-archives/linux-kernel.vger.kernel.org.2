Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06FD458F94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhKVNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:45:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47134 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhKVNpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:45:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDg4Nv078183;
        Mon, 22 Nov 2021 07:42:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637588524;
        bh=Dyen+lVjWHjVEWqkuyugmG3UgJfDIzdT6V++Fe0FhZM=;
        h=From:To:CC:Subject:Date;
        b=Wa1yCsVmrbi79WgJP1IfrPGuiqLJKplS98NZw+rUB3yi97YKaTO8B+rG6CJrQckZS
         x7E97oC6z8400xIeuzqzqqNJdebQNZ4of6INaeemM66INMgK/PhJPUrg6+fL9iTyHL
         1LmRLMwkRCnRNim30k6cyjrjVkPZXOT8YrAGjGUo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMDg4Vo000792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 07:42:04 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 07:42:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 07:42:04 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDg04r023508;
        Mon, 22 Nov 2021 07:42:01 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/6] CAN: Add support for CAN in AM65,J721e and AM64
Date:   Mon, 22 Nov 2021 19:11:52 +0530
Message-ID: <20211122134159.29936-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following series of patches add support for CAN in SoC's AM65, J721e
and AM64.

changes since v4 -
- Rebased the series on top of ti-k3-dts-next branch

changes since v3 -
- Rebased the series on top of ti-k3-dts-next branch

changes since v2 -
- correct the dtbs_check errors. clock names order and interrupts
  property added in the dt bindings
- added support for main mcan instances on common processor board
  for j721e
- rebased the series on top of latest linux-next head

changes since v1 -
- changed the message ram configuration to use the maximum value
  in each field, for better performance.

Aswath Govindraju (3):
  arm64: dts: ti: am654-base-board/am65-iot2050-common: Disable mcan
    nodes
  arm64: dts: ti: k3-am64-main: Add support for MCAN
  arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
    nodes in EVM and disable them on SK

Faiz Abbas (3):
  arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
  arm64: dts: ti: k3-j721e: Add support for MCAN nodes
  arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu and
    main mcan nodes

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  28 +++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  40 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   8 +
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |   8 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  30 +++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |   8 +
 .../dts/ti/k3-j721e-common-proc-board.dts     | 155 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
 9 files changed, 501 insertions(+)

-- 
2.17.1

