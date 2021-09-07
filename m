Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF64402CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbhIGQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:39:28 -0400
Received: from thoth.sbs.de ([192.35.17.2]:41707 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245595AbhIGQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:39:26 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 187Gc4He012625
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 18:38:04 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187Gc3Gh021975;
        Tue, 7 Sep 2021 18:38:04 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
Date:   Tue,  7 Sep 2021 18:38:00 +0200
Message-Id: <5c2c629db5bf85fd9840e7fde0eeaae081feaa56.1631032682.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631032682.git.jan.kiszka@siemens.com>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The IOT2050 devices described so far are using SR1.0 silicon, thus do
not have the additional PRUs of the ICSSG of the SR2.0. Disable them.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 1008e9162ba2..63a28e18a3bf 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -714,3 +714,27 @@ &icssg1_mdio {
 &icssg2_mdio {
 	status = "disabled";
 };
+
+&tx_pru0_0 {
+	status = "disabled";
+};
+
+&tx_pru0_1 {
+	status = "disabled";
+};
+
+&tx_pru1_0 {
+	status = "disabled";
+};
+
+&tx_pru1_1 {
+	status = "disabled";
+};
+
+&tx_pru2_0 {
+	status = "disabled";
+};
+
+&tx_pru2_1 {
+	status = "disabled";
+};
-- 
2.31.1

