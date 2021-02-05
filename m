Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA6311B11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhBFEqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:46:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:63384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhBFD0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:26:13 -0500
IronPort-SDR: F7pbrIz8pooNXXa93lpWUU6HCkrGcVVn42CoOUxC3WxgZQCYTsuUDGBj7ISWjXfOdZqq+BkRB4
 ARwgyufFAqkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181646210"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181646210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:09 -0800
IronPort-SDR: tlk9YHSKPPmFPJpo1/sVcviTVC4+9Kxt4zlWeOX2Bz9wvL8EIniZhSOktY+hB9GEjSITmzshUO
 DZ7U+/ylScoQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="360577859"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:08 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id E689A636B;
        Fri,  5 Feb 2021 14:52:08 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id DAAB8363537; Fri,  5 Feb 2021 14:52:08 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 19/34] xlink-core: Add xlink core device tree bindings
Date:   Fri,  5 Feb 2021 14:51:49 -0800
Message-Id: <20210205225204.32902-20-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205225204.32902-1-mgross@linux.intel.com>
References: <20210205225204.32902-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Add device tree bindings for keembay-xlink.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
---
 .../bindings/misc/intel,keembay-xlink.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
new file mode 100644
index 000000000000..5ac2e7fa5b5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) Intel Corporation. All rights reserved.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay xlink
+
+maintainers:
+  - Seamus Kelly <seamus.kelly@intel.com>
+
+description: |
+  The Keem Bay xlink driver enables the communication/control sub-system
+  for internal and external communications to the Intel Keem Bay SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: intel,keembay-xlink
+
+additionalProperties: False
+
+examples:
+  - |
+    xlink {
+        compatible = "intel,keembay-xlink";
+    };
-- 
2.17.1

