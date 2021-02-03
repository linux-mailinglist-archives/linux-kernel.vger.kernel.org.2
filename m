Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0095B30DB68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhBCNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:35:28 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39568 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231459AbhBCNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:33:04 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DUgDa019916;
        Wed, 3 Feb 2021 05:32:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=SP4NWci7p9L5aYWoA8GhSUF3mmpE/ifw+Jo55hkNkj4=;
 b=cjWTr4j9rM9XCkEGJDBh4t1YNW2Z6ZhN/2oH3q41RuFF7QfMYm5vOAjdv4tKx9fE0eLD
 k9TY6+MK8VmF3KJVrNnbeZUUhF9mo7nO2+IuXDmTT/NncO4zvYMeVcZZmn3zhskTemND
 nVc0FoDwpp3Ubalub8XMny0AUktclu+ZfKQ/Zn9PZL4PBeDHWitfdbyZZwtDGNDoEkXN
 YkjWp8xCcrx32jHEykp1z0uOEGOQOhixQogBuHVzoqcQyWslOyz+f6ozHfaTUJ0is8r9
 80ZgUHO4eyqJDU/Cf8OSEcYx+4hSnS99OuRMZ0nFNZnEvGRLq6yll9GIKlRK0h7MA5dB dA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3ag7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:32:15 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:32:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:32:13 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 696733F7041;
        Wed,  3 Feb 2021 05:32:10 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 08/11] arm64: dts: marvell: armada-3720-db: add eeprom description
Date:   Wed, 3 Feb 2021 15:31:35 +0200
Message-ID: <20210203133138.10754-9-kostap@marvell.com>
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

