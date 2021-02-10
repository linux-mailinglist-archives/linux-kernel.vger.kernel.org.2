Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616093168C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBJOLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:11:41 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50873 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhBJOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:11:06 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AE0okn011463;
        Wed, 10 Feb 2021 06:10:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=y1j52uOfzBx3GUao41qAmpabKvsuQHh3Ms1pKkA3Pq8=;
 b=AVA+C+FiW1ZQQO0iTzK/iSacZsMrHpS9tJV4eXmtXx9yge8WKQGwl/lIvybNAjGdOLi0
 AnBY4d5AyUoJB8SvCXoJCKcwu8WVvm5QWZBIDFJcHuTHb5KiUDMe9CqKjZCk7wMnEONy
 3YYau7Yzpk3AyQzlWhj0jDS++FoEeZrYQMD79y44LdU8wv0FxGCdGkWompl9ndCf775V
 2MGVhMj917KI+dNAbrBzmuFinz1ZLhCVNhyItoJyJW4+WOG2N/JqLVKHxDtPp1Zjx1My
 eSbfgR6HJBhx27wg0G/5spF6BQIG7qgdeWxdKoHmDDB5QHSr1Fv9hKm1Tpwv5JMz+u5a Nw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbs0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:15 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:14 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:13 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 4350F3F7041;
        Wed, 10 Feb 2021 06:10:10 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 05/12] arm64: dts: marvell: armada-3720-db: add comphy references
Date:   Wed, 10 Feb 2021 16:09:42 +0200
Message-ID: <20210210140949.32515-6-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210140949.32515-1-kostap@marvell.com>
References: <20210210140949.32515-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grzegorz Jaszczyk <jaz@semihalf.com>

Adding phy description to pcie, sata and usb will allow appropriate drivers
to configure marvell comphy-a3700 accordingly.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 3e5789f37206..15e923f945d4 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -132,11 +132,15 @@
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
 	status = "okay";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&comphy1 0>;
 };
 
 /* CON3 */
 &sata {
 	status = "okay";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&comphy2 0>;
 };
 
 &sdhci0 {
@@ -217,4 +221,7 @@
 &usb3 {
 	status = "okay";
 	usb-phy = <&usb3_phy>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&comphy0 0>;
+	phy-names = "usb";
 };
-- 
2.17.1

