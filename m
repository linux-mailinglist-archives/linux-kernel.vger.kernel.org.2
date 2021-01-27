Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D38305A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhA0LpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:45:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12752 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236761AbhA0L3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:29:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RBQ0fT027957;
        Wed, 27 Jan 2021 03:28:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jHj3s3iXXpCO8yHV4b3z6m4cHi7TjGgzFyI8TGqe+Rk=;
 b=jlK7JPoDCHerW/HZy9OqM+dvauhyK1zJYQKJL6T5iV2VSAXGKeRUARTfy3u4dXrKpTOD
 TA5OTSZ3hzfQ+SWb37kLNVb2NRabjyDIWnQKaoplLLYMXGSUgJCBf1gTBTErKAJKjn8V
 qY/b69RKhHC39aPdquqhJS15E3PB/n/cKTPn8C0mbABnRah06ZANt5uNK6wINLWToriz
 I6j+fF1/2RBbIhXB3A9DyqxRFYU+HPoByJOXM8zcJrafMjuZAZ+6ihsFzcF2e5fKv0ol
 YRReHMKl926gwCupkOS/9r3QhuWbPYB8ZVyatdqrq+n0pC5yCcZxcRbKcKsq8CtkiYF0 Vw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36b1xpgt2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 03:28:01 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:28:00 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 03:27:59 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 6C83E3F703F;
        Wed, 27 Jan 2021 03:27:55 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lkundrak@v3.sk>,
        <linux@armlinux.org.uk>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 3/4] arch/arm64: dts: add support for Marvell CP110 UTMI driver
Date:   Wed, 27 Jan 2021 13:27:18 +0200
Message-ID: <20210127112719.30632-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127112719.30632-1-kostap@marvell.com>
References: <20210127112719.30632-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-27,2021-01-27 signatures=0
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

