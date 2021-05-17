Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A9382BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbhEQMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:10:58 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36335 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236920AbhEQMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:10:50 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HC6pOf010306;
        Mon, 17 May 2021 14:08:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=/iRm6XLUsizToc00x1Pm9rvjqNdz5eb8TrDBu4Oy548=;
 b=qzemeJDN3FnIi9Oz7UgrruiF7qH/WHunE8nnKSmkPGUBeWwJvF+XrZGJTj3GL3pC7mvy
 bLOBv45IhPVCjeQ5PomhOfcxLRVARsEqZbp/KnZGo2Lk0l1EnVjDedJTorOfcPxwzkDz
 R/ifSfY+6zs3Ln/IRU142Mx9r3Cupwmf2peYf0lsApo0YznMNS+FU3EP8028l7yGnSv1
 FWbPNjJLV4+cniN03SSwyzXDgVmdUKOGiDq3bf12aXmnN9dEz0j5HuLVTcPc0x7Xx+2o
 /85sfKQNO4dfHxRofK0szzkE57NOEdT5fWT23YYoOeACmaeeaHC/fYnGxMHVFp8ZOCkm Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38kmb2sf3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 14:08:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 551C5100034;
        Mon, 17 May 2021 14:08:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42B6622D636;
        Mon, 17 May 2021 14:08:26 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May 2021 14:08:25
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
Subject: [RESEND PATCH v2 1/2] dt-bindings: phy: add vbus-supply optional property to phy-stm32-usbphyc
Date:   Mon, 17 May 2021 14:08:20 +0200
Message-ID: <20210517120821.26466-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
References: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_04:2021-05-17,2021-05-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds vbus-supply optional property to phy sub-nodes using
connector node.
A regulator for USB VBUS may be needed for host mode.

Reviewed-by: Rob Herring <robh@kernel.org>
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

