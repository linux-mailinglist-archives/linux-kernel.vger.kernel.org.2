Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF73093E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhA3KBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:01:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:44020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233199AbhA3Crm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:47:42 -0500
IronPort-SDR: Vevev0fi7ZEPM0yRY9JFccASA8/7i1YOd2HjkCXfoQ5dne9HTXd+2M5tEdKaNMY6GCvqttgtDL
 +1ZV4c+ItEJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="179729138"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="179729138"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
IronPort-SDR: rBRZ00SiIBRVs5hCP1SfckRWOc/9DHE7pD91SpC/g/l4DYMkQtryGgFR4MxjkrjmasXcIIyGKJ
 qpwrzf2mzreA==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389569480"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 7CCB4636B;
        Fri, 29 Jan 2021 18:21:30 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 6CF04363696; Fri, 29 Jan 2021 18:21:30 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Li, Tingqian" <tingqian.li@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 24/34] dt-bindings: misc: Add Keem Bay vpumgr
Date:   Fri, 29 Jan 2021 18:21:14 -0800
Message-Id: <20210130022124.65083-60-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
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

