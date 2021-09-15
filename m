Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68140C535
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhIOM2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:28:44 -0400
Received: from david.siemens.de ([192.35.17.14]:35081 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhIOM2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:43 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 18FCRD1a030330
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:27:13 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.79.72])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18FCRAr4006124;
        Wed, 15 Sep 2021 14:27:13 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v4 2/6] arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
Date:   Wed, 15 Sep 2021 14:27:06 +0200
Message-Id: <c18b46fcf205074db2bdd6d0f7694f07216fc241.1631708830.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631708830.git.jan.kiszka@siemens.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The IOT2050 devices described so far are using SR1.0 silicon, thus do
not have the additional PRUs of the ICSSG of the SR2.0. Disable them.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 6261ca8ee2d8..58c8e64d5885 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -716,3 +716,27 @@ &icssg1_mdio {
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

