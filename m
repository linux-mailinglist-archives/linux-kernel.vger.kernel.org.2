Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039531B11E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBNQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:03:05 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:12994 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229827AbhBNQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:02:29 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EG1TsN022262;
        Sun, 14 Feb 2021 08:01:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jHj3s3iXXpCO8yHV4b3z6m4cHi7TjGgzFyI8TGqe+Rk=;
 b=IKr6VBETnJdnLAt0L0TKnzTT1y5e/9SJBpE4eiOCTXDvUncnVfW04gAHvxZfZb+2qyvh
 iQcyW3lqbLV2KQPR+MC35+g6p6SbQqZkBs+hu8G2KB8SJj7DoFTA7V9o/nm0R0bRL6vi
 UxraJYX+en3JIXdcL4NBZqWgBE5w5DRD66MxiVeOEPWAHlDGI7lhNpBYxb6KRGBRxzPA
 K2W8L+GkNktw9H6Iy4PnUzftWVRNeCcurxliT0Tmzr0YibdRk2FbWR7DyyhYG7PB/gt7
 TRWcsL+6rS+IF8ppDVz+6L9TR6a4RQSbgHxX8AX4XEBVFk2yEOlNjDBvW4WPD7QNwDlq 0Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36pd0vj6gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 08:01:29 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 08:01:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Feb 2021 08:01:27 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id B11A13F703F;
        Sun, 14 Feb 2021 08:01:23 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 3/4] arch/arm64: dts: add support for Marvell CP110 UTMI driver
Date:   Sun, 14 Feb 2021 18:01:07 +0200
Message-ID: <20210214160108.3879-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214160108.3879-1-kostap@marvell.com>
References: <20210214160108.3879-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add support for Marvell CP110 UTMI driver in a common DTSI

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 994a2fce449a..5f1f5d51c881 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -275,6 +275,25 @@
 			};
 		};
 
+		CP11X_LABEL(utmi): utmi@580000 {
+			compatible = "marvell,cp110-utmi-phy";
+			reg = <0x580000 0x2000>;
+			marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			CP11X_LABEL(utmi0): phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			CP11X_LABEL(utmi1): phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
 		CP11X_LABEL(usb3_0): usb@500000 {
 			compatible = "marvell,armada-8k-xhci",
 			"generic-xhci";
-- 
2.17.1

