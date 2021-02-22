Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D1321513
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBVL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:26:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57332 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhBVLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:24:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNhxr007131;
        Mon, 22 Feb 2021 05:23:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613993023;
        bh=ejNLP8A0/TozqWiIO9rw/YN3cU1wXkHRhs46676Bh+o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FNziTBa8jf46AudF0ZD0QI0kzHFUi+AkjCf+HVzp3lwm9ihWMFBSsMZ3HOBZW3sVD
         BAN2ZsN0IJSRQEuX0z/V8HYocDm+gSzcl712b+d+xRhvA75kPIXDz6D1R9pbLvkZZw
         b9yEtYTl/ZhNFgnE46he7cyIehH7h0nup51vwILE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBNhq0101411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:23:43 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:23:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:23:42 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNFDc088010;
        Mon, 22 Feb 2021 05:23:40 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v2 3/9] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
Date:   Mon, 22 Feb 2021 16:53:08 +0530
Message-ID: <20210222112314.10772-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222112314.10772-1-kishon@ti.com>
References: <20210222112314.10772-1-kishon@ti.com>
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

