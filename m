Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305C30DB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBCNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:36:17 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:15928 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbhBCNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:33:03 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DQFAq011143;
        Wed, 3 Feb 2021 05:32:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=msIiUKbingPmOmhsYKgSye9q3s6UPFRd6YjJlvkHYGs=;
 b=lZ2ew0rq33mV7FPXBcnr0whnIS7XDvRTLM2zX5WyAuCqKO6/oRTTijV0aslMUAwSqqrw
 p/nNo8kSmB3RRo6gFRLC5FAm+4vlrf7S8BOJKJH0nTWIGGC/ai4ELOi2lHQEww1D6ILc
 zQxlSNvImA6ZKA7UVRQeh4JUPnl6fNbAEn0Magm9l03/OaaxxDVhqdI5h9sU0jGGEgI/
 Zfu+RYjPsJ4QbFy0sgwnJalEQBBbf6sArplzEvxa8CpSVYP3oM4QV3ciR0fNwbiNVb9I
 xxcsobiYxQu9AxeWD8fvLVRH27EwnpI5Ko7ogqdbjAlfRXOP0HXYd5GF7pqs5N6OQ3ME 7g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36fnr6154q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:32:12 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:32:10 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:32:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:32:09 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id D34603F7043;
        Wed,  3 Feb 2021 05:32:06 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 07/11] fix: ARM64: dts: cp110: Switch to 8-bit ECC NAND setting
Date:   Wed, 3 Feb 2021 15:31:34 +0200
Message-ID: <20210203133138.10754-8-kostap@marvell.com>
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
index d96aa9e9e61c..04241dba189e 100644
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

