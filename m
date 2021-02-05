Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF1311B00
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBFEkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:40:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:55065 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhBFDUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:20:52 -0500
IronPort-SDR: By3gxuYHdiXn5Uy2EfCovKLNJ0a9mIIgFB7hBdiJUuilWw/5lw5YrLgVhO0qk5Sk9IJaVYLN5o
 wjDs1l/amRgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="161252132"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="161252132"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:09 -0800
IronPort-SDR: fjvKv+OpQGy4m0dhkAEAt0IMkv+shAFpOIJ+jRKoB4DumVf8qy4vif9ZH7MpJBx5kMTTQ7oDOi
 OKeMmmz4sw6A==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="357852866"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:09 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 331C56369;
        Fri,  5 Feb 2021 14:52:09 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 26CE63635FF; Fri,  5 Feb 2021 14:52:09 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Li, Tingqian" <tingqian.li@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 24/34] dt-bindings: misc: Add Keem Bay vpumgr
Date:   Fri,  5 Feb 2021 14:51:54 -0800
Message-Id: <20210205225204.32902-25-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205225204.32902-1-mgross@linux.intel.com>
References: <20210205225204.32902-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Li, Tingqian" <tingqian.li@intel.com>

  Add DT binding schema for VPU on Keem Bay ASoC platform

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Li Tingqian <tingqian.li@intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 .../bindings/misc/intel,keembay-vpu-mgr.yaml  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
new file mode 100644
index 000000000000..a44f492277ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2020 Intel
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/intel,keembay-vpu-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel VPU manager bindings
+
+maintainers:
+  - Li, Tingqian <tingqian.li@intel.com>
+  - Zhou, Luwei <luwei.zhou@intel.com>
+
+description: |
+  The Intel VPU manager provides shared memory and process
+  depedent context management for Intel VPU hardware IP.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - intel,keembay-vpu-mgr
+          - intel,keembay-vpusmm
+
+  memory-region:
+    description:
+      phandle to a node describing reserved memory (System RAM memory)
+      used by VPU (see bindings/reserved-memory/reserved-memory.txt)
+    maxItems: 1
+
+  intel,keembay-vpu-ipc-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      the index of the VPU slice to be managed. Default is 0.
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    vpumgr0 {
+        compatible = "intel,keembay-vpu-mgr";
+        memory-region = <&vpu_reserved>;
+        intel,keembay-vpu-ipc-id = <0x0>;
+    };
-- 
2.17.1

