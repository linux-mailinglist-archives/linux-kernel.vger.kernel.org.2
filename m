Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBED37C226
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhELPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:07:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32838 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhELPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:02:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CF1IEm004709;
        Wed, 12 May 2021 10:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620831678;
        bh=ivlAKe4w7kLseNMI44eHskmjeEGvJaiJLjW0095iiR0=;
        h=From:To:CC:Subject:Date;
        b=tFY2+su06uzyleRtYzyNZAWF3tNM2mkrY6OvehfoA+B3JrvnIGkPG9YABC18h8TxK
         T1AkhQiSW7rO9cLFAHh7ntg2yLne3KtnEKw85005dLXqr4uG65iOLl+Mc2PpMCsEp+
         wSs9ipmPUj4OUOU5lregkGNqXMtkLaSshQ31fVaE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CF1Ijm082776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 10:01:18 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 10:01:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 10:01:17 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CF19F7119262;
        Wed, 12 May 2021 10:01:11 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH 0/5] AM64: EVM/SK: Enable PCIe and USB
Date:   Wed, 12 May 2021 20:31:02 +0530
Message-ID: <20210512150107.26793-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM642 EVM has one PCIe slot and AM642 SK has one USB slot.
AM64 SoC has one SERDES module which can be used by either PCIe or USB.

Add DT nodes to represent and enable SERDES/PCIe/USB modules in EVM/SK.

Kishon Vijay Abraham I (5):
  arm64: dts: ti: k3-am64-main: Add SERDES DT node
  arm64: dts: ti: k3-am64-main: Add PCIe DT node
  arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
  arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
  arm64: dts: ti: k3-am642-sk: Disable PCIe

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 102 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  30 +++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  47 +++++++++++
 3 files changed, 179 insertions(+)

-- 
2.17.1

