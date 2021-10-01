Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6102B41E9D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353181AbhJAJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:43:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56994
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353148AbhJAJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:43:33 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C32E402D1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633081309;
        bh=PsCkcyaCEnAXm38y0vJxGzfoUxQhj4fpVQ0zBS6vTGo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ofLa0SA1SdqGkDm5F1fPiSGSE1aPtO/Sz18fD/0ayT8rI61CAgu44QXxk6Qjldq3C
         hDU3vrTQtbeqNGA4DR/s65gtpkKtBfLMx6ECl1g4p2VDUBJ18EZ+P/oKbu7KcFnlwh
         SyUJT1qYNttCpp6ylx8N1M4Wz2tXhAQtvdy2xtslHB+x+mBhyVDuFm+wwM6j1PMKEg
         tS/BnzA08XJ/00faUfxaUmJ4NNlWd7qcoNp5syikDigGIEEG3ud8ZTEMLUJffVYUKb
         t7rTNYx217iiarUneMm4/hIRZSpFrchs9vKjttITiCl2BlYQjeVWRFUHc+jBj5Hiyu
         u/TiOkwh11BIg==
Received: by mail-lf1-f70.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so8416608lfv.18
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsCkcyaCEnAXm38y0vJxGzfoUxQhj4fpVQ0zBS6vTGo=;
        b=GUCaP3tL21PNDYijzyEUDBxZW6xnX+KzDt/suAe2+JxnkyiSw83wrSDuv3hvFxgiE/
         s0ZG3ToQ8D11agRodBk0xN0AgUWrA2aZKoZkN70T9CwvVei/s3uh7NdhGps9/ct5Iq4e
         UZTqxkrLA5ZkArJGFhdv9NISBZ7lGNl5Y6WcpoaH7LFkDX99gyFTSfJnVz/VkQ+/ZZoj
         krCruifAeDit7nshw4AJTty2skWGLUpJUEGnA57JhGqEbKgjZOAN1uWKvBfhxuQizxxf
         nG1yE7KhRXShlayoYYoqVDNNe5YW75/FyJ7VHeem4EfQN4iwhNzC2WvcfwN+cP2+qTGj
         F6MA==
X-Gm-Message-State: AOAM531WCiOiHmO9mbYCnb6fDWQanqkIF3ibdv5rCclw1Ek2Ich09fJv
        eIIC9p5GxkvQVxtllDEI/an76siaLkz30qvZuHDaNolnpwne1Jtz53w9+r0wISPC1MLdS3hdoiD
        LHyMqYpehAxMUGIyELl52eEuLcZL8N5JYHRwBGzy0Aw==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr330477ljj.331.1633081308375;
        Fri, 01 Oct 2021 02:41:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjckcYD+4IDpwNfPju5WCHtLSBxCtXtCtf29IdYTu8oI8wjzmG4OKY3Udt78D8Cq6FYOzgyA==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr330449ljj.331.1633081308052;
        Fri, 01 Oct 2021 02:41:48 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id g29sm673784lfj.212.2021.10.01.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:41:47 -0700 (PDT)
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
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 03/10] dt-bindings: clock: samsung,s2mps11: convert to dtschema
Date:   Fri,  1 Oct 2021 11:40:59 +0200
Message-Id: <20211001094106.52412-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
References: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
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

