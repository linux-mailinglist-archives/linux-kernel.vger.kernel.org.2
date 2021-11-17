Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49C454048
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhKQFl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:41:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53294 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhKQFl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:41:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AH5c8Fk004762;
        Tue, 16 Nov 2021 23:38:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637127488;
        bh=fZ+tCpl6aMiTVA4kq/Iai8pN1fLAIcMf+25zZQaYStE=;
        h=From:To:CC:Subject:Date;
        b=wTn5/5v93SxqcBMZl0tQQU3L+felqLHq361+6Bpy8OzEj9xZQYidp5OwnUefCq2+b
         sHGwqyXOX1dfBIOqMAxM0+vQQ22M6RMW4VaZmYP2vu2ov8mc/VskzYtZV4RcacIS/j
         ApsR1cQWpL43zIyPfOfwO/ENFzc0Pyoo9BHGUz4Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AH5c8sh071185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Nov 2021 23:38:08 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 16
 Nov 2021 23:38:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 16 Nov 2021 23:38:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AH5c7cO098283;
        Tue, 16 Nov 2021 23:38:07 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <jan.kiszka@siemens.com>, <j-choudhary@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: iot2050: Disable mcasp nodes at dtsi level
Date:   Wed, 17 Nov 2021 11:08:06 +0530
Message-ID: <20211117053806.10095-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable mcasp nodes 0-2 because several required properties
are not present in the dtsi file as they are board specific.
These nodes can be enabled via an overlay whenever required.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 65da226847f4..c9407ed67866 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -731,3 +731,15 @@
 &icssg2_mdio {
 	status = "disabled";
 };
+
+&mcasp0 {
+	status = "disabled";
+};
+
+&mcasp1 {
+	status = "disabled";
+};
+
+&mcasp2 {
+	status = "disabled";
+};
-- 
2.17.1

