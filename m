Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78940C53F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhIOM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:28:52 -0400
Received: from thoth.sbs.de ([192.35.17.2]:35184 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236700AbhIOM2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:46 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18FCRDxv005856
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:27:14 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.79.72])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18FCRAr5006124;
        Wed, 15 Sep 2021 14:27:13 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v4 3/6] arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F cores
Date:   Wed, 15 Sep 2021 14:27:07 +0200
Message-Id: <1a39e2efad70eefd548f38d7d5ea2333e0cfab59.1631708830.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631708830.git.jan.kiszka@siemens.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to the am654-base-board, configure the mailboxes for the two
R5F cores, add them and the already existing memory carve-outs to the
related MCU nodes. Allows to load applications under Linux onto the
cores, e.g. the RTI watchdog firmware.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 58c8e64d5885..b29537088289 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -658,11 +658,21 @@ &pcie1_ep {
 };
 
 &mailbox0_cluster0 {
-	status = "disabled";
+	interrupts = <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-tx = <1 0 0>;
+		ti,mbox-rx = <0 0 0>;
+	};
 };
 
 &mailbox0_cluster1 {
-	status = "disabled";
+	interrupts = <432>;
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-tx = <1 0 0>;
+		ti,mbox-rx = <0 0 0>;
+	};
 };
 
 &mailbox0_cluster2 {
@@ -705,6 +715,18 @@ &mailbox0_cluster11 {
 	status = "disabled";
 };
 
+&mcu_r5fss0_core0 {
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+};
+
+&mcu_r5fss0_core1 {
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
+};
+
 &icssg0_mdio {
 	status = "disabled";
 };
-- 
2.31.1

