Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DD371381
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhECKQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhECKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:16:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470CC06174A;
        Mon,  3 May 2021 03:15:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so8443601pjk.0;
        Mon, 03 May 2021 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wzwTcAoDsk0QX/rqj4skJEpuI5KakKUFrzAoXVFoChY=;
        b=CM9IwLyLULeABtzFH+NLmD5aBisGrjKNPdXzMaQrc6P+NB6xOkkOoooPyagCI8OvvF
         mai+sJCtaagopGIliRbwTsLDFI4nFNqH2dNaMIGoHit32gKp1PjWl1gicFJjhkXjikgs
         wrRh6jL25ZE9uz18HThj+ToP5Avhwn6C9uwgzaQ768LVsh1PfQ/uaGtrMMu0BivfPoXz
         ZP45oqOOhO0yD3d0E/82li+l5KWT/qmTqZhaxw9ASzGN5WL7zv+s58l1aHpBP63ZYa4g
         r97QBd6RW1160ZuCHW1ipkAvI0XCoKj3MuAI/35/sH8tentpv+eQ0EAVbM3UvzzQTN77
         B/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wzwTcAoDsk0QX/rqj4skJEpuI5KakKUFrzAoXVFoChY=;
        b=btTefX35pwQY0rex7zoDx7FW44O7n3asxkuFl3ByizLJRzv2i2NeQ2JQ5FU5wfnFoh
         jz3MLnCQkFIFOgP7BfGfJid2C05hKMLU5VUS/tSOQVdLf9UX621Js04QiBKqGEjEvgNr
         LWDKEFsALCyPpO3s92xjtGaw70ZSzejyfmQV3yuu0I9x8r3lEDlmY1NYOt8kCSCZC7NG
         r+YyEnzi7mL05I8fXYT4kdU4mP/zyhKL0APuT9EtCGX3aLx5JahY+T4/pAAZGKbQhSsH
         tDTYLILhjA3StDCOm5hKEei7ZwxpvzvZoTBEtlmMBEIstEOR421O10C0wV6Eg4JciGnt
         3P2A==
X-Gm-Message-State: AOAM532UD6AiZjA1rRXP+fd6ntIGxA071I04uUSb1qj3POlIGFyV5w2B
        49R7lyqWi5wQFNr4qjlM+y4=
X-Google-Smtp-Source: ABdhPJyePc69yjbC1SmKmOohiDA3KWHdMT+h2UUBF/jEhM8fq9HO2/KKWS5zhMe0tUljj3OAauMSNQ==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr30604604pjm.125.1620036927128;
        Mon, 03 May 2021 03:15:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:477:481e:dda5:8dca:2bc5:e1a9])
        by smtp.gmail.com with ESMTPSA id a1sm2840579pfi.22.2021.05.03.03.15.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 May 2021 03:15:26 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: rt6160: Add DT binding documet for Richtek RT6160
Date:   Mon,  3 May 2021 18:15:16 +0800
Message-Id: <1620036917-19040-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the DT binding document for Richtek RT6160 voltage regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt6160-regulator.yaml        | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
new file mode 100644
index 00000000..fe7b168
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt6160-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT6160 BuckBoost converter
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT6160 is a high-efficiency buck-boost converter that can provide
+  up to 3A output current from 2025mV to 5200mV. And it support the wide
+  input voltage range from 2200mV to 5500mV.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT6160A/DS6160A-00.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt6160
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: A connection of the 'enable' gpio line.
+    maxItems: 1
+
+  richtek,vsel_active_low:
+    description: |
+      Used to indicate the 'vsel' pin active level. if not specified, use
+      high active level as the default.
+    type: boolean
+
+patternProperties:
+  buckboost:
+    description: BuckBoost converter regulator description.
+    type: object
+    $ref: regulator.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt6160@75 {
+        compatible = "richtek,rt6160";
+        reg = <0x75>;
+        enable-gpios = <&gpio26 2 0>;
+
+        buckboost {
+          regulator-name = "rt6160-buckboost";
+          regulator-min-microvolt = <2025000>;
+          regulator-max-microvolt = <5200000>;
+          regulator-allowed-modes = <0 1>;
+        };
+      };
+    };
-- 
2.7.4

