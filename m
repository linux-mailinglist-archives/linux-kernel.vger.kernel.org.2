Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888EC39A2FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFCOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:24:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44202 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhFCOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:24:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153EMuHH010789;
        Thu, 3 Jun 2021 09:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622730177;
        bh=B6YIeFNEope+9x+3o1JGFyY9LtfqWwWdqHA6F6Zx498=;
        h=From:To:CC:Subject:Date;
        b=rX8MKacYT34/v2wyVr9XwJF9xuIccR9AglHfs0zpCoMlrxf7XOIgWeZKCSpcZuJ+f
         Xu7lPKhNxpZHllHEWDXmOhm52hvhw6K2oAPKRQFbv3KC8I5kvZ/1sLdJWIZnUqntVt
         /Mx2no3WwaCrqdLQX4pyotVDBgl64e+FZO4hRCvo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153EMu6c013621
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:22:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:22:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:22:56 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EMpNF039957;
        Thu, 3 Jun 2021 09:22:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 0/5] AM64: EVM/SK: Enable PCIe and USB
Date:   Thu, 3 Jun 2021 19:52:46 +0530
Message-ID: <20210603142251.14563-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM642 EVM has one PCIe slot (no USB slot) and AM642 SK has one USB slot
(no PCIe slot).
AM64 SoC has one SERDES module which can be used by either PCIe or USB.

Add DT nodes to represent and enable SERDES/PCIe/USB modules in EVM/SK.

Changes from v3:
1) Limit the lines to < 100

Changes from v2:
1) Dropped "dt-bindings: mux: Convert reg-mux DT bindings to YAML" as
it's handled by a different series from Rob
2) Rename "mux" DT node to a standard "mux-controller" DT node.

Changes from v1:
1) Add a patch to convert reg-mux DT bindings to YAML
2) Use generic names for clock node names
3) Remove redundant status = "okay" for serdes_wiz0

v1: http://lore.kernel.org/r/20210512150107.26793-1-kishon@ti.com
v2: http://lore.kernel.org/r/20210517061739.5762-1-kishon@ti.com
v3: http://lore.kernel.org/r/20210526142921.12127-1-kishon@ti.com

Kishon Vijay Abraham I (5):
  arm64: dts: ti: k3-am64-main: Add SERDES DT node
  arm64: dts: ti: k3-am64-main: Add PCIe DT node
  arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
  arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
  arm64: dts: ti: k3-am642-sk: Disable PCIe

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 107 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  30 +++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  43 +++++++++
 3 files changed, 180 insertions(+)

-- 
2.17.1

