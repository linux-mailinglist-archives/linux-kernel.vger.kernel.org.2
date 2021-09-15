Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8A40C541
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhIOM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:28:57 -0400
Received: from gecko.sbs.de ([194.138.37.40]:38473 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237460AbhIOM2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:47 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 18FCRDYP016562
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:27:13 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.79.72])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18FCRAr3006124;
        Wed, 15 Sep 2021 14:27:12 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v4 1/6] arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
Date:   Wed, 15 Sep 2021 14:27:05 +0200
Message-Id: <104e3f81835f1141e9d822682c89fd5c22e4df25.1631708830.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631708830.git.jan.kiszka@siemens.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that the SD card will remain mmc0 across Basic and Advanced
devices, also avoiding surprises for users coming from the downstream
kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 1008e9162ba2..6261ca8ee2d8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -17,6 +17,8 @@
 / {
 	aliases {
 		spi0 = &mcu_spi0;
+		mmc0 = &sdhci1;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
-- 
2.31.1

