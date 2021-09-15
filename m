Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4CD40BF74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhIOFzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:55:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbhIOFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F5sDti078765;
        Wed, 15 Sep 2021 00:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631685253;
        bh=8P5xWMl1NeCypVDTrycSNmNZutIeWmBQGQALsJXG4N8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EZ6cZPr5GpgaRAXUamZFVhtzA4EPwXECRDiGNhQY9aWSwVYQGp+lvy17UZKVZGIzJ
         weZaheSlLzEH/6Sw37qDLkyB/JTmQlonv2QYYmSOwrSY7xwyH5ale9ey2xzpHugizs
         uX/4HmSQOFVINKi/v/Fy1KRUGZy+iBFZBKMC001s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F5sDms077233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 00:54:13 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 00:54:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 00:54:13 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F5rwsc023333;
        Wed, 15 Sep 2021 00:54:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 3/6] arm64: dts: ti: j7200-main: Fix "vendor-id"/"device-id" properties of pcie node
Date:   Wed, 15 Sep 2021 11:23:55 +0530
Message-ID: <20210915055358.19997-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3276d9f53cf6 ("arm64: dts: ti: k3-j7200-main: Add PCIe device
tree node") incorrectly added "vendor-id" and "device-id" as 16-bit
properties though both of them are 32-bit properties. Fix it here.

Fixes: 3276d9f53cf6 ("arm64: dts: ti: k3-j7200-main: Add PCIe device tree node")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index e8a41d09b45f..521a56316fa5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -608,8 +608,8 @@
 		#size-cells = <2>;
 		bus-range = <0x0 0xf>;
 		cdns,no-bar-match-nbits = <64>;
-		vendor-id = /bits/ 16 <0x104c>;
-		device-id = /bits/ 16 <0xb00f>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00f>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
 		dma-coherent;
 		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
-- 
2.17.1

