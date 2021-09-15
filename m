Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506CF40C103
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhIOH4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:56:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231480AbhIOH4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:56:07 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F1m6Eq027485;
        Wed, 15 Sep 2021 09:54:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=aiizQVmK3AfqYkMO+fw6KiX7uJzSiVZw3/PoYi07I0U=;
 b=hLxj1mdY2+ySYIcyWSwU5Vrp56Hraq/0J5vfLuZQMgndGioPdcLJ9Zy6fJ2DWDVNNu+q
 4M9O2otwPycwQTCRzYERkN68yBOPSdFYJNofJ+zXDmTuIuJPtowTWkFLTcn6XmIlgJj2
 XhuxE6Ol1veZxPlF5r9/nlMrmd0OUtWcETirKeatC9uwiqNXbYzkuQvrCOdznuU5cqOe
 9eKC4F6SD11uJmbUnurRDDYNR39DRTaAfWMPkY9zDeRCB0zs6+7/QiTz/zWEXuCNUYqd
 5xqFpnclcpq1biMW+KfZaGVkKXdfW1VWtfzx9vncmnhBdxrG39h39tZRPdbNaz+9vsvH Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b37g39nq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 09:54:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F6FE100038;
        Wed, 15 Sep 2021 09:54:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 949F621C7BD;
        Wed, 15 Sep 2021 09:54:42 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep 2021 09:54:42
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <alexandre.torgue@foss.st.com>
CC:     <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: set otg-rev on stm32mp151
Date:   Wed, 15 Sep 2021 09:54:33 +0200
Message-ID: <1631692473-8732-4-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631692473-8732-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1631692473-8732-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_01,2021-09-14_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32MP151 complies with the OTG 2.0. Set it with otg-rev dt property.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bd289bf..14e3cdf 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1085,6 +1085,7 @@
 			g-np-tx-fifo-size = <32>;
 			g-tx-fifo-size = <256 16 16 16 16 16 16 16>;
 			dr_mode = "otg";
+			otg-rev = <0x200>;
 			usb33d-supply = <&usb33>;
 			status = "disabled";
 		};
-- 
2.7.4

