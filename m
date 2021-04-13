Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8D35E193
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbhDMOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:33:22 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:57304 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245336AbhDMOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:32:56 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DEWM2J010080;
        Tue, 13 Apr 2021 16:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=6iYZAF1/Vkdy0FjL5VVkFCS8auvkDLWr+RYeFeOCiXE=;
 b=j8FYMo56x90Zcosuc6Ro8E1d7ChzXvz0xjd4XzM2ns3qPeYKqjVeLUaca/QXC8hcqo+k
 Y8ttq5v6dIpzxp2Hqu6moTU3AdDccNUOij7TJfUwUP8tebIVjRbS2so6dtcIiV1e5upT
 8PCnIpigGvkcCstA+uOczXHRKWFKUygzygDT//AMDX7RXPnyjUYACEYI0W0DhHH0NpTu
 v6rQUFJD4h4BCXhFW74z5hd0G63BGQUK8zjWWI+dZFdu+akJqIaxeSHD2toFYmpmCiFD
 R50UCb7neqGdxdo7w6iZO/5YKji3AoNIrsqtDr1RNbmkBGdvRZNPJIk8eDOwo64BTG8V Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37vrp5e7eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 16:32:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 292B510002A;
        Tue, 13 Apr 2021 16:32:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19702246F3E;
        Tue, 13 Apr 2021 16:32:16 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 16:32:15
 +0200
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
Subject: [PATCH v2 1/2] dt-bindings: phy: add vbus-supply optional property to phy-stm32-usbphyc
Date:   Tue, 13 Apr 2021 16:31:40 +0200
Message-ID: <20210413143141.12919-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413143141.12919-1-amelie.delaunay@foss.st.com>
References: <20210413143141.12919-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_08:2021-04-13,2021-04-13 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds vbus-supply optional property to phy sub-nodes using
connector node.
A regulator for USB VBUS may be needed for host mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- add connector vbus-supply property as suggested by Rob
---
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index 018cc1246ee1..3329f1d33a4f 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -74,6 +74,13 @@ patternProperties:
       "#phy-cells":
         enum: [ 0x0, 0x1 ]
 
+      connector:
+        type: object
+        allOf:
+          - $ref: ../connector/usb-connector.yaml
+        properties:
+          vbus-supply: true
+
     allOf:
       - if:
           properties:
@@ -130,6 +137,10 @@ examples:
             reg = <0>;
             phy-supply = <&vdd_usb>;
             #phy-cells = <0>;
+            connector {
+                compatible = "usb-a-connector";
+                vbus-supply = <&vbus_sw>;
+            };
         };
 
         usbphyc_port1: usb-phy@1 {
-- 
2.17.1

