Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA8F439A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhJYPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:20:57 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:55518 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233886AbhJYPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:20:39 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PC9Btq012722;
        Mon, 25 Oct 2021 17:18:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=krpL7TeohHXNEh3e/AyvQVET92Qb+upGuFPSFj2crj8=;
 b=QFfA/a7i3CbcM6794ulI4QTTXdjd/cCdwD2r7Jv6Eix1ig5Au3cd3bfaib1ZozHSxIy/
 lR19KGMgpqKHdA7jhBbQRsW5B0CKknMY1epVQCrfCO0SW+E/tcPuFzjb2UR4EJenFdrn
 m8gVCVW3KEswIfLnYLVI4Ia8Osci1wSfBgqe/UdVheTwhyKUinkxx5bESwj1gl1lI5aA
 bN/WJRKFvvFfoOaZStq3EINP21WpRZpVqPIeaeK7CWOsI7KGmKSFp+ordwfGn4jMHGS8
 +SasvXRZfLX35nN5Ep1Ee/R5azDxZa/aEqXDGpgqR7tMK8W3ZVtYeEVk9b/pdxvWcSUL CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwqpsjtv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 17:18:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2353100038;
        Mon, 25 Oct 2021 17:18:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CB83B24187B;
        Mon, 25 Oct 2021 17:18:05 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 17:18:05
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <amelie.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: tune the HS USB PHYs on stm32mp15xx-dkx
Date:   Mon, 25 Oct 2021 17:17:49 +0200
Message-ID: <1635175070-28722-2-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635175070-28722-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1635175070-28722-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds phy tuning parameters for usbphyc port0 (USBH controller)
and usbphyc port1 (OTG controller).
Phy tuning parameters are used to adjust the phy settings to compensate
parasitics, which can be due to USB receptacle, routing, and ESD protection
component.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 899bfe0..48c7a11 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -694,10 +694,26 @@
 
 &usbphyc_port0 {
 	phy-supply = <&vdd_usb>;
+	st,tune-hs-dc-level = <2>;
+	st,enable-fs-rftime-tuning;
+	st,enable-hs-rftime-reduction;
+	st,trim-hs-current = <15>;
+	st,trim-hs-impedance = <1>;
+	st,tune-squelch-level = <3>;
+	st,tune-hs-rx-offset = <2>;
+	st,no-lsfs-sc;
 };
 
 &usbphyc_port1 {
 	phy-supply = <&vdd_usb>;
+	st,tune-hs-dc-level = <2>;
+	st,enable-fs-rftime-tuning;
+	st,enable-hs-rftime-reduction;
+	st,trim-hs-current = <15>;
+	st,trim-hs-impedance = <1>;
+	st,tune-squelch-level = <3>;
+	st,tune-hs-rx-offset = <2>;
+	st,no-lsfs-sc;
 };
 
 &vrefbuf {
-- 
2.7.4

