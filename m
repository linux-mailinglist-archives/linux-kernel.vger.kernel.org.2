Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA833F531
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhCQQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:10:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22220 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232340AbhCQQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:10:26 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HFlrRu010043;
        Wed, 17 Mar 2021 17:10:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=BGBMk18CEolXd/0993s64ZB5ezWBWESBj3BiykWl4jc=;
 b=cv/nBYdqEoFy7qMvZN08roPTKDSb+vrY/7CgD3q2Mk07iFDQQMisMo6mlLZascxSwb9c
 lCGCoiEzP5cBUjlH1qoU8iMDZfXXgYUXjqGK63FcyV7+0qSl+rA3d+off+54BmT4Adhb
 NAtfV83i0Z8yGaJoMfDVRm38vyX3yQfnOax5SZLwqVC4U8g2++WvbU4VO8S86Ph4vVSb
 vtV3836NUCJZYJlxMLkU0wNOxKh42bv+heFuf1l128v5ZuLNH0KQgGB/Ugyt26Xp1a/f
 BSbiujDMn+BfrTh63/daRl7Inw0PD/Vc0NhxC0/24NWJwVie6EYu2YngBbBYGWg322Fr 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37a8pr67jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 17:10:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C73C3100034;
        Wed, 17 Mar 2021 17:10:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF09423E915;
        Wed, 17 Mar 2021 17:10:06 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar 2021 17:10:06
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/2] dt-bindings: phy: add vbus-supply optional property to phy-stm32-usbphyc
Date:   Wed, 17 Mar 2021 17:09:53 +0100
Message-ID: <20210317160954.15487-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
References: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_10:2021-03-17,2021-03-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds vbus-supply optional property to phy sub-nodes.
A regulator for USB VBUS may be needed for host mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index 018cc1246ee1..ad2378c30334 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -71,6 +71,9 @@ patternProperties:
       phy-supply:
         description: regulator providing 3V3 power supply to the PHY.
 
+      vbus-supply:
+        description: regulator providing 5V Vbus to the USB connector.
+
       "#phy-cells":
         enum: [ 0x0, 0x1 ]
 
-- 
2.17.1

