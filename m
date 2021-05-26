Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B2391A27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhEZObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:31:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41252 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhEZObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:31:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QETR6L053215;
        Wed, 26 May 2021 09:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622039367;
        bh=adwDlqzyFu2w91BOBHgkLr2jlHPCocTpNVgbheqBd1c=;
        h=From:To:CC:Subject:Date;
        b=cwaDSoyf5dY9lHi8AZ4FXXlIjL1JkX3SVUkbjsC+pyoxle2UrmNyvXnQT3lR1kVMx
         PAJ32B/VvuxNelbf9tv3MF4KaPnZt6d8nTgIzl9TEJwtB8QIa4hKNrF0d0VbM9Cj3c
         Hrl442fcY83PIDp39FDLaSVgLT+ajymobNrkdgkM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QETRFA040260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 09:29:27 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 09:29:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 09:29:27 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QETMcZ030380;
        Wed, 26 May 2021 09:29:23 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 0/5] AM64: EVM/SK: Enable PCIe and USB
Date:   Wed, 26 May 2021 19:59:16 +0530
Message-ID: <20210526142921.12127-1-kishon@ti.com>
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

Changes from v2:
1) Dropped "dt-bindings: mux: Convert reg-mux DT bindings to YAML" as
it's handled by a different series from Rob
2) Rename "mux" DT node to a standard "mux-controller" DT node.

Changes from v1:
1) Add a patch to convert reg-mux DT bindings to YAML
2) Use generic names for clock node names
3) Remove redundant status = "okay" for serdes_wiz0

Kishon Vijay Abraham I (5):
  arm64: dts: ti: k3-am64-main: Add SERDES DT node
  arm64: dts: ti: k3-am64-main: Add PCIe DT node
  arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
  arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
  arm64: dts: ti: k3-am642-sk: Disable PCIe

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 102 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  30 +++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  43 ++++++++++
 3 files changed, 175 insertions(+)

-- 
2.17.1

