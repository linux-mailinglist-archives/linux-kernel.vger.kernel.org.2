Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C25309403
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhA3KHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:07:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:10159 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233220AbhA3Crl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:47:41 -0500
IronPort-SDR: mcvJ2TYxVmB3Lj+2c/bgMUMQz6Kl89T19tYR4xZMKm3f9mpwMuRIUWurU0IKqVXubgWYAReDHP
 +7VpZjCdARlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="167606773"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="167606773"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:31 -0800
IronPort-SDR: 7idafQ9mPdCiJA2XHayokdrNq9f6QPjQHIbJh/Y3R5L2jPYJ7I0EwbcD4fJDPukSEtJEPUHJtx
 lPLTlK5bWC/w==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="404733832"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 493706368;
        Fri, 29 Jan 2021 18:21:30 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 3D0C436368C; Fri, 29 Jan 2021 18:21:30 -0800 (PST)
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
Subject: [PATCH v4 19/34] xlink-core: Add xlink core device tree bindings
Date:   Fri, 29 Jan 2021 18:21:09 -0800
Message-Id: <20210130022124.65083-55-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
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

