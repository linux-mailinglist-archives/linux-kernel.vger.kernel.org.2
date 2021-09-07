Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6F402CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbhIGQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:39:26 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:58267 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhIGQjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:39:25 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 187Gc4Zr008518
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 18:38:04 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187Gc3Gg021975;
        Tue, 7 Sep 2021 18:38:03 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Flip mmc device ordering
Date:   Tue,  7 Sep 2021 18:37:59 +0200
Message-Id: <0dce149347353556e38a0bdf9a9489ffc9cf66d2.1631032682.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631032682.git.jan.kiszka@siemens.com>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that the SD card will remain mmc0 across devices with and
without eMMC.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index a9fc1af03f27..785d931a2dd9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -31,6 +31,8 @@ aliases {
 		i2c4 = &main_i2c2;
 		i2c5 = &main_i2c3;
 		ethernet0 = &cpsw_port1;
+		mmc0 = &sdhci1;
+		mmc1 = &sdhci0;
 	};
 
 	chosen { };
-- 
2.31.1

