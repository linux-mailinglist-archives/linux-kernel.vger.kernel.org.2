Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB23168D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhBJOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:12:29 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33786 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhBJOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:11:19 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AEARZL031422;
        Wed, 10 Feb 2021 06:10:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=SP4NWci7p9L5aYWoA8GhSUF3mmpE/ifw+Jo55hkNkj4=;
 b=U0ehoyqRybqhkxeCK1ZK/T2XBnyjTQs1NVn1mLqU/DtNPkKs2NZAEajEbfSn1Fcq52DY
 MYjUl2NypDK/rknHwgP9izXjGbgUKSp3/HqIea7Mku4tj9T/CUgb9xZ30guaEtbID7Eu
 7v/itrnaFyItES0iS3XO5b0rZ4Y11FUweJoWhHC+zwmM7bcgYv0ScvqzKu4BqPOr2Dh3
 1E0DICShTnig+oB5DCh+HhecEn2CdZalwRFL1WKVz0VSH3nkw5GN17UTOuPUp4/jskKx
 xVogDaiedsUp9wf5B5CsKuetXHzWjDR+DxrcV/FwxibcjT5jWn6Jai4DO+PXq9L9Gr18 9A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbs0g-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:27 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:24 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 0C5A63F703F;
        Wed, 10 Feb 2021 06:10:20 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 08/12] arm64: dts: marvell: armada-3720-db: add eeprom description
Date:   Wed, 10 Feb 2021 16:09:45 +0200
Message-ID: <20210210140949.32515-9-kostap@marvell.com>
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

On Armada 3720 board there is serial emprom M24C64 at address 0x57,
reflect it in device-tree.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 15e923f945d4..f2435537c1d3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -113,6 +113,12 @@
 		compatible = "dallas,ds1337";
 		reg = <0x68>;
 	};
+
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
 };
 
 &mdio {
-- 
2.17.1

