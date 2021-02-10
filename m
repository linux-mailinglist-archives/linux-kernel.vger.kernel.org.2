Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162573167CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBJNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:18:48 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29254 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230268AbhBJNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:17:31 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ADG5a0013054;
        Wed, 10 Feb 2021 05:16:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=lcPVSiUXmedqgEc18XcnTl1jkSDY2V18zNZaWGxhnQc=;
 b=YIb8NBj4LD9lvS8QKwjwMN8X5nKoN0kI+UjSUCpCDMXHVd8cUA6OHbKluX5ku8NAXq9x
 n7p08Z/+Kc2RzrvPyyr8hE4nk6d360rteudhcbOWXeg9L/TI9OZjTODwPF+x/kuHq0xE
 XGKv1FJHuAfzNrLGGlUc1J38Dd8yAfbZ/FxoY7K2kecWH014p39cvdomGOaeFEhUggAh
 AOMOhR44v+ntPwoI1h+a1n1rfkOw1zXrmU6BoKHzqIRvZ6gP13M7L4xGY8xM9x+c30py
 5K5P/C2ELYJAd5wZmavvJqQjpOfN+2fzfGXNKtbOsmkRjWC4UccjxAcJ2Mn8gFdtgtkD xg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrkw91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:16:32 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:16:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:16:30 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 37B723F703F;
        Wed, 10 Feb 2021 05:16:26 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <vladimir.vid@sartura.hr>, <tmn505@gmail.com>,
        <luka.kovacic@sartura.hr>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v5 4/5] dts: marvell: Enable 10G interfaces on 9130-DB and 9131-DB boards
Date:   Wed, 10 Feb 2021 15:16:03 +0200
Message-ID: <20210210131604.28806-5-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210131604.28806-1-kostap@marvell.com>
References: <20210210131604.28806-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Chulski <stefanc@marvell.com>

This patch enables eth0 10G interface on CN9130-DB paltforms and
eth0 10G and eth3 10G interfaces on CN9131-DB.

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index 8de3a552b806..97c74b81fd78 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -125,7 +125,7 @@
 
 /* SLM-1521-V2, CON9 */
 &cp0_eth0 {
-	status = "disabled";
+	status = "okay";
 	phy-mode = "10gbase-kr";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy4 0>;
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index 82471a83ad6d..f2e4d3a6a4f8 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -84,7 +84,7 @@
 
 /* CON50 */
 &cp1_eth0 {
-	status = "disabled";
+	status = "okay";
 	phy-mode = "10gbase-kr";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp1_comphy4 0>;
-- 
2.17.1

