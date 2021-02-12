Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BC31A0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBLObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhBLObp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:31:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26A9764E3D;
        Fri, 12 Feb 2021 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613140265;
        bh=TR86Zo3crbYKc8eB0HkdfTa3Zyi0i276o1Lpf2ikz0w=;
        h=From:To:Cc:Subject:Date:From;
        b=A6y4hj8T+9YrEK2cqfdKsiWyY9j1b6zuc5PwurnViCm8BxslLhspBTD3HXRobPYTF
         Z1MmP8ZvsYgF3xcgtCCuc6R+gH0ZvoOwrzKL9xmKpvXuDRDDBzjPDnn2aZxKn5bOvZ
         e0vST9FVyfSpl2QsLVk7N66XQRwdlobgUvXRJnCnG7tHxzj981W3cE2JIamVAfXoJb
         fzwTF9Nkk/nf11OU98e8LEgJauqBvVnY8uDuXSW+jp95lvld6od98mib/VbuPe4Rh2
         nNvx8Mz9pTi4OZwns4cCYu1WyoVwQ8nB/2K2bXLdMMeFlIFp7oMI6e18PJYm3nj0KW
         HmZcdK3G8GW5Q==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv1 1/2] dt-bindings: documentation: add clock bindings information for eASIC N5X
Date:   Fri, 12 Feb 2021 08:30:58 -0600
Message-Id: <20210212143059.478554-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Agilex clock bindings, and add the clock header file. The
clock header is an enumeration of all the different clocks on the eASIC
N5X platform.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 .../bindings/clock/intel,easic-n5x.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,easic-n5x.yaml

diff --git a/Documentation/devicetree/bindings/clock/intel,easic-n5x.yaml b/Documentation/devicetree/bindings/clock/intel,easic-n5x.yaml
new file mode 100644
index 000000000000..8f45976e946e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,easic-n5x.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/intel,easic-n5x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA eASIC N5X platform clock controller binding
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description:
+  The Intel eASIC N5X Clock controller is an integrated clock controller, which
+  generates and supplies to all modules.
+
+properties:
+  compatible:
+    const: intel,easic-n5x-clkmgr
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock controller node:
+  - |
+    clkmgr: clock-controller@ffd10000 {
+      compatible = "intel,easic-n5x-clkmgr";
+      reg = <0xffd10000 0x1000>;
+      clocks = <&osc1>;
+      #clock-cells = <1>;
+    };
+...
-- 
2.30.0

