Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197E7311AD3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhBFEYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:24:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:50657 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhBFDNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:13:49 -0500
IronPort-SDR: UlMnF3hCfypl8N6/+ufZhF7642s1T1JXskGz7IT+wi1lKhMlk9P9cI+NfDwVN6ecLUfIFbgcOa
 ECdyV8FXma4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="177992648"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="177992648"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:08 -0800
IronPort-SDR: n37FcuYf6a4w6oOnvXtSsycXiPd8/8f7HkZ7hgC23g0HrDlgqzqPz1CcgIrr39mP6/PlxyqAj/
 7bj04Bmvw7sQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416175319"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:08 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 277AA636D;
        Fri,  5 Feb 2021 14:52:08 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 1BF6136269B; Fri,  5 Feb 2021 14:52:08 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 04/34] dt-bindings: Add bindings for Keem Bay IPC driver
Date:   Fri,  5 Feb 2021 14:51:34 -0800
Message-Id: <20210205225204.32902-5-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205225204.32902-1-mgross@linux.intel.com>
References: <20210205225204.32902-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add DT binding documentation for the Intel Keem Bay IPC driver, which
enables communication between the Computing Sub-System (CSS) and the
Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
Bay.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 .../bindings/soc/intel/intel,keembay-ipc.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml

diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
new file mode 100644
index 000000000000..586fe73f4cd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-ipc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Keem Bay IPC
+
+maintainers:
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+
+description:
+  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
+  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
+  Keem Bay.
+
+properties:
+  compatible:
+    const: intel,keembay-ipc
+
+  memory-region:
+    items:
+      - description:
+          Reserved memory region used by the CPU to allocate IPC packets.
+      - description:
+          Reserved memory region used by the VPU to allocate IPC packets.
+
+  mboxes:
+    description: VPU IPC Mailbox.
+
+required:
+  - compatible
+  - memory-region
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    ipc {
+          compatible = "intel,keembay-ipc";
+          memory-region = <&ipc_cpu_reserved>, <&ipc_vpu_reserved>;
+          mboxes = <&vpu_ipc_mbox 0>;
+    };
-- 
2.17.1

