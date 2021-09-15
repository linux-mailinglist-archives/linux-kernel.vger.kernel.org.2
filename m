Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDE40BF72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhIOFzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:55:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhIOFzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F5sArf060558;
        Wed, 15 Sep 2021 00:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631685250;
        bh=nChZqKImdc5XPuX5XSrzP1nSJKMX2b5V6v23DDxXOus=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tc6s1zeLpsq9VphsigdTRsUoPMP1Lw1n7jRoz4LJskItnEcFjymaZd2Gw2whXaWNV
         CkAJpIaVfIoUC+31ah7wSvSc267i4Gi3i9ZmU5g3ioJSYOScT5si22mfbBNmzu/oG6
         GlDaSVP7LCv2Xoc+qamKhDFdcoFeTk36Cwj5iUgo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F5sAOv003779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 00:54:10 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 00:54:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 00:54:09 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F5rwsb023333;
        Wed, 15 Sep 2021 00:54:06 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 2/6] arm64: dts: ti: k3-j721e-main: Fix "bus-range" upto 256 bus number for PCIe
Date:   Wed, 15 Sep 2021 11:23:54 +0530
Message-ID: <20210915055358.19997-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device
tree nodes") restricted PCIe bus numbers from 0 to 15 (due to SMMU
restriction in J721E). However since SMMU is not enabled, allow the full
supported bus numbers from 0 to 255.

Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 43be5d23130b..08c8d1b47dcd 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -610,7 +610,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
@@ -658,7 +658,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x10000 0x10000>;
@@ -706,7 +706,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x20000 0x10000>;
@@ -754,7 +754,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x30000 0x10000>;
-- 
2.17.1

