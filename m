Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5F30DB81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhBCNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:40:31 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15068 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231303AbhBCNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:59 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DUfwF019760;
        Wed, 3 Feb 2021 05:32:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=0oNZfFPSPI7qXXMHtz5R4nxV70W2GWek2APnlNw4wlA=;
 b=hPjT83v8QVCy1kyCNAZbaqhOqosuDZ92V9rkowf/Mt4bTz3EAUuQZxTRSDLRSN5zGPyv
 XlM5SDam3wHRQ+Tv0ASmd2m6zwszTmO75uMhRx81qS3cMnqJWOlmA2AXGI/QwLJc/Kwr
 EYodLvCj5DddSIh6xtAkqJYxXU3RKEpqZwri6xMUaoUuotX0GLCDkXrDuliD6xlsBy07
 DC24ylLS3HZHZHEPiKXBvmdcj7IX7slQ/gLPNcwq7LU7dVnqDviqw95l/KGzWXbeye9e
 cbA6CoiRDPiz4/QmF5Y2gubAktovk9vEtKZDL9Srb8sBht8vX3ZNDao/agRUpFX88nV/ qw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3afw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:32:07 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:32:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:32:06 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 4077D3F703F;
        Wed,  3 Feb 2021 05:32:03 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 06/11] arm64: dts: marvell: armada-3270-espressobin: add comphy references
Date:   Wed, 3 Feb 2021 15:31:33 +0200
Message-ID: <20210203133138.10754-7-kostap@marvell.com>
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

From: Grzegorz Jaszczyk <jaz@semihalf.com>

Add "phys" entries pointing to COMPHYs to PCIe and USB3 nodes

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index daffe136c523..bbd955909813 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -59,6 +59,8 @@
 /* J9 */
 &pcie0 {
 	status = "okay";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&comphy1 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
@@ -139,6 +141,9 @@
 /* J7 */
 &usb3 {
 	status = "okay";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&comphy0 0>;
+	phy-names = "usb";
 };
 
 /* J8 */
-- 
2.17.1

