Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3741AB08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhI1Ivv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:51:51 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53242
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239741AbhI1Ivl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:51:41 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE7F1402FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632819001;
        bh=PsCkcyaCEnAXm38y0vJxGzfoUxQhj4fpVQ0zBS6vTGo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vqTFgDrRRrRrfnl9+nhOPE+bmtxGcY0l9wkOtSzOgpxtyWe0ivZEn/qleFY9hdy12
         lypqK0aXPQsejWfK6143yZokahCnWHzT8LKB0npMoyTpvRtZJQK3yTOF0md+VlgFfG
         v2lXOozAdIUXpTllsx0LGeWuB3wD2KbGG3mPxdF4GwlPPi/W0Nqog1mRN+B+oNhJOj
         gVkIfhshilXMItpmZfVsiFHMg2njOFfAMHb8KAqn8MOp/mNbmulYmK5FygCQmGeSji
         ItmH2FUat7oEvfd3w7cQVyK9cyz8wkEfbV4MU3wAANnCqnHRNjk4Lh01nr8WC1gjMR
         aHw/eN3FB026Q==
Received: by mail-lf1-f70.google.com with SMTP id t187-20020a19c3c4000000b003fc1361fb20so18671289lff.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsCkcyaCEnAXm38y0vJxGzfoUxQhj4fpVQ0zBS6vTGo=;
        b=TqmXdOX/XmUsQCrVrsEIKgSHyfXY8H7LBgS4xUWht+YQRAJcYFz+MHPnkfxIZxHBnD
         hh+6X1eY2RH5DrOMewlHSJif01vVp5vD8ToUz3kATJTnVXRV8TUTFVXscEp6gaH18A9Z
         ymVxnxGYFoLAZYSBDWzjkvKfKAlEm31O9ew4nw/3sPNVCe5q+FTkQMItz+mycuAowtoA
         +SPQp/jfYRx7EGoXSknJN6FiX6vkx5QmJR/3NRSm3TvQNeUr65iKyaF9w6lfO+ojNC28
         1Fzn71qPAfJjk3dbgJ18RT55kGzUDGMo3IFn8Zb3k0nI+P/NJppTjraauWAy2gs+Ubdw
         eKWQ==
X-Gm-Message-State: AOAM533PiqcUY+seAtvNCs1sX0OJTCo+196SPQMmHtw7smPSy7Nq/BLX
        H3VQAzMEneC5+Ah5B8ByBxb4SvkL9tk7uFwrAdpd2qaEAMYkD2MPlUJ3JdH48D8j5sp39O3giEy
        JLq1rb8qihCuwuR9xQvdYgchQBR2CGeXM+WqXEHDfIw==
X-Received: by 2002:a2e:22c5:: with SMTP id i188mr4517931lji.0.1632819001003;
        Tue, 28 Sep 2021 01:50:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqR+1LKPp5eRSM9B7lfLIEG2DqnbHilBtRtf1VO9LlnNQe8kcJyNJ/qXNTyPwrsz9BZ9Nw+A==
X-Received: by 2002:a2e:22c5:: with SMTP id i188mr4517915lji.0.1632819000791;
        Tue, 28 Sep 2021 01:50:00 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13sm1848419lfl.205.2021.09.28.01.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:49:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 03/12] clock: dt-bindings: samsung,s2mps11: convert to dtschema
Date:   Tue, 28 Sep 2021 10:49:40 +0200
Message-Id: <20210928084949.27939-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
References: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the clock provider of Samsung S2MPS11 family of PMICs to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/samsung,s2mps11.txt        | 49 -------------------
 .../bindings/clock/samsung,s2mps11.yaml       | 45 +++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 46 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml

diff --git a/Documentation/devicetree/bindings/clock/samsung,s2mps11.txt b/Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
deleted file mode 100644
index 2726c1d58a79..000000000000
--- a/Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Binding for Samsung S2M and S5M family clock generator block
-============================================================
-
-This is a part of device tree bindings for S2M and S5M family multi-function
-devices.
-More information can be found in bindings/mfd/sec-core.txt file.
-
-The S2MPS11/13/15 and S5M8767 provide three(AP/CP/BT) buffered 32.768 kHz
-outputs. The S2MPS14 provides two (AP/BT) buffered 32.768 KHz outputs.
-
-To register these as clocks with common clock framework instantiate under
-main device node a sub-node named "clocks".
-
-It uses the common clock binding documented in:
- - Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-
-Required properties of the "clocks" sub-node:
- - #clock-cells: should be 1.
- - compatible: Should be one of: "samsung,s2mps11-clk", "samsung,s2mps13-clk",
-               "samsung,s2mps14-clk", "samsung,s5m8767-clk"
-   The S2MPS15 uses the same compatible as S2MPS13, as both provides similar
-   clocks.
-
-
-Each clock is assigned an identifier and client nodes use this identifier
-to specify the clock which they consume.
-    Clock               ID           Devices
-    ----------------------------------------------------------
-    32KhzAP		0            S2MPS11/13/14/15, S5M8767
-    32KhzCP		1            S2MPS11/13/15, S5M8767
-    32KhzBT		2            S2MPS11/13/14/15, S5M8767
-
-Include dt-bindings/clock/samsung,s2mps11.h file to use preprocessor defines
-in device tree sources.
-
-
-Example:
-
-	s2mps11_pmic@66 {
-		compatible = "samsung,s2mps11-pmic";
-		reg = <0x66>;
-
-		s2m_osc: clocks {
-			compatible = "samsung,s2mps11-clk";
-			#clock-cells = <1>;
-			clock-output-names = "xx", "yy", "zz";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
new file mode 100644
index 000000000000..1410c51e0e7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,s2mps11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2M and S5M family clock generator block
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The S2MPS11/13/15 and S5M8767 provide three(AP/CP/BT) buffered 32.768 kHz
+  outputs. The S2MPS14 provides two (AP/BT) buffered 32.768 KHz outputs.
+
+  All available clocks are defined as preprocessor macros in
+  dt-bindings/clock/samsung,s2mps11.h header.
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mps11-clk
+      - samsung,s2mps13-clk # S2MPS13 and S2MPS15
+      - samsung,s2mps14-clk
+      - samsung,s5m8767-clk
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    minItems: 3
+    maxItems: 3
+    description: Names for AP, CP and BT clocks.
+
+required:
+  - compatible
+  - "#clock-cells"
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f28fb4b4e5c..241fe78a3282 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16599,7 +16599,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
+F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,sec-core.txt
 F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.txt
 F:	Documentation/devicetree/bindings/regulator/samsung,s5m*.txt
-- 
2.30.2

