Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA873150C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhBINuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:50:16 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62288 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231828AbhBINrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:47:48 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119DkJB3022672;
        Tue, 9 Feb 2021 05:46:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=w2NJn+aqgzr+nJir25ka81y3E8gD1k6g4nu6Xbwb7+A=;
 b=Ae2O81c3T8FK997Db0JlJg+U5RytyiwBXzKdrkZYLyC4QOWDtqxO2HKJ3bRuV+zUoRDU
 2AnCpM5SgNs+IVmwFrX0gMOj67CA3QjIkRVvdELfVK3v//Q+0LgdHR+jFEItfmBOyDqw
 ZaAagVgTqMS9PRuItD0lDqMzRGgxcxwqzHq6UmroOx3GApw48aEfC45jI1ySBIdsgypi
 nGtpshAS54dvIfWr0QmR1AYvHhwoxIw0zhG/BLSgSkaJ/WN3XXetaW42OcLsT4Jn4+X2
 /tjACy3V7aPIHps07g9vISXCVJRe+x2vze/Gpsqv2bYCj6IXMrq0FVQFxKOhdbNwTwQy pQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrgcpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 05:46:54 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:53 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Feb 2021 05:46:52 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id B4F0B3F7040;
        Tue,  9 Feb 2021 05:46:48 -0800 (PST)
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
Subject: [PATCH v4 4/5] dts: marvell: Enable 10G interface on 9130-DB board
Date:   Tue, 9 Feb 2021 15:46:09 +0200
Message-ID: <20210209134610.19904-5-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209134610.19904-1-kostap@marvell.com>
References: <20210209134610.19904-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Chulski <stefanc@marvell.com>

This patch enables eth0 10G interface on CN9130-DB paltforms.

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.17.1

