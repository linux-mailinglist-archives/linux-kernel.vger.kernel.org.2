Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340903C6601
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhGLWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:10:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:22376 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhGLWKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:10:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="210105057"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="210105057"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:07:58 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="464371996"
Received: from jzloch-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.136.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:07:53 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH 03/14] dt-bindings: Add generic bindings for PECI
Date:   Tue, 13 Jul 2021 00:04:36 +0200
Message-Id: <20210712220447.957418-4-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712220447.957418-1-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the PECI controller.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 .../bindings/peci/peci-controller.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml

diff --git a/Documentation/devicetree/bindings/peci/peci-controller.yaml b/Documentation/devicetree/bindings/peci/peci-controller.yaml
new file mode 100644
index 000000000000..54ae8fc333d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-controller.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/peci/peci-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Device Tree Bindings for PECI
+
+maintainers:
+  - Iwona Winiarska <iwona.winiarska@intel.com>
+
+description: |
+  PECI (Platform Environment Control Interface) is an interface that provides a
+  communication channel from Intel processors and chipset components to external
+  monitoring or control devices.
+
+properties:
+  $nodename:
+    pattern: "^peci-controller(@.*)?$"
+
+additionalProperties: true
+
+examples:
+  - |
+    peci-controller@1e78b000 {
+      reg = <0x1e78b000 0x100>;
+    };
+...
-- 
2.31.1

