Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2612C43C94F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbhJ0MPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:15:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56860 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239982AbhJ0MPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:15:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RAq1gg007199;
        Wed, 27 Oct 2021 14:12:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=K+V7SoDRwFrj72+BVN9PGl0W0QLtqYKgJ5J1yPfvkds=;
 b=MOt0ClCsAAuqT4WNaIOWc7DnFY6E103KUFNvdXYeSUm9z5aYBUB7KRsehW+2uqaCwrI4
 B6NM2OQ35gYqyhghqre3yKRVTShnFWDqAtXTMAI1aMzxGhaJqfaiXCuOfOx0a+0CJT7q
 7zs01o8LvenonBMGO+dQBAyrJtPF0+bXGieH/q3gw6tfCQkAWD+20vkzTZXJVWadEu7y
 lZdqUbAyQVe6eZm7E0Im94XRz2a6K5u63BrP6Xp5Xz49eWGk/T7aQtUSlMEY1cwJ1Ddc
 r0ldMwm+JUFz3EO++wC1ORX26b48u9Pg5tiTFI06nDSzghTbobUh4pBNGnYt0lHIyWq+ tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3by10btbpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 14:12:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27C61100038;
        Wed, 27 Oct 2021 14:12:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E82C241850;
        Wed, 27 Oct 2021 14:12:42 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Oct 2021 14:12:41
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2] dt-bindings: usb: dwc2: document the port when usb-role-switch is used
Date:   Wed, 27 Oct 2021 14:12:32 +0200
Message-ID: <1635336752-14796-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_04,2021-10-26_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "port" property, which is used with "usb-role-switch"
to describe the bus connector.
Definition is inspired from mediatek,mtu3.yaml.

This fixes some errors seen when running "make dtbs_check":
... 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: ... Documentation/devicetree/bindings/usb/dwc2.yaml

Note: add dependencies so that 'usb-role-switch' without port is valid or
both must be present.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
Rob's review comments:
- drop reference to graph.txt
- drop unneeded quotes
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 10c7d9b..a351f3c 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -130,6 +130,16 @@ properties:
     description: If present indicates that we need to reset the PHY when we 
       detect a wakeup. This is due to a hardware errata.
 
+  port:
+    description:
+      Any connector to the data bus of this controller should be modelled
+      using the OF graph bindings specified, if the "usb-role-switch"
+      property is used.
+    $ref: /schemas/graph.yaml#/properties/port
+
+dependencies:
+  port: [ usb-role-switch ]
+
 required:
   - compatible
   - reg
-- 
2.7.4

