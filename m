Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1D30DB5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhBCNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:33:48 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:25106 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231488AbhBCNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:54 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DV2Pk020085;
        Wed, 3 Feb 2021 05:31:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=F9oL5Zy+rETHQ3U6q3ECVbU8iYULR7eB3UJtyoKutrg=;
 b=lMNdVVU2hhP4jK7lU5wyzzTNivXzffkoUuWHz7f8OFel1/wqNf/fIJZ6QhpXQhi4oAC/
 3yQjDV91/C0fy652YF8Oujs2MTo7KiPm7RfLdj6bnPc3eAt60PQlf3kN43/yBfLXsULC
 jkUQwrKUyf7V1vDhbYRgdUNvXurBer+8z2b6Bk9+UZc7miNFbzspQaczGIlctBJ6+Whr
 HbUZMIAoy9m2MUrIhzli8+LMdivHUsIcqHUhl7Zr7J1eHusa1ORuKFw49mRzhu1BrvHv
 A0xhXTA8XpodSUNvbQDGhNeT/vnr0OW4l5S8vWiJNca6IaUjAKnWPqZut2oS6wJ4Oxf0 Wg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3afg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:31:50 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:31:48 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 564693F703F;
        Wed,  3 Feb 2021 05:31:45 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 01/11] fix: arm64: dts: replace wrong regulator on ap emmc
Date:   Wed, 3 Feb 2021 15:31:28 +0200
Message-ID: <20210203133138.10754-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203133138.10754-1-kostap@marvell.com>
References: <20210203133138.10754-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_05:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Replace wrong regulator in AP0 eMMC definition on MacchiatoBIN
board with 3.3V regulator.
The MacchiatoBIN board has no 1.8V regulator connected to AP0
eMMC (ap0_sdhci0) interface.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index cbcb210cb6d8..73733b4126e2 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -119,7 +119,7 @@
 	no-sdio;
 	non-removable;
 	status = "okay";
-	vqmmc-supply = <&v_vddo_h>;
+	vqmmc-supply = <&v_3_3>;
 };
 
 &cp0_i2c0 {
-- 
2.17.1

