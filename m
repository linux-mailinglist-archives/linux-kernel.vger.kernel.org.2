Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C137456FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhKSNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:37:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42954 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:37:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDYgp5119360;
        Fri, 19 Nov 2021 07:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637328882;
        bh=sZigb8zPGXPTWrT/lXx+xodfXb49WISCffMYUWGBjHw=;
        h=From:To:CC:Subject:Date;
        b=JB08H4HH2NGAa1LHzTNlUDRw40HuPByxoaD84lCtPZq0eTp6L71+VSy89TUg+s08U
         9dSnBmcP25KvrtMLkIEm8d/lyBeZ993/koEljIypp8hwHRIXAdm2fS3C1lquP2ZN8W
         u+Q9XQrGpfoAOtkvwBAJcS0llrDT+bpckcycD2PA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AJDYgoR102056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 07:34:42 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 19
 Nov 2021 07:34:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 19 Nov 2021 07:34:42 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDYdbc118904;
        Fri, 19 Nov 2021 07:34:39 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: ti-serdes-mux: Add defines for J721S2 SoC
Date:   Fri, 19 Nov 2021 19:04:37 +0530
Message-ID: <20211119133437.19304-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 lanes in the single instance of J721S2 SERDES. Each SERDES
lane mux can select upto 4 different IPs. Define all the possible
functions.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index d417b9268b16..d3116c52ab72 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -95,4 +95,26 @@
 #define AM64_SERDES0_LANE0_PCIE0		0x0
 #define AM64_SERDES0_LANE0_USB			0x1
 
+/* J721S2 */
+
+#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
+#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
+#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J721S2_SERDES0_LANE1_USB		0x2
+#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
+#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
+#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J721S2_SERDES0_LANE3_USB		0x2
+#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
2.17.1

