Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41D13150C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhBINtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:49:16 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:38000 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231816AbhBINrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:47:36 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Dk7li022653;
        Tue, 9 Feb 2021 05:46:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=RjF1O7up2zLp1Oc6rdxUA9EIWEPcvCvW09fitTDa0Jw=;
 b=DT5i+13VDCVSJzlqVw29tcOQwgYh2u62IDA9CI0UJiFsF2VgdCjIw2lXEmS6KjQUgD+C
 VKPVdQ4TubYI+of4K1cDsDIfJCqSg6BV+uSVWnYucaLoaIRJkDOKl5u9XMzgqu5+m7OC
 i5vgOvYh6mFfpRgJVOydX0KWnRfbSFMICqKW1le7SDblD8CFAcjmBUjCsdCqrsrf1d+E
 fGOgo3S/kviU6WNxcREaO9YFtbJrjD6bNSMEGhWI64fkoVU30gRV1usqinNu1QCM2NYc
 KEV+3/APEUyZBHV/FVzHKgcS4m1Hfn/HedwubpE1z8I+/xbxAzxVYx8e0xGFH2sl4AHC ZQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrgcp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 05:46:45 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:43 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Feb 2021 05:46:43 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id EA4633F703F;
        Tue,  9 Feb 2021 05:46:38 -0800 (PST)
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
Subject: [PATCH v4 2/5] arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
Date:   Tue, 9 Feb 2021 15:46:07 +0200
Message-ID: <20210209134610.19904-3-kostap@marvell.com>
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

From: Konstantin Porotchkin <kostap@marvell.com>

Eliminate 1MB gap between Linux and filesystem partitions.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index ce49a70d88a0..d24294888400 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
@@ -258,7 +258,7 @@
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

