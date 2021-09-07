Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FAC402AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhIGOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:23:40 -0400
Received: from thoth.sbs.de ([192.35.17.2]:39502 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235442AbhIGOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:23:39 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 187EMImB021138
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 16:22:18 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187EMGGM016799;
        Tue, 7 Sep 2021 16:22:17 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
Date:   Tue,  7 Sep 2021 16:22:14 +0200
Message-Id: <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631024536.git.jan.kiszka@siemens.com>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
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
---
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index ec9617c13cdb..d1d5278e0b94 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -18,6 +18,11 @@ / {
 	compatible = "siemens,iot2050-advanced", "ti,am654";
 	model = "SIMATIC IOT2050 Advanced";
 
+	aliases {
+		mmc0 = &sdhci1;
+		mmc1 = &sdhci0;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
-- 
2.31.1

