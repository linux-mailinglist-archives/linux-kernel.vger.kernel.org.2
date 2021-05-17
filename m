Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0927382412
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhEQGTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:19:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55284 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhEQGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:19:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14H6HxAK040787;
        Mon, 17 May 2021 01:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621232279;
        bh=SDy+mnfmS0zKcFkEdHEEL45qbIDVtBWBDcD0aecXM/E=;
        h=From:To:CC:Subject:Date;
        b=xDplRIH1aJieI5+yu06WOxMS5LSKiw/nEsUSVmnCfcQ8ssjqQ9IBYTwLWQnQYlX5s
         AxazjwmLLAY6xfLbsW9k0ebCHuN0kS+ropoqH/EBLFp9v7CYc1zOj/ppxOOH7o0Pku
         jAJ0xZAXlDkGfi+6bJdS4xSTQ8vFcc1dBSIp+F0I=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14H6HxGt096264
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 01:17:59 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 01:17:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 01:17:58 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14H6Hpl0003911;
        Mon, 17 May 2021 01:17:53 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v2 0/6] AM64: EVM/SK: Enable PCIe and USB
Date:   Mon, 17 May 2021 11:47:33 +0530
Message-ID: <20210517061739.5762-1-kishon@ti.com>
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

Changes from v1:
1) Add a patch to convert reg-mux DT bindings to YAML
2) Use generic names for clock node names
3) Remove redundant status = "okay" for serdes_wiz0

Kishon Vijay Abraham I (6):
  dt-bindings: mux: Convert reg-mux DT bindings to YAML
  arm64: dts: ti: k3-am64-main: Add SERDES DT node
  arm64: dts: ti: k3-am64-main: Add PCIe DT node
  arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
  arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
  arm64: dts: ti: k3-am642-sk: Disable PCIe

 .../bindings/mux/mux-controller.txt           | 113 ++++++++++++++-
 .../devicetree/bindings/mux/reg-mux.txt       | 129 ------------------
 .../devicetree/bindings/mux/reg-mux.yaml      |  47 +++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 102 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  30 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  43 ++++++
 6 files changed, 334 insertions(+), 130 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml

-- 
2.17.1

