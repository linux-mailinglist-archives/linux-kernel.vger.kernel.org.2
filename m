Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA93E7C67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbhHJPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:35:38 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:34994 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242032AbhHJPfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:35:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7CE58412DE;
        Tue, 10 Aug 2021 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1628609684; x=1630424085; bh=BRiyzJ6ERUdHZZPZotHcTYGai20iWJt8gC8
        cOR8wUgg=; b=X2Z++hTE9b7pltR+jTs4c8ewKRpYFXZYM2b81F2LoaPRYFZ8+ay
        xJ5DmlLYDFi7E6la34/Lz3Eqm3tdMhqvZ9vFmlDiw/W7hn7E1Ll5CC1/jeX0XcS/
        q5prKlVbB4R7g/kyKOq6DG1lnWdq4oNj6Q2sGNEp8+43Saz6wwBRL+og=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nb1N5h8pMOw3; Tue, 10 Aug 2021 18:34:44 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 140CC412DF;
        Tue, 10 Aug 2021 18:34:43 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.0.188) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 10 Aug 2021 18:34:39 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH 2/2] dt-bindings: rtc: provide RTC PCH device tree binding doc
Date:   Tue, 10 Aug 2021 18:44:36 +0300
Message-ID: <20210810154436.125678-3-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810154436.125678-1-i.mikhaylov@yadro.com>
References: <20210810154436.125678-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.188]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C Intel Series PCH built-in read-only RTC driver documentation.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 .../bindings/rtc/intel,pch-rtc.yaml           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/intel,pch-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/intel,pch-rtc.yaml b/Documentation/devicetree/bindings/rtc/intel,pch-rtc.yaml
new file mode 100644
index 000000000000..f49867257f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/intel,pch-rtc.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/intel,pch-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Series PCH built-in read-only RTC
+
+maintainers:
+  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - intel,pch-rtc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@0 {
+            compatible = "intel,pch-rtc";
+            reg = <0x44>;
+        };
+    };
-- 
2.31.1

