Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0491A42A8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJLPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:50:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43802 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhJLPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:50:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19CFmYxn095048;
        Tue, 12 Oct 2021 10:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634053714;
        bh=8rrPQGnqFCUnZxZtTYRofyZNsMnTrSL62XL4Y0etm78=;
        h=From:To:CC:Subject:Date;
        b=B9DVrORSVLNawA8+xF9RVzrc8HuD52+88+P34j7wuDeMX2iXKHj7+IhC1e7IprnAl
         9+JHTwn6zQ5CF61Z493b0VxoXVtwa3HPSf5weqKI2rGxUjgARQfozpBIAuhkgVp+gn
         fKIamx5kmDeMRqrp5SuzuOxLO1AhdIxLJTx26nfc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19CFmY77105407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Oct 2021 10:48:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Oct 2021 10:48:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Oct 2021 10:48:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19CFmYZb009701;
        Tue, 12 Oct 2021 10:48:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Suman Anna <s-anna@ti.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] dt-bindings: sram: Allow numbers in sram region node name
Date:   Tue, 12 Oct 2021 10:48:33 -0500
Message-ID: <20211012154833.14111-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sram regions node name describes the region of reserved memory and can
be names such as l3cache@1000. Permit numbers to be used as part of the
reserved memory node name.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 3eda5049d183..939cf2418445 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -60,7 +60,7 @@ properties:
     type: boolean
 
 patternProperties:
-  "^([a-z]*-)?sram(-section)?@[a-f0-9]+$":
+  "^([a-z0-9]*-)?sram(-section)?@[a-f0-9]+$":
     type: object
     description:
       Each child of the sram node specifies a region of reserved memory.
-- 
2.32.0

