Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4B3BFA90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhGHMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:49:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50424 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231433AbhGHMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:49:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168CextU011611;
        Thu, 8 Jul 2021 05:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=vU/MQb0b6PBeVeo7Wno8MSyvxiN+3dCexkda0qA+S5s=;
 b=YzavH4JWJeYQY4xhG/HTX2GjpM9H9B8tP87GJiatzfbCfrmv1aQ79KHDIJeq/kI4vwGH
 QnPXlwZuUG2dl5wZZ1AZIun+JKaU9BN3JIYXmS6807sGzDe2n8PspN7sXKgopCX3Ewx0
 EcdzcfnoY1UHHI1fL46PfXwiMNhoQICY705Feq4Rcs5ZJbUWIZlHHNZRxgtT2qn+1FKI
 nwn4io3qOadHtpZvLA683S19L/YYl8MvKkdtT3/SQ9dKCtMjAALon45rfWMIdFynwY1v
 ewaFc0vakBEPlomDG3jJqHXuHabS5UzxDknMLJVk5aRhUZCCH0Mjdvdp19Xr/e1CNFtA uQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 39nrnu1y17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 05:46:26 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 8 Jul
 2021 05:46:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Jul 2021 05:46:25 -0700
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id E9C453F7064;
        Thu,  8 Jul 2021 05:46:20 -0700 (PDT)
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
Subject: [PATCH v7 1/5] arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
Date:   Thu, 8 Jul 2021 15:46:08 +0300
Message-ID: <20210708124612.30742-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708124612.30742-1-kostap@marvell.com>
References: <20210708124612.30742-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VF6jb6yGeF_fiYkvzos-znVEyqZlI72w
X-Proofpoint-GUID: VF6jb6yGeF_fiYkvzos-znVEyqZlI72w
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Eliminate 1MB gap between Linux and filesystem partitions.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index 2c2af001619b..9758609541c7 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
@@ -260,7 +260,7 @@
 			};
 			partition@200000 {
 				label = "Linux";
-				reg = <0x200000 0xd00000>;
+				reg = <0x200000 0xe00000>;
 			};
 			partition@1000000 {
 				label = "Filesystem";
-- 
2.17.1

