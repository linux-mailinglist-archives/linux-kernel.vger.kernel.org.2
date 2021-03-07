Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE43302FD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhCGQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:34:49 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52874 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhCGQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:34:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127GUOaK002636;
        Sun, 7 Mar 2021 08:34:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=hNLxXh25PZX9OUyMTTBrMtQYkINjr95UyjaDVZbLI08=;
 b=jU1JIlyyTgTLYW7xO6uCZqM2YV4hmDhqjWAT6rYW33RuNUfS3GC/kYbSlg9CIKKvAz35
 FMDvNsb9tc8Fh3qUnbYgS9QbF+LXy5SCiGX274mjfMLi3BucMcOpYz04xQ/D9/sBSmjH
 I+ZBxi0H3NsB+DfI2/UEPGNH1FBgldgWPNkU4LVZPDOlkzrQsmvd4pAjlPXeHyP3Sk/l
 E+EeJTV7DENvB2/Gyv8Oy4k83xyq55ozn3a920dyKJOjl4Dgz2FuBxnWUbpvWmsDdOmD
 66dni4ZfsRxpCn0xkdiPLfri+kuoYaIAn0hZ9tTT9g+NHB7QoaPzW0kQSXGsXFlT+i0A 7w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqsr36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 08:34:23 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Mar
 2021 08:34:21 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Mar
 2021 08:34:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Mar 2021 08:34:21 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 028153F7043;
        Sun,  7 Mar 2021 08:34:16 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 4/5] arch/arm64: dts: add support for Marvell CP110 UTMI driver
Date:   Sun, 7 Mar 2021 18:33:42 +0200
Message-ID: <20210307163343.25684-6-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307163343.25684-1-kostap@marvell.com>
References: <20210307163343.25684-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_10:2021-03-03,2021-03-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add support for Marvell CP110 UTMI PHY  in a common DTSI

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 64179a372ecf..49f9d2cd8619 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -285,6 +285,25 @@
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
+			CP11X_LABEL(utmi0): usb-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			CP11X_LABEL(utmi1): usb-phy@1 {
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

