Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79DE42C1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhJMN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:59:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230324AbhJMN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:59:35 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DCKVxX008598;
        Wed, 13 Oct 2021 15:57:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=4SRWMG38Lgohb4Pv4LkqAWWlG/xeolL726Z+PJDVPPQ=;
 b=wpH2ki+aak3vtsfRbAd80C9S1u5wp/XvuodTC8/OjEh8GYj/9e5J9PRVNsuAyOmXqkJ/
 fRimSe0xuG/gC2tGiX1+r2vIbN9DhzkHY29o9U9nS9FaZY4fDbAPTFkPkyw7MsTeReI6
 LyTGKejld69gNiVMQjeUOlt/teBC08MKBq/j5w9Zwmd4/GMi8grgj1cgTkOyj5xlT5Ca
 WpKKNU+P0nqqLpJblA84QaJZBDiBQroHSuIJ8UWL9xgOcDNwiQvv4dbYnlL4rDQKYcZC
 X/SEmAT6OWanNMglxAfHtqoMqYfXqd1Io0mN0x+XO68EkHQD8WCfAroLqwpcXr8ex+fM 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bnuactnta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 15:57:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF8CB100034;
        Wed, 13 Oct 2021 15:57:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A541522F7CA;
        Wed, 13 Oct 2021 15:57:25 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct 2021 15:57:25
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v3 2/4] dt-bindings: usb: dwc2: adopt otg properties defined in usb-drd.yaml
Date:   Wed, 13 Oct 2021 15:57:03 +0200
Message-ID: <1634133425-25670-3-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt some OTG optional properties as defined in usb-drd.yaml:
- otg-rev
- hnp-disable
- srp-disable

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 0acbb7a..56a8184 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -106,6 +106,12 @@ properties:
 
   dr_mode: true
 
+  otg-rev: true
+
+  hnp-disable: true
+
+  srp-disable: true
+
   usb-role-switch: true
 
   g-rx-fifo-size:
-- 
2.7.4

