Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5B333B64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhCJL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:28:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCJL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:28:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12ABS4cD017855;
        Wed, 10 Mar 2021 05:28:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615375684;
        bh=HrnytEEcUd6i+UBJygxWFwE8sMSucQF4jASkNH69I8U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IUU7N/7s3gP9SMhiddY2pfDdIDpO+1vOKyN7yRPW/QY4WU6txED2LVM1lYaOM6pY7
         1A0yC5hLiD+yuS7YgbZCTUrIYYDqofETiaA6L0X8DgRx1+YfAKZUcaPalgt+dVXWIx
         3eSfEBJmP8ew2zwJnwD3PNP8W4Z5VjtIYWf8Fswo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12ABS4O8011109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 05:28:04 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 05:28:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 05:28:04 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12ABRkvZ075949;
        Wed, 10 Mar 2021 05:28:00 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 3/3] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
Date:   Wed, 10 Mar 2021 16:57:45 +0530
Message-ID: <20210310112745.3445-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310112745.3445-1-kishon@ti.com>
References: <20210310112745.3445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 has a single lane SERDES which can be configured to be used
with either PCIe or USB. Define the possilbe values for the SERDES
function in AM64 SoC here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Peter Rosin <peda@axentia.se>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/mux/ti-serdes.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index 9047ec6bd3cf..d417b9268b16 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -90,4 +90,9 @@
 #define J7200_SERDES0_LANE3_USB			0x2
 #define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
 
+/* AM64 */
+
+#define AM64_SERDES0_LANE0_PCIE0		0x0
+#define AM64_SERDES0_LANE0_USB			0x1
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
2.17.1

