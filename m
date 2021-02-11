Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372B931932A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBKTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:33:57 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:33180 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBKTdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:33:51 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 11BJWxqd008947
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 20:32:59 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.42.110])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11BJWuhh031206;
        Thu, 11 Feb 2021 20:32:58 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am65-main: Add device_type to pcie*_rc nodes
Date:   Thu, 11 Feb 2021 20:32:56 +0100
Message-Id: <881dfd6c75423efce1d10261909939cd5ef19937.1613071976.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1613071976.git.jan.kiszka@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This is demanded by the parent binding of ti,am654-pcie-rc, see
Documentation/devicetree/bindings/pci/designware-pcie.txt.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 12591a854020..787a49523c35 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -707,6 +707,7 @@ pcie0_rc: pcie@5500000 {
 		dma-coherent;
 		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		device_type = "pci";
 	};
 
 	pcie0_ep: pcie-ep@5500000 {
@@ -739,6 +740,7 @@ pcie1_rc: pcie@5600000 {
 		dma-coherent;
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+		device_type = "pci";
 	};
 
 	pcie1_ep: pcie-ep@5600000 {
-- 
2.26.2

