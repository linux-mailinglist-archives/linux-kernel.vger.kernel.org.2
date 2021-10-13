Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2342C6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhJMQ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:56:11 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52684 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhJMQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DEdTa3014971;
        Wed, 13 Oct 2021 18:53:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=YBdX9wdz7iUgzxH36AjVlR6UXTnIlQMVglJrl1+MRJ4=;
 b=la7knO+U0Hs9Qv4w9Pkl8IoPUJFZfODk9dAX12EoA3gPZtrcdwfYWQfypWVIKQUrTHAE
 anG41W+hA1D34BA0KHNiAdJYMtEO66Ku4AOxvcIQ4LCZYh8fVn6g9n5KBZGaHjiEaVow
 T2k1xzg4nGZDgJUEA7ifS2w6UgUI0LN1bWk6y/WklRQmMnh526+kv2r48uHEjOfqtiy2
 Ue1I61/CvTXjiF2Cu4P+JfSjpzOpTwI84kjKoyF8B+whW22ludeoWG79zxoOdEyyEk7r
 Dgb2CX/UsGNNQgM7q6zkv+enSK8X9jFdK/VbPZr/uwWc5wbC+7cqVRJ9g3tuy1SgUj19 tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bp1dqgnav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 18:53:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ACF3510002A;
        Wed, 13 Oct 2021 18:53:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A26D924489A;
        Wed, 13 Oct 2021 18:53:56 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct 2021 18:53:55
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH] dt-bindings: usb: dwc2: document the port when usb-role-switch is used
Date:   Wed, 13 Oct 2021 18:53:46 +0200
Message-ID: <1634144026-3326-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "port" property, which is used with "usb-role-switch"
to describe the bus connector.
Definition is inspired from mediatek,mtu3.yaml.

This fixes some errors seen when running "make dtbs_check":
... 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: ... Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 10c7d9b..7d1aa53 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -130,6 +130,16 @@ properties:
     description: If present indicates that we need to reset the PHY when we 
       detect a wakeup. This is due to a hardware errata.
 
+  port:
+    description:
+      Any connector to the data bus of this controller should be modelled
+      using the OF graph bindings specified, if the "usb-role-switch"
+      property is used. See graph.txt
+    $ref: /schemas/graph.yaml#/properties/port
+
+dependencies:
+  port: [ 'usb-role-switch' ]
+
 required:
   - compatible
   - reg
-- 
2.7.4

