Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EE3168CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhBJOL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:11:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12090 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhBJOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:11:16 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AEARZK031422;
        Wed, 10 Feb 2021 06:10:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=w345rOU6oWLuwnG3ybqJmfa8vkIYO0JytlkQ4yh5VBc=;
 b=Z5u5O7V4EKzgWiJVrT+6V6ok197Edh9lV97POt3qy+kO/x+Mv0A8qk+l37P3O9aTfgRe
 CY/2nit/UyNqQnAPcEUj4Q81zdqXxgbMlyWpkZIX5DSQ+pAQtcqC9ggVI1oaBZpYVuHr
 /wwEYY/lkNR0IneY+Ct0/Q0V/QQmTp4ShdtUIYHAfR/grl+2nIlB+BbkTZSbG8Mn6Q1G
 PgOHVNPKi3u6PJig3R4kRZpSFcF9dAFx2ux0HIyl7OIlDb4OSe99ihsrYZQEcTiYxdq2
 19PMabCucUbeG9j4yuDuxJjF6GalnZzRAxN+lcM00vXjyFxKg/RnipGXpVIB6hCaatHQ QA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbs0g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:26 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:21 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:20 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 771703F7041;
        Wed, 10 Feb 2021 06:10:17 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 07/12] fix: ARM64: dts: cp110: Switch to 8-bit ECC NAND setting
Date:   Wed, 10 Feb 2021 16:09:44 +0200
Message-ID: <20210210140949.32515-8-kostap@marvell.com>
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

From: Konstantin Porotchkin <kostap@marvell.com>

All A7K/A8K boards are using NAND chip that supports
8 bit ECC strength. Using lower ECC strength is not recommended
by the flash manufacturer and may cause data corruption.
This patch changes the nand-ecc-strength value from 4 to 8.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index f8179cadc610..39f1d393664f 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -169,7 +169,7 @@
 		label = "pxa3xx_nand-0";
 		nand-rb = <0>;
 		nand-on-flash-bbt;
-		nand-ecc-strength = <4>;
+		nand-ecc-strength = <8>;
 		nand-ecc-step-size = <512>;
 
 		partitions {
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 790c7ab0b816..372eda1f8898 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -281,7 +281,7 @@
 		reg = <0>;
 		nand-rb = <0>;
 		nand-on-flash-bbt;
-		nand-ecc-strength = <4>;
+		nand-ecc-strength = <8>;
 		nand-ecc-step-size = <512>;
 
 		partitions {
-- 
2.17.1

