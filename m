Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51D3BF8F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhGHL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:29:11 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30456 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231797AbhGHL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:28:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168BBDes023114;
        Thu, 8 Jul 2021 04:26:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=TRRMBtUXw8cjaFo0FGXaYeU12pX0zsm5KZ5lADeidow=;
 b=Yu+EOVCwSy3f9jcwXLdxIPevZL8kr9s8dTFj5zRGLDyUV3OD9mfBBP5+PtgeSGf50eza
 Zqe3QuxjpBl+US5IutJLkKJE+AV3LSxWUsWnw7BKbi/4w4oZXbRpImUwr+7WZPoyy3Xm
 ECiRNRLx5Xz7muCvfBKKkoHbdNxfLP6/NcOrrGuLypxXi5aVukNfDCgPcqubXoxcFbbL
 Dbuyg9BaU0AH+MxjyQTvYELoeheFjnn8A6gwOPDkuGC7LWLkyx4kqPU1LigzNDy/D0z1
 bFD2O+svn8T8ASut+kcKMMiIGdxytkTYPgmAsaRKAgnaa52GIHUZDBr1GySKp8SfQVG6 bA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 39ny0g89q5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 04:26:08 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 8 Jul
 2021 04:26:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Jul 2021 04:26:06 -0700
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 019903F7069;
        Thu,  8 Jul 2021 04:26:01 -0700 (PDT)
From:   <kostap@marvell.com>
To:     <miquel.raynal@bootlin.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <vladimir.vid@sartura.hr>, <luka.kovacic@sartura.hr>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mw@semihalf.com>, <jaz@semihalf.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <bpeled@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v6 4/5] dts: marvell: Enable 10G interfaces on 9130-DB and 9131-DB boards
Date:   Thu, 8 Jul 2021 14:25:27 +0300
Message-ID: <20210708112528.3254-5-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708112528.3254-1-kostap@marvell.com>
References: <20210708112528.3254-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Szp3zrJs5wVZ7jKB_nxUgQKLmfLAA6yY
X-Proofpoint-GUID: Szp3zrJs5wVZ7jKB_nxUgQKLmfLAA6yY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-06,2021-07-08 signatures=0
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
index 34274e061958..39fc90716454 100644
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
index a7ab791631bc..daddab638fb8 100644
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

