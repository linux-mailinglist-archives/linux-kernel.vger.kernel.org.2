Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94DA405DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbhIITmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:42:52 -0400
Received: from goliath.siemens.de ([192.35.17.28]:38784 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbhIITmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:42:44 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 189JfKnr009753
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 21:41:20 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.244.119])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 189JfIcT001594;
        Thu, 9 Sep 2021 21:41:19 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
Date:   Thu,  9 Sep 2021 21:41:14 +0200
Message-Id: <7385701c47c11ff2c3455e02c81be24cbb919905.1631216478.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631216478.git.jan.kiszka@siemens.com>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
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

