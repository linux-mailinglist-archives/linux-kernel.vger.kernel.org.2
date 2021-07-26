Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EB3D5720
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhGZJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:30:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44506 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhGZJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:30:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16QAAIXU009315;
        Mon, 26 Jul 2021 05:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627294218;
        bh=jubbvzwFoY2RkqlgtpTCj7LrwUWvk1UL28QbNU2u70s=;
        h=From:To:CC:Subject:Date;
        b=DveE4k57YQIbucIu5jKUlduz1SjT9vtCwivKFhqsB5aSDyZEZZUWmUxfODeFehOjZ
         KhUpZRGHAXLUMLwtVEw+KNVo6pBtgKkJhGGgAIPiiqBCKJUjebweEW0U/xLxWuGwrG
         w7P8SW9gR4Op2GVeh84vPxWjpCTudRPnGOXVCyFI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16QAAI7e126485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Jul 2021 05:10:18 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jul 2021 05:10:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Jul 2021 05:10:17 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16QAACRd067730;
        Mon, 26 Jul 2021 05:10:13 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
Date:   Mon, 26 Jul 2021 15:40:06 +0530
Message-ID: <20210726101012.26983-1-a-govindraju@ti.com>
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

This patch series is dependent on [1] and [2] and I have requested for an
immutable tag from the Marc Kleine-Budde(maintainer of net tree).

[1] - https://lore.kernel.org/patchwork/patch/1423048/
[2] - https://www.spinics.net/lists/linux-can/msg08108.html

changes since v1 -
- changed the message ram configuration to use the maximum value
  in each field, for better performance.

Aswath Govindraju (3):
  arm64: dts: ti: am654-base-board: Disable mcan nodes
  arm64: dts: ti: k3-am64-main: Add support for MCAN
  arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
    nodes in EVM and disable them on SK

Faiz Abbas (3):
  arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
  arm64: dts: ti: k3-j721e: Add support for MCAN nodes
  arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
    nodes

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  28 +++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  40 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   8 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  30 +++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |   8 +
 .../dts/ti/k3-j721e-common-proc-board.dts     | 116 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
 8 files changed, 454 insertions(+)

-- 
2.17.1

