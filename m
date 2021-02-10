Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47A3168B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBJOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:10:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33280 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhBJOKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:10:51 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AE0dpH011435;
        Wed, 10 Feb 2021 06:10:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=F9oL5Zy+rETHQ3U6q3ECVbU8iYULR7eB3UJtyoKutrg=;
 b=KAo6wQThSgKgfqRHLApGuHbLN8/1X2B4mYTX0dJEZ2YYjJs+msqOwLf8h+QPosb1qY7V
 d5mmAylMnIrqYNmSgknOJXuIZmnh0aivZhQakry24vFgNa8PtCKvBeU+ZS/R0Oh3EDeb
 u4FqgmgIM329TYDiiX7XLRkOIKtNnnwKrlF0XrLkruEyjlS6Op0JzGGf9M73BNthorRO
 ugJRLtihbhRVKhwQVAGQKTdg9uP9j5jUbsTvePSMFz88/e6F8/W61zHKCuwQjG6iOucw
 gB6M5AC+gP97SSJ9GxUN66/oZRCv3S5plh4PPZRxuk3yXXt174fikSFubmLonQwx7eVj bA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbryr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:01 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:09:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:09:59 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id EF94E3F7043;
        Wed, 10 Feb 2021 06:09:55 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 01/12] fix: arm64: dts: replace wrong regulator on ap emmc
Date:   Wed, 10 Feb 2021 16:09:38 +0200
Message-ID: <20210210140949.32515-2-kostap@marvell.com>
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

Replace wrong regulator in AP0 eMMC definition on MacchiatoBIN
board with 3.3V regulator.
The MacchiatoBIN board has no 1.8V regulator connected to AP0
eMMC (ap0_sdhci0) interface.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index cbcb210cb6d8..73733b4126e2 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -119,7 +119,7 @@
 	no-sdio;
 	non-removable;
 	status = "okay";
-	vqmmc-supply = <&v_vddo_h>;
+	vqmmc-supply = <&v_3_3>;
 };
 
 &cp0_i2c0 {
-- 
2.17.1

