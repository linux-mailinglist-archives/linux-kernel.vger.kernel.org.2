Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0F4269E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbhJHLow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:44:52 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33722
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243017AbhJHLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:42:06 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 271BE3F499
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633693089;
        bh=Kj42Lqs2l794a5Qgw3tsNbTNjAz05cyprgAbVt08QkA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=a8iOwByAgz7/iR4RS9hbnEPVkn45vz9mLSG5R97TcwbxywAsJ5wv1XzU78uBcdQPK
         R+mfbEOKe0xsTpiI4lenexnFZ8yRGC9AdXb/ShexOssU+oKZ2v5QsOUVwXeYGgcCGd
         pYKkeeS606irJ+iVaxq+5x/wAVOeD/eYX+o12CFyguB1rMRlmXjOH4Ta2bktOsnx2I
         358pkkw3nfkNnyde960ManBvEYIcavM8ryLBNX6k5LoIglIbxynYf9e50x/dhMe0pJ
         6LlLzgOVsIWD6/OQkvDDh30WGjQzp3B6NwGkx4tX4/3O9ybvxhAWH/RAvGzXugz5af
         LnfO3hkCWlbAg==
Received: by mail-ed1-f71.google.com with SMTP id q26-20020aa7da9a000000b003db531e7acbso4552091eds.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kj42Lqs2l794a5Qgw3tsNbTNjAz05cyprgAbVt08QkA=;
        b=YpjWtDnkhbT4SmgtJKBp5byKqToK7IxPp4+zS+BgqsCzbAvIbOqlkuDZ+7sWkew5e7
         ffRKzZlsytJaQjzOEIFpnifxJpnIs2DYf2t/ieKJiRj6dv0Kd0V6B83O1eyRbJlrZq9m
         u3cmvLaVMX/+WZKAW2WCKeUo4y27Ic8bj3qIGfgtcXcicE59urTXEGcoF4qOa0LCn1x8
         pa4DTIuR1b/kDLFIUvtRxABTT4gmW8ucSS5y92Pe75U2uyP/ZT1yRFVyWAzfUsUqaZw0
         5gf1T2WUzcnWhuoRqH0r7Sszv0fIFstSvWVDveY2oVnamGZ1bKdA12MFJFyy/KNerprJ
         qWlg==
X-Gm-Message-State: AOAM532u9EPMnRbFmcIN41kqTOLmDOjfBsjTItO5LlbfNGgkYnVTVDWt
        wRQkyLTXKUHNP/2KGea/Y6Ehg/1ImgVi+K2Z9pnBJuFUBnjliaAAPHid+yS8aM7oBD7AB3mvB5V
        njbqNuT63oJ/+O7WsgKKqa+VoJevZ6vbbMrZvcaRcvQ==
X-Received: by 2002:a17:906:2405:: with SMTP id z5mr3564601eja.170.1633693087930;
        Fri, 08 Oct 2021 04:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbiKgMIE5F2JpCsRCYiqaNAz1tSc6fqi2txMM74q7pSsu2pEWOFi13zFyTPQF5lbVNyvJ+mA==
X-Received: by 2002:a17:906:2405:: with SMTP id z5mr3564575eja.170.1633693087691;
        Fri, 08 Oct 2021 04:38:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id la1sm819948ejc.48.2021.10.08.04.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:38:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 03/10] dt-bindings: clock: samsung,s2mps11: convert to dtschema
Date:   Fri,  8 Oct 2021 13:37:15 +0200
Message-Id: <20211008113723.134648-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
References: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the clock provider of Samsung S2MPS11 family of PMICs to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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
index e6bf87081930..d86fd237edee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16636,7 +16636,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

