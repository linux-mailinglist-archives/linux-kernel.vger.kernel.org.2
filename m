Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26343168D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhBJONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:13:37 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60658 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231926AbhBJOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:11:29 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AEATaX031469;
        Wed, 10 Feb 2021 06:10:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=fX+EWkwnTUd2MgsWVftPqyZbyK8EJpnIeNoIM84CgaE=;
 b=RQu9BvR3ZrXSYh5dItEkEvoMWjjh3BMxDvQ1BYhcwRVzoNyqN+wWOnBaG7lzCA0b4Fo3
 DBCgg/1HDBMNVM0lv+yi/2SBq5G0sJ/iggo7EUu9KvNbo1TOR6L58PhdwWs2xCCV6Ivn
 X04eK6Jn+wnZNcfGp3VeaxsqnEnGC+KhOq8sh7RqRwiH60XHcC8mGbj6wyyJEEIJFFKX
 KiXg29Qo42I2voC1SNY0f3NeH3F7MDeIx0JZUEnhx1ygVtJpJfY9IV6PnXSsJyT3EByr
 qscpZVOmBX0H9TRXtqk8DjBzp1Qy+Caky3v0xdGE188KiJl/YTat+NXYvmTJt5epkmsR lw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbs18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:37 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:35 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:35 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id D03B93F7045;
        Wed, 10 Feb 2021 06:10:31 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 11/12] dts: marvell: add 2 eeprom properties to A7K DB device tree
Date:   Wed, 10 Feb 2021 16:09:48 +0200
Message-ID: <20210210140949.32515-12-kostap@marvell.com>
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

From: Ben Peled <bpeled@marvell.com>

Add on-board i2c EEPROMs U37 and U38

Signed-off-by: Ben Peled <bpeled@marvell.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 39f1d393664f..c8258defa9e5 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -152,6 +152,20 @@
 		 * IO0_7:		IO1_7: SDIO_Vcntrl
 		 */
 	};
+
+	/* U38 */
+	eeprom0: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <0x20>;
+	};
+
+	/* U37 */
+	eeprom1: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <0x20>;
+	};
 };
 
 &cp0_nand_controller {
-- 
2.17.1

