Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DDB3093F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhA3KFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:05:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:24253 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhA3Crl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:47:41 -0500
IronPort-SDR: WCz2/F6SVU4dClJAklYyUdbHgSfXLSESqMHxu0ODIbrtvBSis4g77B0dG4YXD/67+jCjiRIIUa
 IqjbpMA/BhCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="159675239"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="159675239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:28 -0800
IronPort-SDR: z16xkneY8O2d6Ik44Srue2kPopaeThLToSnRc5YN2OSpl925VIBcMBzzy8HjC9I9bYpfhY8Br2
 PIOdFqCCCFBw==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389569449"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:28 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 685F36372;
        Fri, 29 Jan 2021 18:21:28 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 586763631DE; Fri, 29 Jan 2021 18:21:28 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: [PATCH v3 17/34] xlink-ipc: Add xlink ipc device tree bindings
Date:   Fri, 29 Jan 2021 18:20:32 -0800
Message-Id: <20210130022124.65083-18-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Add device tree bindings for the xLink IPC driver which enables xLink to
control and communicate with the VPU IP present on the Intel Keem Bay
SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
---
 .../misc/intel,keembay-xlink-ipc.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
new file mode 100644
index 000000000000..699e43c4cd40
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) Intel Corporation. All rights reserved.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink-ipc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay xlink IPC
+
+maintainers:
+  - Kelly Seamus <seamus.kelly@intel.com>
+
+description: |
+  The Keem Bay xlink IPC driver enables the communication/control sub-system
+  for internal IPC communications within the Intel Keem Bay SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: intel,keembay-xlink-ipc
+
+  memory-region:
+    items:
+      - description: reference to the CSS xlink IPC reserved memory region.
+      - description: reference to the MSS xlink IPC reserved memory region.
+
+  intel,keembay-vpu-ipc-id:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The numeric ID identifying the VPU within the xLink stack.
+
+  intel,keembay-vpu-ipc-name:
+    $ref: "/schemas/types.yaml#/definitions/string"
+    description: User-friendly name for the VPU within the xLink stack.
+
+  intel,keembay-vpu-ipc:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: reference to the corresponding intel,keembay-vpu-ipc node.
+
+examples:
+  - |
+    xlink-ipc {
+        compatible = "intel,keembay-xlink-ipc";
+        memory-region = <&css_xlink_reserved>,
+                        <&mss_xlink_reserved>;
+        intel,keembay-vpu-ipc-id = <0x0>;
+        intel,keembay-vpu-ipc-name = "vpu-slice-0";
+        intel,keembay-vpu-ipc = <&vpuipc>;
+    };
-- 
2.17.1

