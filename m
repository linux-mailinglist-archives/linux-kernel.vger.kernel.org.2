Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1873E53BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhHJGpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:45:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45924 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhHJGpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:45:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17A6iSYK019084;
        Tue, 10 Aug 2021 01:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628577868;
        bh=Yw+UpOFUrE6UhDoCznS4ihOxW2oYkQGs6noafQyEU00=;
        h=From:To:CC:Subject:Date;
        b=XNxwcJnOQdI0lUzirjSSqlD1AFDjJW0K8u37fKtmQn8NQDBYOVc7/2ebMICFXviog
         ZuQAVDUprMvQfaoffwYKe2/ibvgduvbF+eZzqHf7skn+S066fOVqL/B6N2TcYDp26l
         3yTmSBnkCUhhFp6O5rMzQB5YJkLaI9D/o7dlU70g=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17A6iShR097560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Aug 2021 01:44:28 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 10
 Aug 2021 01:44:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 10 Aug 2021 01:44:27 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17A6iMnj002476;
        Tue, 10 Aug 2021 01:44:23 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Andrew Lunn <andrew@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Remove #address-cells and #size-cells property from at93c46d dt node
Date:   Tue, 10 Aug 2021 12:14:20 +0530
Message-ID: <20210810064420.9489-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #address-cells and #size-cells property from at93c46d device tree
node as it does not have child nodes.

Fixes: 1556063fde42 ("ARM: dts: vf610-zii-dev: Add ZII development board.")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 6f1e0f0d4f0a..043ddd70372f 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -311,8 +311,6 @@
 			compatible = "atmel,at93c46d";
 			pinctrl-0 = <&pinctrl_gpio_e6185_eeprom_sel>;
 			pinctrl-names = "default";
-			#address-cells = <0>;
-			#size-cells = <0>;
 			reg = <1>;
 			spi-max-frequency = <500000>;
 			spi-cs-high;
-- 
2.17.1

